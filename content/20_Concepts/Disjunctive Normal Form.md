---
unit: [FIT1058, FIT2014]
domain: D
week: [1, 4]
parent: "[[Boolean Algebra Laws]]"
tags: [Math/Logic, Math/Discrete, Math/Theory]
aliases: [DNF, disjunctive normal form, literal]
---
# [[Disjunctive Normal Form]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · an OR-of-ANDs standard form · read directly from a truth table · dual to [[Conjunctive Normal Form]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a disjunction (OR) of parts, each a conjunction (AND) of literals ➔ readable row-by-row from a truth table.
> - **📦 Core Components:** literal (plain $X$ / negated $\neg X$) ➔ one implicant per True row ➔ OR them.
> - **⚡ Key Constraint:** up to $2^k$ parts (exponential blow-up); but satisfiability is trivial. **In FIT2014, DNF is mainly a stepping stone to [[Conjunctive Normal Form|CNF]].**

## 🔁 The two-table routine (FIT2014)
- **DNF** ➔ take the **True** rows; one conjunction per row; **OR** them.
- **CNF** ➔ take the **False** rows; write their DNF; then **negate the whole thing** and apply De Morgan.
- **Worked contrast — "at least one of $J,K,M$"** ➔ 7 True rows ⟹ DNF has **7 terms**; the single False row $\neg J\wedge\neg K\wedge\neg M$ negates to the **1 clause** $(J\vee K\vee M)$:
$$\neg(\neg J\wedge\neg K\wedge\neg M)\;=\;(\neg\neg J\vee\neg\neg K\vee\neg\neg M)\;=\;(J\vee K\vee M)$$
- **"At least two of $J,K,M$"** ➔ the 4 False rows negate and simplify to $(J\vee K)\wedge(J\vee M)\wedge(K\vee M)$.
- **Degenerate case** ➔ for "**all three**", the single True row gives $J\wedge K\wedge M$, which is simultaneously **DNF and CNF** (each conjunct is a one-literal clause).

## 📝 Core
### 1. The Form (OR-of-ANDs)
- **Literal** ➔ a variable plain ($X$) or negated once ($\neg X$); $\neg\neg X$ is not a literal (equals $X$).
- **DNF** ➔ disjunction of parts, each part a conjunction of literals.
- **Standard form** ➔ built for **any** truth table ⟹ every expression has a DNF.

### 2. Reading It Off a Truth Table
- **Per True row** ➔ write a conjunction: variable **plain if True**, **negated if False**, AND them.
- **OR the rows** ➔ each part is True in exactly its own row ⟹ the OR is True on exactly $P$'s rows.
- **Meaning** ➔ the parts are an encoded list of all satisfying assignments.

**Key identities:**

$$P=(\neg X\wedge\neg Y)\vee(\neg X\wedge Y)\vee(X\wedge Y)$$

## ⚖️ Core Decision Matrix
| Property | DNF | Why |
| :--- | :--- | :--- |
| built from | True rows | one implicant each |
| satisfiability | **easy** | any internally-consistent part is a witness |
| size | up to $2^k$ parts | exponential blow-up |
| natural for | listing solutions | not for stating rules ([[Conjunctive Normal Form\|CNF]] better) |

> [!NOTE] **When It Flips:** DNF makes satisfiability trivial (inspect the parts — a part with no $X\wedge\neg X$ names a satisfying assignment), but real specifications list conditions that hold *together* (a conjunction), which suits CNF.

## 📊 Exam Execution Trace

### Manual Execution Trace
$P$ with output T,T,F,T:

| Step / State | $X$ | $Y$ | Output | Row term (True row) |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — |
| 1 | F | F | T | $\neg X\wedge\neg Y$ |
| 2 | F | T | T | $\neg X\wedge Y$ |
| 3 | T | F | F | — |
| 4 | T | T | T | $X\wedge Y$ |

## ⚠️ Common Mistakes
- 💡 **DNF keeps row-true literals plain** ➔ opposite of CNF's False-row negation; reduce $\neg\neg X$ to $X$ before calling it a literal.

## 🧠 Active Recall
> [!FAQ]- Construct the DNF of an expression from its truth table.
> - **Hint:** True rows → implicants.
> > [!SUCCESS]- Answer
> > - **Short answer:** For each True row, AND the literals (plain if True, negated if False); OR the rows.
> > - **Why:** **Row-exact** ➔ each conjunction is true only in its own row, so the disjunction matches $P$ exactly.

> [!FAQ]- Why can DNF be impractical, yet make satisfiability easy?
> - **Hint:** $2^k$ rows vs part inspection.
> > [!SUCCESS]- Answer
> > - **Short answer:** Many True rows ⟹ exponentially many parts (impractical); but any internally-consistent part is a satisfying assignment.
> > - **Why:** **No search** ➔ satisfiability is a scan of the parts for one without $X$ and $\neg X$.
