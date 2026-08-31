---
unit: FIT3003
week: 6
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Determinant Dimension, Determinant Attribute, Non-Determinant Dimension]
---
# [[Determinant Dimensions]]

**Context:** [[FIT3003_MOC]] · a correctness property of a dimension, discovered *after* the star is drawn ➔ [[Star Schema]], [[Fact Measure Aggregation Rules]]
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a **Determinant Dimension** *must* appear in every retrieval from the fact, or the returned measure is **meaningless**; its key identifier is the **Determinant Attribute**.
> - **📦 Core Components:** **the test** ➔ does *all* data retrieved from the fact need this dimension? | **two enforcements** ➔ [[Pivoted Fact Tables|pivot it into the fact]] · force it at the **user-interface** level.
> - **⚡ Key Constraint:** SQL cannot declare "this dimension is compulsory" — a legal query that omits it still runs and still returns rows, so the schema or the UI must make omission impossible.

## 📝 How It Works
### 1. The definition
- **Determinant Dimension** ➔ a dimension that must be used in the data retrieval **because the fact measures are determined by it**.
- **Determinant Attribute** ➔ that dimension's key identifier (`PetrolType`, `TestComponent`, `Year`) — the column the query must actually name.
- **Notation** ➔ the determinant dimension is drawn with a **dashed box** in the unit's star-schema notation.

### 2. Petrol Station — where it is discovered
- **Requirements** ➔ average, minimum and maximum petrol price, sliced by day of week, suburb and company.
- **Version 1 — no petrol-type dimension** ➔ not all stations sell Premium 98, so every measure must be split per fuel type; the [[Two-Column Table Methodology|two-column table]] fans out to **24 fact measures** ($4$ measures $\times\ 6$ petrol types).
- **Version 2 — add `PetrolTypeDIM`** ➔ the fact collapses back to four measures, $\text{PetrolFACT}(\underline{\text{DayofWeek}^{*}, \text{Suburb}^{*}, \text{PetrolType}^{*}, \text{Company}^{*}}, \text{Total\_Petrol\_Price}, \text{Num\_of\_Petrol\_Station}, \text{Min\_Petrol\_Price}, \text{Max\_Petrol\_Price})$.
- **The new defect** ➔ V2 now *permits* a query that never mentions `PetrolType`, and that query is nonsense ➔ see the trace below.

### 3. The test — a "Type Dimension" is not automatically determinant
- **Ask of the fact, not the dimension** ➔ check whether **all** data retrieved from the fact actually needs information from this dimension or its key identifier. Yes $\Rightarrow$ determinant; no $\Rightarrow$ a normal dimension.
- **Olympic Games counter-example** ➔ $\text{MedalTypeDIM}$ is a Type Dimension yet **not** determinant: "how many medals did China win at Rio" is a meaningful answer without the breakdown.
- **The discriminator is the aggregate function** ➔ Olympic measures use `count`, which stays meaningful when summed over the type; Petrol measures use `min`/`max`, whose meaning **relies on** the petrol type.
- **Non-Type dimensions can be determinant** ➔ in the University Enrolment star, `ClassTypeDIM` (Bachelor/Master/PhD) is *not* determinant, but **`YearDIM` is**: "$100{,}000$ students in the Science Faculty" totalled across all years is not a meaningful figure.

### 4. Enforcing it
- **Route A — [[Pivoted Fact Tables|pivot]]** ➔ shift the determinant dimension into the fact so all required information is captured in the measures; the dimension disappears and omission becomes impossible.
- **Route B — user interface** ➔ keep the star and force the user to choose a value of the determinant attribute; on a web form this is the mandatory field marked with a star `*`.
- **When Route A is unavailable** ➔ a determinant dimension with **many records** would need one fact measure per record (a thousand measures is not practical) $\Rightarrow$ UI enforcement only.
- **What Route A costs** ➔ shifting keeps only the **key identifier**; every other attribute of the determinant dimension is **lost from the star schema**.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — the same fact, three queries
| Step | Query written against `PetrolFact` | Rows returned | Verdict |
| :--- | :--- | :--- | :--- |
| 0 | `select DayofWeek, min(Min_Petrol_Price) … where DayofWeek='Monday' group by DayofWeek;` | 6 rows, all labelled `Monday`, values $117.9\dots133.9$ | ❌ meaningless — *which* petrol type? |
| 1 | add `and PetrolType = 'Unleaded'` | 1 row: `Monday`, $117.9$ | ✅ filtered on the determinant attribute |
| 2 | instead `select DayofWeek, PetrolType, … group by DayofWeek, PetrolType;` | 6 labelled rows, one per type | ✅ grouped on the determinant attribute |
| 3 | drop `PetrolTypeDIM`, keep `Avg_Petrol_Price` as the only measure, use **all** dimensions in every retrieval | 1 row per full key | ✅ `avg` is legal here — no second `avg` is ever applied ➔ [[Fact Measure Aggregation Rules]] |

