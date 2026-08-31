---
unit: FIT3003
week: [2, 6]
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Average of an Average, Additivity, Fact Measure Selection, Non-Additive Measure]
---
# [[Fact Measure Aggregation Rules]]

**Context:** [[FIT3003_MOC]] · which aggregate may legally become a stored measure in [[Building Fact Tables]]
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a stored measure must survive **re-aggregation** ➔ the analyst re-sums fact rows to roll up, so only measures whose roll-up equals the operational answer may be stored.
> - **📦 Core Components:** `count`/`sum` ➔ always safe | `min`/`max` ➔ safe but not mixable | `avg` ➔ **never store**.
> - **⚡ Key Constraint:** an average of averages is not the average — replace `Average_X` with `Total_X` **and** `Number_of_Y`, and divide at query time.

## 📝 How It Works
### 1. Count semantics — pick the right one
- **`count(*)`** ➔ number of records in the group, NULLs included.
- **`count(attribute)`** ➔ **excludes NULL values** — the measure that makes an outer-joined fact correct.
- **`count(distinct attribute)`** ➔ removes duplication; *Total Apps* needs `count(distinct ApplicationID)` because one application appears once per download row.

### 2. Sum
- **Always re-aggregable** ➔ $\sum$ of group sums $=$ the global sum, so a stored `sum` rolls up correctly to any coarser grain.
- **Count and Sum are the common measures** ➔ the chapter's default expectation for a fact table.

### 3. Average — the trap
- **Roll-up breaks** ➔ $\operatorname{avg}$ of per-group averages ignores group sizes, so it equals the true average only when all groups are the same size.
- **Correction is decomposition** ➔ store $\text{Total\_Score}$ and $\text{Number\_of\_Students}$; recover the average with `sum(Total_Score)/sum(Number_of_Students)`.
- **The W6 exception** ➔ a stored `Avg_X` **is** legal when **every** dimension is used in every retrieval, because then no second `avg` is ever applied to it; the Petrol Station star reaches this state only after all four dimensions are made compulsory ➔ [[Determinant Dimensions]].

### 4. Min / Max
- **Global value guaranteed** ➔ $\max$ of group maxima $=$ the global maximum, likewise $\min$; both may be stored.
- **Never mix them** ➔ `max(Min_Score)` or `min(Max_Score)` is a meaningless quantity.

## ⚙️ Core Implementation
### 🔹 Average of an average — the failing fact vs its correction
> [!code]- Fact v1 (stores `Average_Score`) vs Fact v2 (stores totals)
> ```sql
> -- BROKEN: EnrolmentFact(UnitCode, Semester, Average_Score)
> select avg(Average_Score) from EnrolmentFact where UnitCode = 'IT001';
> --  (73.833 + 48)/2 = 60.9165   ✗   true answer 539/8 = 67.375
>
> -- FIXED: EnrolmentFact2(UnitCode, Semester, Total_Score, Number_of_Students)
> select sum(Total_Score)/sum(Number_of_Students) as Average_Score
> from   EnrolmentFact2
> where  UnitCode = 'IT001';
> --  539/8 = 67.375   ✓
> ```
> 💡 **Common Mistake:** **Weighting is what is lost** ➔ semester 1 has 6 students and semester 2 has 2; averaging the two averages silently weights them equally.

### 🔹 Min / Max stored safely
> [!code]- Fact v3 (`Min_Score`, `Max_Score`) queried globally
> ```sql
> select max(Max_Score) from EnrolmentFact3 where UnitCode = 'IT001';   -- 87 ✓
> select min(Min_Score) from EnrolmentFact3 where UnitCode = 'IT001';   -- 32 ✓
> ```
> 💡 **Common Mistake:** **`max(Min_Score)` answers nothing** ➔ "the largest of the per-semester minimums" is not a business quantity.

