---
unit: FIT1058
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Logic, Math/Discrete]
---
# [[Subset and Superset]]

**Context:** [[FIT1058_MOC]] · the containment relation between [[Set (Mathematics)|sets]] · framed as logical implication · the basis of proving [[Set (Mathematics)|set]] equality

> [!abstract] Quick Revision
> - **🎯 Objective:** $A\subseteq B$: every element of $A$ is in $B$ ➔ membership of $A$ implies membership of $B$.
> - **📦 Core Components:** $\subseteq$ (allows $=$) vs $\subset$ (proper) ➔ set equality by double inclusion.
> - **⚡ Key Constraint:** $\subseteq$ is a **partial order** (reflexive, antisymmetric, transitive); not all sets comparable.

## 📝 Core
### 1. The Relation (Containment as Implication)
- **Subset** ➔ $A\subseteq B\Leftrightarrow(\forall x:\ x\in A\Rightarrow x\in B)$.
- **Superset** ➔ $B\supseteq A$ (same relation, read the other way).
- **Proper** ➔ $A\subset B$ = $A\subseteq B$ **and** $A\neq B$ (some element of $B$ not in $A$).

### 2. Set Equality by Double Inclusion
- **Both directions** ➔ $A=B\Leftrightarrow(A\subseteq B)\wedge(B\subseteq A)$.
- **Element level** ➔ biconditional $x\in A\Leftrightarrow x\in B$.
- **Technique** ➔ prove two easier one-directional inclusions separately.

### 3. "Iff" Decomposed
- **"if"** ➔ $x\in A\Leftarrow x\in B$ ⟹ $B\subseteq A$.
- **"only if"** ➔ $x\in A\Rightarrow x\in B$ ⟹ $A\subseteq B$.

**Key identities:**

$$A\subseteq B \iff (\forall x:\ x\in A\Rightarrow x\in B), \qquad A=B \iff (A\subseteq B)\wedge(B\subseteq A)$$
$$A\subseteq A,\qquad \emptyset\subseteq A \text{ (vacuously)},\qquad A\subseteq B\subseteq C\Rightarrow A\subseteq C$$

## ⚖️ Core Decision Matrix
| Property | Holds for $\subseteq$? | Statement |
| :--- | :--- | :--- |
| reflexive | yes | $A\subseteq A$ |
| antisymmetric | yes | $A\subseteq B\wedge B\subseteq A\Rightarrow A=B$ |
| transitive | yes | $A\subseteq B\subseteq C\Rightarrow A\subseteq C$ |
| total | no | not all sets comparable |

> [!NOTE] **When It Flips:** $\subseteq$ is a **partial order**; antisymmetry *is* double inclusion, the standard route to set equality. $\emptyset$ and $A$ itself are the universal extreme subsets of every set.

## 📊 Exam Execution Trace

### Manual Execution Trace
Double-inclusion proof of $A=B$:

| Step / State | Direction | Take $x$ in | Show $x$ in |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $A\subseteq B$ | $A$ | $B$ |
| 2 | $B\subseteq A$ | $B$ | $A$ |
| 3 | antisymmetry | — | $A=B$ |

## ⚠️ Common Mistakes
- 💡 **$\emptyset\subseteq A$ holds vacuously** ➔ no element of $\emptyset$ can violate the implication; and $\subseteq$ allows $A=B$ whereas $\subset$ forbids it.

## 🧠 Active Recall
> [!FAQ]- State the standard technique for proving two sets equal, and why it works.
> - **Hint:** Antisymmetry.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prove double inclusion $A\subseteq B$ and $B\subseteq A$.
> > - **Why:** **$\subseteq$ antisymmetric** ➔ the two implications give the biconditional $x\in A\Leftrightarrow x\in B$.

> [!FAQ]- Why is $\emptyset\subseteq A$ for every $A$, and how does $\subseteq$ differ from $\subset$?
> - **Hint:** Vacuous truth + proper.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\emptyset\subseteq A$ vacuously (no element to check); $\subseteq$ permits $A=B$, $\subset$ requires $A\neq B$.
> > - **Why:** **Material implication** ➔ $x\in\emptyset\Rightarrow x\in A$ is never violated.

> [!FAQ]- Decompose "$x\in A$ iff $x\in B$" into two implications and link each to an inclusion.
> - **Hint:** if / only-if.
> > [!SUCCESS]- Answer
> > - **Short answer:** "if" ($x\in A\Leftarrow x\in B$) = $B\subseteq A$; "only if" ($x\in A\Rightarrow x\in B$) = $A\subseteq B$.
> > - **Why:** **Double inclusion** ➔ both together give $A=B$; an "iff" proof is two one-directional arguments.
