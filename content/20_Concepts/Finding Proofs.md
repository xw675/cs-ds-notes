---
unit: [FIT1058, FIT2014]
week: 3
parent: "[[Theorem and Proof]]"
tags: [Math/Proof, Math/Logic, Monash/CS_DS]
---
# [[Finding Proofs]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · how to *discover* a proof · no general algorithm exists · structural blueprints for common goals

> [!abstract] Quick Revision
> - **🎯 Objective:** discover and structure a proof by matching a blueprint to the goal's shape ➔ no mechanical algorithm exists.
> - **📦 Core Components:** $\subseteq$ → element chasing | set $=$ → double containment | numeric $=$ → direct / mutual inequality.
> - **⚡ Key Constraint:** Gödel + Church–Turing forbid a general proof-finding algorithm.

## 📝 Core
### 1. No Algorithm, Only Blueprints
- **Art + science** ➔ logical skill, familiarity, experimentation, pattern recognition, perseverance.
- **Blueprints** ➔ standard step-structures matched to the goal's *shape* ([[Subset and Superset|subset]], set equality, numeric equality).

### 2. The Three Blueprints
- **$A\subseteq B$** ➔ **element chasing** — take arbitrary $x\in A$, unpack, show $x\in B$.
- **$A=B$ (sets)** ➔ **double containment** — prove $A\subseteq B$ and $B\subseteq A$.
- **$A=B$ (numbers)** ➔ **direct manipulation** or **mutual inequality** ($A\le B$ and $A\ge B$).

### 3. Why No Algorithm
- **Gödel (1931)** ➔ any consistent arithmetic-capable system has **true but unprovable** statements.
- **Church–Turing (1936)** ➔ the *Entscheidungsproblem* is **undecidable** — no algorithm decides provability.

## ⚖️ Core Decision Matrix
| Goal shape | Blueprint | First line |
| :--- | :--- | :--- |
| $A\subseteq B$ | element chasing | "Let $x\in A$…" |
| $A=B$ (sets) | double containment | prove both inclusions |
| $A=B$ (numbers) | direct / mutual inequality | transform or $A\le B, A\ge B$ |

> [!NOTE] **When It Flips:** blueprints are heuristics, not recipes — they organise the argument, but choosing *which* definition to unpack or *which* bound to use is the creative content. Double containment / mutual inequality splits one hard equality into two easier one-directional arguments.

## 📊 Exam Execution Trace

### Manual Execution Trace
Element-chasing $A\cap B\subseteq A$:

| Step / State | Statement | Justification |
| :--- | :--- | :--- |
| **0 (Init)** | let $x\in A\cap B$ | arbitrary element |
| 1 | $x\in A\wedge x\in B$ | def $\cap$ |
| 2 | $x\in A$ | conjunction elimination |
| 3 | $A\cap B\subseteq A$ | $\square$ |

## ⚠️ Common Mistakes
- 💡 **Match blueprint to goal shape** ➔ $\subseteq$ → element chasing; set $=$ → double containment; the two-sided inequality is the fallback when direct transformation stalls.

## 🧠 Active Recall
> [!FAQ]- Why is there no general algorithm for finding proofs?
> - **Hint:** Foundational limits.
> > [!SUCCESS]- Answer
> > - **Short answer:** Gödel (true-but-unprovable statements) and Church–Turing (undecidable *Entscheidungsproblem*).
> > - **Why:** **Not a gap** ➔ these are theorems; proof discovery relies on insight, not mechanisation.

> [!FAQ]- Give the blueprint for set equality $A=B$ and the two routes for numeric $A=B$.
> - **Hint:** Split into one-directional arguments.
> > [!SUCCESS]- Answer
> > - **Short answer:** Sets: double containment ($A\subseteq B$ and $B\subseteq A$); numbers: direct manipulation or mutual inequality ($A\le B$, $A\ge B$).
> > - **Why:** **Fallback** ➔ two-sided inequality when direct transformation stalls.
