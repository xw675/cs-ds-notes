---
unit: FIT3003
week: 3
source: [lecture, lab]
domain: C
parent: "[[Data Engineering]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing]
aliases: [Record Count Reconciliation, Row Count Check, Data Profiling]
---
# [[Data Exploration (Warehouse Validation)]]

**Context:** [[FIT3003_MOC]] · the step that must run **before** [[Building Dimension Tables]] and after [[Building Fact Tables]] · defects it finds are repaired by [[Data Cleaning (Dirty Data)]]
**Parent Framework:** [[Data Engineering]]
**Runnable scripts:** `30_Projects/FIT3003_Labs/Lab03a_USELOG_clean_to_star.sql` · `Lab03b_ROBCOR_clean_to_star.sql`

> [!abstract] Quick Revision
> - **🎯 Objective:** the SQL can be flawless and the warehouse still wrong ➔ correctness is established by **predicting a record count and comparing it**, never by re-reading the code.
> - **📦 Core Components:** count the operational tables ➔ predict the join cardinality ➔ count the TempFact ➔ explain every discrepancy.
> - **⚠️ Key Constraint:** *"Don't trust the operational databases."* A dirty source produces a fact table of the **right shape with the wrong numbers** — the row count of the fact can match perfectly while every measure is inflated.

## 📝 How It Works
### 1. The four opening questions
- **How many records in the operational DB?** ➔ `select count(*)` on every source table — this is the baseline every later number is judged against.
- **How many records in the warehouse?** ➔ count the TempFact and the fact; manually-populated dimensions need no probe because their rows were inserted by hand.
- **What kind of data is in the source?** ➔ `select` a formatted sample (`to_char(log_time,'HH24:MI')`) with an `order by`, so repeats sit adjacent and become visible.
- **How do the warehouse tables look?** ➔ the same read on the TempFact, to be diffed against the source sample.

### 2. Predict the cardinality, then compare
- **A 1–$m$ join returns exactly the $m$-side count** ➔ if $\text{STUDENT}$ is the 1 side and $\text{USELOG}$ the $m$ side, then $\lvert\text{TempFact}\rvert = \lvert\text{USELOG}\rvert$ **regardless** of how many students exist.
- **Excess rows ⟹ the 1 side is not unique** ➔ a duplicated PK on the 1 side multiplies every matching transaction row; the join is the amplifier, the duplicate is the cause.
- **Missing rows ⟹ orphan FKs on the $m$ side** ➔ transactions referencing a non-existent parent are dropped by the inner join and vanish silently.

### 3. Which shrink is legitimate
- **TempFact ➔ Fact is *expected* to shrink** ➔ the single `group by` collapses every row sharing a dimension-key combination into one, so $1363 \ll 170610$ is normal, not a defect.
- **Source ➔ TempFact must NOT change size** ➔ staging only joins and projects; any delta here is a data defect ➔ [[Data Cleaning (Dirty Data)]].

### 4. Equal row counts do not mean equal contents
- **`fact_uselog` and `fact_uselog2` both hold 1363 rows** ➔ the dimension-key combinations that occur are unchanged by de-duplication; only `Total_Usage` differs.
- **Consequence** ➔ a row-count check on the *fact* proves nothing; the check must be made upstream, on the TempFact.

## 🗂️ Schema
$$\text{FACT\_USELOG}(\underline{\text{SemID}^{*}, \text{TimeID}^{*}, \text{Class\_ID}^{*}, \text{Major\_Code}^{*}}, \text{Total\_Usage})$$
- **Sources** ➔ $\text{USELOG}(\underline{\text{Log\_Date}, \text{Log\_Time}, \text{Student\_ID}^{*}}, \text{Act})$ joined 1–$m$ to $\text{STUDENT}(\underline{\text{Student\_ID}}, \text{Sex}, \text{Class\_ID}^{*}, \text{Major\_Code}^{*})$.
- **Derived keys** ➔ `TimeID` and `SemID` do not exist in the source; they are banded onto the TempFact by `alter add` + `update` ➔ [[Building Fact Tables]].

## ⚙️ Core Implementation
### 🔹 The probe suite
> [!code]- Duplicate, orphan, and completeness checks
> ```sql
> -- 1. duplicate PK on the "1" side  (the join amplifier)
> select student_id, count(*)
> from   dw.student
> group by student_id
> having count(*) > 1;                       -- 14288 duplicated students
>
> -- 2. duplicate transactions on the "m" side (composite key)
> select to_char(log_time,'HH24:MI') log_time, log_date, student_id, act, count(*)
> from   dw.uselog
> group by log_time, log_date, student_id, act
> having count(*) > 1;                       -- 6 rows
>
> -- 3. orphan FKs — a transaction pointing at a missing parent
> select * from dw.uselog
> where  student_id not in (select student_id from dw.student);   -- no rows
>
> -- 4. orphan FKs on the dimension side
> select *
> from   dw.uselog, dw.student
> where  dw.uselog.student_id = dw.student.student_id
> and    dw.student.major_code not in (select major_code from dw.major);  -- no rows
> ```
> 💡 **Common Mistake:** **Probing only the table you suspect** ➔ `dw.student` was dirty *and* `dw.uselog` was dirty; stopping after the first find left 6 rows unexplained.

