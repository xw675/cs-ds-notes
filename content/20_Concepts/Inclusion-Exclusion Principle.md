---
unit: FIT1058
week: [8, 9]
parent: "[[Set Operations (Mathematics)]]"
tags: [Math/Combinatorics, Math/Probability, Math/Discrete]
---
# [[Inclusion-Exclusion Principle]]

**Context:** [[FIT1058_MOC]] · the size (or [[Probability|probability]]) of a union of **overlapping** sets · alternating signed sum of all intersections · generalises $|A\cup B|=|A|+|B|-|A\cap B|$ · proved by [[Mathematical Induction]]

> [!abstract] Quick Revision
> - **🎯 Objective:** size of a union of overlapping sets ➔ alternating signed sum of all intersections.
> - **📦 Core Components:** add singles ➔ subtract pairs ➔ add triples ➔ sign $(-1)^{k+1}$.
> - **⚡ Key Constraint:** $2^n-1$ terms (exponential); disjoint case collapses to [[Counting Principles|addition]].

## 📝 Core
### 1. The Correction (Overlap)
- **Problem** ➔ adding sizes overcounts shared elements.
- **Two/three sets** ➔ $|A\cup B|=|A|+|B|-|A\cap B|$; add back $|A\cap B\cap C|$ for three.
- **Sign** ➔ $k$-fold intersection carries $(-1)^{k+1}$ (+ odd, − even).

### 2. General Theorem
- **Formula** ➔ $\lvert\bigcup A_i\rvert=\sum_{k=1}^n(-1)^{k+1}(\text{sum of }k\text{-fold intersection sizes})$.
- **Each element once** ➔ signs make every element counted exactly once.

### 3. Probability Version
- **Same identity** ➔ for [[Probability|probabilities]] of [[Sample Space and Events|events]].
- **Counting = uniform case** ➔ divide sizes by $|U|$ ([[Probability|Equally Likely Outcomes]]).

## ⚖️ Core Decision Matrix
| $k$ | Sign | Term |
| :--- | :--- | :--- |
| 1 | $+$ | single-set sizes |
| 2 | $-$ | pairwise intersections |
| 3 | $+$ | triple intersections |
| all disjoint | — | collapses to $\sum|A_i|$ ([[Counting Principles|Addition Principle]]) |

> [!NOTE] **When It Flips:** the disjoint case (all intersections empty) is the [[Counting Principles|Addition Principle]]. A dual form expresses $\lvert\bigcap A_i\rvert$ via union sizes (De Morgan). $\binom{n}{k}$ counts the $k$-fold terms at each level.

## 📊 Exam Execution Trace

### Manual Execution Trace
Divisible by 2, 3, or 5 among 100:

| Step / State | $k$ | Sign | Sum of sizes | Contribution |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — |
| 1 | 1 | $+$ | $50+33+20$ | $+103$ |
| 2 | 2 | $-$ | $16+10+6$ | $-32$ |
| 3 | 3 | $+$ | $3$ | $+3$ |

## ⚠️ Common Mistakes
- 💡 **$2^n-1$ terms** ➔ one per non-empty subset ([[Power Set]] count) — exact but exponential; practical only for small $n$ or when most intersections vanish.

## 🧠 Active Recall
> [!FAQ]- State inclusion–exclusion for three sets and why each sign is needed.
> - **Hint:** Count each element once.
> > [!SUCCESS]- Answer
> > - **Short answer:** $|A|+|B|+|C|-|A\cap B|-|A\cap C|-|B\cap C|+|A\cap B\cap C|$.
> > - **Why:** **Overcount fix** ➔ triples counted 3×, dropped to 0 by pairwise subtraction, restored to 1 by the triple term.

> [!FAQ]- Outline the inductive step of the general theorem.
> - **Hint:** Two-set rule + distributive law.
> > [!SUCCESS]- Answer
> > - **Short answer:** Split off $A_{n+1}$, apply two-set rule, distribute the intersection, apply the hypothesis to both $n$-fold unions.
> > - **Why:** **Reindex** ➔ terms excluding and including $A_{n+1}$ combine into the full signed sum over $n+1$ sets.
