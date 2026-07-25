---
unit: FIT1058
week: 9
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete, Monash/CS_DS]
---
# [[Sample Space and Events]]

**Context:** [[FIT1058_MOC]] · the set of all outcomes of a random experiment · events are its [[Subset and Superset|subsets]] · the universal set for [[Probability]]

> [!abstract] Quick Revision
> - **🎯 Objective:** sample space $U$ = all outcomes; event = subset $A\subseteq U$ ➔ occurs when the outcome is in $A$.
> - **📦 Core Components:** experiment ➔ outcome ➔ $U$ (universal set) ➔ events as subsets.
> - **⚡ Key Constraint:** choice of space matters — a fine uniform space beats a coarse non-uniform one.

## 📝 Core
### 1. The Setup
- **Experiment** ➔ a partly random process yielding one outcome.
- **Sample space** ➔ $U$ = set of all outcomes = the universal set.
- **Event** ➔ subset $A\subseteq U$, occurs when the actual outcome lies in $A$.

### 2. Choosing the Space
- **Non-uniform valid** ➔ two-dice totals $\{2,\dots,12\}$ (not equally likely).
- **Uniform better** ➔ $36$ ordered pairs, each $\tfrac1{36}$ ([[Cartesian Product]]).
- **Fine expresses more** ➔ "doubles" / "first die = 3" need the pair space.

### 3. Events Are Sets
- **Operations** ➔ $A\cup B$ ("or"), $A\cap B$ ("and"), $\overline A$ ("not").
- **Extremes** ➔ $U$ = certain event, $\emptyset$ = impossible event.

**Key identities:**

$$U=\{1,\dots,6\}\times\{1,\dots,6\},\ |U|=36\ (\text{uniform})$$
$$\text{vs totals } \{2,\dots,12\}\ (\text{valid but non-uniform})$$

## ⚖️ Core Decision Matrix
| Space | Uniform? | Expressive? |
| :--- | :--- | :--- |
| $36$ pairs | yes ($\tfrac1{36}$) | high |
| $11$ totals | no | low |
| $U$ | — | certain event |
| $\emptyset$ | — | impossible event |

> [!NOTE] **When It Flips:** the sample space *is* the [[Set Operations (Mathematics)|universal set]], which makes "not $A$" ($\overline A$) well-defined; a uniform fine space makes $|A|/|U|$ ([[Probability|Equally Likely Outcomes]]) usable, but accuracy of the model comes first.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Give $U$, $A=$"total 8", $B=$"doubles" for two fair dice.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
U &= \{1,\dots,6\}^2,\ |U|=36 \\
|A| &= 5,\quad |B| = 6
\end{aligned}
$$
**Final Extracted Output:** $U$ = 36 pairs; $A$ has 5 outcomes, $B$ has 6 — both only in the fine space.

## ⚠️ Common Mistakes
- 💡 **Coarse spaces lose information** ➔ the $11$-total space can't represent "doubles"; the fine $36$-pair space is both uniform and more expressive.

## 🧠 Active Recall
> [!FAQ]- What are a sample space and event, and why prefer the 36-pair over the 11-total space?
> - **Hint:** Uniform + expressive.
> > [!SUCCESS]- Answer
> > - **Short answer:** $U$ = all outcomes (universal set); event = subset; the pair space is uniform and can express doubles.
> > - **Why:** **Finer = more** ➔ totals are non-uniform and lose events like "first die = 3".

> [!FAQ]- Why can set operations be applied to events, and what are the certain/impossible events?
> - **Hint:** Events are subsets.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\cup,\cap,\overline{\cdot}$ build new events; $U$ certain (prob 1), $\emptyset$ impossible (prob 0).
> > - **Why:** **Set footing** ➔ lets probability reuse union/intersection and inclusion–exclusion.
