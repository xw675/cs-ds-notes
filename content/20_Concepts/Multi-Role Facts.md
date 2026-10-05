---
unit: FIT3003
week: 3
source: [lecture, lab]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing]
aliases: [Role-Playing Dimension, Pilot Co-Pilot Problem, Fact Union, Double-Dip]
---
# [[Multi-Role Facts]]

**Context:** [[FIT3003_MOC]] · what to do when one transaction names the **same dimension member in two roles** · measure legality governed by [[Fact Measure Aggregation Rules]]
**Parent Framework:** [[Star Schema]]
**Runnable script:** `30_Projects/FIT3003_Labs/Lab03b_ROBCOR_clean_to_star.sql`

> [!abstract] Quick Revision
> - **🎯 Objective:** one transaction, two participants of the same kind (pilot + co-pilot) ➔ build **one star schema per role**, not one star with two keys.
> - **📦 Core Components:** `charter_fact` ➔ the pilot's view | `charter_fact2` ➔ the co-pilot's view | identical dimensions, disjoint contents.
> - **⚠️ Key Constraint:** the two facts may be **union-merged only if the roles are disjoint per transaction**. When both roles sit on the *same* trip, merging double-dips every measure that belongs to the trip rather than to the person.

## 📝 How It Works
### 1. The role-playing source
- **One table read twice** ➔ `Char_Pilot` and `Char_CoPilot` are both employee numbers drawn from `PILOT`; there is no second employee table.
- **The E/R diagram lies** ➔ ROBCOR's diagram shows a phantom `Pilot_1` entity because the designer drew the two references as two boxes; the correct reading is **one entity, two relationships**.
- **Verify the roles before modelling** ➔ probe that no record has the same employee as pilot *and* co-pilot, that no flight lacks a pilot, and that flights-with-copilot $+$ flights-without $=$ total ➔ [[Data Exploration (Warehouse Validation)]].

### 2. Why not one fact with two keys
- **A second key would change the grain** ➔ adding `CoPilot_ID` to the composite PK makes the fact "per pilot **pair**", and every co-pilotless flight then needs a dummy member.
- **The analysis question is per person** ➔ *"total hours flown by each pilot"* ranges over employees, not over crews.

### 3. Two facts, then a scope test on merging
- **The merge is `union` inside an inline view, then re-aggregate** ➔ `union` alone leaves two rows per employee; the outer `group by` sums them.
- **Only individually-attributable measures survive** ➔ flying hours are earned by a person; fuel and revenue are earned by the **trip** and are already recorded once by the other crew member.
- **Dropping the other dimensions is what makes the merge legal** ➔ keep only the role dimension (`Emp_Num`); the moment `Time_ID` returns, the shared trip is counted twice inside one month.

### 4. The disjointness rule
- **Roles on the same transaction ⟹ overlap** ➔ pilot and co-pilot fly the *same* trip, so their fact rows describe one event.
- **Roles across disjoint transactions ⟹ safe** ➔ permanent vs sessional pilots (a trip has exactly one) can be `union`-ed with **no re-aggregation at all**: the two row sets never collide, and the result is simply both sets concatenated.

## 🗂️ Schema
$$\text{CHARTER\_FACT}(\underline{\text{Time\_ID}^{*}, \text{Mod\_Code}^{*}, \text{Emp\_Num}^{*}}, \text{Tot\_Char\_Hours}, \text{Tot\_Fuel}, \text{Revenue})$$
- **`CHARTER_FACT2`** ➔ identical structure, `Emp_Num` populated from `Char_CoPilot`.
- **Dimensions** ➔ $\text{TIME\_DIM}(\underline{\text{Time\_ID}}, \text{Time\_Month}, \text{Time\_Year})$ · $\text{MODEL\_DIM}(\underline{\text{Mod\_Code}}, \dots, \text{Mod\_Chg\_Mile})$ · $\text{PILOT\_DIM}(\underline{\text{Emp\_Num}}, \text{Pil\_License}, \dots)$ — shared by both stars.
- **`Revenue` is computed, not stored** ➔ $\text{Revenue} = \sum(\text{Char\_Distance} \times \text{Mod\_Chg\_Mile})$, which forces `AIRCRAFT` and `MODEL` into the fact's `from` clause purely to reach the per-mile rate.

