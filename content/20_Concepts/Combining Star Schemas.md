---
unit: FIT3003
week: 7
source: [lecture, slides]
domain: C
parent: "[[Multi-Fact Star Schemas]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [To Combine or Not To Combine, One Pool Two Pools, Mutually Exclusive Star Schemas, Type Dimension]
---
# [[Combining Star Schemas]]

**Context:** [[FIT3003_MOC]] · the reverse question to [[Multi-Fact Star Schemas]] — two stars already exist and look alike, may they become one? ➔ [[Determinant Dimensions]], [[Pivoted Fact Tables]]
**Parent Framework:** [[Multi-Fact Star Schemas]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify the pair by **how many pools of personnel/objects** feed it and **whether they share a transaction record** ➔ the class dictates which of the three solutions (normal dimension · pivoted fact · type dimension) are legal.
> - **📦 Core Components:** **one pool, same record** ➔ Flight Charter, all three legal, base dimension is **determinant** | **one pool, different records** ➔ Bachelor/Master, all three legal, base dimension is **normal** | **two pools, different records** ➔ Lecturer/Tutor, **only** the base solution works.
> - **⚡ Key Constraint:** combining is refused outright when the dimension sets differ; the hard cases are the ones where all but **one** dimension matches, or matches with a different context.

## 📝 How It Works
### 1. The easy verdicts
- **Different dimensions $\Rightarrow$ never combine** ➔ star-1 over $\{A,B,C\}$ and star-2 over $\{A,B,D,E\}$ are different subjects by definition ➔ [[Multi-Fact Star Schemas]].
- **Same dimensions, different measures $\Rightarrow$ join** ➔ one subject; merge on the full composite key (Private Taxi).
- **Same dimensions, same measures $\Rightarrow$ the difference is the time period** ➔ the facts are **union-compatible**, so `union` merges them.

```sql
create table PrivateTaxiFact1 as
select * from PrivateTaxiFact1a
union
select * from PrivateTaxiFact1b;      -- two periods, identical column lists
```

### 2. The hard case and its three options
- **Shape of the problem** ➔ star-1 over $\{A, B, C_1\}$ and star-2 over $\{A, B, C_2\}$ where $C_1$ and $C_2$ are the same dimension in a **different context**, or only slightly different.
- **Option 1 — determinant-dimension solution** ➔ combine, but the shared dimension becomes a [[Determinant Dimensions|determinant dimension]] (dashed box).
- **Option 2 — non-determinant solution** ➔ combine with an ordinary dimension; no query constraint is created.
- **Option 3 — mutually exclusive** ➔ the two populations never meet, so combining is trivial and only the base shape survives.
- **The classifier** ➔ count the **pools** (of personnel or objects) and ask whether they appear in the **same transaction record**.

### 3. One pool, SAME transaction record — Flight Charter
- **The case** ➔ $12$ pilots in one `Employee` pool; a medium aircraft flight records a **pilot and a co-pilot on the same flight row**.
- **Naive `union` fails** ➔ `select * from FlightCharterFact1 union select * from FlightCharterFact2` then `group by TimeID, AircraftNo, EmployeeID` — correct per employee, **double-counted** per month and per aircraft ➔ see the trace.
- **Solution 1 (base)** ➔ keep one $\text{PilotDIM}$ but mark it **determinant**: every query must name the pilot/co-pilot role.
- **Solution 2 (pivot)** ➔ $\text{FlightCharterFACT}(\underline{\text{AircraftNo}^{*}, \text{PilotID}^{*}, \text{TimeID}^{*}}, \text{Total\_Flying\_Hours\_Pilot}, \dots, \text{Total\_Revenue\_CoPilot})$ — $3$ measures $\times\ 2$ roles ➔ [[Pivoted Fact Tables]].
- **Solution 3 (type dimension)** ➔ pull the pivot back out as $\text{PilotTypeDIM}(\underline{\text{PilotType}}, \text{Description})$; `PilotType` joins the fact's **key**, measures return to $3$.

### 4. One pool, DIFFERENT transaction records — Bachelor/Master Projects
- **The case** ➔ one pool of Faculty Members; two transaction tables (Bachelor projects, Master projects) but **one manager per project**, so no row carries two roles.
- **No determinant dimension arises** ➔ nothing is double-counted, so $\text{ManagerDIM}$ stays a normal (solid-box) dimension.
- **Same three solutions** ➔ base $\text{ProjectFACT}(\underline{\text{AreaID}^{*}, \text{StaffNo}^{*}, \text{Year}^{*}}, \text{Num\_of\_Projects}, \text{Num\_of\_Students})$ · pivot into `Num_of_Bachelor_Projects, Num_of_Bachelor_Students, Num_of_Master_Projects, Num_of_Master_Students` · or add $\text{LevelTypeDIM}(\underline{\text{LevelNo}}, \text{LevelName})$ with `LevelNo` in the fact key.
- **The originals can be discarded** ➔ unlike the Flight Charter case, once combined there is no reason to keep the two source stars.

### 5. Two pools, DIFFERENT transaction records — Lecturer/Tutor
- **The case** ➔ two distinct pools (Tutors/TAs and Faculty Members); each tutorial has exactly **one** teacher drawn from either pool.
- **Only the base solution works** ➔ a single $\text{StaffDIM}$ holding both pools, carrying **only attributes common to both** (`StaffNo`, `Name`, `Office`, `Phone`).
- **Pivot is nonsense** ➔ for a tutor there is no `Num_of_Classes_by_Lecturer`, and vice versa — every row would be half zeroes by construction.
- **A type dimension is nonsense** ➔ there is no Lecturer $\times$ Tutor-Type combination to key on.
- **Two separate dimensions are worse** ➔ one dimension per pool leaves each fact measure without values for the other.
- **If a type is genuinely needed** ➔ add a `Type` **attribute inside** $\text{StaffDIM}$; it describes the staff record, it is not an analysis axis.

## ⚖️ Core Decision Matrix
| Case | Pools | Transaction records | Base dimension | Pivot legal? | Type dimension legal? | Keep originals? |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Flight Charter (pilot / co-pilot) | one | **same** row holds both roles | **determinant** (dashed) | ✅ | ✅ | ✅ — the combined fact is only safe under the determinant rule |
| Bachelor / Master projects | one | different rows, one role each | normal (solid) | ✅ | ✅ | ❌ — combined star fully replaces them |
| Lecturer / Tutor tutorials | **two** | different rows, one role each | normal, **common attributes only** | ❌ half the row is structurally empty | ❌ no valid combination exists | ❌ |

> [!NOTE] **When It Flips:** the determinant requirement appears exactly when **one transaction row contributes the same measure to two members of the same pool** — that is the sole source of the double count, and it is why Bachelor/Master escapes it despite also being one pool.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — where the Flight Charter union breaks
| Perspective | Employee 101 as pilot | Employee 101 as co-pilot | Combined total | Correct? |
| :--- | :--- | :--- | :--- | :--- |
| per employee, Jan, A1 | $500$ h | $250$ h | $750$ h | ✅ 101 really was aboard for $750$ h |
| per **aircraft** A1, Jan | $500$ h | $250$ h counted again under the *other* pilot | $\geq 1000$ h | ❌ each two-crew flight counted twice |
| per **month** Jan | as above | as above | inflated | ❌ same double count |
| per employee **and** `PilotType` | $500$ h | $250$ h, separate row | correct per role | ✅ the determinant attribute is pinned |

- **Reading the trace** ➔ the error is invisible from the employee axis and only surfaces on the aircraft and month axes — which is exactly why the constraint must be structural, not documented ➔ [[Determinant Dimensions]].

### Applied Exercise — classify and prescribe
**Problem:** a hospital records each operation with a **surgeon** and an **assisting surgeon** on the same operation row, both drawn from the one `Doctor` pool. Two stars exist (Surgeon, Assistant) over $\{\text{TheatreDIM}, \text{MonthDIM}, \text{DoctorDIM}\}$ with measures Total Hours and Total Cost. Combine?
$$
\begin{aligned}
\text{pools} &= 1, \quad \text{roles per transaction row} = 2 \\
\Rightarrow \text{class} &= \text{one pool, same transaction record (Flight Charter)} \\
\Rightarrow \text{combine} &\Rightarrow \text{DoctorDIM must be determinant, or pivot to } \text{Total\_Hours\_Surgeon}, \text{Total\_Hours\_Assistant}, \dots
\end{aligned}
$$
**Final Extracted Output:** combine, but only with one of the three enforced shapes — dashed $\text{DoctorDIM}$, a pivoted fact, or a $\text{RoleTypeDIM}$ keyed into the fact; a plain `union` $+$ `group by` inflates every theatre and month total.

## ⚠️ Common Mistakes
- 💡 **Merging identical-looking stars with `union` alone** ➔ `union` de-duplicates *rows*, it does not re-aggregate; the outer `group by` is what merges, and it is legal only when no transaction row feeds two members ➔ [[Multi-Role Facts]].
- 💡 **Applying the pivot or type-dimension solution to the two-pool case** ➔ both produce structurally empty measures or impossible key combinations; the mutually-exclusive case has **one** solution.
- 💡 **Putting the type inside the dimension when it is an analysis axis** ➔ a `Type` attribute in $\text{StaffDIM}$ describes staff; a $\text{TypeDIM}$ keyed into the fact splits measures. The Lecturer/Tutor case needs the first, the Bachelor/Master case the second.

## 🧠 Active Recall
> [!FAQ]- Two stars have identical dimensions and identical fact measures. What is the most likely difference, and how do you merge them?
> > [!SUCCESS]- Answer
> > - **Short answer:** they almost certainly cover **different time periods**, and being union-compatible they merge with a plain `union`.
> > - **Why:** **Identical dimensions $\Rightarrow$ identical subject** ➔ nothing else distinguishes them structurally. **Union-compatible means same column list, same types** ➔ so no join, no re-aggregation is required. **Contrast with same-dimensions-different-measures** ➔ that merge is a **join** on the full key, not a `union` ➔ [[Multi-Fact Star Schemas]].

> [!FAQ]- Both the Flight Charter and the Bachelor/Master cases involve one pool of people. Why does only one of them force a determinant dimension?
> > [!SUCCESS]- Answer
> > - **Short answer:** because in Flight Charter **one transaction row names two members of the pool**, so the same flying hours reach two dimension members; in Bachelor/Master each project row names exactly one manager.
> > - **Why:** **Double counting needs a shared row** ➔ the co-pilot's $250$ hours also belong to that flight's pilot, so any aggregate that does not pin the role counts the flight twice. **Per-member totals stay correct either way** ➔ which is why the defect is invisible unless you aggregate by aircraft or month. **Hence the different notation** ➔ dashed $\text{PilotDIM}$ versus a solid $\text{ManagerDIM}$.
