---
unit: FIT3003
week: [2, 3]
source: [lecture, slides, lab]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing]
aliases: [Dimension Table Creation, Temporary Dimension Table, TimeDimTemp]
type: pattern
---
# [[Building Dimension Tables]]

**Context:** [[FIT3003_MOC]] · step 1 of the [[Star Schema]] build, always done **before** [[Building Fact Tables]]
**Problem it solves:** turning operational tables into the de-duplicated lookup tables that supply the star's grouping attributes.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a dimension is named ➔ ask *can one `select` produce its rows?* If yes pick a direct route; if the dimension needs a **derived or banded** attribute, stage it in a temporary dimension.
> - **⚠️ Key Constraint:** a dimension holds **one row per member** ➔ `select distinct` whenever the source is a transaction table, or the fact's FK will not join uniquely.

## 🔧 Minimal Working Example
*(the three direct routes, in the order the chapter lists them)*
```sql
-- Route 1: direct copy — dimension = the operational table
create table AgentDim as select * from Agent;

-- Route 2: selected attributes — drop columns no analysis question needs
create table CourseDim as
select CourseCode, CourseName, Duration, CourseLevel from Course;

-- Route 2b: derived / de-duplicated attribute out of a transaction table
create table CountryDim as select distinct Country from Student;
create table YearDim    as select distinct EnrolmentYear from Enrolment;
create table LocationDim as
select distinct Country || City as LocationID, City, Country from University;
create table TimeDim as
select distinct to_char(DownloadDate, 'YYYYMM') as TimeID,
                to_char(DownloadDate, 'MM')     as Month,
                to_char(DownloadDate, 'YYYY')   as Year
from Download;

-- Route 3: manual — the members are business knowledge, not data
create table TimeDim (Quarter number(1), Description varchar2(20));
insert into TimeDim values (1, 'Jan-Mar');
insert into TimeDim values (2, 'Apr-Jun');
insert into TimeDim values (3, 'Jul-Sep');
insert into TimeDim values (4, 'Oct-Dec');
```
**Expected output:** one row per distinct member; $\text{COURSEDIM}(\underline{\text{CourseCode}}, \text{CourseName}, \text{Duration}, \text{CourseLevel})$, $\text{TIMEDIM}(\underline{\text{Quarter}}, \text{Description})$.

## 🗂️ Schema
- **Dimension ID is the PK** ➔ each dimension carries a Dimension ID; the same column sits in the fact as **FK and part of the composite PK**.
- **Composite text keys are built with `||`** ➔ `Country || City as LocationID` and `Year || Quarter as QuarterID` manufacture an ID the operational database never stored.
- **`to_char` is the time-dimension workhorse** ➔ `'YYYYMM'` builds a month key, `'YYYY'` / `'MM'` / `'Month'` extract the attributes to group by.
- **The dimension's job is query time, not build time** ➔ [[Building Fact Tables]] never reads it; it exists so a query can ask for `CourseName = 'MIT'` instead of `CourseCode = '60001'`, and so the result set carries a readable label.
- **Group on the code, join for the label** ➔ `select F.CourseCode, D1.CourseName, sum(…) … group by F.CourseCode, D1.CourseName` keeps the key in the grouping list, so a shared description cannot merge two members ➔ [[One-Attribute Dimensions]].

