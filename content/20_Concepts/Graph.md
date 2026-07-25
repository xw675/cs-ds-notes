---
unit: FIT1058
domain: D
week: 11
parent: "[[Binary Relation]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Graph]]

**Context:** [[FIT1058_MOC]] · an abstract model of a network · a [[Set (Mathematics)|set]] of vertices plus edges (unordered vertex-pairs) · adjacency is a [[Binary Relation|relation]] on vertices

> [!abstract] Quick Revision
> - **🎯 Objective:** $G=(V,E)$: vertices + edges (unordered pairs) ➔ models which pairs interact.
> - **📦 Core Components:** adjacency ($\sim$) ➔ incidence ➔ isolated/leaf vertices.
> - **⚡ Key Constraint:** adjacency is a symmetric irreflexive [[Binary Relation]]; specify both $V$ **and** $E$.

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

## ⚖️ Core Decision Matrix
| Term | Relates | Example |
| :--- | :--- | :--- |
| adjacency $\sim$ | vertex–vertex | $a\sim c$ |
| incidence | vertex–edge | $c$ in $\{a,c\}$ |
| isolated | degree 0 | $e$ |
| leaf | degree 1 | $d,f,g$ |

> [!NOTE] **When It Flips:** adjacency $\sim$ is a symmetric, irreflexive [[Binary Relation]] on $V$ — the bridge to relation theory; [[Connectivity]] turns the *walk* relation into an [[Equivalence Relation]]. Here graphs are **simple** unless stated ([[Types of Graphs]]).

## 📊 Exam Execution Trace

### Manual Execution Trace
$G=(\{a,\dots,g\},\{ab,ac,bc,cd,fg\})$:

| Step / State | Query | Answer |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | neighbours of $c$ | $a,b,d$ |
| 2 | edges incident with $c$ | $\{a,c\},\{b,c\},\{c,d\}$ |
| 3 | classify $e$ | isolated |

## ⚠️ Common Mistakes
- 💡 **Must give both $V$ and $E$** ➔ an isolated vertex leaves no trace in the edge list; edges are *sets*, so no vertex is adjacent to itself.

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
