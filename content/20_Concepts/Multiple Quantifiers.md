---
unit: FIT1058
week: 5
parent: "[[Quantifiers (Existential and Universal)]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Multiple Quantifiers]]

**Context:** [[FIT1058_MOC]] · stacking $\exists/\forall$ over several variables · **order matters** when the types differ · supports instantiation and distribution

> [!abstract] Quick Revision
> - **🎯 Objective:** prefix an expression with several quantifiers, each binding a distinct variable ➔ mixed order changes meaning.
> - **📦 Core Components:** four $\exists/\forall$ patterns ➔ distinctness needs $\neg(X{=}Y)$ ➔ instantiation + distribution laws.
> - **⚡ Key Constraint:** $\exists\forall\Rightarrow\forall\exists$ but **not** conversely; like quantifiers commute, mixed do not.

## 📝 Core
### 1. Stacking Quantifiers
- **Distinct variables** ➔ $\exists X,\forall X$ is meaningless (same variable twice).
- **Four patterns** ➔ $\exists\exists$, $\forall\forall$, $\exists\forall$, $\forall\exists$ express four different claims.
- **Distinctness** ➔ "other"/"two vertices" needs the [[Predicate|equality predicate]] $\neg(X{=}Y)$, pairing $\wedge$ under $\exists$, $\Rightarrow$ under $\forall$.

### 2. Order of Mixed Quantifiers
- **$\exists X\forall Y$** ➔ **one** witness adjacent to **all** — stronger.
- **$\forall Y\exists X$** ➔ **each** $Y$ has **some** neighbour — witness may depend on $Y$.
- **Implication** ➔ $\exists X\forall Y\Rightarrow\forall Y\exists X$, not conversely; like quantifiers commute/merge.

### 3. Instantiation & Distribution
- **Universal instantiation** ➔ $(\forall X\,p(X))\Rightarrow p(\text{obj})$; **existential generalisation** ➔ $p(\text{obj})\Rightarrow\exists X\,p(X)$.
- **Full distribution** ➔ $\forall$ over $\wedge$, $\exists$ over $\vee$ (equivalences).
- **One-way only** ➔ $\forall$ over $\vee$, $\exists$ over $\wedge$ (no converse).

## ⚖️ Core Decision Matrix
| Distribution | Direction | Holds? |
| :--- | :--- | :--- |
| $\forall X(p\wedge q)\equiv(\forall p)\wedge(\forall q)$ | both | ✅ equivalence |
| $\exists X(p\vee q)\equiv(\exists p)\vee(\exists q)$ | both | ✅ equivalence |
| $(\forall p)\vee(\forall q)\Rightarrow\forall X(p\vee q)$ | one way | ⚠️ no converse |
| $\exists X(p\wedge q)\Rightarrow(\exists p)\wedge(\exists q)$ | one way | ⚠️ no converse |

> [!NOTE] **When It Flips:** counterexample to the missing converse — on $\mathbb Z$ every number satisfies $\text{even}\vee\text{odd}$, so $\forall X(p\vee q)$ holds, yet $(\forall X\,p)\vee(\forall X\,q)$ (all even or all odd) fails.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Evaluate both quantifier orderings and state their relationship.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\exists X\forall Y &: X{=}1 \text{ works for all } Y \Rightarrow \textbf{True} \\
\forall Y\exists X &: \text{each } Y \text{ has a neighbour} \Rightarrow \textbf{True} \\
\text{relationship} &: \exists X\forall Y \Rightarrow \forall Y\exists X \text{ (not conversely)}
\end{aligned}
$$
**Final Extracted Output:** both hold here ($K_2$ is complete); in general $\exists\forall$ is the stronger form.

## ⚠️ Common Mistakes
- 💡 **Mixed $\exists/\forall$ do not commute** ➔ $\exists X\forall Y$ (one witness for all) is strictly stronger than $\forall Y\exists X$ (witness may vary); only like quantifiers merge to $\exists(X,Y)$/$\forall(X,Y)$.

## 🧠 Active Recall
> [!FAQ]- Why does the order of mixed quantifiers matter — $\exists X\forall Y\,\text{adj}$ vs $\forall Y\exists X\,\text{adj}$?
> - **Hint:** Witness dependence.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\exists X\forall Y$ = one $X$ for every $Y$; $\forall Y\exists X$ = $X$ may depend on $Y$.
> > - **Why:** **One-way implication** ➔ the universal witness serves everyone, so $\exists\forall\Rightarrow\forall\exists$ but not conversely; like quantifiers commute/merge.

> [!FAQ]- Which quantifier/connective distributions are equivalences, and which are one-directional?
> - **Hint:** $\forall$–$\wedge$, $\exists$–$\vee$ full; cross-pairs one way.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\forall(p\wedge q)\equiv\forall p\wedge\forall q$, $\exists(p\vee q)\equiv\exists p\vee\exists q$; the $\forall$–$\vee$ / $\exists$–$\wedge$ pairs hold one way only.
> > - **Why:** **Even/odd** ➔ $\forall X(\text{even}\vee\text{odd})$ true but not all-even-or-all-odd.