## 🔀 Variations
### Temporary dimension table (derived attribute the source cannot express)
*(Sales case: `TimeDim` needs `QuarterID` in `YYYYQ` format — the number of quarters present is unknown, so manual `insert` is neither safe nor efficient.)*
```sql
create table TimeDimTemp as                       -- 1. distinct raw grain
select distinct to_char(SalesDate, 'MM')   as Month,
                to_char(SalesDate, 'YYYY') as Year
from Sales;

alter table TimeDimTemp add (QuarterID char(5), Quarter char(1));   -- 2. empty derived cols

update TimeDimTemp set Quarter = '1' where Month >= '01' and Month <= '03';
update TimeDimTemp set Quarter = '2' where Month >= '04' and Month <= '06';
update TimeDimTemp set Quarter = '3' where Month >= '07' and Month <= '09';
update TimeDimTemp set Quarter = '4' where Month >= '10' and Month <= '12';   -- 3. band
update TimeDimTemp set QuarterID = Year || Quarter;                          -- 4. build key

create table TimeDim as                                                      -- 5. collapse
select distinct QuarterID, Quarter, Year from TimeDimTemp;
```
- **Why the final `distinct`** ➔ the temp table holds one row per *month*; three months collapse to one quarter member.
- **Banding is `update`, not `case`** ➔ the chapter derives every band with a separate `update … where` over the staged table.

## ✏️ Practice
> [!QUESTION]- Practice 1: Employment Agency — build `MonthDim` (month names of actual placements) and `DurationDim` (Short-Term <10 days, Medium-Term 10–30, Long-Term >30).
> > [!SUCCESS]- Reference solution
> > ```sql
> > create table MonthDim as
> > select distinct to_char(ActualStartDate, 'Month') as MonthName
> > from Placement;
> >
> > create table DurationDim (DurationID number, DurationDesc varchar2(20));
> > insert into DurationDim values (1, 'Short-Term');
> > insert into DurationDim values (2, 'Medium-Term');
> > insert into DurationDim values (3, 'Long-Term');
> > ```
> > - **Key move:** `MonthName` is *data* ➔ `select distinct` from the transaction table; `DurationDesc` is a *business band* with a fixed known membership ➔ create manually. The band boundaries themselves are applied later, in the fact's TempFact ➔ [[Building Fact Tables]].

> [!QUESTION]- Practice 2: Mobile-apps repository — `UniversityDim` must expose only the university's identity, while `LocationDim` must be keyed on country+city.
> > [!SUCCESS]- Reference solution
> > ```sql
> > create table UniversityDim as
> > select UniversityID, UniversityName from University;
> >
> > create table LocationDim as
> > select distinct Country || City as LocationID, City, Country
> > from University;
> > ```
> > - **Key move:** both dimensions read the *same* source table — `University` — but `LocationDim` needs `distinct` because many universities share a city, and `UniversityDim` does not because `UniversityID` is already unique.

## ⚠️ Common Mistakes
- 💡 **Omitting `distinct` on a transaction-sourced dimension** ➔ one dimension row per transaction instead of per member; the fact's FK then matches many rows and every aggregate is inflated.
- 💡 **Trying to derive a banded attribute in one `select`** ➔ the chapter's route is stage ➔ `alter add` ➔ `update` per band ➔ `select distinct`; skipping the temp table forces manual `insert` of an unknown number of rows.
- 💡 **`create table … as select` copies rows only** ➔ no PK/FK comes across ➔ [[Populating Tables from Queries (INSERT-SELECT, CTAS)]].
- 💡 **Grouping a report on a dimension's *description* instead of its key** ➔ `majorDIM` holds several majors sharing one `Major_Name`, so the "more meaningful" USELOG query returned $722$ rows where the code-based query returned $773$ — the readable answer was the inaccurate one ➔ [[Data Exploration (Warehouse Validation)]].

## 🧠 Active Recall
> [!FAQ]- If the fact table is never built from the dimension tables, why create them at all?
> > [!SUCCESS]- Answer
> > - **Short answer:** they supply the descriptive attributes a query needs to *ask* and to *label*, which the fact's bare keys cannot.
> > - **Why:** **The fact stores codes** ➔ `CollegeFact` holds `CourseCode = '60001'`, so "total income from the MIT course" is unanswerable from the fact alone. **The dimension resolves the name** ➔ joining `CourseDim` lets the predicate be `CourseName = 'MIT'` and puts the name in the output. **Build order and query order are opposite** ➔ dimensions are built first but read last; the fact is built from the operational tables ➔ [[Building Fact Tables]].
