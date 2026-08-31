---
unit: FIT3003
week: 6
source: [lecture, slides]
domain: C
parent: "[[Determinant Dimensions]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Pivoted Fact Table, Pivot Table, Non-Determinant Dimension Version, Column-based Solution]
---
# [[Pivoted Fact Tables]]

**Context:** [[FIT3003_MOC]] · route A for enforcing a [[Determinant Dimensions|determinant dimension]] — and the ETL job it creates
**Parent Framework:** [[Determinant Dimensions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** shift a dimension's **key identifier into the fact measures** ➔ each fact record becomes a $2\text{D}$ matrix between the surviving dimension keys and one measure per member of the removed dimension.
> - **📦 Core Components:** **build the determinant version first** ➔ the pivoted version is assembled *from* its fact tables, not from the source again.
> - **⚡ Key Constraint:** the determinant fact was built by **inner join**, so absent combinations have no row; the pivoted fact must show them as $0$ ➔ Cartesian product $+$ outer join $+$ `nvl`.

## 📝 How It Works
### 1. What the pivot does to the schema
- **Determinant version** ➔ $\text{PTE\_FACT}(\underline{\text{CountryCodeVenue}^{*}, \text{CountryCodeCitizen}^{*}, \text{Year}^{*}, \text{Grade}^{*}, \text{TestComponent}^{*}}, \text{Total\_Students})$ with a dashed `TestComponentDIM` holding `Listening, Reading, Writing, Speaking, Overall`.
- **Pivoted version** ➔ `TestComponentDIM` is deleted and the fact carries $\text{Total\_Students\_Listening}, \dots, \text{Total\_Students\_Overall}$; the remaining four dimension tables are **re-used unchanged**.
- **Row-count arithmetic** ➔ the pivoted fact must be the full grid: $2 \text{ venue countries} \times 6 \text{ citizenships} \times 1 \text{ year} \times 5 \text{ grades} = 60$ rows.
- **Naming** ➔ Chapter 10 calls this the **column-based solution in the fact**; the alternative, keeping the attribute as a key column with one row per member, is the **row-based solution** ➔ [[One-Attribute Dimensions]].

### 2. Pivoting without a determinant dimension — Private Taxi
- **Business rules state there is no determinant dimension** ➔ a dimension may still be shifted purely because its membership is small and fixed.
- **Five cars** ➔ $\text{PrivateTaxiFACT}$ keeps `DriverNo`, `MonthYear` and gains `CarNo1 … CarNo5` plus $3 \times 5 = 15$ measures (`Total_Kilometers_Car1`, `Total_Fuel_Used_Car1`, `Total_Income_Car1`, …).
- **Query cost explodes** ➔ retrieving the five cars' make and year needs **five aliases of `CarDim`** and five join conditions in one `where` clause.

## ⚙️ Core Implementation
### 🔹 Step 1 — the determinant version (PTE Academic Test)
> [!code]- `TempFact` ➔ band the scores ➔ one fact per component ➔ `union`
> ```sql
> create table TempFact as
> select TV.CountryCode, S.Citizenship,
>        to_char(T.TestDate, 'YYYY') as Year, TR.ListeningScore,
>        TR.ReadingScore, TR.WritingScore, TR.SpeakingScore,
>        TR.OverallScore, TR.RegistrationID
> from   Test_Venue TV, Test T, Student S, Test_Result TR
> where  TV.VenueID = T.VenueID
> and    T.TestNo = TR.TestNo
> and    TR.RegistrationID = S.RegistrationID;
>
> alter table TempFact add (GradeOverall varchar2(3), GradeListening varchar2(3),
>        GradeReading varchar2(3), GradeWriting varchar2(3), GradeSpeaking varchar2(3));
>
> update TempFact set GradeOverall =            -- the PTE band-scale, one case per component
> (case when OverallScore >= 30 and OverallScore <= 35 then '4.5'
>       when OverallScore >= 36 and OverallScore <= 49 then '5'
>       when OverallScore >= 50 and OverallScore <= 64 then '6'
>       when OverallScore >= 65 and OverallScore <= 78 then '7'
>       when OverallScore >= 79 and OverallScore <= 90 then '8-9' end);
>
> create table OverallFact as                   -- one temp fact per test component
> select CountryCode, Citizenship, Year, GradeOverall As Grade,
>        'Overall' as TestComponent, count(RegistrationID) as Total_Students_Overall
> from   TempFact
> group by CountryCode, Citizenship, Year, GradeOverall, 'Overall';
> -- create table ListeningFact / ReadingFact / WritingFact / SpeakingFact as select ...;
>
> create table FinalFact as select                -- stack them: 5 components, 1 measure
>   CountryCode, Citizenship, Year, Grade, TestComponent,
>   Total_Students_Overall as Total_Students
> from OverallFact
> union select * from ListeningFact
> union select * from ReadingFact
> union select * from WritingFact
> union select * from SpeakingFact;
> ```
> 💡 **Common Mistake:** **Trying to go straight from `TempFact` to the final fact** ➔ one source record carries all five component scores, so it must be **broken into five records**; that is what the five temp facts and the `union` exist to do.

### 🔹 Step 2 — the pivoted version, built from Step 1's facts
> [!code]- Cartesian product ➔ outer join with `nvl` ➔ join the five back together
> ```sql
> create table AllDimensions as                  -- every possible key combination (60 rows)
> select CO.CountryCode, CI.Citizenship, Y.Year, G.Grade
> from   CountryVenueDim CO, CitizenshipDim CI, YearDim Y, GradeDim G;
>
> create table OverallFactNew as                 -- re-attach measures, manufacturing the zeroes
> select A.CountryCode, A.Citizenship, A.Year, A.Grade,
>        nvl(O.Total_Students_Overall, 0) as Total_Students_Overall
> from   AllDimensions A, OverallFact O
> where  A.CountryCode = O.CountryCode(+)
> and    A.Citizenship = O.Citizenship(+)
> and    A.Year        = O.Year(+)
> and    A.Grade       = O.Grade(+);
> -- create table ListeningFactNew / ReadingFactNew / WritingFactNew / SpeakingFactNew as select ...;
>
> create table FinalFact2 as select              -- 5 measures side by side, 60 rows
>   O.CountryCode, O.Citizenship, O.Year, O.Grade,
>   O.Total_Students_Overall, L.Total_Students_Listening,
>   R.Total_Students_Reading, W.Total_Students_Writing, S.Total_Students_Speaking
> from OverallFactNew O, ListeningFactNew L, ReadingFactNew R,
>      WritingFactNew W, SpeakingFactNew S
> where O.CountryCode = L.CountryCode and L.CountryCode = R.CountryCode
> and   R.CountryCode = W.CountryCode and W.CountryCode = S.CountryCode
> and   O.Citizenship = L.Citizenship and L.Citizenship = R.Citizenship
> and   R.Citizenship = W.Citizenship and W.Citizenship = S.Citizenship
> and   O.Year = L.Year and L.Year = R.Year and R.Year = W.Year and W.Year = S.Year
> and   O.Grade = L.Grade and L.Grade = R.Grade and R.Grade = W.Grade and W.Grade = S.Grade;
> ```
> 💡 **Common Mistake:** **Omitting `AllDimensions` and outer-joining the component facts to each other** ➔ a combination missing from *all five* facts is then still missing; only the deliberate Cartesian product guarantees all $60$ rows exist before `nvl` fills them.

## ⚖️ Core Decision Matrix
| Aspect | Determinant version (dimension kept) | Pivoted version (dimension shifted) |
| :--- | :--- | :--- |
| Storage | ✅ narrower fact, one measure | ❌ one measure per member; zeroes stored explicitly |
| Modelling clarity | ✅ the analysis axis is visible in the star | ❌ the axis is hidden inside column names |
| Query joins | ❌ one extra join to reach the member | ✅ fewer joins — the member is a column |
| Correctness enforcement | ❌ a query may omit it and return nonsense | ✅ omission is impossible |
| Dimension's other attributes | ✅ retained (`Description`, `MinScore`, `MaxScore`) | ❌ **lost** — only the key identifier survives |
| Adding a new member | one `insert` into the dimension | `alter table … add` $+$ rebuild the fact |

> [!NOTE] **When It Flips:** the pivot stops being an option once the determinant dimension has **many records** (a thousand measures is impractical) or **many attributes** worth keeping — at that point the only remaining enforcement is the user-interface route ➔ [[Determinant Dimensions]].

## 🧠 Active Recall
> [!FAQ]- Why does the pivoted fact need a Cartesian product and outer joins, when the determinant fact needed neither?
> > [!SUCCESS]- Answer
> > - **Short answer:** because the pivot turns *absent rows* into *required zeroes*, and an inner-joined fact simply has no row for a combination that never occurred.
> > - **Why:** **Rows vs columns carry absence differently** ➔ in the determinant version, "Italy won no Silver" is expressed by the row not existing; in the pivoted version there is one row per key combination, so the fact **must** hold an explicit $\text{Num\_of\_Silver} = 0$. **The grid must exist before it can be filled** ➔ `AllDimensions` is the Cartesian product of every surviving dimension, which is exactly the set of rows the pivoted fact is defined to have. **`(+)` plus `nvl` does the filling** ➔ the Oracle outer join keeps every grid row and `nvl(measure, 0)` replaces the padded NULL.
