---
unit: FIT1058
domain: D
week: 9
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Probability Rules for Events]]

**Context:** [[FIT1058_MOC]] · set operations on events give probability rules · complement, difference, general union · mirror the [[Set Operations (Mathematics)|set-size laws]]

> [!abstract] Quick Revision
> - **🎯 Objective:** set operations on events ⟹ probability identities ➔ complement / difference / union.
> - **📦 Core Components:** $\mathrm{Pr}(\overline A)=1-\mathrm{Pr}(A)$ ➔ difference ➔ two-event inclusion–exclusion.
> - **⚡ Key Constraint:** these mirror the set-size laws divided by $|U|$; complement is the workhorse shortcut.

## 📝 Core
### 1. The Three Rules
- **Complement** ➔ $\mathrm{Pr}(\overline A)=1-\mathrm{Pr}(A)$.
- **Difference** ➔ $\mathrm{Pr}(B\setminus A)=\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$.
- **Union** ➔ $\mathrm{Pr}(A\cup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$.

### 2. Consequences
- **Complement tactic** ➔ "at least one" $=1-$"none".
- **Monotonicity** ➔ $A\subseteq B\Rightarrow\mathrm{Pr}(A)\le\mathrm{Pr}(B)$.
- **Union↔intersection** ➔ knowing one gives the other.

### 3. Partition Trick
- **Distributive** ➔ $B=\bigsqcup_i B_i\Rightarrow\mathrm{Pr}(A\cap B)=\sum_i\mathrm{Pr}(A\cap B_i)$.
- **Seed of** ➔ [[Law of Total Probability]].

**Key identities:**

$$\mathrm{Pr}(\overline A)=1-\mathrm{Pr}(A),\quad \mathrm{Pr}(B\setminus A)=\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$$
$$\mathrm{Pr}(A\cup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$$

## ⚖️ Core Decision Matrix
| Target | Set form | Rule |
| :--- | :--- | :--- |
| $\overline A$ | $U\setminus A$ | $1-\mathrm{Pr}(A)$ |
| $B\setminus A$ | difference | $\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$ |
| $A\cup B$ | union | $\mathrm{Pr}A+\mathrm{Pr}B-\mathrm{Pr}(A\cap B)$ |
| $A\cap B$ | intersection | $\mathrm{Pr}A+\mathrm{Pr}B-\mathrm{Pr}(A\cup B)$ |

> [!NOTE] **When It Flips:** these mirror the set-size laws over $|U|$ — dividing $|A\cup B|=|A|+|B|-|A\cap B|$ by $|U|$ gives the probability rule in the uniform case; the general-union rule is two-event [[Inclusion-Exclusion Principle|inclusion–exclusion]].

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Find $\mathrm{Pr}(\text{not blank})$ and $\mathrm{Pr}(\text{consonant})$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\mathrm{Pr}(\text{not blank}) &= 1-0.02 = 0.98 \\
\mathrm{Pr}(\text{consonant}) &= \mathrm{Pr}(\text{non-blank})-\mathrm{Pr}(\text{vowel}) = 0.98-0.42 = 0.56
\end{aligned}
$$
**Final Extracted Output:** 0.98 (complement); 0.56 (difference, since vowels $\subseteq$ non-blanks).

## ⚠️ Common Mistakes
- 💡 **Difference needs $A\cap B$, not $A$** ➔ $\mathrm{Pr}(B)-\mathrm{Pr}(A)$ only holds when $A\subseteq B$; in general subtract $\mathrm{Pr}(A\cap B)$.

## 🧠 Active Recall
> [!FAQ]- Derive $\mathrm{Pr}(A)=1-\mathrm{Pr}(\overline A)$ and $\mathrm{Pr}(A\cup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)-\mathrm{Pr}(A\cap B)$.
> - **Hint:** Disjoint decomposition.
> > [!SUCCESS]- Answer
> > - **Short answer:** $A\sqcup\overline A=U$ ⟹ complement; $A\cup B=(A\setminus B)\sqcup(A\cap B)\sqcup(B\setminus A)$ ⟹ union.
> > - **Why:** **Double-count fix** ➔ adding $\mathrm{Pr}(A)+\mathrm{Pr}(B)$ counts $A\cap B$ twice.

> [!FAQ]- Why does $A\subseteq B$ imply $\mathrm{Pr}(A)\le\mathrm{Pr}(B)$, and what replaces $\mathrm{Pr}(B)-\mathrm{Pr}(A)$ otherwise?
> - **Hint:** Monotonicity.
> > [!SUCCESS]- Answer
> > - **Short answer:** $B=A\sqcup(B\setminus A)$ with nonnegative parts ⟹ $\mathrm{Pr}(B)\ge\mathrm{Pr}(A)$; general form uses $\mathrm{Pr}(A\cap B)$.
> > - **Why:** **Special case** ➔ $A\subseteq B$ makes $A=A\cap B$.
