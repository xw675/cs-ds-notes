---
unit: [FIT1058, FIT2004]
week: [4, 11]
source: [lecture]
domain: [D, A]
parent: "[[Binary Relation]]"
tags: [Math/GraphTheory, Math/Discrete, CS/DataStructures]
---
# [[Graph]]

**Context:** [[FIT1058_MOC]] · an abstract model of a network · a [[Set (Mathematics)|set]] of vertices plus edges (unordered vertex-pairs) · adjacency is a [[Binary Relation|relation]] on vertices · [[FIT2004_MOC]] · the W4 **data structure** everything else reduces to — see [[Graph Representations]], [[Uninformed Search (BFS and DFS)]], [[Dijkstra's Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $G=(V,E)$: vertices + edges ➔ models which pairs interact; add direction and weight and it models cost, order and flow.
> - **📦 Core Components:** adjacency ($\sim$) ➔ incidence ➔ isolated/leaf vertices ➔ $\lvert V\rvert,\lvert E\rvert$ and the sparse/dense split.
> - **⚡ Key Constraint:** adjacency is a symmetric irreflexive [[Binary Relation]] *in the undirected case only*; specify both $V$ **and** $E$, and say whether the graph is directed and weighted before quoting any bound.

## 📝 Core
### 1. The Graph
- **Definition** ➔ $G=(V,E)$; $V$ vertices, $E$ edges (unordered pairs $\{v,w\}$ of distinct vertices).
- **Models** ➔ structure of interactions, discarding all else.

### 2. Adjacency & Incidence
- **Adjacent** ➔ $v\sim w$ iff $\{v,w\}\in E$ (vertex–vertex).
- **Incident** ➔ vertex is an endpoint of an edge (or two edges share one).

### 3. Special Vertices
- **Isolated** ➔ in no edge (degree 0).
- **Leaf** ➔ in exactly one edge (degree 1).

**Key identities:**

$$v\sim w \iff \{v,w\}\in E,\qquad \{v,w\}=\{w,v\}\ (\text{undirected, no self-loop})$$

### 4. FIT2004 Formal Definitions (W4)
- **Edge** ➔ $e=(u,v)$ with $u,v\in V$; **directed** ⟹ the edge runs *from* $u$ *to* $v$; **weighted** ⟹ $e=(u,v,w)$ and the graph is written $G=(V,E,W)$.
- **Simple graph** ➔ no **self-edges** (loops) and no **multi-edges** between a pair — the default assumption in every FIT2004 algorithm ([[Types of Graphs]]).
- **Vertex $=$ node, edge $=$ link** ➔ both naming pairs appear in the slides and in exam wording; treat them as synonyms.
- **Everything reduces to a graph** ➔ a [[Tree]] is a graph, a database is a graph, and problems such as **longest common subsequence** are solved by *building* a [[Directed Acyclic Graph (DAG)|DAG]] — the transferable move is modelling the problem as $G$, not memorising an algorithm (LO1).
- **A [[Tree]] as a graph** ➔ the **root** is the single vertex with **no incoming edge**; a binary tree caps out-degree at $2$; and there is **no [[Cycle (Graph Theory)|cycle]]**.

### 5. Size Properties and the Sparse/Dense Split
- **Notation** ➔ $\lvert V\rvert$ is the vertex count, $\lvert E\rvert$ the edge count; complexity bounds are written in $V$ and $E$ with the bars dropped.
- **Maximum edges** ➔ directed $V(V-1)=O(V^{2})$ · undirected $\dfrac{V(V-1)}{2}=O(V^{2})$ — the halving is the constant factor, so **both** are $O(V^{2})$.
- **Sparse** ➔ $E\lll V^{2}$ (typically $E=O(V)$) · **dense** ➔ $E\approx V^{2}$.
- **Why it matters** ➔ this one classification decides the [[Graph Representations|representation]], collapses $O(E\log V)$ into $O(V^{2}\log V)$ for [[Dijkstra's Algorithm]], and decides whether a Fibonacci heap is worth its constants.
- **Worked example** ➔ the World Wide Web: pages are vertices, hyperlinks edges, and **PageRank** is a traversal that propagates authority — a huge, extremely **sparse** graph.

## ⚖️ Core Decision Matrix
| Term | Relates | Example |
| :--- | :--- | :--- |
| adjacency $\sim$ | vertex–vertex | $a\sim c$ |
| incidence | vertex–edge | $c$ in $\{a,c\}$ |
| isolated | degree 0 | $e$ |
| leaf | degree 1 | $d,f,g$ |

> [!NOTE] **When It Flips:** adjacency $\sim$ is a symmetric, irreflexive [[Binary Relation]] on $V$ — the bridge to relation theory; [[Connectivity]] turns the *walk* relation into an [[Equivalence Relation]]. Here graphs are **simple** unless stated ([[Types of Graphs]]). Direction breaks the symmetry, weight breaks the "one hop $=$ one unit" assumption that [[Uninformed Search (BFS and DFS)|BFS]] rests on.

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
\begin{aligned}
E_{\max} &= \frac{V(V-1)}{2} = \frac{1000\cdot999}{2} = 499\,500 \approx 5\times10^{5} \\
\frac{E}{E_{\max}} &= \frac{4000}{499\,500} \approx 0.008 \;\lll\; 1
\end{aligned}
$$
**Final Extracted Output:** **sparse** ($E=O(V)$) ➔ store it as an **adjacency list** at $\Theta(V+E)=\Theta(5000)$ rather than a matrix at $\Theta(V^{2})=\Theta(10^{6})$, and quote [[Dijkstra's Algorithm|Dijkstra]] as $O(E\log V)$ rather than collapsing to $O(V^{2}\log V)$.

## ⚠️ Common Mistakes
- 💡 **Must give both $V$ and $E$** ➔ an isolated vertex leaves no trace in the edge list; in the undirected case edges are *sets*, so no vertex is adjacent to itself.
- 💡 **Treating $O(V^{2})$ as "dense means directed"** ➔ directed and undirected maxima differ only by the factor $\tfrac12$; **density** is about how many of those possible edges are actually present.

## 🧠 Active Recall
> [!FAQ]- Define a graph, and distinguish adjacency from incidence.
> - **Hint:** Vertex–vertex vs vertex–edge.
> > [!SUCCESS]- Answer
> > - **Short answer:** $G=(V,E)$, edges unordered pairs; adjacency relates two vertices, incidence a vertex to an edge.
> > - **Why:** **$v\sim w\Leftrightarrow\{v,w\}\in E$** ➔ "$c$ incident with $\{a,c\}$" is a vertex–edge link.

> [!FAQ]- Why specify the vertex set separately, and what are isolated and leaf vertices?
> - **Hint:** Isolated vertices vanish from edges.
> > [!SUCCESS]- Answer
> > - **Short answer:** An isolated vertex is in no edge, so $V$ must be recorded; isolated = degree 0, leaf = degree 1.
> > - **Why:** **Both $V,E$** ➔ the edge list alone loses isolated vertices.

> [!FAQ]- Why does FIT2004 keep restating "sparse or dense?" before quoting a complexity?
> - **Hint:** Two variables, one of them bounded by the square of the other.
> > [!SUCCESS]- Answer
> > - **Short answer:** because $E$ ranges from $O(V)$ to $O(V^{2})$, so a bound in $E$ is not a bound in $V$ until the density is fixed.
> > - **Why:** **Bounds carry two parameters** ➔ $\Theta(V+E)$ is $\Theta(V)$ on a sparse graph and $\Theta(V^{2})$ on a dense one, and "tightest bound" ([[Big-O Notation]]) has no meaning until you say which. **The representation choice follows** ➔ adjacency list wins by an order of magnitude on sparse graphs and loses nothing but $O(1)$ edge lookup on dense ones ([[Graph Representations]]). **Algorithm selection follows too** ➔ the Fibonacci-heap [[Dijkstra's Algorithm|Dijkstra]] only pays off when $E\gg V$.
