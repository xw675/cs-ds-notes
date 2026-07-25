---
unit: FIT1058
week: 9
parent: "[[Sample Space and Events]]"
tags: [Math/Probability, Math/Combinatorics, Math/Discrete]
aliases: [Equally Likely Outcomes, Laplace Probability]
---
# [[Probability]]

**Context:** [[FIT1058_MOC]] · a measure in $[0,1]$ of how likely an event is · outcomes get probabilities summing to $1$ · uniform finite case turns probability into [[Selection (Counting Framework)|counting]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\mathrm{Pr}(A)\in[0,1]$ measures likelihood ➔ $\mathrm{Pr}(A)=\sum_{x\in A}\mathrm{Pr}(x)$; uniform finite ⟹ $|A|/|U|$.
> - **📦 Core Components:** axioms (normalised weights) ➔ event = sum over outcomes ➔ Laplace ratio when equally likely.
> - **⚡ Key Constraint:** $|A|/|U|$ requires finiteness **and** uniformity; no uniform distribution on $\mathbb N$ exists.

## 📝 Core

### 1. The Measure (Axioms)
- **Definition** ➔ $\mathrm{Pr}(A)\in[0,1]$; impossible $=0$, certain $=1$.
- **Axioms** ➔ $0\le\mathrm{Pr}(x)\le1$, $\sum_{x\in U}\mathrm{Pr}(x)=1$.
- **Event probability** ➔ $\mathrm{Pr}(A)=\sum_{x\in A}\mathrm{Pr}(x)$ over the event's outcomes.
- **Graded vs binary** ➔ a [[Proposition and Truth Value|proposition]] is true/false; probability grades likelihood continuously.

### 2. Equally Likely Outcomes (Laplace / Uniform Case)
- **Uniform formula** ➔ finite $U$, all outcomes equal ⟹ each $\mathrm{Pr}(x)=\tfrac1{|U|}$ and $\mathrm{Pr}(A)=\tfrac{|A|}{|U|}$ — favourable ÷ total.
- **Probability = counting** ➔ reduces to finding $|A|$ and $|U|$; all [[Selection (Counting Framework)|counting]] techniques and [[Inclusion-Exclusion Principle|inclusion–exclusion]] apply (divide the set formula by $|U|$).
- **Worked micro-example** ➔ fair die: $\mathrm{Pr}(\text{square})=\mathrm{Pr}(\{1,4\})=\tfrac26=\tfrac13$; $\mathrm{Pr}(\text{not }1)=\tfrac56$.
- **Refinement trick** ➔ coarse non-uniform spaces (dice *totals*) hide a uniform substrate — drop to the $36$ equally-likely pairs first.

### 3. Non-Uniform & Infinite Spaces
- **Unequal weights** ➔ use the general sum: Scrabble $\mathrm{Pr}(\text{vowel})=0.42$ (sum of tile weights).
- **Infinite $U$** ➔ needs a convergent sum: $\mathrm{Pr}(n)=\tfrac1{2^n}$ on $\mathbb N$ sums to $1$ ([[Geometric Series]]).
- **No uniform on $\mathbb N$** ➔ constant $c>0$ sums to $\infty$, $c=0$ sums to $0$ — uniformity over an infinite set is impossible.

## ⚠️ Common Mistakes
- 💡 **Only if equally likely** ➔ dice totals are non-uniform, so $|A|/|U|$ is wrong on the 11 totals — refine to the uniform 36-pair space.
- 💡 **No uniform distribution on $\mathbb N$** ➔ any constant weight fails normalisation; state finiteness before using Laplace.

## 🧠 Active Recall
> [!FAQ]- State the axioms of a probability assignment and the equally-likely special case.
> - **Hint:** Normalise, then sum.
> > [!SUCCESS]- Answer
> > - **Short answer:** $0\le\mathrm{Pr}(x)\le1$, $\sum\mathrm{Pr}(x)=1$, $\mathrm{Pr}(A)=\sum_{x\in A}\mathrm{Pr}(x)$; uniform finite ⟹ $|A|/|U|$.
> > - **Why:** **Counting ratio** ➔ uniform probability is favourable ÷ total (Laplace).

> [!FAQ]- Show $\mathrm{Pr}(n)=1/2^n$ on $\mathbb N$ is valid, and why no uniform distribution on $\mathbb N$ exists.
> - **Hint:** Normalisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\sum_{n\ge1}\tfrac1{2^n}=1$ (geometric); a constant $c$ gives $\infty$ or $0$.
> > - **Why:** **Fails normalisation** ➔ positive integers cannot be made equally likely.

> [!FAQ]- Two fair dice: why is $\mathrm{Pr}(\text{total}=7)$ not $\tfrac1{11}$, and what is it?
> - **Hint:** Refine to the uniform substrate.
> > [!SUCCESS]- Answer
> > - **Short answer:** Totals are non-uniform; on the 36 equally-likely ordered pairs, six give 7 ⟹ $\mathrm{Pr}=\tfrac6{36}=\tfrac16$.
> > - **Why:** **Uniformity check** ➔ Laplace applies only where outcomes are interchangeable — pairs, not totals.
