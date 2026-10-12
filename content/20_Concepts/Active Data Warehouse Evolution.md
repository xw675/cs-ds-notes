---
unit: FIT3003
week: 11
source: [slides]
domain: C
parent: "[[Active Data Warehousing]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Data Warehousing Schema Evolution, Schema Evolution, Operational Database Evolution, Inserting a Star Schema, Deleting a Star Schema]
---
# [[Active Data Warehouse Evolution]]

**Context:** [[FIT3003_MOC]] · [[Active Data Warehousing]] keeps the *data* current; this note handles the *design* changing underneath it — from the warehouse's own requirements (§2–§5) or from the operational source (§6) · reuses [[Levels of Aggregation]], [[Combining Star Schemas]], [[Multi-Input Operational Databases]]
**Parent Framework:** [[Active Data Warehousing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** an active warehouse is **time-boundless**, so its requirements and sources drift ➔ for any change, name the level it **enters**, whether it **propagates** upward, and which dimensions, TempFacts, facts and triggers must be rebuilt.
> - **📦 Core Components:** **warehouse schema evolution** ➔ change propagates up · change stays local · insert a star · delete a star | **operational database evolution** ➔ table structure · E/R schema · whole system replaced, each met by **Option 1 update the existing stars** or **Option 2 build new ones**.
> - **⚡ Key Constraint:** propagation follows **build dependency, not level number** ➔ an upper star is hit only if one of its objects is **built from** the changed one; a dimension sourced straight from the operational table, or a star nothing is built from, stops the ripple.

## 📝 How It Works
### 1. The dependency map — draw it first
- **Level-0 fact** ⟵ `LabActivities` $+$ `Student` (operational).
- **Level-1 dimensions** (`SemesterYearDIM`, `TimePeriodDIM`) ⟵ `LabActivities` **directly**, not a lower star.
- **Level-1 TempFact** ⟵ the Level-0 fact; **Level-1 fact** ⟵ its TempFact.
- **Level-2 fact** ⟵ a **view** over the Level-1 fact; Level-2 dimensions **reused** from Level-1.
- **Method** ➔ find the changed object, follow every arrow leaving it; whatever is reached must change, whatever is not is safe.

### 2. Change propagating to upper levels — Semester gains Year
- **Requirement** ➔ Semester holds no Year, so analysis is by semester alone; add Year ➔ one record per semester **per year**.
- **Level-0** ➔ no change: Semester first appears at Level-1.
- **Level-1 dimension** ➔ $\text{SemesterDIM}$ becomes $\text{SemesterYearDIM}(\underline{\text{SemYearID}}, \text{Semester}, \text{Year}, \text{Description})$, built once from `distinct LoginDate`, then **maintained** by trigger `AddSemesterYear` on `LabActivities` — find-or-insert, because every half-year brings a new member.
- **Level-1 TempFact and fact** ➔ rebuilt on `SemYearID = Year || Semester`; the fact's increment trigger must be **find-or-insert**, since every new semester opens key combinations with no fact row yet.
- **Level-2** ➔ the view is re-declared on `SemYearID` — propagation is "more at the **schema design** level than at the technical implementation level".

### 3. Change not affecting upper levels — ComputerDIM added to Level-0
- **Level-0** ➔ the fact gains `ComputerID` (in the `group by`, with an FK), and its insert trigger must carry `:new.ComputerID`.
- **Level-1 / Level-2** ➔ untouched: their granularity is already reduced to semester and time period, so a computer axis has no place there.

### 4. Inserting a new star — Sub-Level-1 at Month × Hour
- **Why** ➔ the jump from Login Date/Time to Semester Year/Time Period is wide; a star at month and hour sits between them.
- **Dimensions** ➔ `MonthDIM` built **and maintained** by trigger `AddMonthYear` (find-or-insert on `YYYYMM`); `HourDIM` created once with all $24$ hours ➔ never maintained; `DegreeDIM`, `StudentDIM` **reused** from Level-0.
- **Fact** ➔ a **view** over the Level-0 fact ➔ no trigger.
- **Impact above** ➔ **none**: Level-1 dimensions come from `LabActivities`, its TempFact from Level-0, Level-2 from Level-1 — nothing is built from the new star.

### 5. Deleting a star — remove Level-1
- **Dimensions** ➔ **kept**: Level-2 shares three of them.
- **Fact** ➔ only the Level-1 fact goes — but the Level-2 fact is a view **over** it, so Level-2 loses its source and must be rebuilt from what survives.

### 6. Operational database evolution
- **Table structure** ➔ `LogoutTime` is now recorded ➔ new measure `Total_Duration`. **Option 1:** `alter table ComputerLabFactLevel0 add Total_Duration date;` and the insert trigger stores `:new.LogoutTime - :new.LoginTime` — **new records only**, old ones have no logout time; upper levels follow the same way. **Option 2:** build a new warehouse, justified when the star "now has new requirements".
- **E/R schema** ➔ new entities `ROOM` (via `COMPUTER.RoomNumber`) and `SOFTWAREACCESS`–`SOFTWARE` off `LABACTIVITIES` ➔ **two Level-0s**: **0a** at **login** grain ($\text{ComputerDIM}$ absorbs `RoomNumber`, `BuildingNumber`; measures `Num_of_Logins`, `Total_Duration`) and **0b** at **software-access** grain ($+\text{SoftwareDIM}$; measure `Total_Accesses`). Each needs its own trigger; changes then propagate upward.
- **Whole system replaced** ➔ the new lab system has **no Degree entity**; degree now lives in a separate **Student Enrolment** database as $\text{ENROLMENT}(\underline{\text{StudentNo}^{*}, \text{DegreeCode}^{*}, \text{SemYearID}}, \text{StudyType})$ — a student's degree is recorded **per semester**. **Option 1:** keep the star; the fact trigger fetches `DegreeCode` from `StudentEnrolmentDatabase.Enrolment` matching `StudentNo` **and** the login's `SemYearID`. **Option 2:** one star per source — $\text{ComputerLabFACT0a}$ (lab: LoginDate, LoginTime, StudentNo, ComputerID) and $\text{ComputerLabFACT0b}(\underline{\text{StudentNo}^{*}, \text{SemYearID}^{*}, \text{DegreeCode}^{*}})$ — then **merge** into a final fact, kept current by a trigger on 0a ➔ [[Combining Star Schemas]].

## ⚙️ Core Implementation
### 🔹 A maintained dimension — `SemesterYearDIM`
> [!code]- Build once, then find-or-insert per login
> ```sql
> create table SemesterYearDimTemp as select distinct LoginDate from LabActivities;
> alter table SemesterYearDimTemp add (SemYearID varchar2(10), Semester varchar2(2),
>                                      Year varchar2(4), Description varchar2(20));
> update SemesterYearDimTemp set Semester = 'S1'
> where  to_char(LoginDate,'MM/DD') >= '01/01' and to_char(LoginDate,'MM/DD') <= '06/30';
> update SemesterYearDimTemp set Semester = 'S2' where Semester is null;
> update SemesterYearDimTemp set Year = to_char(LoginDate,'YYYY');
> update SemesterYearDimTemp set SemYearID = Year || Semester;          -- '2021S1'
> create table SemesterYearDim as
> select distinct SemYearID, Semester, Year, Description from SemesterYearDimTemp;
>
> create or replace trigger AddSemesterYear
>   after insert on LabActivities
>   for each row
> declare
>   TempSemester       SemesterYearDim.Semester%type;
>   TempYear           SemesterYearDim.Year%type;
>   TempSemesterYearID SemesterYearDim.SemYearID%type;
>   IsFound            number;
> begin
>   if to_char(:new.LoginDate,'MM/DD') <= '06/30' then TempSemester := 'S1';
>   else TempSemester := 'S2'; end if;
>   TempYear           := to_char(:new.LoginDate,'YYYY');
>   TempSemesterYearID := TempYear || TempSemester;                     -- same order as the build
>   select count(*) into IsFound from SemesterYearDim where SemYearID = TempSemesterYearID;
>   if IsFound = 0 then
>     insert into SemesterYearDim values (TempSemesterYearID, TempSemester, TempYear, null);
>     commit;
>   end if;
> end AddSemesterYear;
> ```
> 💡 **Common Mistake:** **Building the key in two orders** ➔ slide 68's trigger writes `TempSemester || TempYear` (`'S12021'`) while the build and the TempFact use `Year || Semester` (`'2021S1'`); `IsFound` is then always $0$ and every semester is inserted again under a key no fact row matches.

### 🔹 A new star as a view — Sub-Level-1
> [!code]- `ComputerLabFactSubLevel1`
> ```sql
> create or replace view ComputerLabFactSubLevel1 as
> select to_char(LoginDate,'YYYY') || to_char(LoginDate,'MM') as MonthID,
>        to_char(LoginTime,'HH24')                            as HourID,
>        DegreeCode, StudentNo,
>        sum(Num_of_Logins) as Num_of_Logins
> from   ComputerLabFactLevel0
> group by to_char(LoginDate,'YYYY') || to_char(LoginDate,'MM'),
>          to_char(LoginTime,'HH24'), DegreeCode, StudentNo;
> ```
> 💡 **Common Mistake:** **Slide 88's `sum(StudentNo)`** ➔ adds student numbers together; re-aggregating the Level-0 measure is `sum(Num_of_Logins)` (slide 87's table version counts from the source instead).

### 🔹 E/R change — Level-0b at software-access grain
> [!code]- Fact $+$ trigger climbing from child to parent
> ```sql
> create table ComputerLabFactLevelNew0b as
> select distinct LoginDate, LoginTime, S.DegreeCode, L.StudentNo, L.ComputerID, A.SoftwareID,
>        count(*) as Total_Accesses
> from   Student S, LabActivities L, SoftwareAccess A
> where  S.StudentNo = L.StudentNo and L.LoginNo = A.LoginNo
> group by LoginDate, LoginTime, S.DegreeCode, L.StudentNo, L.ComputerID, A.SoftwareID;
>
> create or replace trigger UpdateFactLevelNew0b
>   after insert on SoftwareAccess
>   for each row
> declare
>   v_StudentNo  LabActivities.StudentNo%type;
>   v_LoginDate  LabActivities.LoginDate%type;
>   v_LoginTime  LabActivities.LoginTime%type;
>   v_ComputerID LabActivities.ComputerID%type;
>   v_Degree     Student.DegreeCode%type;
> begin
>   select StudentNo, LoginDate, LoginTime, ComputerID
>   into   v_StudentNo, v_LoginDate, v_LoginTime, v_ComputerID
>   from   LabActivities where LoginNo = :new.LoginNo;   -- the access row only knows its login
>   select DegreeCode into v_Degree from Student where StudentNo = v_StudentNo;
>   insert into ComputerLabFactLevelNew0b
>   values (v_LoginDate, v_LoginTime, v_Degree, v_StudentNo, v_ComputerID, :new.SoftwareID, 1);
>   commit;
> end UpdateFactLevelNew0b;
> ```
> 💡 **Common Mistake:** **Locals named like columns** ➔ the slide names its variables `StudentNo`, `LoginDate`…; inside SQL a column name wins, so `where StudentNo = StudentNo` is true for every row. Prefix locals (`v_`). The slide's CTAS also omits `ComputerID`, which its diagram and trigger carry.

### 🔹 Option 2 merge — degree from the enrolment star
> [!code]- Copy 0a, derive `SemYearID`, fill `DegreeCode` from 0b
> ```sql
> create table ComputerLabFactNew0a as select * from ComputerLabFact0a;
> alter table ComputerLabFactNew0a add (DegreeCode varchar2(10), SemYearID varchar2(10),
>                                      Semester varchar2(2), Year varchar2(4));
> update ComputerLabFactNew0a set Semester = 'S1'
> where  to_char(LoginDate,'MM/DD') >= '01/01' and to_char(LoginDate,'MM/DD') <= '06/30';
> update ComputerLabFactNew0a set Semester = 'S2' where Semester is null;
> update ComputerLabFactNew0a set Year = to_char(LoginDate,'YYYY');
> update ComputerLabFactNew0a set SemYearID = Year || Semester;
> alter table ComputerLabFactNew0a drop (Semester, Year);
>
> update ComputerLabFactNew0a N                          -- this student's degree in THIS semester
> set    N.DegreeCode = (select B.DegreeCode from ComputerLabFact0b B
>                        where  B.StudentNo = N.StudentNo and B.SemYearID = N.SemYearID);
> alter table ComputerLabFactNew0a drop (SemYearID);     -- temporary join key, not a dimension
> ```
> 💡 **Common Mistake:** **Slide 122's `set DegreeCode = ComputerLabFact0b.DegreeCode where …`** ➔ Oracle's `update` has no `from`, so a second table can only enter through a correlated subquery, as above.

## ⚖️ Core Decision Matrix
| Change | Enters at | Propagates up? | What is rebuilt |
| :--- | :--- | :--- | :--- |
| Year added to Semester | Level-1 dimension | ✅ to Level-2 | `SemesterYearDIM` $+$ trigger; TempFact, fact, find-or-insert trigger; Level-2 view re-declared |
| ComputerDIM added | Level-0 fact | ❌ — Level-1 is already coarser | Level-0 column, FK, trigger |
| Sub-Level-1 inserted | a new star | ❌ — nothing is built from it | `MonthDIM` $+$ trigger, static `HourDIM`, fact view |
| Level-1 deleted | Level-1 fact | ✅ — the Level-2 view loses its source | Level-2 fact re-sourced; shared dimensions kept |
| `LogoutTime` recorded | Level-0 measure | ✅ (Option 1) | `Total_Duration` column $+$ trigger, then upper levels |
| New entities in the E/R | a second Level-0 | ✅ | Level-0b fact $+$ trigger, then upper levels |
| Operational system replaced | every source lookup | ✅ | Option 1: re-point the trigger's lookup · Option 2: two stars $+$ merge $+$ trigger on 0a |

> [!NOTE] **When It Flips:** a change between two levels propagates only when an existing star is **built from** the changed object — Sub-Level-1 sits between Level-0 and Level-1 yet touches nothing, while a dimension change at Level-1 reaches Level-2 through its view.

## 🧠 Active Recall
> [!FAQ]- Inserting Sub-Level-1 leaves Level-1 and Level-2 untouched, but adding Year to Semester reaches Level-2. Both changes sit "between" Level-0 and Level-2 — what separates them?
> > [!SUCCESS]- Answer
> > - **Short answer:** whether anything is **built from** the changed object.
> > - **Why:** **Sub-Level-1 is a leaf** ➔ Level-1's dimensions come from `LabActivities` and its TempFact from the Level-0 fact, so no arrow leaves the new star. **SemesterYearDIM is a source** ➔ the Level-1 TempFact and fact are keyed on it, and Level-2 is a view over that fact re-using the dimension, so the new key must be carried up. **Level number is irrelevant** ➔ the dependency map decides.

> [!FAQ]- After the system change, why must the degree lookup match on `SemYearID` as well as `StudentNo`?
> > [!SUCCESS]- Answer
> > - **Short answer:** the enrolment system records a degree **per student per semester**, so `StudentNo` alone can return several degrees.
> > - **Why:** **The PK says so** ➔ $\text{ENROLMENT}$ is keyed on $(\text{StudentNo}, \text{DegreeCode}, \text{SemYearID})$. **A login has a date** ➔ deriving its `SemYearID` and matching on both picks the degree the student was enrolled in **when they logged in**. **Without it** ➔ a `select … into` raises an error on multiple rows, and a correlated update returns more than one row per fact row.

> [!FAQ]- When Level-1 is deleted, its dimensions are kept. Why does Level-2 still break?
> > [!SUCCESS]- Answer
> > - **Short answer:** the dimensions are shared, but Level-2's **fact** is a view over the Level-1 fact, which is gone.
> > - **Why:** **Two kinds of dependency** ➔ *sharing* a dimension survives the delete because the table still exists; *building from* a fact does not, because the view's `select` names a dropped table. **Fix** ➔ Level-2's fact must be rebuilt on a surviving lower source.
