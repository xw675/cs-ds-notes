---
unit: [FIT1058, FIT2014]
week: [1, 3]
parent: "[[Proof Techniques]]"
tags: [Math/Logic, Math/Proof]
---
# [[Theorem and Proof]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · a theorem is a proven statement, a proof its rigorous argument · each step is a definition/assumption/[[Modus Ponens|consequence]] · realised by the [[Proof Techniques]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a theorem is a proven statement; a proof is its finite, rigorous step sequence ➔ ends in exactly the claim.
> - **📦 Core Components:** each step ➔ pre-existing knowledge / assumption / logical consequence.
> - **⚡ Key Constraint:** must be **verifiable** and **sequentially readable** (no forward/circular dependence).

## 📝 Core
### 1. Theorem & Proof (Object + Certificate)
- **Theorem** ➔ a statement **proven true**.
- **Proof** ➔ a finite **sequence of statements** establishing the claim with certainty, ending in the target.
- **Roles** ➔ **lemma** (stepping-stone), **proposition** (independent lesser result), **corollary** (immediate follow-on).

### 2. The Three Kinds of Step
- **Pre-existing** ➔ a definition, **axiom** (accepted unproven, e.g. distributivity), or prior theorem.
- **Assumption** ➔ a temporary hypothesis (incl. "let $x$ arbitrary").
- **Logical consequence** ➔ implied by prior steps ➔ engine is [[Modus Ponens]].

### 3. Conventions
- **Format** ➔ open **Proof.**, close $\square$ / *Q.E.D.*
- **Numbering** ➔ useful for *analysis* only, omitted in a normal written proof.

## ⚖️ Core Decision Matrix
| Label | Role | Proven? |
| :--- | :--- | :--- |
| **Theorem** | significant result | yes |
| **Lemma** | stepping-stone for a bigger theorem | yes |
| **Proposition** | independent lesser result | yes |
| **Corollary** | immediate consequence of a theorem | yes |

> [!NOTE] **When It Flips:** theorem/lemma/proposition/corollary differ in *role*, not truth — all are proven. A proof must be verifiable (auditable independently) and read strictly top-to-bottom.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying each proof line:

| Step / State | Statement | Kind | Justification |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $A\subseteq B$ | assumption | hypothesis |
| 2 | let $X\in\mathcal P(A)$ | assumption | arbitrary |
| 3 | $X\subseteq A$ | consequence | def $\mathcal P$ |
| 4 | $X\subseteq B$ | consequence | 1,3 + transitivity |
| 5 | $X\in\mathcal P(B)$ | consequence | def $\mathcal P$ |

## ⚠️ Common Mistakes
- 💡 **Never depend on a later step** ➔ each line may use *only* what is already established; a step referencing a not-yet-proved fact is circular reasoning.

## 🧠 Active Recall
> [!FAQ]- What are the three permissible kinds of step, and the two structural requirements a proof must meet?
> - **Hint:** Step kinds + verifiability/readability.
> > [!SUCCESS]- Answer
> > - **Short answer:** Pre-existing knowledge / assumption / logical consequence; must be verifiable and sequentially readable.
> > - **Why:** **No look-ahead** ➔ each step depends only on prior ones, forbidding circular reasoning.

> [!FAQ]- Distinguish theorem, lemma, proposition, and corollary.
> - **Hint:** Role, not truth.
> > [!SUCCESS]- Answer
> > - **Short answer:** Theorem = significant; lemma = stepping-stone; proposition = independent lesser; corollary = immediate follow-on.
> > - **Why:** **All proven** ➔ the label marks importance and position, not validity.
