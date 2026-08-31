---
unit: FIT3003
week: [3, 6]
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Degenerate Dimension, Dimension-less Key, Single-Attribute Dimension, One Attribute Dimension, Column-based Solution, Row-based Solution]
---
# [[One-Attribute Dimensions]]

**Context:** [[FIT3003_MOC]] · a design refinement applied after [[Building Dimension Tables]] · W3 feedback-session material, completed by Chapters 9–10 in W6
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a dimension whose only column is its own key carries **no description to look up** ➔ querying the fact never needs to join it, so it is a candidate for absorption.
> - **📦 Core Components:** **Solution 1 — move it to the fact** ➔ *column-based* (values become measures) or *row-based* (stays a key, becomes a **dimension-less key**) | **Solution 2 — keep it in the dimension** ➔ combine, or keep because something forces you to.
> - **⚡ Key Constraint:** absorbing it is a **choice, not a rule** — and two situations forbid it outright: the dimension is a [[Determinant Dimensions|determinant dimension]], or it hangs off a [[Bridge Tables|bridge]].

## 📝 How It Works
### 1. Why the case arises
- **What a dimension's extra attributes are for** ➔ to describe the member, so a query can filter and label on `CourseName` rather than on `CourseCode` ➔ [[Building Dimension Tables]].
- **No extras ⟹ no join** ➔ the fact already stores the key value and the dimension holds nothing else, so `select … from Fact` answers the question outright.
- **Rare but real** ➔ Chapter 10's own verdict: one-attribute dimensions are special dimensions, uncommon in the wild, but they do occur.

### 2. Solution 1 — move it to the fact
- **1.1 Column-based** ➔ the attribute's **values become separate measure columns**; `MedalTypeDIM(MedalType)` disappears and $\text{Num\_of\_Medal}$ expands to $\text{Num\_of\_Gold\_Medal}, \text{Num\_of\_Silver\_Medal}, \text{Num\_of\_Bronze\_Medal}$. This is the same operation as a [[Pivoted Fact Tables|pivoted fact table]].
- **1.2 Row-based** ➔ the dimension is deleted but the attribute **stays as a key column** in the fact with one fact row per value; `TimeDIM(Quarter)` goes, `Quarter` remains inside $\text{SalesFACT}$, drawn on its own band between the FKs and the measures.
- **The row-based residue has a name** ➔ an attribute in the fact that **refers to no dimension** is a **dimension-less key**; it holds singular information, generally a widely accepted categorical code (`M`/`F`, `Q1`–`Q4`, `Gold`/`Silver`/`Bronze`).
- **Why it is safe for codes and unsafe otherwise** ➔ no master file lists the valid values, so nothing validates a typo; that is tolerable only when the code set is universally agreed.

### 3. Solution 2 — keep it in the dimension
- **2.1 Combine all one-attribute dimensions** ➔ several unrelated thin dimensions merge into one [[Junk Dimensions|junk dimension]]: Sales with `GiftCoupon`, `SalesMode`, `Delivery`, `PaymentMode` collapses to $\text{JunkDIM}$ of $2 \times 2 \times 3 \times 2 = 24$ rows.
- **2.2 Combine with a normal dimension** ➔ when the lone attribute is **related** to a fuller dimension it is absorbed into it: each book has exactly one category, so `CategoryDIM(Category)` folds into $\text{BookDIM}(\underline{\text{ISBN}}, \text{Title}, \text{Publisher}, \text{PublishedYear}, \text{Category})$.
- **2.3 It is a determinant dimension** ➔ the Weather case keeps `MonthDIM(WeatherMonth)` **precisely because** removing it would let a query omit the month; the dimension exists to enforce its own use ➔ [[Determinant Dimensions]].
- **2.4 It carries a bridge** ➔ `BookGroupListDIM(ISBNGroupList)` has one attribute but **cannot** be removed: it is the parent that `TitleAuthorBridge` connects to `AuthorDIM` ➔ [[Bridge Tables]].
- **Doing nothing is also legitimate** ➔ the Chapter 2 College star keeps `CountryDIM` and `YearDIM` as single-column tables so the star's analysis axes stay explicit ➔ [[Star Schema]].

