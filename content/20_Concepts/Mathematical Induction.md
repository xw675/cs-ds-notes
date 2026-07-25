---
unit: [FIT1058, FIT2014]
domain: D
week: [2, 3]
parent: "[[Proof Techniques]]"
tags: [Math/Proof, Math/Induction]
---
# [[Mathematical Induction]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · proves $\forall n\in\mathbb N,\ S(n)$ via base case + step · a [[Proof Techniques|proof technique]] driven by [[Modus Ponens]] · powers loop/recursion analysis

> [!abstract] Quick Revision
> - **🎯 Objective:** prove $\forall n\in\mathbb N,\ S(n)$ ➔ discharge basis $S(1)$ + step $S(k)\Rightarrow S(k+1)$.
> - **📦 Core Components:** **Basis** ➔ $S(1)$ | **Hypothesis** ➔ assume $S(k)$ | **Step** ➔ derive $S(k+1)$.
> - **⚡ Key Constraint:** both obligations mandatory — no basis ⟹ chain never starts; no step ⟹ dominoes don't propagate.

## 📝 Core
### 1. The Principle (Domino Cascade)
- **Claim shape** ➔ $\forall n\in\mathbb N,\ S(n)$ ➔ a universal over a well-ordered domain.
- **Two obligations** ➔ **basis** $S(1)$ + **step** $\forall k\ge1:\ S(k)\Rightarrow S(k+1)$.
- **Engine** ➔ [[Modus Ponens]] fires along the integers: $S(1)\Rightarrow S(2)\Rightarrow S(3)\Rightarrow\cdots$

### 2. Anatomy of the Step
- **Inductive hypothesis** ➔ **assume** $S(k)$ for arbitrary $k$.
- **Obligation** ➔ *derive* $S(k+1)$ from $S(k)$ ➔ not re-assert it.
- **Re-indexing** ➔ $S(k-1)\Rightarrow S(k)$ with shifted basis is the same proof.

### 3. Variants & Assumptions
- **Strong induction** ➔ assume $S(1),\dots,S(k)$ ➔ derive $S(k+1)$.
- **Shifted basis** ➔ start at $n=0$ or $n_0$ ➔ proves $\forall n\ge n_0$.
- **Assumption** ➔ domain well-ordered ($\mathbb N$); $S(n)$ a precise per-$n$ statement.

### 4. Stating the Hypothesis Correctly (FIT2014)
- **✅ Correct opening** ➔ "**Let $k\ge1$. Assume $S(k)$ is true.**" — announces $k$ as **arbitrary**, subject only to the stated condition.
- **❌ "Assume for all $k$, $S(k)$"** ➔ assumes the very conclusion (circular).
- **❌ "Assume for some $k$, $S(k)$"** ➔ assumes only what the **base case** already gives.
- **Test the step at its smallest $k$** ➔ a step valid "for large $n$" but failing at the first link proves nothing — the classic faulty inductions are catalogued in [[Proof Critique (Good, Bad and Ugly Proofs)]].
- **Worked application** ➔ the extended De Morgan law $\neg(P_1\vee\cdots\vee P_n)=\neg P_1\wedge\cdots\wedge\neg P_n$ is proved by induction on $n$: basis $\neg P_1=\neg P_1$; step regroups $(P_1\vee\cdots\vee P_k)\vee P_{k+1}$, applies two-variable De Morgan, then the inductive hypothesis.

**Key identities:**

$$\begin{aligned}\textbf{Basis }(n{=}1)&:\ 1=\tfrac{1\cdot2}{2}=1\ \checkmark \\ \textbf{Step}&:\ \sum_{i=1}^{k+1}i=\underbrace{\tfrac{k(k+1)}{2}}_{\text{hyp.}}+(k+1)=(k+1)\tfrac{k+2}{2}=\tfrac{(k+1)(k+2)}{2}\end{aligned}$$

## ⚖️ Core Decision Matrix
| Obligation | Role | Omitting it |
| :--- | :--- | :--- |
| **Basis** $S(1)$ | knocks over first domino | chain never starts |
| **Step** $S(k)\Rightarrow S(k+1)$ | each domino topples next | truth can't propagate |
| **Hypothesis** $S(k)$ | assumed *inside* the step | (not a separate obligation) |

> [!NOTE] **When It Flips:** basis + step together are equivalent to the well-ordering of $\mathbb N$ — neither alone proves anything. Application: the nested loop `for i=1..N, for j=i+1..N` runs $\sum_{i=1}^{N-1}(N-i)=\tfrac{N(N-1)}{2}$ times, an [[Arithmetic Series]] proved by this very formula.

## 📊 Exam Execution Trace

### Manual Execution Trace
Discharging both obligations for $\sum_{i=1}^n i=\tfrac{n(n+1)}{2}$:

| Step / State | Stage | Statement to establish | Discharged? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | claim | $\forall n:\ \sum_{i=1}^n i=\tfrac{n(n+1)}{2}$ | — |
| 1 | Basis $S(1)$ | $1=\tfrac{1\cdot2}{2}$ | ✓ |
| 2 | Hypothesis $S(k)$ | assume $\sum_{i=1}^k i=\tfrac{k(k+1)}{2}$ | assumed |
| 3 | Step $S(k){\Rightarrow}S(k+1)$ | $\sum_{i=1}^{k+1} i=\tfrac{(k+1)(k+2)}{2}$ | ✓ |

## ⚠️ Common Mistakes
- 💡 **Induction is deductive, not empirical** ➔ the basis + implication *force* $S(n)$ for every $n$ with zero error; statistical "induction" from sampled data is probabilistic and **cannot** be a proof step.

## 🧠 Active Recall
> [!FAQ]- State the two obligations of an induction proof and why both are necessary (domino analogy).
> - **Hint:** Start the chain *and* propagate it.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prove basis $S(1)$ and step $S(k)\Rightarrow S(k+1)$ for arbitrary $k$.
> > - **Why:** **Dominoes** ➔ basis knocks over the first, step topples each next; [[Modus Ponens]] cascades over all $n$. No basis ⟹ nothing starts; no step ⟹ chain stalls.

> [!FAQ]- Prove $1+2+\cdots+n=\frac{n(n+1)}{2}$ by induction.
> - **Hint:** Add $(k+1)$ to the hypothesis.
> > [!SUCCESS]- Answer
> > - **Short answer:** Basis $1=\tfrac{1\cdot2}{2}$; step $\tfrac{k(k+1)}{2}+(k+1)=\tfrac{(k+1)(k+2)}{2}$.
> > - **Why:** **Factor out $(k+1)$** ➔ $(k+1)(\tfrac k2+1)=\tfrac{(k+1)(k+2)}{2}$, the formula at $n=k+1$. $\square$

> [!FAQ]- Why is "mathematical induction" deductive rather than the empirical "induction" of data science?
> - **Hint:** Certainty vs probability.
> > [!SUCCESS]- Answer
> > - **Short answer:** Base case + $S(k)\Rightarrow S(k+1)$ logically force $S(n)$ for every $n$ with certainty.
> > - **Why:** **Opposite epistemics** ➔ empirical induction generalises from samples (probabilistic, error-prone) and cannot be a proof step.
