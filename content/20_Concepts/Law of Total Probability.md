---
unit: FIT1058
domain: D
week: 9
parent: "[[Conditional Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Law of Total Probability]]

**Context:** [[FIT1058_MOC]] · break an event's probability across a [[Set Partition|partition]] of the sample space · weighted sum of [[Conditional Probability|conditionals]] · the denominator of extended [[Bayes' Theorem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** partition $U=\bigsqcup A_i$ ⟹ $\mathrm{Pr}(B)=\sum_i\mathrm{Pr}(B\mid A_i)\mathrm{Pr}(A_i)$ ➔ weighted sum of conditionals.
> - **📦 Core Components:** distribute over the partition ➔ additivity ➔ multiplication rule.
> - **⚡ Key Constraint:** partition must be disjoint + exhaustive; supplies Bayes' denominator.

## 📝 Core
### 1. The Law
- **Formula** ➔ $\mathrm{Pr}(B)=\sum_i\mathrm{Pr}(B\cap A_i)=\sum_i\mathrm{Pr}(B\mid A_i)\mathrm{Pr}(A_i)$.
- **Partition** ➔ $U=A_1\sqcup\cdots\sqcup A_n$ (mutually exclusive + exhaustive).

### 2. Why It Works
- **Distribute** ➔ $B=\bigsqcup_i(B\cap A_i)$ (disjoint pieces).
- **Add** ➔ $\mathrm{Pr}(B)=\sum_i\mathrm{Pr}(B\cap A_i)$ ([[Mutually Exclusive Events|additivity]]).
- **Multiply** ➔ $\mathrm{Pr}(B\cap A_i)=\mathrm{Pr}(B\mid A_i)\mathrm{Pr}(A_i)$.

### 3. When It Helps
- **Easy conditionals** ➔ choose a partition where each $\mathrm{Pr}(B\mid A_i)$ is simple.
- **Causes/scenarios** ➔ turns one hard probability into a sum of simple ones.

**Key identities:**

$$\mathrm{Pr}(B)=\sum_{i=1}^n\mathrm{Pr}(B\mid A_i)\,\mathrm{Pr}(A_i),\qquad U=\bigsqcup_i A_i$$

> [!NOTE] **When It Flips:** the sum $\sum_i\mathrm{Pr}(B\mid A_i)\mathrm{Pr}(A_i)$ is exactly the **denominator** (normaliser) of the extended [[Bayes' Theorem]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Three coins (Fair, DoubleHead, DoubleTail), $\mathrm{Pr}(\text{Heads})$:

| Step / State | Cause $A_i$ | $\mathrm{Pr}(A_i)$ | $\mathrm{Pr}(H\mid A_i)$ | Product |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — |
| 1 | Fair | $\tfrac13$ | $\tfrac12$ | $\tfrac16$ |
| 2 | DoubleHead | $\tfrac13$ | 1 | $\tfrac13$ |
| 3 | DoubleTail | $\tfrac13$ | 0 | 0 |

## ⚠️ Common Mistakes
- 💡 **Partition must cover with no overlap** ➔ a gap or overlap breaks the equality; each $\mathrm{Pr}(A_i)>0$ so the conditionals exist.

## 🧠 Active Recall
> [!FAQ]- State the law of total probability and derive it from additivity.
> - **Hint:** Distribute + add + multiply.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(B)=\sum_i\mathrm{Pr}(B\mid A_i)\mathrm{Pr}(A_i)$ over a partition.
> > - **Why:** **$B=\bigsqcup(B\cap A_i)$** ➔ additivity then the multiplication rule.

> [!FAQ]- Why is the law useful, and where does it appear in Bayes' Theorem?
> - **Hint:** Easy conditionals; the normaliser.
> > [!SUCCESS]- Answer
> > - **Short answer:** Converts a hard $\mathrm{Pr}(B)$ into a sum of simple conditionals over causes $A_i$.
> > - **Why:** **Bayes' denominator** ➔ the same sum normalises the posteriors to sum to 1.