## ⚙️ Core Implementation
### 🔹 The two role facts
> [!code]- `charter_fact` (pilot) and `charter_fact2` (co-pilot)
> ```sql
> create table charter_fact as
> select C.Char_Pilot as EMP_Num, M.Mod_Code,
>        to_char(C.Char_Date,'YYYYMM') as Time_ID,
>        sum(C.Char_Hours_Flown)               as Tot_Char_Hours,
>        sum(C.Char_Fuel_Gallons)              as Tot_Fuel,
>        sum(C.Char_Distance * M.Mod_chg_mile) as Revenue
> from   dw.Charter C, dw.Model M, dw.Aircraft A
> where  C.AC_Number = A.AC_Number and A.Mod_Code = M.Mod_Code
> group by C.Char_Pilot, M.Mod_Code, to_char(C.Char_Date,'YYYYMM');
>
> create table charter_fact2 as
> select C.Char_CoPilot as EMP_Num, M.Mod_Code,
>        to_char(C.Char_Date,'YYYYMM') as Time_ID,
>        sum(C.Char_Hours_Flown)               as Tot_Char_Hours,
>        sum(C.Char_Fuel_Gallons)              as Tot_Fuel,
>        sum(C.Char_Distance * M.Mod_chg_mile) as Revenue
> from   dw.Charter C, dw.Model M, dw.Aircraft A
> where  C.AC_Number = A.AC_Number and A.Mod_Code = M.Mod_Code
> group by C.Char_CoPilot, M.Mod_Code, to_char(C.Char_Date,'YYYYMM');
> ```
> 💡 **Common Mistake:** **The handout's `charter_fact2` still groups by `C.Char_Pilot`** ➔ the selected `Char_CoPilot` is then not a grouping column and Oracle raises *ORA-00979: not a GROUP BY expression*. Change the `select` **and** the `group by` together — three tables, two join conditions.

### 🔹 Merging — the wrong one and the right one
> [!code]- `charter_fact3` (invalid) vs `charter_fact3b` (valid)
> ```sql
> -- ✗ keeps all three dimensions: a shared trip is counted twice within one month
> create table charter_fact3 as
> select time_id, mod_code, emp_num,
>        sum(tot_char_hours) as tot_char_hours,
>        sum(tot_fuel) as tot_fuel, sum(revenue) as revenue
> from ( select * from charter_fact union select * from charter_fact2 )
> group by time_id, mod_code, emp_num;
>
> -- ✓ role dimension only, and only the individually-attributable measure
> create table charter_fact3c as
> select emp_num, sum(tot_char_hours) as tot_char_hours
> from ( select * from charter_fact union select * from charter_fact2 )
> group by emp_num
> order by emp_num;
> ```
> 💡 **Common Mistake:** **Building the merged table at all** ➔ the same `union` runs perfectly well as a plain `select`; a physical `charter_fact3` adds a table that answers one question the two facts already answer.

## ⚖️ Merge Legality Matrix
| Measure | Attributable to | Merge across roles on `Emp_Num` | Merge with `Time_ID` / `Mod_Code` retained |
| :--- | :--- | :--- | :--- |
| `Tot_Char_Hours` | the **person** — each crew member logs their own hours | ✅ sum is the employee's true total | ❌ the trip's hours are also logged by the other crew member |
| `Tot_Fuel` | the **trip** — one tank, one flight | ❌ doubled whenever a flight has two crew | ❌ doubled |
| `Revenue` | the **trip** — one invoice, one flight | ❌ a $\$1000$ charter becomes $\$2000$ | ❌ doubled |

