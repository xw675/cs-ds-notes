---
unit: FIT3003
week: 2
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing]
aliases: [TempFact, Fact Table Creation, Temporary Operational Table]
type: pattern
---
# [[Building Fact Tables]]

**Context:** [[FIT3003_MOC]] · step 2 of the [[Star Schema]] build, after [[Building Dimension Tables]] · measure choice governed by [[Fact Measure Aggregation Rules]]
**Problem it solves:** aggregating the operational transaction tables down to one row per dimension-key combination.

> [!abstract] Quick Revision
> - **🎯 Trigger:** every fact is `select <dimension keys>, <aggregate> … group by <the same keys>` ➔ the only question is whether the source is the operational tables **directly** or a staged **TempFact**.
> - **⚠️ Key Constraint:** build the fact **from the operational tables, never from the dimension tables** — the dimensions have already been de-duplicated, so the transaction rows the aggregate must count no longer exist there.

## 🔧 Minimal Working Example
*(Route A — direct aggregation; College case, no staging needed)*
```sql
create table CollegeFact as
select S.Country, E.AgentNo, E.CourseCode, E.EnrolmentYear,
       count(P.PaymentNo) as Number_of_Payments,
       sum(P.Amount)      as Total_Income
from   Student S, Enrolment E, Payment P
where  E.EnrolmentNo = P.EnrolmentNo
and    E.StudentID   = S.StudentID
group by S.Country, E.AgentNo, E.CourseCode, E.EnrolmentYear;
```
**Expected output:** $\text{COLLEGEFACT}(\underline{\text{Country}^{*}, \text{AgentNo}^{*}, \text{CourseCode}^{*}, \text{EnrolmentYear}^{*}}, \text{Number\_of\_Payments}, \text{Total\_Income})$ — one row per key combination that actually occurs.

## 🗂️ Schema
- **`group by` list $=$ the fact's composite PK** ➔ the grouped columns are exactly the dimension FKs; any extra column in `select` that is not aggregated must be added to `group by`.
- **$n$ tables need $n-1$ join conditions** ➔ FIT3003 uses old-style comma joins; a missing condition returns the Cartesian product ➔ [[SQL Joins (ANSI)]].
- **Aggregate over the join** ➔ WHERE joins first, then grouping happens on the surviving rows ➔ [[SQL Aggregate Functions and GROUP BY]].

## 🔀 Variations

### Route B — TempFact (a fact key must be derived or banded)
*(Sales case: quarterly analysis, but `Sales` stores only `SalesDate`.)*
```sql
create table TempFact as
select S.SalesDate, B.BranchID, C.CategoryID, S.TotalPrice
from   Branch B, Sales S, Product P, Category C
where  B.BranchID   = S.BranchID
and    S.ProductNo  = P.ProductNo
and    P.CategoryID = C.CategoryID
and    to_char(S.SalesDate, 'YYYY') = '2020';

alter table TempFact add (Quarter number(1));
update TempFact set Quarter = 1
where  to_char(SalesDate, 'MM') >= '01' and to_char(SalesDate, 'MM') <= '03';
-- … one update per quarter …

create table SalesFact as
select Quarter, BranchID, CategoryID, sum(TotalPrice) as Total_Sales
from   TempFact
group by Quarter, BranchID, CategoryID;
```
- **TempFact keeps the grain** ➔ it is the joined, *unaggregated* row set; the derived key is written onto it before the single `group by` collapses it.

### Route C — outer join (two measures with different populations)
*(Employment Agency: every opening exists, only some become placements.)*
```sql
create table TempFact as
select O.QCode, O.StartDate, O.EndDate,
       to_char(P.ActualStartDate, 'Month') as MonthName,
       O.OpenNo, P.CandNo
from   Opening O left outer join Placement P on O.OpenNo = P.OpenNo;

alter table TempFact add (DurationID number);
update TempFact set DurationID = 1 where EndDate - StartDate < 10;
update TempFact set DurationID = 2 where EndDate - StartDate >= 10 and EndDate - StartDate <= 30;
update TempFact set DurationID = 3 where EndDate - StartDate > 30;

create table AgencyFact as
select QCode, DurationID, MonthName,
       count(OpenNo) as TotalOpening,
       count(CandNo) as TotalPlacement
from   TempFact
group by QCode, DurationID, MonthName;
```
- **The outer join is what makes both counts correct** ➔ an inner join would silently drop unfilled openings and `TotalOpening` would collapse onto `TotalPlacement`.
- **`count(CandNo)` excludes the NULLs the outer join introduced** ➔ unfilled openings contribute to `TotalOpening` but not to `TotalPlacement`; `count(*)` here would be wrong ➔ [[Fact Measure Aggregation Rules]].

