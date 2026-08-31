---
unit: [FIT1058, FIT2004]
week: [5, 11]
source: [lecture]
domain: [A, D]
parent: "[[Graph]]"
tags: [Math/GraphTheory, CS/DataStructures]
---
# [[Graph Representations]]

**Context:** [[FIT1058_MOC]] · symbolic ways to store a [[Graph]] in memory · edge list, adjacency matrix, adjacency list, incidence matrix · [[FIT2004_MOC]] · the W5 **ADT selection** decision that sets every traversal bound (LO3)

> [!abstract] Quick Revision
> - **🎯 Objective:** store a [[Graph]] symbolically for algorithms ➔ four standard encodings, two used in practice.
> - **📦 Core Components:** edge list ➔ adjacency **matrix** ($\Theta(V^{2})$, $O(1)$ lookup) ➔ adjacency **list** ($\Theta(V+E)$, output-sensitive scan) ➔ incidence matrix.
> - **⚡ Key Constraint:** the representation, not the algorithm, fixes the bound — [[Uninformed Search (BFS and DFS)|BFS/DFS]] is $\Theta(V+E)$ on a list and $\Theta(V^{2})$ on a matrix, from **identical** code.

## 📝 Core
### 1. The Four Representations
- **Edge list** ➔ set of edges (+ $V$, else isolated vertices vanish).
- **Adjacency matrix** ➔ $V\times V$ array; unweighted stores `True/False`, **weighted stores the weight**; undirected ⟹ symmetric, zero diagonal.
- **Adjacency list** ➔ an **array of vertex objects**, each holding a list of the edges leaving it (with weights).
- **Incidence matrix** ➔ $v\times e$ bit array, $1$ iff vertex is an endpoint; each column has two $1$s — used mainly for proofs, where row sums give $\deg(v)$ ([[Degree and the Handshaking Lemma]]) and the total $1$s give $2m$.

### 2. FIT2004 Costs (W5)
- **Matrix, space** ➔ $\Theta(V^{2})$ **unconditionally** — allocated whether or not the edges exist, so a sparse graph pays the full square.
- **Matrix, time** ➔ $O(1)$ to test whether edge $\langle u,v\rangle$ exists · $O(V)$ to walk **all** neighbours of $u$, scanning a whole row including empty cells.
- **List, space** ➔ $\Theta(V+E)$ — $V$ vertex slots plus $E$ edge records across all lists.
- **List, time** ➔ $O(X)$ to retrieve all neighbours of $u$, $X$ that vertex's neighbour count — **output-sensitive** ([[Output-Sensitive Complexity]]), and summed over all vertices it is $\Theta(E)$, which is where traversal's $\Theta(V+E)$ comes from.
- **List, edge lookup** ➔ *nominally* $O(\log V)$ if each list is kept sorted, but you **cannot binary-search a linked list**; the real cost stays $O(X)$ with an **early exit** once a larger vertex id is reached.
- **The selection rule** ➔ **sparse** ($E\lll V^{2}$) ⟹ adjacency **list**; **dense** ($E\approx V^{2}$) ⟹ the matrix costs the same space and buys $O(1)$ lookup. Real graphs (road networks, the web, social graphs) are sparse, so the list is the default.

## ⚖️ Core Decision Matrix
| Representation | Space | Edge-exists test | All neighbours of $u$ | Best for |
| :--- | :--- | :--- | :--- | :--- |
| adjacency matrix | $\Theta(V^{2})$ | $O(1)$ | $O(V)$ | **dense**; frequent "is there an edge?" queries |
| adjacency list | $\Theta(V+E)$ | $O(X)$ (early exit if sorted) | $O(X)$ | **sparse**; traversal-dominated workloads |
| edge list | $\Theta(V+E)$ | scan $O(E)$ | $O(E)$ | compact storage, [[Bellman-Ford]]-style edge sweeps |
| incidence matrix | $\Theta(V\cdot E)$ | — | — | proofs |

> [!NOTE] **When It Flips:** the adjacency matrix is the [[Binary Relation]]'s $0/1$ matrix over $V\times V$. The crossover is **density**: below $E\approx V^{2}$ the list wins on space and on neighbour iteration, and only an $O(1)$ edge-existence requirement buys the matrix back — and only when $\Theta(V^{2})$ cells are affordable at all.

## 📊 Exam Execution Trace

### Manual Execution Trace
Rows for $a,c,e$ (order $a$–$g$):

| Step / State | Vertex | Row | Degree |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $a$ | $0110000$ | 2 |
| 2 | $c$ | $1101000$ | 3 |
| 3 | $e$ | $0000000$ | 0 |

### Applied Exercise
**Problem:** run [[Uninformed Search (BFS and DFS)|BFS]] over $V=10^{5}$, $E=3\times10^{5}$ under both representations.
$$
\text{list}: \Theta(V+E)=\Theta(4\times10^{5}) \qquad\text{vs}\qquad \text{matrix}: \Theta(V^{2})=\Theta(10^{10})
$$
**Final Extracted Output:** a factor of $\approx25\,000$ in time and worse in space, from **identical** traversal code — the bound belongs to the representation. Quote it as "$\Theta(V+E)$ **on an adjacency list**"; an unqualified $\Theta(V+E)$ is an incomplete answer.

## ⚠️ Common Mistakes
- 💡 **Edge list needs $V$** ➔ isolated vertices have no edges; the matrix is $V^{2}$ cells regardless, the list stores only actual edges.
- 💡 **Claiming $O(\log V)$ edge lookup on an adjacency list** ➔ only if the neighbours sit in a **sorted array**; a linked list has no random access, so it degrades to a scan with early termination.
- 💡 **Adding the $\Theta(V+E)$ adjacency list to a traversal's *auxiliary* space** ➔ the graph is **input**, not auxiliary ([[Algorithmic Complexity]]); auxiliary is the $\Theta(V)$ queue and flags.

## 🧠 Active Recall
> [!FAQ]- Describe the adjacency matrix and adjacency list, and when each is preferable.
> - **Hint:** Dense vs sparse.
> > [!SUCCESS]- Answer
> > - **Short answer:** matrix $=V\times V$ cells, $O(1)$ test, $\Theta(V^{2})$ space; list $=$ neighbours per vertex, $\Theta(V+E)$ space, $O(X)$ neighbour scan.
> > - **Why:** **Sparse wins list** ➔ real graphs store no empty entries, and traversal only ever asks for *all* neighbours, which the list answers output-sensitively.

> [!FAQ]- An algorithm asks "does edge $\langle u,v\rangle$ exist?" $10^{6}$ times on a graph with $V=2000$. Which representation, and what changed?
> - **Hint:** The workload, not the graph, moved.
> > [!SUCCESS]- Answer
> > - **Short answer:** the **matrix** — $\Theta(V^{2})=4\times10^{6}$ cells is affordable, and $10^{6}$ $O(1)$ lookups beat $10^{6}$ list scans.
> > - **Why:** **Representation is chosen against the operation mix, not the graph alone** ➔ traversal wants "all neighbours" and favours the list; membership testing wants random access and favours the matrix. **The space penalty must first be survivable** ➔ at $V=10^{5}$ the same argument fails because $10^{10}$ cells cannot be allocated. **This is LO3 in miniature** ➔ every "X vs Y" answer must end in a **selection rule**, not a feature list.
