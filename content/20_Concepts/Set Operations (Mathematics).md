---
unit: FIT1058
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Logic, Math/Discrete]
aliases: [Union and Intersection, Set Complement and Difference, Symmetric Difference, De Morgan's Laws (Sets)]
---
# [[Set Operations (Mathematics)]]

**Context:** [[FIT1058_MOC]] · the combining operations on [[Set (Mathematics)|sets]] — union, intersection, complement, difference, symmetric difference · each mirrors a [[Logical Connectives|logical connective]]

> [!abstract] Quick Revision
> - **🎯 Objective:** combine/compare sets by membership predicates ➔ $\cup\leftrightarrow\vee$, $\cap\leftrightarrow\wedge$, $\overline{\ }\leftrightarrow\neg$, $\triangle\leftrightarrow$ XOR.
> - **📦 Core Components:** union/intersection ➔ complement/difference (needs $U$ vs not) ➔ symmetric difference (equality test).
> - **⚡ Key Constraint:** $|A\cup B|=|A|+|B|-|A\cap B|$ (never blindly additive); $B\setminus A\neq A\setminus B$.

## 📝 Core

### 1. Union & Intersection (or / and)
- **Union** ➔ $A\cup B=\{x:x\in A\text{ or }x\in B\}$ ➔ **inclusive** or (keeps shared elements once).
- **Intersection** ➔ $A\cap B=\{x:x\in A\text{ and }x\in B\}$.
- **Containment sandwich** ➔ $A\cap B\subseteq A\subseteq A\cup B$; identities $A\cup\emptyset=A$, $A\cap U=A$.
- **Cardinality** ➔ $|A\cup B|=|A|+|B|-|A\cap B|$ (inclusion–exclusion); $=|A|+|B|$ only when disjoint.

### 2. Complement & Difference (everything except)
- **Universal set** ➔ $U$ = universe of discourse; complement $\overline A=U\setminus A=\{x\in U:x\notin A\}$.
- **Difference** ➔ $B\setminus A=\{x\in B:x\notin A\}=\overline A\cap B$ — more general, needs no $U$; complement is the special case $B=U$.
- **Finite counts** ➔ $|\overline A|=|U|-|A|$; involution $\overline{\overline A}=A$.
- **Notation discipline** ➔ the bar suppresses $U$ — write $U\setminus A$ when several universes are in play ([[Sets of Numbers]], [[Sets of Strings]]).

### 3. De Morgan's Laws
- **Push complement inward** ➔ $\overline{A\cup B}=\overline A\cap\overline B$ ("not in either"), $\overline{A\cap B}=\overline A\cup\overline B$ ("not in both") — swap $\cup\leftrightarrow\cap$.
- **Mirrors logic** ➔ $\overline{p\vee q}=\overline p\wedge\overline q$ etc.

### 4. Symmetric Difference (exactly one)
- **Three forms** ➔ $A\triangle B=(A\setminus B)\cup(B\setminus A)=(A\cap\overline B)\cup(\overline A\cap B)=(A\cup B)\setminus(A\cap B)$.
- **Equality test** ➔ $A\triangle B=\emptyset\Leftrightarrow A=B$; self-difference $A\triangle A=\emptyset$.
- **XOR algebra** ➔ associative, commutative, identity $\emptyset$, every set self-inverse; $A\triangle B=\overline A\triangle\overline B$; set analogue of [[Exclusive-or]].

## ⚖️ Core Decision Matrix
| Operation | Membership | Logic dual | Needs $U$? | Symmetric? | Identity |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $A\cup B$ | at least one | $\vee$ | no | yes | $\emptyset$ |
| $A\cap B$ | both | $\wedge$ | no | yes | $U$ |
| $\overline A$ | not in $A$ | $\neg$ | **yes** | — | — |
| $B\setminus A$ | in $B$ not $A$ | $\wedge\neg$ | no | **no** | — |
| $A\triangle B$ | exactly one | XOR | no | yes | $\emptyset$ |

> [!NOTE] **When It Flips:** every operation is a membership predicate, so set algebra inherits Boolean algebra — De Morgan binds $\cup,\cap$ to complement, and $\triangle$ behaves as bitwise XOR on membership.

## 📊 Exam Execution Trace & Applied Exercises

### 1. Manual Execution Trace Layout
$U=\{1,\dots,6\}$, $A=\{1,2,3,4\}$, $B=\{3,4,5,6\}$:

| Step / State | Quantity | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $A\cup B$ / $A\cap B$ | $\{1,\dots,6\}$ / $\{3,4\}$ |
| 2 | $\lvert A\cup B\rvert$ | $6=4+4-2$ ✓ inclusion–exclusion |
| 3 | $\overline A$ / $B\setminus A$ | $\{5,6\}$ / $\{5,6\}=\overline A\cap B$ ✓ |
| 4 | $A\setminus B$ | $\{1,2\}\neq B\setminus A$ (asymmetric) |
| 5 | $A\triangle B$ | $\{1,2,5,6\}\neq\emptyset\Rightarrow A\neq B$ |
| 6 | $\overline{A\cup B}$ | $\emptyset=\overline A\cap\overline B$ ✓ De Morgan |

## ⚠️ Common Mistakes
- 💡 **Don't add cardinalities blindly** ➔ $|A\cup B|=|A|+|B|$ only when disjoint; overlap double-counted otherwise.
- 💡 **Difference is not symmetric** ➔ $B\setminus A\neq A\setminus B$ in general; the order-free version is $A\triangle B$.
- 💡 **Inclusive vs exclusive or** ➔ $A\cup B$ keeps "at least one", $A\triangle B$ keeps "exactly one" — they differ by $A\cap B$.

## 🧠 Active Recall
> [!FAQ]- State De Morgan's laws for sets and put each into words.
> - **Hint:** Complement swaps $\cup\leftrightarrow\cap$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\overline{A\cup B}=\overline A\cap\overline B$ ("not in either"); $\overline{A\cap B}=\overline A\cup\overline B$ ("not in both").
> > - **Why:** **Mirrors logic** ➔ $\overline{p\vee q}=\overline p\wedge\overline q$, etc.

> [!FAQ]- Why is $|A\cup B|$ generally not $|A|+|B|$?
> - **Hint:** Overlap double-counted.
> > [!SUCCESS]- Answer
> > - **Short answer:** $|A\cup B|=|A|+|B|-|A\cap B|$; equality holds only when disjoint.
> > - **Why:** **Inclusion–exclusion** ➔ elements of $A\cap B$ are counted twice, subtracted once.

> [!FAQ]- Define $\overline A$ and $B\setminus A$; which is more general and why?
> - **Hint:** Complement suppresses $U$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\overline A=U\setminus A$; $B\setminus A=\{x\in B:x\notin A\}$ needs no universe — complement is the case $B=U$.
> > - **Why:** **Names the universe** ➔ the bar is relative to an unstated $U$; write $U\setminus A$ when ambiguous.

> [!FAQ]- Why does $A\triangle B=\emptyset$ characterise set equality?
> - **Hint:** Disagreement set.
> > [!SUCCESS]- Answer
> > - **Short answer:** $A\triangle B$ collects elements in one set but not the other; empty ⟺ no disagreement.
> > - **Why:** **Double inclusion** ➔ emptiness gives $A\subseteq B$ and $B\subseteq A$, so $A=B$.