### Route D — temporary table in the *operational* database (source has too many rows per entity)
*(Sessional-jobs case: an employee holds several degrees, the warehouse wants only the latest.)*
```sql
create table EmployeeTemp as
select T.EmpNo, T.EmpName, T.DOB, T.Phone, T.TaxFileNumber, T.DegreeID
from ( select E.EmpNo, E.EmpName, E.DOB, E.Phone, E.TaxFileNumber, D.DegreeID,
              rank() over (partition by E.EmpNo order by D.GraduationDate desc) as Rank
       from   Employee E, Emp_Degree D
       where  E.EmpNo = D.EmpNo ) T
where T.Rank = 1;

create table ContractFact as
select E.DegreeID, to_char(C.StartDate, 'YYYY') as Year, C.DeptNo,
       count(*) as Num_of_Contracts
from   EmployeeTemp E, Contract C
where  E.EmpNo = C.EmpNo
group by E.DegreeID, to_char(C.StartDate, 'YYYY'), C.DeptNo;
```
- **`rank() over (partition by … order by … desc)` + `where Rank = 1`** ➔ the latest-per-entity idiom; without it the join to `Contract` multiplies each contract by the employee's degree count.
- **Pre-processing sits on the source side** ➔ `EmployeeTemp` transforms operational data *before* the warehouse query, distinct from `TempFact` which stages warehouse-side rows.

## ✏️ Practice
> [!QUESTION]- Practice 1: Mobile-apps repository — `AppsDownloadFACT(TimeID, LocationID, CategoryID, UniversityID, TotalDownloads)` from `University`, `App_User`, `Download`, `Application`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > create table TempFact as
> > select to_char(D.DownloadDate, 'YYYYMM') as DownloadMonth,
> >        to_char(A.CreationDate, 'YYYYMM') as CreationMonth,
> >        U.Country || U.City as LocationID,
> >        A.CategoryID, A.ApplicationID, U.UniversityID
> > from   University U, App_User R, Download D, Application A
> > where  U.UniversityID = R.UniversityID
> > and    R.UserID       = D.DownloaderID
> > and    D.ApplicationID = A.ApplicationID;
> >
> > create table AppsDownloadFact as
> > select DownloadMonth as TimeID, LocationID, CategoryID, UniversityID,
> >        count(*) as TotalDownloads
> > from   TempFact
> > group by DownloadMonth, LocationID, CategoryID, UniversityID;
> > ```
> > - **Key move:** the TempFact carries **both** date keys, so the same staging table also answers the *Total Apps* variant — `count(distinct ApplicationID)` grouped on `CreationMonth` instead. Four tables ⟹ three join conditions.

> [!QUESTION]- Practice 2: why is `CollegeFact` built from `Student`, `Enrolment`, `Payment` rather than from `CountryDim`, `AgentDim`, `CourseDim`, `YearDim`?
> > [!SUCCESS]- Reference solution
> > - **Key move:** the dimensions were created with `select distinct` — they hold **one row per member and no measure column**, so nothing there can be summed or counted. The measures exist only in the transaction rows of the operational database, and the dimensions carry no FK back to them.

## ⚠️ Common Mistakes
- 💡 **Aggregating from the dimension tables** ➔ dimensions are de-duplicated lookups with no measures; the fact must read the operational tables.
- 💡 **Inner join where the two measures have different populations** ➔ unmatched rows vanish and the smaller measure silently overwrites the larger; use `left outer join` plus `count(attribute)`.
- 💡 **`count(*)` after an outer join** ➔ counts the NULL-padded rows too, so both measures come out equal; count the *attribute* that is NULL when unmatched.
- 💡 **Grouping on fewer columns than the fact's key** ➔ Oracle rejects the non-aggregated column, or the grain silently coarsens and the star can no longer answer its question.