## ⚖️ Core Decision Matrix
| Aggregate | Stored as a measure? | Roll-up behaviour | Recovery at query time |
| :--- | :--- | :--- | :--- |
| `count(*)` / `count(col)` / `count(distinct col)` | ✅ | additive | `sum()` over fact rows |
| `sum` | ✅ | additive | `sum()` over fact rows |
| `min` / `max` | ✅ (separately) | semi-additive — global value survives | `min()` / `max()`, never crossed |
| `avg` | ❌ *(⚠️ ✅ only if **all** dimensions are always used)* | **not additive** — weights are lost | store total + count, then `sum/sum` |

> [!NOTE] **When It Flips:** an average is safe to *display* and unsafe to *store*. The rule fires the moment a fact row can be combined with another fact row — which is always, because that is what a dimension roll-up does. **The one escape** ➔ if the star forces every query to name every dimension, no fact rows are ever combined and $\text{Avg\_X}$ becomes a legal stored measure ➔ [[Determinant Dimensions]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — IT001 "Database", two semesters
| Step | Source | Value | Running interpretation |
| :--- | :--- | :--- | :--- |
| 0 | operational rows, sem 1 | $6$ scores summing to $443$ | true group total |
| 1 | operational rows, sem 2 | $2$ scores summing to $96$ | true group total |
| 2 | fact v1 stores averages | $443/6 = 73.833$, $96/2 = 48$ | sizes discarded |
| 3 | roll up fact v1 | $(73.833 + 48)/2 = 60.9165$ | ✗ wrong by $6.46$ |
| 4 | roll up fact v2 | $(443 + 96)/(6 + 2)$ | ✓ $= 67.375$ |

### Applied Exercise
**Problem:** the `FitnessCentreFACT` stores `Num_of_Employees` and `Total_Salary` by JobTitle, Month, EmploymentType, Gender. Why not `Average_Salary`?
$$
\begin{aligned}
\text{stored} &: \operatorname{avg}(S_g) \text{ per group } g \\
\text{roll-up} &: \frac{1}{k}\sum_{g=1}^{k}\operatorname{avg}(S_g) \neq \frac{\sum_g \sum S_g}{\sum_g n_g} \quad\text{unless all } n_g \text{ equal} \\
\text{fix} &: \text{store } \textstyle\sum S_g \text{ and } n_g \Rightarrow \operatorname{avg} = \frac{\text{sum}(\text{Total\_Salary})}{\text{sum}(\text{Num\_of\_Employees})}
\end{aligned}
$$
**Final Extracted Output:** `Total_Salary` + `Num_of_Employees` is strictly more informative than `Average_Salary` — the average is recoverable from them, they are not recoverable from it.

## 🧠 Active Recall
> [!FAQ]- A fact row already summarises many transactions. Why does storing `avg` break while storing `sum` does not?
> > [!SUCCESS]- Answer
> > - **Short answer:** `sum` is additive across groups; `avg` is not, because it divides by a group size the fact no longer stores.
> > - **Why:** **Roll-up is re-aggregation** ➔ every OLAP roll-up combines fact rows, so a measure is only valid if the operation applied to the stored values reproduces the operational answer. **Sum composes** ➔ $\sum_g \sum S_g = \sum S$. **Average loses the weights** ➔ once $n_g$ is discarded, $\frac{1}{k}\sum_g \operatorname{avg}(S_g)$ can only coincide with the true mean when every $n_g$ is equal.

> [!FAQ]- After a `left outer join` in the TempFact, why is `count(attribute)` correct where `count(*)` is not?
> > [!SUCCESS]- Answer
> > - **Short answer:** the outer join pads unmatched rows with NULLs, and `count(attribute)` excludes NULLs while `count(*)` counts the padded row.
> > - **Why:** **Two populations, one row set** ➔ every opening survives the join but only placed openings carry a `CandNo`. **`count(OpenNo)` vs `count(CandNo)`** ➔ the same grouped rows then yield $\text{TotalOpening} \geq \text{TotalPlacement}$; `count(*)` would report both as the row count and erase the difference the analysis exists to measure ➔ [[Building Fact Tables]].