## ⚙️ Schema Layout
### 🔹 The three shapes for the same Olympic star
> [!code]- Keep · column-based · row-based
> ```text
> KEEP        OlympicMedalFACT(Country*, Sport*, OlympicName*, MedalType*, Num_of_Medal)
>             + MedalTypeDIM(MedalType)                       -- 4 dimensions, 1 measure
>
> COLUMN      OlympicMedalFACT(Country*, Sport*, OlympicName*,
>                              Num_of_Gold_Medal, Num_of_Silver_Medal, Num_of_Bronze_Medal)
>                                                             -- 3 dimensions, 3 measures
>
> ROW         OlympicMedalFACT(Country*, Sport*, OlympicName*, MedalType, Num_of_Medal)
>                                                             -- 3 dimensions; MedalType is
>                                                             -- a dimension-less key
> ```
> 💡 **Common Mistake:** **Deleting the attribute from the *diagram* as well as the schema** ➔ the star must still show which perspectives the fact supports; in the row-based shape the absorbed attribute is drawn **inside the fact**, on its own band, not omitted.

### 🔹 What would justify keeping `SexDIM`
> [!code]- Three versions of the same thin dimension
> ```text
> SexDim(Sex)                                -- trivial: Sex is already in the fact ⟹ delete it
> SexDim(Sex, Sex_Description)               -- earns its place: 'M' ➔ 'Male' is a real lookup
> SexDim(SexID, Sex, Sex_Description)        -- surrogate-keyed ➔ [[Surrogate Key]]
> ```
> 💡 **Common Mistake:** **Adding a surrogate key to rescue a one-column dimension** ➔ a `SexID` over `Sex` adds an identifier, not information; what rescues the table is a **description**, not a key.

## ⚖️ Core Decision Matrix
| Treatment | Dimension survives? | Fact shape | Choose it when | What it costs |
| :--- | :--- | :--- | :--- | :--- |
| Column-based (1.1) | ❌ | one measure per member | membership is small **and** fixed | values hard-coded into the schema; absent combinations need explicit $0$ |
| Row-based (1.2) | ❌ | attribute stays as a **dimension-less key** | the code set is universal and self-explaining | no master list ⟹ an unseen value splits an aggregate silently |
| Combine into junk (2.1) | ✅ as `JunkDIM` | single `JunkID` FK | several thin dimensions, **unrelated** | `JunkID` is unreadable without the join ➔ [[Junk Dimensions]] |
| Combine with a normal dim (2.2) | ✅ merged | unchanged | the attribute is **related** to a fuller dimension | none — this is ordinary modelling |
| Keep: determinant (2.3) | ✅ mandatory | unchanged | omitting it makes the measure meaningless | one join every query ➔ [[Determinant Dimensions]] |
| Keep: bridged (2.4) | ✅ mandatory | unchanged | it is the parent of a [[Bridge Tables\|bridge]] | removing it disconnects the far dimension |

> [!NOTE] **When It Flips:** absorption is the default only while the dimension is genuinely inert. Test in this order — is it determinant? is it bridged? is it related to another dimension? — and only if all three answer *no* is it free to move into the fact.

## ⚠️ Common Mistakes
- 💡 **Joining a one-attribute dimension "for completeness"** ➔ costs a join and returns the column the fact already had.
- 💡 **Choosing the row-based treatment and forgetting validation** ➔ a dimension-less key has no master list, so an unseen value enters the fact unchallenged and silently splits an aggregate in two.
- 💡 **Absorbing a determinant dimension without noticing** ➔ column-based absorption is fine (it *is* the pivot), but row-based absorption leaves the attribute optional again and re-opens the meaningless-query hole.

## 🧠 Active Recall
> [!FAQ]- If a one-attribute dimension is never joined at query time, why would a design ever keep the table?
> > [!SUCCESS]- Answer
> > - **Short answer:** because a dimension's attribute set is expected to grow, and the table is where growth lands without restructuring the fact.
> > - **Why:** **Most dimensions are descriptive** ➔ the single-attribute case is the exception; adding `Country_Region` later is a column on `CountryDIM`, whereas the absorbed version requires rebuilding the fact. **The star documents the analysis axes** ➔ an explicit dimension states that the fact is sliceable on it. **Absorption trades structure for width** ➔ column-based fixes the set of values into the schema, row-based creates an unvalidated dimension-less key.

> [!FAQ]- `MonthDIM(WeatherMonth)` and `BookGroupListDIM(ISBNGroupList)` both hold exactly one attribute. Why can neither be absorbed into its fact?
> > [!SUCCESS]- Answer
> > - **Short answer:** each is load-bearing for a reason unrelated to description — one enforces its own use, the other anchors a bridge.
> > - **Why:** **`MonthDIM` is determinant** ➔ average high and low temperature mean nothing without the month, so the dimension is kept expressly to force every query to name it ➔ [[Determinant Dimensions]]. **`BookGroupListDIM` is a bridge parent** ➔ `TitleAuthorBridge` joins it to `AuthorDIM`, so deleting it severs the path from the fact to authors ➔ [[Bridge Tables]]. **Thinness is not the test** ➔ the question is never "how many columns", it is "does anything depend on this table existing".
