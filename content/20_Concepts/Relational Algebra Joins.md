---
unit: FIT2094
domain: C
week: 3
parent: "[[Relational Algebra]]"
tags: [CS/Databases, Math/Discrete]
---
# [[Relational Algebra Joins]]

**Context:** [[FIT2094_MOC]] · combine two [[Relation (Database)|relations]] on a predicate · **theta**, **equi**, and **natural** joins · built from [[Cartesian Product]] + [[Select and Project (σ, π)|select/project]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\bowtie$ combines tuples from two relations satisfying a predicate ➔ product + select (+ project).
> - **📦 Core Components:** theta (any comparison) ➔ equi ($=$) ➔ natural (shared attrs, dedup column).
> - **⚡ Key Constraint:** joins are **derived** from [[Cartesian Product]], not primitive.

![[natural-join-a.png]]
![[natural-join-b.png]]

## 📝 Core
### 1. The Join
- **Definition** ➔ $\bowtie$ combines tuples from two relations satisfying a predicate.
- **Three kinds** ➔ theta / equi / natural.

### 2. The Three Kinds
- **Theta** ➔ $R_1\bowtie_F R_2$, $F: R_1.a_i\ \theta\ R_2.b_j$, $\theta\in\{<,\le,=,\ge,>\}$.
- **Equi** ➔ theta with $\theta$ being $=$; shared attribute appears **twice**.
- **Natural** ➔ equi join on common attribute(s) with duplicate column **removed**; no explicit predicate needed.

### 3. Natural Join = 3 Steps
- **Product** ➔ $R_1\times R_2$.
- **Select** ➔ $\sigma_{R_1.\text{ID}=R_2.\text{ID}}$ (this is the equi join).
- **Project** ➔ drop the duplicate column → natural join.

**Key identities:**

$$\text{STUDENT}\times\text{MARK} \quad(2\times3=6 \text{ tuples})$$
$$\sigma_{\text{STUDENT.ID}=\text{MARK.ID}} \quad(6\to3,\ =\text{equi join})$$
$$\pi_{\dots}\ (\text{drop MARK.ID}) = \{(1,\text{Alice},1004,95),(1,\text{Alice},1045,90),(2,\text{Bob},1045,55)\}$$

## ⚖️ Core Decision Matrix
| Join | Predicate | Shared column |
| :--- | :--- | :--- |
| theta | any $\theta$ | kept (both) |
| equi | $=$ | duplicated |
| natural | $=$ on common | removed |
| vs set ops | different schemas | (set ops need identical) |

> [!NOTE] **When It Flips:** every join is a [[Cartesian Product]] filtered by the predicate (natural join also projects) — joins are derived, not primitive. Equi joins on PK = FK are the everyday case ([[Foreign Key and Referential Integrity]]); pure algebra drops unmatched tuples (inner join, no [[NULL Value|NULLs]]).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Show the natural join of STUDENT and MARK on ID as three steps.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{STUDENT}\times\text{MARK} &\Rightarrow 6 \text{ tuples} \\
\sigma_{\text{STUDENT.ID}=\text{MARK.ID}} &\Rightarrow 3 \text{ (equi join)} \\
\pi\ (\text{drop MARK.ID}) &\Rightarrow \text{natural join, Alice twice, Bob once}
\end{aligned}
$$
**Final Extracted Output:** 3 tuples; Alice (ID 1) appears twice, Bob (ID 2) once.

## ⚠️ Common Mistakes
- 💡 **Natural join needs a shared attribute** ➔ if relations share matching attribute(s) the predicate is implicit; without one, use an equi join and **state the predicate**.

## 🧠 Active Recall
> [!FAQ]- Distinguish theta, equi, and natural joins.
> - **Hint:** Comparison and column handling.
> > [!SUCCESS]- Answer
> > - **Short answer:** Theta = any $\theta$; equi = $=$ (shared column duplicated); natural = equi on common attrs with duplicate column removed.
> > - **Why:** **Implicit predicate** ➔ natural join needs no stated predicate when attributes match.

> [!FAQ]- Show the natural join of STUDENT and MARK on ID as three algebra steps.
> - **Hint:** Product → select → project.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\times$ (6 tuples), $\sigma_{\text{ID}=\text{ID}}$ (3, equi), $\pi$ drop dup ID (natural).
> > - **Why:** **Alice twice** ➔ two marks with ID 1; Bob once.