- **Reading the trace** ➔ steps 1 and 2 are the *only* two safe shapes: the determinant attribute must appear in the `where` **or** in the `group by`.

### Applied Exercise — University Enrolment, both shifts
**Problem:** $\text{UniversityFACT}(\underline{\text{FacultyCode}^{*}, \text{Year}^{*}, \text{GenderID}^{*}, \text{ClassType}^{*}}, \text{Num\_of\_Students})$. Shift each candidate determinant dimension into the fact and state what is lost.
$$
\begin{aligned}
\text{shift ClassType} &\Rightarrow \text{Num\_of\_Bachelor\_Students},\ \text{Num\_of\_Masters\_Students},\ \text{Num\_of\_PhD\_Students} \\
\text{shift Year} &\Rightarrow \text{Num\_of\_Students\_2017},\ \dots,\ \text{Num\_of\_Students\_2020} \\
\text{measures after a shift} &= |\text{members of the shifted dimension}| \times |\text{original measures}|
\end{aligned}
$$
**Final Extracted Output:** shifting `ClassType` is optional (it was never determinant); shifting `Year` enforces a real constraint but hard-codes the year set into the schema, so each new year is a `alter table … add` rather than a row — and `ClassTypeDIM`'s `ClassDescription` would be lost if that dimension were shifted instead.

## ⚠️ Common Mistakes
- 💡 **Concluding "Type Dimension $\Rightarrow$ determinant"** ➔ Petrol Type is, Medal Type is not; the label carries no information, only the aggregate function and the business question do.
- 💡 **Calling the non-determinant version wrong** ➔ both Olympic star schemas are **correct**; they differ on storage (V1 smaller), modelling clarity (V2 clearer) and join count (V1 fewer joins), not on validity.
- 💡 **Forgetting the zeros after a shift** ➔ the fact was built with an **inner join**, so a combination that never occurred (Italy, Swimming, Rio, Silver) has **no row at all** — the pivoted version must manufacture the $0$ ➔ [[Pivoted Fact Tables]].

## 🧠 Active Recall
> [!FAQ]- Two star schemas differ only by whether a "Type" dimension exists. What single check decides whether that dimension is determinant?
> > [!SUCCESS]- Answer
> > - **Short answer:** ask whether **every** retrieval from the fact needs that dimension's key identifier to be meaningful — if a single useful query can omit it, it is a normal dimension.
> > - **Why:** **The measure's aggregate function decides** ➔ `count` survives being summed across the type (medal tally), so `MedalType` is optional; `min`/`max` over mixed petrol types answers no question at all, so `PetrolType` is compulsory. **"Determined by" is literal** ➔ the fact measure's *value* changes meaning, not just precision, when the attribute is dropped. **The test is on the fact, not the dimension** ➔ a one-column dimension is a [[One-Attribute Dimensions|one-attribute dimension]] question; determinacy is a question about what the measures mean.

> [!FAQ]- Why must a determinant dimension be enforced structurally or through the interface, rather than by documenting the rule?
> > [!SUCCESS]- Answer
> > - **Short answer:** because the omitting query is **valid SQL** that runs, returns rows, and gives no error to reveal the mistake.
> > - **Why:** **No DDL expresses "compulsory dimension"** ➔ the FK constraint forces referential integrity, never query participation. **The wrong answer looks right** ➔ six rows all labelled `Monday` read as a plausible result set, so nothing prompts the analyst to re-check. **So the two remedies remove the choice** ➔ pivoting deletes the dimension so it cannot be omitted, and UI enforcement marks the field mandatory before the query is ever generated.
