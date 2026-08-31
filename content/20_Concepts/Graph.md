---
unit: [FIT1058, FIT2004]
week: [5, 11]
source: [lecture]
domain: [D, A]
parent: "[[Binary Relation]]"
tags: [Math/GraphTheory, Math/Discrete, CS/DataStructures]
---
# [[Graph]]

**Context:** [[FIT1058_MOC]] · an abstract model of a network · a [[Set (Mathematics)|set]] of vertices plus edges · adjacency is a [[Binary Relation|relation]] on vertices · [[FIT2004_MOC]] · the W5 **data structure** everything else reduces to — see [[Graph Representations]], [[Uninformed Search (BFS and DFS)]], [[Dijkstra's Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $G=(V,E)$: vertices + edges ➔ models which pairs interact; add direction and weight and it models cost, order and flow.
> - **📦 Core Components:** adjacency ($\sim$) ➔ incidence ➔ isolated/leaf vertices ➔ $\lvert V\rvert,\lvert E\rvert$ and the sparse/dense split.
> - **⚡ Key Constraint:** adjacency is a symmetric irreflexive [[Binary Relation]] *in the undirected case only*; specify both $V$ **and** $E$, and say whether the graph is directed and weighted before quoting any bound.

## 📝 Core
### 1. The Graph, Adjacency and Incidence
- **Definition** ➔ $G=(V,E)$; $V$ vertices, $E$ edges (unordered pairs $\{v,w\}$ of distinct vertices) — models the structure of interactions, discarding all else.
- **Adjacent** ➔ $v\sim w$ iff $\{v,w\}\in E$ (vertex–vertex) · **incident** ➔ vertex is an endpoint of an edge (vertex–edge).
- **Special vertices** ➔ **isolated** = in no edge (degree $0$) · **leaf** = in exactly one edge (degree $1$).

$$v\sim w \iff \{v,w\}\in E,\qquad \{v,w\}=\{w,v\}\ (\text{undirected, no self-loop})$$

### 2. FIT2004 Formal Definitions (W5)
- **Edge** ➔ $e=(u,v)$; **directed** ⟹ the edge runs *from* $u$ *to* $v$; **weighted** ⟹ $e=(u,v,w)$ and the graph is written $G=(V,E,W)$.
- **Simple graph** ➔ no **self-edges** and no **multi-edges** — the default assumption in every FIT2004 algorithm ([[Types of Graphs]]).
- **Vertex $=$ node, edge $=$ link** ➔ both naming pairs appear in the slides; treat them as synonyms.
- **Everything reduces to a graph** ➔ a [[Tree]] is a graph, a database is a graph, and problems such as **longest common subsequence** are solved by *building* a [[Directed Acyclic Graph (DAG)|DAG]] — the transferable move is modelling the problem as $G$, not memorising an algorithm (LO1).
- **A [[Tree]] as a graph** ➔ the **root** is the single vertex with **no incoming edge**; a binary tree caps out-degree at $2$; and there is **no [[Cycle (Graph Theory)|cycle]]**.

### 3. Size Properties and the Sparse/Dense Split
- **Notation** ➔ $\lvert V\rvert$ vertices, $\lvert E\rvert$ edges; bounds are written in $V$ and $E$ with the bars dropped.
- **Maximum edges** ➔ directed $V(V-1)$ · undirected $\tfrac{V(V-1)}{2}$ — the halving is a constant factor, so **both** are $O(V^{2})$.
- **Sparse** ➔ $E\lll V^{2}$ (typically $E=O(V)$) · **dense** ➔ $E\approx V^{2}$.
- **Why it matters** ➔ this one classification decides the [[Graph Representations|representation]], collapses $O(E\log V)$ into $O(V^{2}\log V)$ for [[Dijkstra's Algorithm]], and decides whether a Fibonacci heap is worth its constants.
- **Worked example** ➔ the World Wide Web: pages are vertices, hyperlinks edges, **PageRank** a traversal propagating authority — a huge, extremely **sparse** graph.

## ⚖️ Core Decision Matrix
| Term | Relates | Example |
| :--- | :--- | :--- |
| adjacency $\sim$ | vertex–vertex | $a\sim c$ |
| incidence | vertex–edge | $c$ in $\{a,c\}$ |
| isolated | degree 0 | $e$ |
| leaf | degree 1 | $d,f,g$ |

> [!NOTE] **When It Flips:** adjacency $\sim$ is a symmetric, irreflexive [[Binary Relation]] on $V$ — the bridge to relation theory; [[Connectivity]] turns the *walk* relation into an [[Equivalence Relation]]. Graphs here are **simple** unless stated ([[Types of Graphs]]). Direction breaks the symmetry; weight breaks the "one hop $=$ one unit" assumption that [[Uninformed Search (BFS and DFS)|BFS]] rests on.

## 📊 Exam Execution Trace

### Manual Execution Trace
$G=(\{a,\dots,g\},\{ab,ac,bc,cd,fg\})$:

| Step / State | Query | Answer |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | neighbours of $c$ | $a,b,d$ |
| 2 | edges incident with $c$ | $\{a,c\},\{b,c\},\{c,d\}$ |
| 3 | classify $e$ | isolated |

### Applied Exercise
**Problem:** a simple undirected graph has $V=1000$ vertices and $E=4000$ edges. Sparse or dense, and what follows?
$$
E_{\max} = \frac{V(V-1)}{2} \approx 5\times10^{5}, \qquad \frac{E}{E_{\max}} \approx 0.008 \;\lll\; 1
$$
**Final Extracted Output:** **sparse** ($E=O(V)$) ➔ store it as an **adjacency list** at $\Theta(V+E)=\Theta(5000)$ rather than a matrix at $\Theta(V^{2})=\Theta(10^{6})$, and quote [[Dijkstra's Algorithm|Dijkstra]] as $O(E\log V)$ rather than collapsing to $O(V^{2}\log V)$.

## ⚠️ Common Mistakes
- 💡 **Must give both $V$ and $E$** ➔ an isolated vertex leaves no trace in the edge list; in the undirected case edges are *sets*, so no vertex is adjacent to itself.
- 💡 **Treating $O(V^{2})$ as "dense means directed"** ➔ directed and undirected maxima differ only by $\tfrac12$; **density** is about how many possible edges are actually present.

## 🧠 Active Recall
> [!FAQ]- Define a graph, distinguish adjacency from incidence, and say why the vertex set must be recorded separately.
> - **Hint:** Vertex–vertex vs vertex–edge; isolated vertices vanish from edges.
> > [!SUCCESS]- Answer
> > - **Short answer:** $G=(V,E)$ with edges as unordered pairs; adjacency relates two vertices ($v\sim w\Leftrightarrow\{v,w\}\in E$), incidence relates a vertex to an edge. An isolated vertex (degree $0$) appears in no edge, so the edge list alone would lose it.
> > - **Why:** **The two relations answer different queries** ➔ traversal asks for adjacency, degree counting asks for incidence, and neither recovers a vertex that participates in nothing.

> [!FAQ]- Why does FIT2004 keep restating "sparse or dense?" before quoting a complexity?
> - **Hint:** Two variables, one bounded by the square of the other.
> > [!SUCCESS]- Answer
> > - **Short answer:** because $E$ ranges from $O(V)$ to $O(V^{2})$, so a bound in $E$ is not a bound in $V$ until density is fixed.
> > - **Why:** **Bounds carry two parameters** ➔ $\Theta(V+E)$ is $\Theta(V)$ on a sparse graph and $\Theta(V^{2})$ on a dense one, so "tightest bound" ([[Big-O Notation]]) is meaningless until you say which. **The representation choice follows** ➔ the adjacency list wins by an order of magnitude on sparse graphs ([[Graph Representations]]), and the Fibonacci-heap [[Dijkstra's Algorithm|Dijkstra]] only pays off when $E\gg V$.
