---
unit: FIT1008
week: 1
parent: "[[Algorithm]]"
tags: [CS/Foundations, CS/Algorithms]
---
# [[Computational Problem]]

**Context:** [[FIT1008_MOC]] · the input→output **specification** an [[Algorithm]] must satisfy · owns *lower bounds*

> [!abstract] Quick Revision
> - **🎯 Objective:** specify a correct input→output relationship ➔ states *what* is correct for any input, not *how* to compute it.
> - **📦 Core Components:** **problem** (general spec) vs **instance** (one input) ➔ decision / search / optimisation.
> - **⚡ Key Constraint:** problems own **lower bounds** (comparison sorting $\Omega(n\log n)$); reductions transfer hardness.

## 📝 Core
### 1. The Problem (Spec, Not Method)
- **Definition** ➔ a well-specified **input→output relationship** — *what* a correct answer is, not *how*.
- **Instance** ➔ one concrete input ("find $\gcd(a,b)$" is the problem; $\gcd(45,30)=15$ an instance).
- **Correctness contract** ➔ a spec is a $(\text{Pre},\text{Post})$ pair; an [[Algorithm]] is **correct** iff every $\text{Pre}$-input yields a $\text{Post}$-output.

### 2. Taxonomy of Problem Types
- **Decision** ➔ yes/no ➔ the basis of **P** and **NP**.
- **Search / function** ➔ output an object (a path, a sorted list).
- **Optimisation** ➔ output the *best* feasible solution ➔ reduced to decision in complexity theory.

### 3. Intrinsic Difficulty (Lower Bounds, Reductions)
- **Lower bounds** ➔ bound *all* algorithms (comparison sorting $\Omega(n\log n)$, see [[Sorting Problem]]).
- **Reductions** ➔ $A\le_p B$ transfers hardness: $A$ hard and $A\le_p B$ ⟹ $B$ at least as hard.

## ⚖️ Core Decision Matrix
| Term | Meaning | Owns |
| :--- | :--- | :--- |
| **Problem** | general input→output specification | lower bounds |
| Instance | one specific input | — |
| [[Algorithm]] | finite procedure solving every instance | upper bounds |

> [!NOTE] **When It Flips:** tractability classes — **P** (poly-time solvable) vs **NP-hard/NP-complete** (no known poly algorithm). Reductions propagate both hardness ($A\le_p B$, $A$ hard ⟹ $B$ hard) and tractability (an efficient $B$-solver solves $A$).

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying three problems:

| Step / State | Problem | Type | Output |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | "Is $G$ 3-colourable?" | **decision** | yes/no |
| 2 | "Shortest $v\to u$ path" | **search** | a path object |
| 3 | "Minimum spanning tree" | **optimisation** | best feasible tree |

## ⚠️ Common Mistakes
- 💡 **Lower bound = about the problem** ➔ no algorithm beats it; an **upper bound** is exhibited by a *specific* [[Algorithm]] — matching the two proves optimal complexity.

## 🧠 Active Recall
> [!FAQ]- Distinguish decision, search, and optimisation problems and say which underpins P vs NP.
> - **Hint:** Output shape defines the class.
> > [!SUCCESS]- Answer
> > - **Short answer:** Decision (yes/no) defines P and NP; search outputs a witness; optimisation outputs the best feasible solution.
> > - **Why:** **Reduce to decision** ➔ complexity theory is built on decision problems, to which the others reduce.

> [!FAQ]- Why is a *lower bound* a statement about a problem rather than an algorithm?
> - **Hint:** Quantifies intrinsic difficulty.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Omega(n\log n)$ for comparison sorting asserts *no* correct algorithm can do better in the model.
> > - **Why:** **Match bounds** ➔ an upper bound is one algorithm's; equal upper and lower bounds prove optimal complexity.

> [!FAQ]- What does $A$ reducing to $B$ mean, and why is it useful?
> - **Hint:** Transform-and-transfer.
> > [!SUCCESS]- Answer
> > - **Short answer:** Efficiently map $A$'s instances to $B$'s so $B$'s answer yields $A$'s.
> > - **Why:** **Two-way flow** ➔ $A$ hard, $A\le_p B$ ⟹ $B$ hard; an efficient $B$-solver solves $A$ — propagates hardness and tractability.
