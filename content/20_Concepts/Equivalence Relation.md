---
unit: FIT1058
week: 2
parent: "[[Properties of Binary Relations]]"
tags: [Math/Relations, Math/Discrete, Monash/CS_DS]
---
# [[Equivalence Relation]]

**Context:** [[FIT1058_MOC]] · the [[Properties of Binary Relations|reflexive + symmetric + transitive]] [[Binary Relation]] · generalises equality · its classes form a [[Set Partition]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a reflexive + symmetric + transitive relation ➔ "same for some purpose", generalising equality.
> - **📦 Core Components:** three properties ➔ equivalence class $[x]$ ➔ Fundamental Partition Theorem.
> - **⚡ Key Constraint:** classes form a [[Set Partition]] (every element in exactly one); equivalences ⟺ partitions.

## 📝 Core
### 1. The Relation (Three Properties)
- **Definition** ➔ reflexive **and** symmetric **and** transitive.
- **Meaning** ➔ "the same *for some purpose*" — interchangeable under a criterion.
- **Class** ➔ $[x]=\{y\in A:x\,R\,y\}$ — a maximal mutually-equivalent block.

### 2. Fundamental Partition Theorem
- **Classes partition $A$** ➔ every element in exactly one class; classes identical or disjoint.
- **Two-way** ➔ every partition arises from an equivalence relation ➔ same structure, two views.

### 3. Standard Examples
- **Congruence mod $m$** ➔ $x\equiv y\Leftrightarrow m\mid(x-y)$; classes = residue classes.
- **Integer part** ➔ $\lfloor x\rfloor=\lfloor y\rfloor$; classes = $[n,n+1)$.
- **Preimage** ➔ $x\sim_f y\Leftrightarrow f(x)=f(y)$; classes = $f^{-1}(y)$.

**Key identities:**

$$\underbrace{\forall x:xRx}_{\text{refl}}\wedge\underbrace{xRy\Rightarrow yRx}_{\text{sym}}\wedge\underbrace{xRy\wedge yRz\Rightarrow xRz}_{\text{trans}}$$
$$[x]=\{y\in A:x\,R\,y\}$$

## ⚖️ Core Decision Matrix
| Structure | Properties | Divides set into |
| :--- | :--- | :--- |
| equivalence | reflexive + symmetric + transitive | disjoint classes (partition) |
| partial order | reflexive + **antisymmetric** + transitive | a hierarchy |
| congruence mod $m$ | equivalence | $m$ residue classes |
| $\sim_f$ | equivalence | preimages $f^{-1}(y)$ |

> [!NOTE] **When It Flips:** symmetry vs antisymmetry is the dividing line between equivalences and partial orders. The transitive closure of any reflexive + symmetric relation is automatically an equivalence relation.

## 📊 Exam Execution Trace

### Manual Execution Trace
Congruence mod 3 on $\{0,\dots,5\}$:

| Step / State | Property | Check | Holds? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | reflexive | $3\mid0$ | ✅ |
| 2 | symmetric | $3\mid(x-y)\Rightarrow3\mid(y-x)$ | ✅ |
| 3 | transitive | sums of multiples of 3 | ✅ |
| 4 | classes | $[0],[1],[2]$ | $\{0,3\},\{1,4\},\{2,5\}$ |

## ⚠️ Common Mistakes
- 💡 **All three are needed** ➔ drop reflexivity (an element in no class), symmetry (one-directional), or transitivity (classes overlap without merging) and the partition breaks.

## 🧠 Active Recall
> [!FAQ]- State the three defining properties and what fails if each is dropped.
> - **Hint:** Partition needs all three.
> > [!SUCCESS]- Answer
> > - **Short answer:** Reflexive, symmetric, transitive; drop reflexivity → element in no class; symmetry → one-directional; transitivity → overlap without merge.
> > - **Why:** **Clean partition** ➔ only all three make the classes a [[Set Partition]].

> [!FAQ]- State the Fundamental Partition Theorem and the classes of congruence mod $m$.
> - **Hint:** Equivalence ⟺ partition.
> > [!SUCCESS]- Answer
> > - **Short answer:** Classes partition $A$ (each element in exactly one; distinct classes disjoint); every partition defines an equivalence.
> > - **Why:** **Residue classes** ➔ mod $m$ gives $m$ classes $\{km+r:k\in\mathbb Z\}$, $r=0,\dots,m-1$.