## ⚖️ Symptom ➔ Diagnosis Matrix
| Symptom | Likely cause | Probe | Repair |
| :--- | :--- | :--- | :--- |
| $\lvert\text{TempFact}\rvert > \lvert m\text{-side}\rvert$ | duplicate PK on the 1 side | `group by PK having count(*) > 1` | `select distinct` in the TempFact, or clean the source copy |
| $\lvert\text{TempFact}\rvert < \lvert m\text{-side}\rvert$ | orphan FK dropped by the inner join, **or** duplicates already in the $m$ side | `where FK not in (select PK …)` | delete orphans, or accept if the $m$ side was itself duplicated |
| counts match, measures wrong | duplicates that survive `distinct` on the projected columns | compare `fact` vs `fact2` contents | re-stage from a cleaned source |
| a dimension join *reduces* the answer | two dimension members share a description | `select * from majorDIM` | group on the **code**, not the description |

> [!NOTE] **When It Flips:** a row-count check is sufficient while the fault is *structural* (join fan-out). Once the counts agree, only a content diff of the measures can expose the remaining fault — which is why `fact_uselog2` had to be compared value-by-value against `fact_uselog`.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — the USELOG reconciliation
| Step | Probe | Result | Verdict |
| :--- | :--- | :--- | :--- |
| 0 | `count(*) dw.uselog` | $108\,267$ | the $m$ side — the prediction |
| 1 | `count(*) dw.student` | $37\,951$ | the 1 side — irrelevant to the join size |
| 2 | `count(*) tempfact_uselog` | $170\,610$ | ✗ $+62\,343$ over prediction |
| 3 | duplicate probe on `dw.student` | $14\,288$ ids with $>1$ row | cause of the inflation |
| 4 | `count(*) tempfact_uselog2` (`distinct`) | $108\,261$ | ✗ still $-6$ vs `dw.uselog` |
| 5 | duplicate probe on `dw.uselog` | $6$ rows with `count(*) = 2` | the source itself is dirty |
| 6 | verdict | $108\,261$ | ✓ **the TempFact is right, `dw.uselog` is wrong** |
| 7 | `count(*) fact_uselog` vs `fact_uselog2` | $1363$ vs $1363$ | shape identical, `Total_Usage` differs |

### Applied Exercise — the band totals as a second reconciliation
**Problem:** after cleaning, the three `TimeID` updates report $39\,921$, $48\,261$ and $20\,079$ rows, and the two `SemID` updates report $57\,612$ and $50\,649$. Does this corroborate the cleaned count?
$$
\begin{aligned}
39\,921 + 48\,261 + 20\,079 &= 108\,261 \\
57\,612 + 50\,649 &= 108\,261
\end{aligned}
$$
**Final Extracted Output:** both banding partitions total the TempFact exactly ➔ every row received exactly one band, so no row was double-updated and none was left `null`. On the **dirty** TempFact the same sums reach $170\,610$ — the arithmetic is self-consistent either way, which is precisely why row counts alone never certify correctness.

## ⚠️ Common Mistakes
- 💡 **Reading the code to find the bug** ➔ there is no bug in the code; the fault is in the data, and only counting exposes it.
- 💡 **Treating the TempFact ➔ Fact shrink as suspicious** ➔ that reduction is the `group by` doing its job; the *staging* step is the one that must preserve cardinality.
- 💡 **Declaring victory after one duplicate probe** ➔ every source table needs its own check, on the **composite** key where no single-column PK exists.
- 💡 **Joining to a dimension "for readability" without checking it** ➔ `majorDIM` holds several majors sharing one `Major_Name`; grouping on the name silently merged them, cutting $773$ result rows to $722$ ➔ [[Building Dimension Tables]].

## 🧠 Active Recall
> [!FAQ]- `dw.student` has $37\,951$ rows and `dw.uselog` has $108\,267$. Predict the row count of their inner join, and justify the prediction without running it.
> > [!SUCCESS]- Answer
> > - **Short answer:** exactly $108\,267$ — the size of the $m$ side.
> > - **Why:** **Cardinality decides, not table size** ➔ the relationship is 1–$m$, so every `uselog` row matches exactly one `student` row. **Each match contributes one output row** ➔ the join neither adds nor removes rows, giving $\lvert\text{join}\rvert = \lvert\text{USELOG}\rvert$. **The prediction is the test** ➔ any deviation means a stated assumption is false — either the 1 side is not unique (excess) or referential integrity is broken (shortfall).

> [!FAQ]- `fact_uselog` and `fact_uselog2` have the same number of rows. Why is the first one still wrong, and what does an analyst see?
> > [!SUCCESS]- Answer
> > - **Short answer:** the *set* of dimension-key combinations is unchanged by de-duplication; only the `count(t.student_id)` measures are inflated.
> > - **Why:** **Duplication multiplies rows inside a group, not the groups themselves** ➔ a duplicated student still belongs to the same semester, labtime, class and major, so `group by` produces the same $1363$ keys. **The inflation lands entirely in the measure** ➔ `Total_Usage` counts the duplicated join rows. **Nothing looks wrong downstream** ➔ every query returns plausible, well-formed numbers, so the error is undetectable after loading ➔ [[Data Cleaning (Dirty Data)]].
