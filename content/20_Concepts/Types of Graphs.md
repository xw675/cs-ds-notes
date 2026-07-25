---
unit: FIT1058
domain: D
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Types of Graphs]]

**Context:** [[FIT1058_MOC]] · the **simple** graph (no loops, no parallel edges) is the default · richer classes add loops, multi-edges, weights, or direction

> [!abstract] Quick Revision
> - **🎯 Objective:** simple graph = no loops, no parallel edges ➔ the default.
> - **📦 Core Components:** loop / multi-edge / weighted / directed generalisations.
> - **⚡ Key Constraint:** edges-as-sets *force* simplicity; directed = ordered pairs (non-symmetric).

## 📝 Core
### 1. The Simple Graph
- **Definition** ➔ no loops, no parallel edges (default here).
- **From sets** ➔ edge $\{v,w\}$ has distinct vertices (no loop); $E$ a set (no repeat).

### 2. Richer Classes
- **Loop** ➔ edge from a vertex to itself.
- **Multiple/parallel** ➔ >1 edge between a pair.
- **Weighted** ➔ each edge carries a number (cost/capacity).
- **Directed (digraph)** ➔ ordered pairs $(v,w)$, arcs; $(v,w)\neq(w,v)$.

**Key identities:**

$$\{v,w\}\ \text{a set of distinct vertices} \Rightarrow \text{no loop } \{v,v\}$$
$$E\ \text{a set},\ \{v,w\}=\{w,v\} \Rightarrow \text{no parallel edges}$$

## ⚖️ Core Decision Matrix
| Class | Edges | Adjacency |
| :--- | :--- | :--- |
| simple | unordered distinct pairs | symmetric, irreflexive |
| loops | $\{v,v\}$ allowed | reflexive possible |
| multi | repeated pairs | multiplicities |
| directed | ordered $(v,w)$ | possibly non-symmetric |

> [!NOTE] **When It Flips:** simple undirected graphs capture the main computational issues, so theorems transfer broadly; weights/directions add modelling power (road cost, one-way, flow) at the cost of more complex algorithms.

## 📊 Exam Execution Trace

### Manual Execution Trace
Allowed in a simple graph?

| Step / State | Candidate | Verdict |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $\{a,a\}$ | loop — no |
| 2 | $\{a,b\},\{b,a\}$ | parallel — no (one edge) |
| 3 | $(a,b)$ | directed — no |

## ⚠️ Common Mistakes
- 💡 **Directed ≠ undirected** ➔ a digraph uses ordered pairs, so adjacency need not be symmetric ($(a,b)$ without $(b,a)$) — the general [[Binary Relation]] case.

## 🧠 Active Recall
> [!FAQ]- What is a simple graph, and why do "edges are sets" force its two conditions?
> - **Hint:** Sets forbid duplicates.
> > [!SUCCESS]- Answer
> > - **Short answer:** No loops, no parallel edges; edge $\{v,w\}$ has distinct vertices, $E$ has no repeat.
> > - **Why:** **$\{v,w\}=\{w,v\}$** ➔ counts once.

> [!FAQ]- How is a directed graph modelled, and how does it differ from a simple graph?
> - **Hint:** Ordered pairs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Arcs are ordered pairs $(v,w)$; $(v,w)\neq(w,v)$, adjacency need not be symmetric.
> > - **Why:** **Modelling power** ➔ digraphs/weights capture one-way streets, costs, flows.
