---
unit: FIT3003
week: 2
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Two-Column Method, Star Schema Validation]
---
# [[Two-Column Table Methodology]]

**Context:** [[FIT3003_MOC]] · the correctness check applied to a drafted [[Star Schema]] **before** [[Building Dimension Tables]] and [[Building Fact Tables]]

> [!abstract] Quick Revision
> - **🎯 Objective:** imagine one two-column table per dimension — category $\mid$ fact measure ➔ if every such table makes sense, the star may be drawn.
> - **⚡ Key Constraint:** with multiple measures $F = \{F_1, F_2, F_3\}$, **all $F$ must exist in all tables** — one dimension that cannot carry one measure invalidates the whole star.

## 📝 Core
- **Column 1 = category** ➔ a candidate dimension $A, B, C, D$; each row is one member of it.
- **Column 2 = fact** ➔ the statistical numerical figure viewed from that category; the table is *imaginary*, never built.
- **One Fact Measure** ➔ draw one table per dimension; all four sensible ⟹ $\text{FACT}(F)$ with dimensions $A, B, C, D$ is valid. *(e.g. `Num_of_Immigrants` viewed by Year, Country, VisaType, SettlingState.)*
- **Multiple Fact Measure** ➔ column 2 widens to $F_1, F_2, F_3$; the test is that every category table can display **every** measure. *(e.g. `Num_of_Employees` and `Total_Salary` viewed by JobTitle, Month, EmploymentType, Gender.)*
- **Failure verdict** ➔ if $B$ carries only $F_1, F_2$, then $F_3$ is not viewable from every dimension, so a single star over $\{A,B,C,D\}$ with all three measures cannot be drawn — split the measure out or drop the dimension.

## ⚠️ Common Mistakes
- 💡 **Testing only the dimensions you already like** ➔ the method is exhaustive by construction; one unchecked dimension is the one that fails.
- 💡 **Accepting a table whose column 2 is not numerical** ➔ a fact holds only numerical, aggregated values, so a descriptive column 2 means the "measure" is really a dimension attribute.

## 🧠 Active Recall
> [!FAQ]- Why does the method insist that *all* fact measures appear in *all* category tables?
> > [!SUCCESS]- Answer
> > - **Short answer:** every dimension in a star joins to the same single fact row, so it must be able to qualify every measure that row stores.
> > - **Why:** **One fact, one grain** ➔ the fact's composite PK is the full set of dimension FKs, so each measure is simultaneously viewable from all of them. **A measure missing from one category** ➔ means that measure is defined at a different grain and belongs in a *separate* fact table, not this one.
