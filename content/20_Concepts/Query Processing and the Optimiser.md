---
unit: FIT2094
domain: C
week: 10
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
aliases: [Query Processing, Cost-Based Optimiser, CBO, Explain Plan, Access Plan]
---
# [[Query Processing and the Optimiser]]

**Context:** [[FIT2094_MOC]] · how Oracle turns SQL into an execution plan · explains **why** [[SQL Subquery Approaches (Nested, Correlated, Inline)|nested vs correlated]] subqueries differ in cost · **conceptual only — not assessed**

> [!abstract] Quick Revision
> - **🎯 Objective:** trace SQL through parse → analyse → optimise → execute ➔ understand relative query cost.
> - **⚡ Key Constraint:** the Explain-Plan COST is a **relative** unit — meaningful only when comparing two versions of the same query.

## 📝 Core
- **1. SQL Parser** ➔ checks syntax (grammar) and semantics (do the tables/columns exist?).
- **2. Query analysis** ➔ decomposes into relational-algebra ops (joins, selects, projects).
- **3. Optimiser (CBO)** ➔ the Cost-Based Optimiser estimates each strategy's cost, picks the cheapest, caches the plan.
- **4. Execution engine** ➔ runs the plan, pulling data blocks into cache, returns the result set.
- **Cost depends on statistics** ➔ CBO estimates rely on gathered stats (`user_tab_col_statistics`, `user_ind_statistics`).

## ⚠️ Common Mistakes
- 💡 **COST has no absolute meaning** ➔ a plan cost of 9 vs 39 only says the second is ~4× costlier *for that query*; it is not seconds or rows.
- 💡 **Correctness ≠ efficiency** ➔ a correlated subquery gives the same answer as a nested one but re-scans per row; you are **not penalised** for it in this unit.

## 🧠 Active Recall
> [!FAQ]- Why does the correlated version of the "min price per type" query cost ~4× the nested version?
> > [!SUCCESS]- Answer
> > - **Short answer:** The correlated subquery references the outer row, so `RENTAL`/`DRONE` is scanned once **per outer row**; the nested version runs once as a hash-based semi-join (scanning the table ~twice total).
> > - **Why:** **Re-execution vs single pass** ➔ repeated inner scans (cost 39) vs one hash semi-join (cost 9).
