---
unit: FIT1058
domain: [A, D]
week: 12
parent: "[[Tree]]"
tags: [Math/GraphTheory, CS/Algorithms]
---
# [[Spanning Tree]]

**Context:** [[FIT1058_MOC]] · a [[Tree|tree]] [[Subgraph|subgraph]] reaching **every** vertex · a minimal connecting skeleton · cost-optimised by [[Kruskal's Greedy Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a tree subgraph containing every vertex ➔ a minimal connected skeleton.
> - **📦 Core Components:** delete-edges or add-edges construction ➔ $n-1$ edges.
> - **⚡ Key Constraint:** every connected graph has one; disconnected ⟹ spanning forest.

## 📝 Core
### 1. The Spanning Tree
- **Definition** ➔ a [[Subgraph]] that is a [[Tree]] **and** includes every vertex.
- **Minimal connected** ➔ connected, but deleting any edge disconnects it.
- **Edges** ➔ exactly $n-1$.

### 2. Two Constructions
- **Delete** ➔ remove edges whose removal keeps it connected, until none can be.
- **Add** ➔ add edges that create no [[Cycle (Graph Theory)|cycle]], until none can be (partial = [[Forest]]).
- **Both succeed** ➔ every connected graph has a spanning tree.

### 3. Multiplicity
- **Many** ➔ different orders usually give different spanning trees.
- **Disconnected** ➔ a spanning *forest*, one tree per [[Connectivity|component]].

**Key identities:**

$$\textbf{Add: } X=\emptyset;\ \text{add edge if no cycle; stop when none} \Rightarrow \text{spanning tree}$$
$$\textbf{Delete: } \text{remove edges keeping connectivity} \Rightarrow \text{spanning tree}$$

> [!NOTE] **When It Flips:** minimality is the point — drop every redundant edge for the cheapest connectivity ($n-1$ edges). [[Kruskal's Greedy Algorithm]] adds costs, choosing a *minimum-cost* spanning tree.

## 📊 Exam Execution Trace

### Manual Execution Trace
Add edges to $G$ (4-cycle + diagonal $ac$):

| Step / State | Edge | Cycle? | In tree? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $ab$ | no | ✅ |
| 2 | $bc$ | no | ✅ |
| 3 | $cd$ | no | ✅ (spans, $n-1=3$) |
| 4 | $da,ac$ | yes | rejected |

## ⚠️ Common Mistakes
- 💡 **Add-method stays a forest** ➔ acyclic throughout, connected only at the end; the final tree has $n-1$ edges (minimum to connect all).

## 🧠 Active Recall
> [!FAQ]- Define a spanning tree and give two methods proving every connected graph has one.
> - **Hint:** Add / delete.
> > [!SUCCESS]- Answer
> > - **Short answer:** A tree subgraph containing all vertices; build by deleting connectivity-preserving edges or adding cycle-free edges.
> > - **Why:** **Both terminate** ➔ in a spanning tree for any connected $G$ (disconnected ⟹ forest).

> [!FAQ]- Why does the add-method's partial result stay a forest, and how many edges in the final tree?
> - **Hint:** Acyclic invariant.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each added edge avoids a cycle ⟹ acyclic ([[Forest]]); final tree has $n-1$ edges.
> > - **Why:** **Connected at end** ➔ becomes a tree once no cycle-free edge remains.
