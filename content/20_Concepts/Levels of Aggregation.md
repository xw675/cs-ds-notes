---
unit: FIT3003
week: 8
source: [lecture, slides, applied]
domain: C
parent: "[[Data Warehouse]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Data Warehousing Granularity, Level of Aggregation, Level-0, Facts without Fact Measures, Granularity]
---
# [[Levels of Aggregation]]

**Context:** [[FIT3003_MOC]] · the ladder of star schemas over ONE subject — how far the fact measure has been rolled up, and how to push it back down ➔ [[Star Schema]], [[Identifying a Level-0 Star Schema]], [[Fact Constellation]]
**Parent Framework:** [[Data Warehouse]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a warehouse is **precomputed aggregate values** ➔ keep the same subject at several granularities, $\text{Level-}0$ (no aggregation, most detail) up to $\text{Level-}n$ (most aggregated), so management can **drill down** by querying the level below.
> - **📦 Core Components:** **add a new dimension** ➔ breaks each measure value across the new dimension's members | **replace a dimension with a higher-granularity one** ➔ breaks it across finer members of the same axis.
> - **⚡ Key Constraint:** given a star schema you can only decide **Level-0 or not** — any other number depends on how many non-Level-0 schemas sit beneath it, so the numbering is a property of the **architecture**, never of one diagram.

## 📝 How It Works
### 1. Granularity and aggregation are inverse
- **Level-0 definition** ➔ **highest granularity, no aggregation**: all domain tables are incorporated as dimension tables and **no grouping exists in the dimension attributes**.
- **Inverse pairing** ➔ lower granularity $\Rightarrow$ higher aggregation $\Rightarrow$ higher level number; because warehousing is about aggregates, the ladder is named *Level of Aggregation*.
- **Only one rule** ➔ $\text{Level-}(x+1)$ is more aggregated than $\text{Level-}x$. There is **no guideline** on how many levels a warehouse needs, and **more than one star schema may sit at the same level**.
- **A date dimension may not reach Level-0** ➔ Oracle's `date` displays only the date portion, so two orders placed by one customer on one day collapse into a single fact row; a true Level-0 `DateDIM` must store the **full date and time** to separate them ➔ [[Identifying a Level-0 Star Schema]].
- **The measure betrays the level** ➔ `Num_of_Logins` is `count(*)` over the `LABACTIVITIES` transaction table grouped by Semester, TimePeriod and Degree — a `count` in the build SQL proves the schema is **not** Level-0 ➔ [[Building Fact Tables]].

### 2. The two ways to lower a level *(the only two)*
- **Add a new dimension** ➔ each measure value is literally broken into one value per record of the new dimension; Computer Lab adds $\text{StudentDIM}$ and the Level-2 schema becomes Level-1, answering **who** contributed to the total.
- **Replace with a higher-granularity dimension** ➔ swap $\text{SemesterDIM} \to \text{LoginDateDIM}$ and $\text{TimePeriodDIM} \to \text{LoginTimeDIM}$; the same measure now sits at the actual login date and time, giving Level-0.
- **A replacement can absorb two dimensions** ➔ lowering may *reduce* the dimension count, e.g. a $\text{PurchaseOrderDIM}$ that captures both Order Date and Ordering Method ➔ [[Identifying a Level-0 Star Schema]].
- **Count the aggregated dimensions first** *(Lab 8a)* ➔ scan the Level-$n$ star for dimensions that **bucket** something finer (Season buckets dates, Location buckets customers); a dimension already at its finest (Ordering Source) is not a candidate. **Level-1 lowers one of them, Level-0 lowers them all.**
- **Level-1 has no unique answer** ➔ the lab marks any schema strictly below Level-2 and strictly above Level-0 as correct; the verdict for **Level-0** is the strict one — check that the fact measure carries **no aggregation** at all.
- **Design starts high, not low** ➔ a Level-0 schema holds the same data as the operational database, only restructured, which makes "why build a star at all?" unanswerable; start where the measures are obviously aggregates and lower from there.

### 3. Levels are a partial order, not a chain
- **Incomparable siblings** ➔ Level-1a keyed on $(\text{MonthID}, \text{TimeID})$ and Level-1b keyed on $(\text{SemesterID}, \text{HourID})$: $\text{MonthID}$ is finer than $\text{SemesterID}$ but $\text{TimeID}$ is coarser than $\text{HourID}$ — **neither is more general**.
- **What is still decidable** ➔ both are strictly below Level-2 and strictly above Level-0, so they share a level number without being comparable.
- **The exam question is binary** ➔ for any two schemas, answer "$A$ is more general than $B$" **or** "not comparable"; never invent a ranking ➔ [[Fact Constellation]].

### 4. Facts without fact measures
- **All-ones measure is redundant** ➔ at Level-0 a `count` measure is $1$ on every row, so the measure may be **dropped entirely**; $\text{ComputerLabFACT}$ then holds nothing but its composite key.
- **Precondition: the measure must be a count** ➔ a `sum` measure such as `Total_Sales` still carries a per-transaction amount at Level-0 and **cannot** be removed.
- **Merging dimensions does not change granularity** ➔ folding $\text{LoginDateDIM}$ and $\text{LoginTimeDIM}$ into one $\text{LabActivitiesDIM}$ keyed on `LoginNo` keeps Level-0, because there is exactly **one login per** `LoginNo`.
- **The star is an $n$-ary relationship** ➔ the measure-less Level-0 fact contains all the information of the E/R diagram, restructured: dimensions $=$ entities, fact $=$ the transaction relating them.

### 5. Implementation
- **Level-0 is physical, upper levels are derived** ➔ Level-0 is built with `create table`; the upper-level star schemas are normally implemented as **views** over it.
- **The top level is the dashboard** ➔ the most aggregated schema is what an interactive management dashboard reads.

## 🗂️ Schema
$$\text{ComputerLabFACT}_{\text{L2}}(\underline{\text{SemesterID}^{*}, \text{TimeID}^{*}, \text{DegreeCode}^{*}}, \text{Num\_of\_Logins})$$
$$\text{ComputerLabFACT}_{\text{L1}}(\underline{\text{SemesterID}^{*}, \text{TimeID}^{*}, \text{DegreeCode}^{*}, \text{StudentNo}^{*}}, \text{Num\_of\_Logins})$$
$$\text{ComputerLabFACT}_{\text{L0}}(\underline{\text{LoginNo}^{*}, \text{ComputerID}^{*}, \text{DegreeCode}^{*}, \text{StudentNo}^{*}})$$
> [!code]- Mermaid — the Level-0 fact, measure-less, with the merged Lab Activities dimension
> ```mermaid
> erDiagram
>   LABACTIVITIES_DIM ||--o{ COMPUTERLAB_FACT : qualifies
>   COMPUTER_DIM      ||--o{ COMPUTERLAB_FACT : qualifies
>   DEGREE_DIM        ||--o{ COMPUTERLAB_FACT : qualifies
>   STUDENT_DIM       ||--o{ COMPUTERLAB_FACT : qualifies
>   COMPUTERLAB_FACT {
>     NUMBER LoginNo FK
>     NUMBER ComputerID FK
>     VARCHAR2 DegreeCode FK
>     NUMBER StudentNo FK
>   }
>   LABACTIVITIES_DIM {
>     NUMBER LoginNo PK
>     DATE LoginDate
>     DATE LoginTime
>   }
>   COMPUTER_DIM {
>     NUMBER ComputerID PK
>     VARCHAR2 ComputerModel
>     VARCHAR2 ComputerOS
>     VARCHAR2 RoomNumber
>   }
>   DEGREE_DIM {
>     VARCHAR2 DegreeCode PK
>     VARCHAR2 DegreeName
>     NUMBER DegreeDuration
>   }
>   STUDENT_DIM {
>     NUMBER StudentNo PK
>     VARCHAR2 FirstName
>     VARCHAR2 StudyType
>   }
> ```
> 💡 **Common Mistake:** **Keeping `Num_of_Logins` in the Level-0 fact** ➔ every row would read $1$; the count only becomes informative once a level above groups it.

## ⚖️ Core Decision Matrix
| Method | Trigger condition | Effect on the measure | Effect on the dimension count |
| :--- | :--- | :--- | :--- |
| Add a new dimension | the needed detail is an **entity the fact never referenced** (which student, which computer) | each value splits across the new dimension's members | $+1$ |
| Replace with a higher-granularity dimension | the needed detail is a **finer version of an existing axis** (Semester ➔ LoginDate) | each value splits along the same axis | $0$, or $-1$ when the replacement absorbs two old dimensions |

> [!NOTE] **When It Flips:** replacement is forced once an existing dimension is already at its finest (Order Date and Ordering Method cannot be broken down further) — then only *another* dimension can be made more detailed.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — drilling the Computer Lab ladder
| Level | Fact key | Sample row | Measure | Reading |
| :--- | :--- | :--- | :--- | :--- |
| Level-2 | Semester, TimePeriod, Degree | S1 · 3 · BIT | $1500$ | BIT logins at night in S1 |
| Level-1 | $+$ StudentNo | S1 · 3 · BIT · 21002 | $120$ | one student's share; the column **must** sum to $1500$ |
| Level-1a | MonthID, TimePeriod, Degree, Student | May · 3 · BIT · 21002 | $25$ | that student's May night logins |
| Level-1b | Semester, HourID, Degree, Student | S1 · 6:00–6:59pm · BIT · 21002 | $25$ | the same student, by hour, **not comparable** with Level-1a |
| Level-0 | LoginDate, LoginTime, Degree, Student | 4-Apr · 19:00 · BIT · 21002 | $1$ | one actual login ➔ the measure is droppable |

- **The reconciliation check** ➔ every drill-down must preserve the total: $\sum$ Level-1 rows under a Level-2 cell $=$ that cell. A mismatch means the lower fact was built from a different join, not a finer grouping.

### Applied Exercise 1 — Clothing Company *(Lab 8a, Case Study 1)*
**Problem:** the Level-2 star is $\text{ClothingCompanyFACT}(\underline{\text{SeasonID}^{*}, \text{OSourceID}^{*}, \text{CLocationID}^{*}}, \text{Total\_Order\_Quantity}, \text{Total\_Order\_Cost})$ over $\text{SeasonDIM}(\underline{\text{SeasonID}}, \text{SeasonDescription}, \text{Start\_Month}, \text{End\_Month})$, $\text{LocationDIM}(\underline{\text{CLocationID}}, \text{City})$ and $\text{OSourceDIM}(\underline{\text{SourceID}})$. Source tables: `CUSTOMER1`, `ORDER1`, `ORDER_INV1`, `INVENTORY1`, `ITEM1`. Draw Level-1 and Level-0.
> [!QUESTION]- Attempt both levels cold, then expand.
> > [!SUCCESS]- Model answer
> > - **Aggregated dimensions:** $\text{SeasonDIM}$ (buckets order dates) and $\text{LocationDIM}$ (buckets customers by city); $\text{OSourceDIM}$ is already at its finest.
> > - **Level-1 — lower exactly one:**
> > $$\text{ClothingCompanyFACT}_{\text{L1}}(\underline{\text{OrderDate}^{*}, \text{OSourceID}^{*}, \text{CLocationID}^{*}}, \text{Total\_Order\_Quantity}, \text{Total\_Order\_Cost})$$
> > with $\text{SeasonDIM}$ replaced by $\text{OrderDateDIM}(\underline{\text{OrderDate}})$. Lowering $\text{LocationDIM} \to \text{CustomerDIM}$ instead is equally acceptable.
> > - **Level-0 — lower both:**
> > $$\text{ClothingCompanyFACT}_{\text{L0}}(\underline{\text{OrderDate}^{*}, \text{OSourceID}^{*}, \text{CustID}^{*}}, \text{Total\_Order\_Quantity}, \text{Total\_Order\_Cost})$$
> > with $\text{CustomerDIM}(\underline{\text{CustID}}, \text{LName}, \text{FName}, \text{Address}, \text{Phone}, \text{City})$ — $\text{City}$ moves **inside** the customer dimension, so $\text{LocationDIM}$ disappears.
> > - **Key move:** the number of dimensions is unchanged at Level-1 and Level-0 here — a *replacement*, never an addition, because both offenders are coarse versions of axes the fact already has.
> > - ⚠️ $\text{OrderDate}$ only reaches Level-0 if it carries the **time** as well; on a bare Oracle `date` two same-day orders from one customer still merge.

### Applied Exercise 2 — Toll Way *(Lab 8a, Case Study 2)*
**Problem:** a toll way records, per passage, the gate, registration number, vehicle type, amount paid, and date/time. Management wants **revenue** drilled down by **toll gate**, **day of week** and **time period of a day**. Draw Level-2, Level-1 and Level-0.
> [!QUESTION]- Write all three, then expand.
> > [!SUCCESS]- Model answer
> > - **Level-2 — the three required axes, all bucketed:**
> > $$\text{TollFACT}_{\text{L2}}(\underline{\text{GateID}^{*}, \text{DayID}^{*}, \text{TimeID}^{*}}, \text{Total\_Payment})$$
> > over $\text{ExitGateDIM}(\underline{\text{GateID}}, \text{Gate\_Location\_Desc})$, $\text{DayofWeekDIM}(\underline{\text{DayID}})$ and $\text{TimeDIM}(\underline{\text{TimeID}}, \text{Time\_Desc})$ — day of **week**, not the date; time **period**, not the clock time.
> > - **Level-1 — add a dimension:**
> > $$\text{TollFACT}_{\text{L1}}(\underline{\text{GateID}^{*}, \text{DayID}^{*}, \text{TimeID}^{*}, \text{VehicleTypeID}^{*}}, \text{Total\_Payment})$$
> > with $\text{VehicleTypeDIM}(\underline{\text{VehicleTypeID}}, \text{Vehicle\_Type\_Desc})$; the grain is the **type** (car, bus, truck), **not** the registration number, and the other three dimensions are untouched.
> > - **Level-0 — replace all three:**
> > $$\text{TollFACT}_{\text{L0}}(\underline{\text{GateID}^{*}, \text{TravelDate}^{*}, \text{TravelTime}^{*}, \text{Car\_Registration\_Number}^{*}}, \text{Total\_Payment})$$
> > with $\text{DateDIM}(\underline{\text{TravelDate}})$, $\text{TimeDIM}(\underline{\text{TravelTime}})$ and $\text{CarDIM}(\underline{\text{Car\_Registration\_Number}}, \text{Model}, \text{Year})$ — actual date, actual time, actual vehicle.
> > - **Key move:** this case uses **both** lowering methods — addition to reach Level-1 (vehicle type was never an axis), replacement to reach Level-0 (each existing axis had a finer version waiting in the source).
> > - **Why `Total_Payment` survives to Level-0:** it is a `sum`, not a `count`, so it keeps a real per-passage amount and cannot be dropped.

## ⚠️ Common Mistakes
- 💡 **"It has all the detailed dimensions, so it is Level-0"** ➔ lowest-level dimensions do **not** guarantee an unaggregated measure; the E/R transaction decides ➔ [[Identifying a Level-0 Star Schema]].
- 💡 **Numbering a schema from its own diagram** ➔ only "Level-0 or not" is visible locally; everything else is relative to the schemas built below it.
- 💡 **Ranking two same-level schemas** ➔ if one dimension is finer and another is coarser, they are **incomparable** — asserting an order is a mark-loss answer.

## 🧠 Active Recall
> [!FAQ]- The Computer Lab star has Semester, Time Period and Degree dimensions and one measure. Management wants the breakdown of a $1500$ figure. What do you build, and which method do you use first?
> > [!SUCCESS]- Answer
> > - **Short answer:** build a **lower** level — first **add** $\text{StudentDIM}$, then **replace** Semester and Time Period with Login Date and Login Time.
> > - **Why:** **Drill-down is a query against a lower level** ➔ the existing fact physically stores only the rolled-up value, so the detail must exist as another star schema. **Addition is the cheaper move** ➔ $\text{StudentDIM}$ comes from a table already in the operational database and answers "who", splitting $1500$ into per-student counts that must re-sum to $1500$. **Replacement is the deeper move** ➔ only swapping $\text{SemesterDIM} \to \text{LoginDateDIM}$ reaches the actual date and time, where the measure degenerates to $1$ and the fact may drop it.

> [!FAQ]- Level-1a is keyed on Month and Time Period; Level-1b on Semester and Hour. Which has the higher level of aggregation?
> > [!SUCCESS]- Answer
> > - **Short answer:** neither — they are **not comparable**.
> > - **Why:** **Comparability needs agreement on every axis** ➔ $\text{MonthID}$ is finer than $\text{SemesterID}$ but $\text{TimeID}$ is coarser than $\text{HourID}$, so the two schemas disagree in opposite directions. **The bounds still hold** ➔ both are below the Semester/TimePeriod Level-2 and above the LoginDate/LoginTime Level-0, which is why they share a level number. **Generalises to the lattice** ➔ with two hierarchies the levels form paths, not a chain ➔ [[Fact Constellation]].
