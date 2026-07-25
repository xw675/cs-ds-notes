---
unit: FIT1058
domain: D
week: 3
parent: "[[Theorem and Proof]]"
tags: [Math/Logic, Math/Proof]
---
# [[Logical Implication]]

**Context:** [[FIT1058_MOC]] · the conditional [[Logical Connectives|connective]] $P\Rightarrow Q$ · equivalent to a [[Subset and Superset|subset]] containment · used by [[Modus Ponens]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $P\Rightarrow Q$: whenever $P$ holds, $Q$ holds ➔ forbids exactly one case — $P$ true, $Q$ false.
> - **📦 Core Components:** $P\Rightarrow Q\equiv\neg P\vee Q$ ➔ $\equiv P\subseteq Q$ ➔ biconditional = both directions.
> - **⚡ Key Constraint:** **non-symmetric** — the converse $Q\Rightarrow P$ does not follow.

## 📝 Core
### 1. The Conditional (One Forbidden Row)
- **Meaning** ➔ "if antecedent $P$ then consequent $Q$" ➔ forbids only $P$ T with $Q$ F.
- **Domino** ➔ (stands,stands), (stands,falls), (falls,falls) possible; only (falls,stands) impossible.
- **Vacuous truth** ➔ $P$ false ⟹ $P\Rightarrow Q$ true regardless of $Q$.

### 2. Two Rewrites
- **Disjunction** ➔ $P\Rightarrow Q\equiv\neg P\vee Q$ ➔ needs no special gate, just $\neg,\vee$.
- **Biconditional** ➔ $P\Leftrightarrow Q\equiv(P\Rightarrow Q)\wedge(Q\Rightarrow P)$.

### 3. Implication as Containment
- **Set view** ➔ $P,Q$ as scenario-sets ➔ "$P$ can't happen without $Q$" ⟹ $P\setminus Q=\emptyset$.
- **Equivalence** ➔ $P\Rightarrow Q\equiv P\subseteq Q$ ➔ proving an implication = proving a [[Subset and Superset|containment]].
- **iff = set equality** ➔ both directions ⟹ $P\subseteq Q$ and $Q\subseteq P$ ⟹ $P=Q$.

**Key identities:**

$$P\Rightarrow Q \equiv \neg P\vee Q, \qquad P\Rightarrow Q \equiv P\subseteq Q$$

## ⚖️ Core Decision Matrix
| Statement | Formal | As sets |
| :--- | :--- | :--- |
| "if $P$ then $Q$" / "$P$ only if $Q$" | $P\Rightarrow Q$ | $P\subseteq Q$ |
| "$P$ if $Q$" (converse) | $Q\Rightarrow P$ | $Q\subseteq P$ |
| "$P$ iff $Q$" (biconditional) | $P\Leftrightarrow Q$ | $P=Q$ |
| rewrite | $\neg P\vee Q$ | complement ∪ |

> [!NOTE] **When It Flips:** $P\Rightarrow Q$ asserts neither $P$ nor $Q$ individually — only the conditional link. Implication ↔ subset is the bridge: proving containment proves implication and vice versa; double inclusion is iff.

## 📊 Exam Execution Trace

### Manual Execution Trace
Verify $P\Rightarrow Q\equiv\neg P\vee Q$ and compare the converse:

| Step / State | $P$ | $Q$ | $P\Rightarrow Q$ | $\neg P\vee Q$ | $Q\Rightarrow P$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — | — |
| 1 | F | F | T | T | T |
| 2 | F | T | T | T | F |
| 3 | T | F | F | F | T |
| 4 | T | T | T | T | T |

## ⚠️ Common Mistakes
- 💡 **Beware the converse** ➔ $P\Rightarrow Q$ gives *no* information about $Q\Rightarrow P$; seeing the right domino fallen doesn't prove the left fell. "$P$ only if $Q$" = $P\Rightarrow Q$; "$P$ if $Q$" = $Q\Rightarrow P$.

## 🧠 Active Recall
> [!FAQ]- Why is $P\Rightarrow Q$ equivalent to $P\subseteq Q$, and what is the one forbidden configuration?
> - **Hint:** Scenario-sets.
> > [!SUCCESS]- Answer
> > - **Short answer:** No scenario has $P$ without $Q$ ⟹ $P\setminus Q=\emptyset$ ⟹ $P\subseteq Q$.
> > - **Why:** **Forbidden row** ➔ the only impossible case is $P$ true, $Q$ false (left domino falls, right stands).

> [!FAQ]- What is the converse of $P\Rightarrow Q$, why can't you assume it, and what does the biconditional add?
> - **Hint:** Non-symmetry.
> > [!SUCCESS]- Answer
> > - **Short answer:** Converse is $Q\Rightarrow P$; it doesn't follow from $P\Rightarrow Q$.
> > - **Why:** **Double inclusion** ➔ both directions give $P\Leftrightarrow Q$ = $P=Q$ (iff / logical equivalence).
