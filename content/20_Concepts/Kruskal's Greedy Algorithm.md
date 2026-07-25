---
unit: FIT1058
week: 12
parent: "[[Spanning Tree]]"
tags: [Math/GraphTheory, CS/Algorithms, Monash/CS_DS]
---
# [[Kruskal's Greedy Algorithm]]

**Context:** [[FIT1058_MOC]] · finds a **minimum-cost** [[Spanning Tree|spanning tree]] · adds cheapest cycle-free edge each step · a rare case where greedy is optimal

> [!abstract] Quick Revision
> - **🎯 Objective:** build a minimum-cost [[Spanning Tree|spanning tree]] ➔ add cheapest cycle-free edge each step.
> - **📦 Core Components:** greedy choice ➔ acyclic ([[Forest]]) invariant ➔ stop at $n-1$ edges.
> - **⚡ Key Constraint:** greedy is provably optimal here — a rare exception (matroid theory).

## 📝 Core
### 1. The Algorithm
- **Input** ➔ connected weighted graph, costs $w(e)>0$.
- **Rule** ➔ repeatedly add the **cheapest** edge creating no [[Cycle (Graph Theory)|cycle]]; stop when none remain.
- **Output** ➔ minimum-cost [[Spanning Tree]] minimising $w(X)=\sum_{e\in X}w(e)$.

### 2. Why a Spanning Tree
- **No redundant edge** ➔ if $X\setminus\{e\}$ still connects, drop $e$ to save $w(e)$.
- **Optimum** ➔ a minimal connected vertex-spanning subgraph = a spanning tree, of least cost.

### 3. Greedy Optimality
- **Theorem** ➔ Kruskal always finds a minimum-cost spanning tree.
- **Surprising** ➔ greedy usually fails (e.g. shortest paths); matroid theory explains the exceptions.

**Key identities:**

$$X=\emptyset;\ \text{repeatedly add } \min\nolimits_w\{e:\ X\cup\{e\}\text{ acyclic}\};\ \text{stop when none}$$

> [!NOTE] **When It Flips:** the partial $X$ is always a forest; the cheapest-edge rule among cycle-free options attains the global minimum. Recognising the structures where greedy provably works (matroids) is the deeper lesson.

## 📊 Exam Execution Trace

### Manual Execution Trace
Costs $ab{=}1,bc{=}2,cd{=}2,da{=}3,ac{=}4$:

| Step / State | Edge ($w$) | Cycle? | Add? | $w(X)$ |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | 0 |
| 1 | $ab$ (1) | no | ✅ | 1 |
| 2 | $bc$ (2) | no | ✅ | 3 |
| 3 | $cd$ (2) | no | ✅ | 5 |
| 4 | $da$(3),$ac$(4) | yes | ✗ | — |

## ⚠️ Common Mistakes
- 💡 **Greedy ≠ optimal in general** ➔ Kruskal is a celebrated exception; for most problems "maximise short-term gain" misses the global optimum.

## 🧠 Active Recall
> [!FAQ]- State Kruskal's algorithm and why the optimum must be a spanning tree.
> - **Hint:** No redundant edge.
> > [!SUCCESS]- Answer
> > - **Short answer:** Add the cheapest cycle-free edge repeatedly; output a minimum-cost spanning tree.
> > - **Why:** **Drop redundant** ➔ a least-cost connecting subgraph is minimal connected = a spanning tree.

> [!FAQ]- Why is Kruskal's optimality notable, and what theory explains it?
> - **Hint:** Greedy usually fails.
> > [!SUCCESS]- Answer
> > - **Short answer:** Greedily cheapest cycle-free edges always give the minimum-cost tree — a rare exception.
> > - **Why:** **Matroids** ➔ the class of structures where greedy provably succeeds.

> [!abstract] 极速同步
> - **核心干货**：按权重**从小到大排序**所有边，**只要不形成环**就无脑加边，直到加满 $n-1$ 条。
> - **关键底层**：并查集（Union-Find）判环。
> - **复杂度**：$O(|E| \log |E|)$ （瓶颈在排序）。
