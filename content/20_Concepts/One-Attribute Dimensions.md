---
unit: FIT3003
week: 3
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Degenerate Dimension, Dimension-less Key, Single-Attribute Dimension]
---
# [[One-Attribute Dimensions]]

**Context:** [[FIT3003_MOC]] · a design refinement applied after [[Building Dimension Tables]] · feedback-session material answering "why keep a dimension that stores nothing"

> [!abstract] Quick Revision
> - **🎯 Objective:** a dimension whose only column is its own ID carries **no description to look up** ➔ querying the fact never needs to join it, so it is a candidate for absorption.
> - **⚠️ Key Constraint:** absorbing it is a **choice, not a rule** — in practice most dimensions grow extra attributes, and the four treatments differ in what they cost when that happens.

## 📝 Core
- **What a dimension's extra attributes are for** ➔ to describe the member, so a query can filter and label on `CourseName` rather than on `CourseCode` ➔ [[Building Dimension Tables]].
- **No extras ⟹ no join** ➔ the fact already stores the key value, and the dimension holds nothing else, so `select … from Fact` answers the question outright.
- **Treatment 1 — move it to the fact, column-based** ➔ the attribute's values become separate measure columns (`Total_Gold`, `Total_Silver`, `Total_Bronze`); the attribute itself disappears and the fact widens.
- **Treatment 2 — move it to the fact, row-based** ➔ the attribute stays as a key column with one fact row per value; `Medal Type` in the fact is then a **dimension-less key** — no master file lists its valid values, so nothing validates a typo.
- **Treatment 3 — combine all one-attribute dimensions** ➔ several thin dimensions merge into one wider lookup table.
- **Treatment 4 — combine with a normal dimension** ➔ the lone attribute is absorbed into a related dimension that already carries descriptive columns.
- **Doing nothing is legitimate** ➔ the Chapter 2 College star keeps `CountryDIM` and `YearDIM` as single-column tables so the star's axes stay explicit ➔ [[Star Schema]].

## ⚠️ Common Mistakes
- 💡 **Joining a one-attribute dimension "for completeness"** ➔ costs a join and returns the column the fact already had.
- 💡 **Choosing the row-based treatment and forgetting validation** ➔ a dimension-less key has no master list, so an unseen value enters the fact unchallenged and silently splits an aggregate in two.
- 💡 **Deleting the dimension from the *diagram* as well as the schema** ➔ the star must still show which perspectives the fact supports; an absorbed attribute is drawn inside the fact, not omitted.

## 🧠 Active Recall
> [!FAQ]- If a one-attribute dimension is never joined at query time, why would a design ever keep the table?
> > [!SUCCESS]- Answer
> > - **Short answer:** because a dimension's attribute set is expected to grow, and the table is where growth lands without restructuring the fact.
> > - **Why:** **Most dimensions are descriptive** ➔ the single-attribute case is the exception; adding `Country_Region` later is a column on `CountryDIM`, whereas the absorbed version requires rebuilding the fact. **The star documents the analysis axes** ➔ an explicit dimension states that the fact is sliceable on it. **Absorption trades structure for width** ➔ column-based fixes the set of values into the schema, row-based creates an unvalidated dimension-less key.
