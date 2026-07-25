---
unit: FIT1058
domain: D
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Combinatorics, Math/Discrete]
---
# [[Set Partition]]

**Context:** [[FIT1058_MOC]] · splits a [[Set (Mathematics)|set]] into disjoint covering parts · each element in exactly one part · counted by Bell numbers

> [!abstract] Quick Revision
> - **🎯 Objective:** carve $A$ into nonempty disjoint parts whose union is $A$ ➔ each element in exactly one part.
> - **📦 Core Components:** nonempty ➔ pairwise disjoint ➔ covering ➔ coarsest/finest.
> - **⚡ Key Constraint:** counted by **Bell numbers** $B_n$; correspond to equivalence relations.

## 📝 Core
### 1. The Partition (Three Conditions)
- **Definition** ➔ a set of nonempty, pairwise disjoint subsets (parts/blocks) of $A$ whose union is $A$.
- **One-line equivalent** ➔ every element lies in **exactly one** part.
- **Extremes** ➔ coarsest = single part $\{A\}$; finest = all singletons.

### 2. Why Each Condition
- **Nonempty** ➔ no $\emptyset$ block.
- **Disjoint** ➔ no element in two parts.
- **Covering** ➔ union equals $A$ (nothing left out).

### 3. Counting (Bell Numbers)
- **$B_n$** ➔ number of partitions of an $n$-set.
- **Sequence** ➔ $1,2,5,15,52,203,877,\dots$ ($B_3=5$).

**Key identities:**

$$\textbf{(1) nonempty},\quad \textbf{(2) disjoint},\quad \textbf{(3) covering (union }=A)$$
$$\{\{a,b,c\}\},\ \{\{a,b\},\{c\}\},\ \{\{a,c\},\{b\}\},\ \{\{b,c\},\{a\}\},\ \{\{a\},\{b\},\{c\}\}$$

## ⚖️ Core Decision Matrix
| Concept | Restriction | Count |
| :--- | :--- | :--- |
| partition of $n$-set | 3 conditions | Bell $B_n$ |
| [[Power Set]] | any subset collection | $2^n$ |
| coarsest partition | one block | 1 |
| finest partition | all singletons | 1 |

> [!NOTE] **When It Flips:** partitions correspond exactly to **equivalence relations** on $A$ (each part = an equivalence class). A partition is a *restricted* subcollection of $\mathcal P(A)$, so $B_n\ll 2^n$ but still grows super-exponentially.

## 📊 Exam Execution Trace

### Manual Execution Trace
Partitions of $\{1,2,3\}$ by block count:

| Step / State | Blocks | Partition |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | 1 | $\{\{1,2,3\}\}$ |
| 2 | 2 | $\{\{1,2\},\{3\}\},\{\{1,3\},\{2\}\},\{\{2,3\},\{1\}\}$ |
| 3 | 3 | $\{\{1\},\{2\},\{3\}\}$ |

## ⚠️ Common Mistakes
- 💡 **Each element in exactly one part** ➔ $\{\{a,b\},\{c\},\emptyset\}$ fails (1); $\{\{a,b\},\{b,c\}\}$ fails (2); $\{\{a\},\{b\}\}$ fails (3).

## 🧠 Active Recall
> [!FAQ]- State the three conditions for a partition and a counter-example violating each ($A=\{a,b,c\}$).
> - **Hint:** Nonempty / disjoint / covering.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\{\{a,b\},\{c\},\emptyset\}$ breaks nonempty; $\{\{a,b\},\{b,c\}\}$ breaks disjoint; $\{\{a\},\{b\}\}$ breaks covering.
> > - **Why:** **Exactly one** ➔ all three hold iff each element is in exactly one part.

> [!FAQ]- How many partitions does a 3-element set have, and what counts partitions in general?
> - **Hint:** Bell numbers.
> > [!SUCCESS]- Answer
> > - **Short answer:** 5 partitions of a 3-set; in general the Bell number $B_n$ ($1,2,5,15,52,\dots$).
> > - **Why:** **Smaller than $2^n$** ➔ partitions are a restricted subcollection of subsets.
