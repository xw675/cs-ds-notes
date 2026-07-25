---
unit: FIT1058
week: 8
parent: "[[Set (Mathematics)]]"
tags: [Math/Combinatorics, Math/Discrete]
aliases: [Addition Principle, Multiplication Principle, Sum Rule, Product Rule]
---
# [[Counting Principles]]

**Context:** [[FIT1058_MOC]] · the two atoms of counting — add for **disjoint** "or", multiply for **independent** "and" · sizes of a disjoint union vs a [[Cartesian Product]] · refined by [[Inclusion-Exclusion Principle|inclusion–exclusion]] and [[Selection (Counting Framework)|selection]]

> [!abstract] Quick Revision
> - **🎯 Objective:** parse the problem's "or"/"and" structure ➔ disjoint alternatives ⟹ add; independent stages ⟹ multiply.
> - **📦 Core Components:** Addition ➔ $|A\cup B|=|A|+|B|$ (disjoint) | Multiplication ➔ $|A\times B|=|A||B|$ (independent).
> - **⚡ Key Constraint:** each rule has a hypothesis — overlap breaks addition, dependence breaks multiplication.

## 📝 Core

### 1. Addition Principle (or, disjoint)
- **Statement** ➔ choose one item from disjoint option sets ⟹ add: $A\cap B=\emptyset\Rightarrow|A\cup B|=|A|+|B|$; generally $\lvert\bigcup_i A_i\rvert=\sum_i\lvert A_i\rvert$ pairwise-disjoint.
- **Signature** ➔ "one *or* the other, never both"; sequential loops ⟹ costs add ($r+c$).
- **Casework basis** ➔ generalises to a [[Set Partition]]: total = sum of disjoint class sizes.

### 2. Multiplication Principle (and, independent)
- **Statement** ➔ successive independent stages with $r$ then $c$ options ⟹ $r\cdot c$; outcomes are pairs of $\{1,\dots,r\}\times\{1,\dots,c\}$; generally $\bigl|\prod_i A_i\bigr|=\prod_i|A_i|$.
- **Signature** ➔ "this *and then* that"; nested loops run $rc$ times.
- **Repeated choice** ➔ $r$ independent picks from $n$ options ⟹ $n^r$ ([[Counting Functions]]).

## ⚖️ Core Decision Matrix
| Situation | Rule | Loop Structure | Breaks When |
| :--- | :--- | :--- | :--- |
| disjoint alternatives ("or") | add | sequential | overlap ⟹ [[Inclusion-Exclusion Principle\|inclusion–exclusion]] |
| independent stages ("and") | multiply | nested | dependence ⟹ falling factorial |
| repeated independent choice | $n^r$ | $r$ equal factors | without replacement ⟹ $n^{\underline r}$ |
| disjoint covering classes | sum of class sizes | casework | classes overlap |

> [!NOTE] **When It Flips:** add for "or", multiply for "and". All of [[Selection (Counting Framework)]] (permutations, falling factorials, [[Binomial Coefficient|combinations]]) is built by composing these two rules.

## ⚠️ Common Mistakes
- 💡 **Overlap breaks addition** ➔ $A\cap B\neq\emptyset$ ⟹ use $|A|+|B|-|A\cap B|$; the addition principle is the disjoint special case of inclusion–exclusion.
- 💡 **Dependence breaks multiplication** ➔ if stage 2's options shrink with stage 1 (selection without replacement), factors aren't constant — that's the falling factorial, not $n^r$.

## 🧠 Active Recall
> [!FAQ]- A password is 2 letters then 2 digits, or 4 digits. How do the two principles combine, and which hypotheses are you invoking?
> - **Hint:** Parse and/or structure into multiply/add.
> > [!SUCCESS]- Answer
> > - **Short answer:** $(26\cdot26\cdot10\cdot10)+(10^4)$ — multiply within each format (independent stages), add across formats (disjoint alternatives).
> > - **Why:** **Hypotheses** ➔ character slots are independent (constant factor counts); the two formats share no string (different lengths ⟹ disjoint).

> [!FAQ]- Why do sequential loops add but nested loops multiply?
> - **Hint:** Map control flow to set structure.
> > [!SUCCESS]- Answer
> > - **Short answer:** Sequential loops enumerate a disjoint union ($r+c$ iterations); nested loops enumerate a Cartesian product ($rc$ iterations).
> > - **Why:** **Or vs and** ➔ each iteration of the outer loop *and* each of the inner ⟹ pairs; loop A *then* loop B ⟹ disjoint alternatives in time.
