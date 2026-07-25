---
unit: FIT1058
week: 4
parent: "[[Boolean Algebra Laws]]"
tags: [Math/Logic, CS/DigitalLogic]
---
# [[Universal Sets of Operations]]

**Context:** [[FIT1058_MOC]] · an operation set that can express every Boolean expression · follows from [[Disjunctive Normal Form|DNF]]/[[Conjunctive Normal Form|CNF]] · motivates simple logic gates

> [!abstract] Quick Revision
> - **🎯 Objective:** an operation set expressing every Boolean expression ➔ functional completeness.
> - **📦 Core Components:** $\{\neg,\wedge,\vee\}$ (from DNF/CNF) ➔ shrink via De Morgan to $\{\neg,\wedge\}$ or $\{\neg,\vee\}$.
> - **⚡ Key Constraint:** $\neg$ alone (unary) and $\{\wedge,\vee\}$ (no negation) are **not** universal; NAND/NOR alone are.

## 📝 Core
### 1. Universality (Functional Completeness)
- **Definition** ➔ set $X$ is universal if every Boolean expression equals one using only $X$'s operations + variables.
- **Baseline** ➔ every expression has a [[Disjunctive Normal Form|DNF]]/[[Conjunctive Normal Form|CNF]] using only $\neg,\wedge,\vee$ ⟹ $\{\neg,\wedge,\vee\}$ universal.

### 2. Shrinking the Set
- **De Morgan trades** ➔ $P\wedge Q=\neg(\neg P\vee\neg Q)$, $P\vee Q=\neg(\neg P\wedge\neg Q)$.
- **Drop one** ➔ $\{\neg,\wedge\}$ and $\{\neg,\vee\}$ are each universal (keep $\neg$).
- **Not minimal via others** ➔ $\Rightarrow,\Leftrightarrow,\oplus$ already reduce to $\neg,\wedge,\vee$.

### 3. Why It Matters (Gates)
- **Circuits** ➔ Boolean expressions realise as **logic-gate** circuits.
- **Few types** ➔ a small universal set ⟹ fewer component types ⟹ cheaper, easier to verify.
- **Single gate** ➔ **NAND** or **NOR** is universal alone ⟹ chips often built from one gate type.

**Key identities:**

$$P\vee Q = \neg(\neg P\wedge\neg Q), \qquad P\Rightarrow Q = \neg P\vee Q = \neg(P\wedge\neg Q)$$

## ⚖️ Core Decision Matrix
| Set | Universal? | Reason |
| :--- | :--- | :--- |
| $\{\neg,\wedge,\vee\}$ | ✅ | DNF/CNF use only these |
| $\{\neg,\wedge\}$, $\{\neg,\vee\}$ | ✅ | De Morgan drops one |
| $\{\wedge,\vee\}$ | ❌ | no way to negate |
| $\{\neg\}$ | ❌ | unary — can't combine |
| $\{$NAND$\}$, $\{$NOR$\}$ | ✅ | each expresses $\neg,\wedge,\vee$ |

> [!NOTE] **When It Flips:** universality guarantees *expressibility*, not minimal *circuit size* — a single-gate realisation may need more gates/longer chains than a mixed set. Trade-off: fewer component types (manufacturing) vs circuit depth.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Express $P\vee Q$ in $\{\neg,\wedge\}$ and explain why $\{\wedge,\vee\}$ fails.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
P\vee Q &= \neg(\neg P\wedge\neg Q) && \text{(De Morgan)} \\
\{\wedge,\vee\}\text{ of } P &\text{ is T whenever } P \text{ is T} &&\Rightarrow \neg P \text{ unreachable}
\end{aligned}
$$
**Final Extracted Output:** $\{\neg,\wedge\}$ universal; $\{\wedge,\vee\}$ not — it cannot flip a value.

## ⚠️ Common Mistakes
- 💡 **A universal singleton must be binary** ➔ $\{\neg\}$ can't combine two variables; $\{\wedge,\vee\}$ can't flip a value (any $\wedge/\vee$ of $P$ stays T when $P$ is T), so negation is indispensable.

## 🧠 Active Recall
> [!FAQ]- Why is $\{\neg,\wedge,\vee\}$ universal, and how do you shrink it to two operations?
> - **Hint:** DNF/CNF + De Morgan.
> > [!SUCCESS]- Answer
> > - **Short answer:** Every expression has a DNF/CNF over $\neg,\wedge,\vee$; De Morgan rewrites one binary op via the other.
> > - **Why:** **Drop $\wedge$ or $\vee$** ➔ $\{\neg,\wedge\}$ and $\{\neg,\vee\}$ each remain universal.

> [!FAQ]- Why can't $\{\neg\}$ or $\{\wedge,\vee\}$ be universal, and why does universality matter for circuits?
> - **Hint:** Arity and negation.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\neg$ is unary (can't combine); $\{\wedge,\vee\}$ can't build $\neg P$.
> > - **Why:** **Simple hardware** ➔ NAND/NOR are each universal alone, so chips use few, mass-produced gate types.
