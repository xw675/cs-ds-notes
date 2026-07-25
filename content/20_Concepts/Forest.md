---
unit: FIT1058
week: 12
parent: "[[Tree]]"
tags: [Math/GraphTheory, Math/Discrete, Monash/CS_DS]
---
# [[Forest]]

**Context:** [[FIT1058_MOC]] · an acyclic [[Graph]] (connectivity dropped) · a disjoint union of [[Tree|trees]] · $n-k$ edges for $k$ components

> [!abstract] Quick Revision
> - **🎯 Objective:** an acyclic graph, not required connected ➔ a disjoint union of trees.
> - **📦 Core Components:** each [[Connectivity|component]] a [[Tree]] ➔ $n-k$ edges for $k$ components.
> - **⚡ Key Constraint:** generalises the tree's $n-1$; acyclicity is componentwise.

## 📝 Core
### 1. The Forest
- **Definition** ➔ a graph with **no [[Cycle (Graph Theory)|cycles]]**, not required connected.
- **Components** ➔ each connected + acyclic ⟹ a [[Tree]]; a forest is a disjoint union of trees.

### 2. Edge Count
- **Formula** ➔ $n$ vertices, $k$ components ⟹ exactly $n-k$ edges.
- **Proof** ➔ $\sum(n_i-1)=n-k$ (each tree $m_i=n_i-1$).
- **Generalises** ➔ tree formula $n-1$ is $k=1$.

### 3. Trees & Forests
- **Tree ⊆ forest** ➔ a tree is a one-component forest.
- **Componentwise** ➔ any cycle lives in one component.

**Key identities:**

$$m=\sum_{i=1}^k m_i=\sum_{i=1}^k(n_i-1)=\Bigl(\sum n_i\Bigr)-k=n-k$$

## ⚖️ Core Decision Matrix
| Object | Connected? | Edges |
| :--- | :--- | :--- |
| tree | yes | $n-1$ |
| forest ($k$ comps) | not required | $n-k$ |
| isolated vertex | — | 0 (1-vertex tree) |
| acyclic | yes (defining) | — |

> [!NOTE] **When It Flips:** a forest relaxes the [[Tree]]'s connectivity but keeps acyclicity; [[Kruskal's Greedy Algorithm]]'s partial result is always a forest, becoming a [[Spanning Tree]] once it connects up.

## 📊 Exam Execution Trace

### Manual Execution Trace
Forest, 10 vertices, components 4,3,3:

| Step / State | Component | $n_i$ | $m_i=n_i-1$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $F_1$ | 4 | 3 |
| 2 | $F_2$ | 3 | 2 |
| 3 | $F_3$ | 3 | 2 |

## ⚠️ Common Mistakes
- 💡 **Each extra component costs one fewer edge** ➔ $n-1$ (tree) → $n-k$; edges are exactly what would merge the $k$ trees into one.

## 🧠 Active Recall
> [!FAQ]- Define a forest and prove it has $n-k$ edges.
> - **Hint:** Sum of tree edge counts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Acyclic graph; each component a tree with $n_i-1$ edges ⟹ $m=\sum(n_i-1)=n-k$.
> > - **Why:** **$k=1$** ➔ recovers the tree formula $n-1$.

> [!FAQ]- How are trees and forests related, and why is acyclicity componentwise?
> - **Hint:** Cycles live in one component.
> > [!SUCCESS]- Answer
> > - **Short answer:** A tree is a connected forest ($k=1$); a forest is acyclic iff every component is.
> > - **Why:** **Connected cycle** ➔ any cycle lies entirely in one component.
