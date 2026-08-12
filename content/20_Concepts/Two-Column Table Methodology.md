---
unit: FIT3003
week: [2, 3]
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

### The grounding check — run it alongside the two-column tables
- **What does one cube row look like?** ➔ write four or five literal rows (`Q1-2020 | Nike Shoes | Chadstone | $150,750`); a row you cannot write is a grain you have not decided.
- **Where does the data come from?** ➔ name the operational artefact (transaction receipts; doctor records) — if no source record carries the measure, the star is undeliverable.
- **Where is the aggregate?** ➔ state what one source record contributes (each receipt's total is summed; **each doctor contributes 1** to `Number_of_Doctors`) — a `count` measure is easy to miss because no source column holds it.
- **What can be queried?** ➔ read two real questions back off the draft ("total sales of Nike Shoes in Chadstone in Q1-2020"; "how many female GPs with $>10$ years' experience"); a question the draft cannot answer means a missing dimension or attribute.

## ⚙️ Worked Failure — a measure that one dimension cannot carry
### 🔹 Sales with `Total_Sales` **and** `Number_of_Reviews`
> [!code]- The three imaginary tables, and the verdict
> ```text
> Time      | Total Sales | Number of Reviews      ✓ reviews accrue per quarter
> Product   | Total Sales | Number of Reviews      ✓ reviews are posted about a product
> Location  | Total Sales | irrelevant             ✗ a review is not tied to the shop
> ```
> - **Rejected star** ➔ $\text{FACT}(\underline{\text{Time}^{*}, \text{Product}^{*}, \text{Location}^{*}}, \text{Total\_Sales}, \text{Number\_of\_Reviews})$ — every `Number_of_Reviews` cell would be unanswerable, because the review population is not divisible by location.
> - **Accepted design ➔ two stars** ➔ $\text{FACT}_1(\underline{\text{Time}^{*}, \text{Product}^{*}, \text{Location}^{*}}, \text{Total\_Sales})$ **and** $\text{FACT}_2(\underline{\text{Time}^{*}, \text{Product}^{*}}, \text{Number\_of\_Reviews})$ — each measure keeps only the dimensions it is genuinely viewable from.
> 💡 **Common Mistake:** **Keeping the dimension and leaving the measure NULL** ➔ a NULL here is not missing data, it is a grain error; the second measure lives at a coarser grain and needs its own fact ➔ the **Multi-Fact** topic in Week 6.

## ⚠️ Common Mistakes
- 💡 **Testing only the dimensions you already like** ➔ the method is exhaustive by construction; one unchecked dimension is the one that fails.
- 💡 **Accepting a table whose column 2 is not numerical** ➔ a fact holds only numerical, aggregated values, so a descriptive column 2 means the "measure" is really a dimension attribute.
- 💡 **Reading "irrelevant" as "zero"** ➔ zero reviews at Chadstone is a claim about data; irrelevance is a claim about the model, and only the second one invalidates the star.

## 🧠 Active Recall
> [!FAQ]- Why does the method insist that *all* fact measures appear in *all* category tables?
> > [!SUCCESS]- Answer
> > - **Short answer:** every dimension in a star joins to the same single fact row, so it must be able to qualify every measure that row stores.
> > - **Why:** **One fact, one grain** ➔ the fact's composite PK is the full set of dimension FKs, so each measure is simultaneously viewable from all of them. **A measure missing from one category** ➔ means that measure is defined at a different grain and belongs in a *separate* fact table, not this one.

> [!FAQ]- A draft star counts doctors by specialist area, gender and years of experience. Which source record supplies the measure, and what does one record contribute?
> > [!SUCCESS]- Answer
> > - **Short answer:** the doctor records themselves; each doctor contributes exactly $1$ to `Number_of_Doctors` in the cell matching their area, gender and experience.
> > - **Why:** **A `count` measure has no source column** ➔ nothing in the operational database stores "number of doctors", so the grounding check is what reveals that the measure is manufactured by the aggregation. **Experience is derived, not stored** ➔ the record holds `Year_Graduate`, so years of experience must be computed during staging before it can become a dimension key ➔ [[Building Fact Tables]].
