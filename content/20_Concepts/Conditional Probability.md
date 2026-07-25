---
unit: FIT1058
week: 9
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Conditional Probability]]

**Context:** [[FIT1058_MOC]] · the probability of $A$ **given** $B$ occurred · restricts the sample space to $B$ and rescales · the basis of [[Bayes' Theorem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A\cap B)/\mathrm{Pr}(B)$ ➔ treat $B$ as the new sample space.
> - **📦 Core Components:** restrict to $B$ ➔ rescale by $1/\mathrm{Pr}(B)$ ➔ multiplication rule.
> - **⚡ Key Constraint:** requires $\mathrm{Pr}(B)>0$; independence ⟺ $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)$.

## 📝 Core
### 1. The Definition
- **Formula** ➔ $\mathrm{Pr}(A\mid B)=\frac{\mathrm{Pr}(A\cap B)}{\mathrm{Pr}(B)}$ ($\mathrm{Pr}(B)>0$).
- **Restrict** ➔ $B$ becomes the new [[Sample Space and Events|sample space]].
- **Multiplication rule** ➔ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(B)\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)\mathrm{Pr}(B\mid A)$.

### 2. Why Divide by $\mathrm{Pr}(B)$
- **Rescale** ➔ retained outcomes sum to $\mathrm{Pr}(B)\le1$; divide by $\mathrm{Pr}(B)$ to renormalise.
- **Only $A\cap B$ counts** ➔ within $B$, $A$ is realised by $A\cap B$.

### 3. Special Cases
- **$\mathrm{Pr}(B\mid B)=1$**, $\mathrm{Pr}(\emptyset\mid B)=0$.
- **Disjoint** ➔ $\mathrm{Pr}(A\mid B)=0$.
- **Independent** ➔ $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)$.

**Key identities:**

$$\mathrm{Pr}(A\mid B)=\frac{\mathrm{Pr}(A\cap B)}{\mathrm{Pr}(B)},\qquad \mathrm{Pr}(A\cap B)=\mathrm{Pr}(B)\mathrm{Pr}(A\mid B)$$

> [!NOTE] **When It Flips:** independence ⟺ $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)$ ⟺ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$; the symmetric multiplication rule yields [[Bayes' Theorem]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Scrabble: $\mathrm{Pr}(\text{vowel})=0.42$, $\mathrm{Pr}(\text{non-blank})=0.98$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | vowel ∩ non-blank | = vowel = 0.42 |
| 2 | $\mathrm{Pr}(\text{non-blank})$ | 0.98 |
| 3 | $\mathrm{Pr}(\text{vowel}\mid\text{non-blank})$ | $\approx0.43$ |

## ⚠️ Common Mistakes
- 💡 **Numerator is $A\cap B$, not $A$** ➔ $\mathrm{Pr}(X)/\mathrm{Pr}(B)$ only when $X\subseteq B$; otherwise use $A\cap B$. Conditioning on an impossible event is undefined.

## 🧠 Active Recall
> [!FAQ]- Define $\mathrm{Pr}(A\mid B)$ and justify the division by $\mathrm{Pr}(B)$.
> - **Hint:** Renormalise on $B$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A\cap B)/\mathrm{Pr}(B)$; $B$ is the new sample space.
> > - **Why:** **Sum to 1** ➔ retained masses sum to $\mathrm{Pr}(B)$; dividing renormalises.

> [!FAQ]- How does conditional probability characterise independence, and what is the multiplication rule?
> - **Hint:** Unchanged conditional.
> > [!SUCCESS]- Answer
> > - **Short answer:** Independent ⟺ $\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)$ ⟺ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$.
> > - **Why:** **Symmetric rule** ➔ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(B)\mathrm{Pr}(A\mid B)=\mathrm{Pr}(A)\mathrm{Pr}(B\mid A)$ gives Bayes.