> [!NOTE] **When It Flips:** the union becomes unconditionally safe — every measure, every dimension, no re-aggregation — the moment the two roles are **mutually exclusive per transaction**. Permanent vs sessional pilot passes; pilot vs co-pilot does not.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — employee 101
| Step | Source | Value | Verdict |
| :--- | :--- | :--- | :--- |
| 0 | `dw.charter`, Apr-1997 | 101 appears as pilot **and** as co-pilot on one flight | role overlap confirmed |
| 1 | `charter_fact`, Apr-1997, PA31-350 | $8.2$ hrs | pilot-role view |
| 2 | `charter_fact2`, Apr-1997, PA31-350 | $5.6$ hrs | co-pilot-role view |
| 3 | `charter_fact3`, same keys | $13.8$ hrs | ✓ correct **as an employee total** |
| 4 | read step 3 as "April 1997 hours" | $13.8$ hrs | ✗ the $5.6$ is also in the other pilot's row |
| 5 | `charter_fact3b`, `Emp_Num` only | $1053.2$ hrs | ✓ 101's genuine lifetime hours |
| 6 | same row, `Tot_Fuel` / `Revenue` | $50\,534.9$ gal · $\$447\,900.57$ | ✗ trips flown with a second crew member counted twice |

### Applied Exercise
**Problem:** one charter with a pilot and a co-pilot bills $\$1000$ and burns $100$ gallons. Compute what `charter_fact3` reports versus the truth.
$$
\begin{aligned}
\text{fact rows} &: (\text{pilot},\ 1000,\ 100) \ \text{and} \ (\text{co-pilot},\ 1000,\ 100) \\
\text{merged} &: 1000 + 1000 = 2000 \quad\text{and}\quad 100 + 100 = 200 \\
\text{truth} &: 1000 \ \text{and} \ 100 \quad \text{— independent of crew size}
\end{aligned}
$$
**Final Extracted Output:** `Tot_Fuel` and `Revenue` must be **excluded** from any cross-role merged fact; only `Tot_Char_Hours` survives, because hours are the sole quantity each crew member owns individually.

## ⚠️ Common Mistakes
- 💡 **Trusting the supplied E/R diagram** ➔ ROBCOR's phantom `Pilot_1` entity has no table behind it; the diagram is a drawing convention for one entity used twice.
- 💡 **Modelling both roles as keys of one fact** ➔ changes the grain to "per crew pair" and leaves solo flights needing a dummy co-pilot member.
- 💡 **`union` without re-aggregating** ➔ union removes only *identical* rows; an employee appearing in both facts stays as two rows, and every roll-up over them is wrong ➔ [[SQL Set Operators]].
- 💡 **Assuming a measure is additive because it is a `sum`** ➔ additivity across *fact rows* is not additivity across *roles*; ask who owns the quantity ➔ [[Fact Measure Aggregation Rules]].

## 🧠 Active Recall
> [!FAQ]- Why is `Tot_Char_Hours` valid in a merged role fact when `Tot_Fuel` and `Revenue` are not?
> > [!SUCCESS]- Answer
> > - **Short answer:** hours are individual; fuel and revenue belong to the trip and are already attributed to the other crew member.
> > - **Why:** **Ownership decides, not the aggregate function** ➔ all three are `sum`s, yet only one is a per-person quantity. **A shared trip appears in both role facts** ➔ merging adds the trip's fuel and revenue once per crew member, so a $\$1000$ charter reports $\$2000$. **Hours are earned twice, legitimately** ➔ pilot and co-pilot each genuinely fly the trip, so their hours are distinct quantities that happen to be equal.

> [!FAQ]- Two star schemas exist for permanent pilots and sessional pilots. Why can these be `union`-ed with no re-aggregation, when pilot/co-pilot cannot?
> > [!SUCCESS]- Answer
> > - **Short answer:** the two populations never share a transaction, so no fact row describes an event already described by the other set.
> > - **Why:** **Disjointness at the transaction level** ➔ a trip has exactly one pilot, permanent *or* sessional, so the two facts partition the trips instead of overlapping on them. **No key collides** ➔ combining the two record sets yields two records, not one to be summed, so revenue and fuel stay correct with every dimension retained. **The pilot/co-pilot case fails this test** ➔ both roles sit on one trip, which is exactly the condition that forces the measure-by-measure scope check.
