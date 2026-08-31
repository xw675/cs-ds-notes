---
unit: FIT2004
week: 5
source: [applied]
domain: A
parent: "[[Uninformed Search (BFS and DFS)]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Directed Cycle Detection, Back Edge, Shortest Cycle, Three-State DFS]
---
# [[Cycle Detection]]

**Context:** [[FIT2004_MOC]] · the W5 applied spine — [[Uninformed Search (BFS and DFS)|DFS]] with a **third vertex state**, because on a directed graph "already visited" and "on the current path" stop being the same question
**Parent Framework:** [[Uninformed Search (BFS and DFS)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a cycle exists iff [[Uninformed Search (BFS and DFS)|DFS]] finds an edge back into the branch it is **currently inside** ➔ upgrade the boolean `visited` to **unvisited / active / inactive**.
> - **📦 Core Components:** **undirected** ➔ any edge to a visited non-parent | **directed** ➔ edge to an **active** vertex only | **shortest** cycle ➔ [[Uninformed Search (BFS and DFS)|BFS]] from **every** source | **pure-cycle** component ➔ every $\deg(v)=2$.
> - **⚡ Key Constraint:** an edge to an **inactive** vertex is a second path to a finished branch, **not** a cycle — collapsing the two states is the entire failure mode of the undirected algorithm on a digraph.

## 📝 How It Works
### 1. Why the Undirected Algorithm Breaks on a Digraph
- **The undirected rule** ➔ DFS meets an edge to an already-visited vertex (other than the one it came from) ⟹ report a cycle. Correct, because an undirected edge can be walked **both** ways, so a second route back *is* a closed walk.
- **The digraph counterexample** ➔ $a\!\to\!b$, $a\!\to\!c$, $b\!\to\!d$, $c\!\to\!d$. DFS reaches $d$ via $b$, later reaches $d$ again via $c$, and the undirected rule fires — but every edge points **forward**, so this is a [[Directed Acyclic Graph (DAG)|DAG]].
- **The real question** ➔ not *have I seen $v$ before?* but *can I get back to where I am standing?* Two forward paths to a common descendant are a **diamond**; only an edge into an **ancestor** closes a cycle.
- **Discriminating the two** ➔ in $a\!\to\!b$, $b\!\to\!c$, $b\!\to\!d$, $c\!\to\!e$, $d\!\to\!e$, $d\!\to\!a$ the edge $\langle d,e\rangle$ must be ignored (a finished sibling branch) while $\langle d,a\rangle$ must fire ($a$ is still on the path) — same "already visited" flag, opposite verdicts.

### 2. The Three States
- **Unvisited** ➔ never reached.
- **Active** ➔ entered, descendants **still being explored** ➔ the vertex sits on the current root-to-here path in the DFS tree.
- **Inactive** ➔ entered and **finished** ➔ its whole subtree is settled and the search has backtracked past it.
- **The test** ➔ on edge $\langle u,v\rangle$, `status[v] == Active` ⟹ **back edge** ⟹ directed cycle. `status[v] == Inactive` ⟹ cross/forward edge ⟹ ignore. `Unvisited` ⟹ recurse.
- **Where the third state is written** ➔ `status[u] = Active` on **entry**, `status[u] = Inactive` on **exit**, after the neighbour loop — the same "do it on finish" beat as [[Topological Sort]]'s push.
- **The outer loop is mandatory** ➔ a digraph need not be reachable from one vertex; seed DFS at every still-unvisited vertex.

### 3. The Undirected Case Costs $\Theta(V)$, Not $\Theta(V+E)$ *(applied P10)*
- **The claim** ➔ deciding whether an **undirected** graph has a cycle is $O(V)$ — the bound is **independent of $\lvert E\rvert$**.
- **Acyclic branch** ➔ an acyclic undirected graph is a forest, so $E\le V-1$ ⟹ $\Theta(V+E)=\Theta(V)$; the algorithm never sees more edges than that.
- **Cyclic branch** ➔ the search **terminates the instant** it examines the first edge to an already-visited vertex. Every edge inspected before that moment (parent edges aside) was a tree edge, and a forest of DFS trees holds at most $V-1$ of them ⟹ at most $O(V)$ work in total.
- **The transferable move (LO2)** ➔ when an algorithm **stops on first success**, bound the work done **before** the stop, not the size of the input it never reads ➔ the same argument shape as [[Graph Representations|the universal-sink elimination]].

### 4. The **Shortest** Cycle *(applied P6)*
- **Why one BFS is not enough** ➔ [[Uninformed Search (BFS and DFS)|BFS]] visits in distance order **from the source**, not in cycle-length order. On $s\!\to\!a$, $a\!\to\!b$, $a\!\to\!d$, $b\!\to\!c$, $d\!\to\!c$, $c\!\to\!e$, $e\!\to\!f$, $f\!\to\!g$, $g\!\to\!h$, $h\!\to\!f$ the $4$-cycle $a,b,c,d$ is met at distance $1$, while the $3$-cycle $f,g,h$ is $5$ away and surfaces only at distance $8$.
- **The fix** ➔ run a **separate BFS from every vertex** and keep the minimum. If the source lies on a cycle of length $k$, that BFS closes it at distance $k$ — before any longer cycle through the source has a chance to be detected.
- **The implementation simplification** ➔ when the search is rooted **inside** the shortest cycle, the first already-visited vertex it walks into is the **source itself**, so the inner test is just `if v == s: return dist[u] + 1` — no general back-edge machinery needed.
- **Bound** ➔ $\lvert V\rvert$ searches at $O(V+E)$ each ⟹ $O(V(V+E))$ time, $\Theta(V)$ auxiliary (the `dist` array is reinitialised per run).
- **Undirected is harder, not easier** ➔ the applied sheet leaves it open: the parent edge must be excluded or every edge reports a phantom $2$-cycle, and a vertex reached from two different tree branches needs care.

### 5. Counting Components That Are **Pure** Cycles *(applied P7)*
- **The structural characterisation** ➔ a connected undirected component is exactly a cycle iff **every** vertex in it has $\deg(v)=2$ — degree $1$ leaves a dangling tail, degree $\ge3$ leaves a branch, and both disqualify it.
- **The algorithm** ➔ the ordinary connected-components DFS, with each recursive call returning a boolean; `is_cycle` for a component is the **conjunction** of `deg(u) == 2` over its vertices.
- **Conjunction, not early exit** ➔ the traversal must finish the component even after the first bad degree, or the remaining vertices stay unvisited and get counted as a fresh component.
- **Bound** ➔ $\Theta(V+E)$, unchanged from plain component counting — the degree test is $O(1)$ per vertex on an [[Graph Representations|adjacency list]] that stores a length.

## ⚙️ Core Implementation
### 🔹 Directed cycle detection — three states
> [!code]- Code
> ```python
> UNVISITED, ACTIVE, INACTIVE = 0, 1, 2
>
> def has_cycle(graph):
>     status = [UNVISITED] * len(graph.vertices)
>     for u in graph.vertices:                  # every component, every source
>         if status[u.id] == UNVISITED and dfs(u, status):
>             return True
>     return False
>
> def dfs(u, status):
>     status[u.id] = ACTIVE                     # entering: u is on the current path
>     for (v, _w) in u.edges:
>         if status[v.id] == ACTIVE:            # back edge -> cycle
>             return True
>         elif status[v.id] == UNVISITED and dfs(v, status):
>             return True
>     status[u.id] = INACTIVE                   # finished: branch closed, not a cycle
>     return False
> ```
> 💡 **Common Mistake:** **Marking `INACTIVE` inside the loop** ➔ the flip must happen *after* every out-neighbour has returned; flipping early makes a genuine back edge look like a cross edge and the algorithm silently reports "acyclic".
> 💡 **Common Mistake:** **Testing `status[v] != UNVISITED`** ➔ that is the undirected rule, and it fires on the diamond $a\!\to\!b\!\to\!d$, $a\!\to\!c\!\to\!d$.

### 🔹 Shortest cycle — one BFS per source
> [!code]- Code
> ```python
> def shortest_cycle(graph):
>     best = INF
>     for s in graph.vertices:                  # V searches -> O(V(V+E))
>         best = min(best, bfs_from(s))
>     return best
>
> def bfs_from(s):
>     dist = [INF] * n
>     dist[s.id] = 0
>     queue = Queue()
>     queue.push(s)
>     while len(queue) > 0:
>         u = queue.pop()
>         for (v, _w) in u.edges:
>             if v is s:                        # walked back into the root
>                 return dist[u.id] + 1
>             elif dist[v.id] == INF:
>                 dist[v.id] = dist[u.id] + 1
>                 queue.push(v)
>     return INF                                # s lies on no cycle
> ```
> 💡 **Common Mistake:** **Running BFS once from an arbitrary source** ➔ it returns the shortest cycle *reachable soonest*, which is a different quantity; the counterexample in §4 gives $4$ instead of $3$.

### 🔹 Counting pure-cycle components
> [!code]- Code
> ```python
> def count_cycle_components(graph):
>     visited = [False] * len(graph.vertices)
>     num_components = 0
>     for u in graph.vertices:
>         if not visited[u.id] and dfs_cycle(u, visited):
>             num_components += 1
>     return num_components
>
> def dfs_cycle(u, visited):                    # True iff u's component is a pure cycle
>     visited[u.id] = True
>     is_cycle = (degree(u) == 2)
>     for (v, _w) in u.edges:
>         if not visited[v.id]:
>             if not dfs_cycle(v, visited):
>                 is_cycle = False              # keep traversing - do NOT return here
>     return is_cycle
> ```
> 💡 **Common Mistake:** **`return False` on the first bad degree** ➔ the rest of the component is left unvisited, so the outer loop restarts inside it and counts it again.

## ⚖️ Complexity
| Task | Traversal | Time | Auxiliary space | Discriminator |
| :--- | :--- | :--- | :--- | :--- |
| **Undirected**, does a cycle exist? | DFS | $O(V)$ — **independent of $E$** | $\Theta(V)$ | stops at the first non-tree edge; acyclic ⟹ $E\le V-1$ |
| **Directed**, does a cycle exist? | DFS, three states | $\Theta(V+E)$ | $\Theta(V)$ status $+$ $\Theta(V)$ stack | back edge $=$ edge into an **active** vertex |
| **Directed**, via [[Topological Sort]] | Kahn's | $\Theta(V+E)$ | $\Theta(V)$ | emitted $<V$ ⟹ cycle; no recursion |
| **Shortest** cycle, directed | $\lvert V\rvert\times$ BFS | $O(V(V+E))$ | $\Theta(V)$ | one BFS answers only for **its own** source |
| Count **pure-cycle** components | DFS | $\Theta(V+E)$ | $\Theta(V)$ | conjunction of $\deg(v)=2$ over the component |

- **Bounds are adjacency-list bounds** ➔ on an [[Graph Representations|adjacency matrix]] every neighbour scan is $O(V)$ ⟹ $\Theta(V^{2})$ throughout.
- **The $O(V)$ line is the trap** ➔ it is the one graph bound in W5 that is *not* $\Theta(V+E)$, and the reason is early termination, not a cleverer traversal.

## 📊 Exam Execution Trace & Applied Exercises
Directed graph $a\!\to\!b$, $b\!\to\!c$, $b\!\to\!d$, $c\!\to\!e$, $d\!\to\!e$, $d\!\to\!a$. Adjacency lists in the order written; DFS seeded at $a$.

### Manual Execution Trace
| Step | At | Edge examined | `status[v]` seen | Action | Active set after |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | — | — | — | enter $a$ | $\{a\}$ |
| $2$ | $a$ | $\langle a,b\rangle$ | Unvisited | recurse into $b$ | $\{a,b\}$ |
| $3$ | $b$ | $\langle b,c\rangle$ | Unvisited | recurse into $c$ | $\{a,b,c\}$ |
| $4$ | $c$ | $\langle c,e\rangle$ | Unvisited | recurse into $e$ | $\{a,b,c,e\}$ |
| $5$ | $e$ | — (no out-edges) | — | finish ⟹ $e$ **Inactive** | $\{a,b,c\}$ |
| $6$ | $c$ | — exhausted | — | finish ⟹ $c$ **Inactive** | $\{a,b\}$ |
| $7$ | $b$ | $\langle b,d\rangle$ | Unvisited | recurse into $d$ | $\{a,b,d\}$ |
| $8$ | $d$ | $\langle d,e\rangle$ | **Inactive** | **ignore** — finished branch | $\{a,b,d\}$ |
| $9$ | $d$ | $\langle d,a\rangle$ | **Active** | **CYCLE** ➔ return True | — |

**Final Extracted Output:** cycle $a\rightarrow b\rightarrow d\rightarrow a$. The undirected rule would have fired at step $8$ instead and reported the non-cycle $b,c,e,d$ — the two steps carry the **same** `visited` bit and the **opposite** verdict, which is precisely what the third state buys.

### Applied Exercise
**Problem:** the graph $s\!\to\!a$, $a\!\to\!b$, $a\!\to\!d$, $b\!\to\!c$, $d\!\to\!c$, $c\!\to\!e$, $e\!\to\!f$, $f\!\to\!g$, $g\!\to\!h$, $h\!\to\!f$ holds a $4$-cycle and a $3$-cycle. What does one BFS from $s$ return, and what does the $\lvert V\rvert$-source version return?
$$
\text{cycle } a,b,c,d:\ \text{len}=4,\ d(s,a)=1 \ \Rightarrow\ \text{closed at BFS depth } 5
$$
$$
\text{cycle } f,g,h:\ \text{len}=3,\ d(s,f)=5 \ \Rightarrow\ \text{closed at BFS depth } 8
$$
**Final Extracted Output:** one BFS from $s$ meets the length-$4$ cycle first and returns $4$; running BFS from $f$ returns $3$, so the minimum over all $\lvert V\rvert$ sources is the correct answer $3$. **Distance from the source and cycle length are different orderings** — BFS only sorts by the first.

## ⚠️ Common Mistakes
- 💡 **Importing the undirected rule into a digraph** ➔ two forward paths to a shared descendant are a diamond, not a cycle; the answer needs the **active** state, not the visited bit.
- 💡 **Quoting $\Theta(V+E)$ for the undirected existence question** ➔ the sheet's P10 wants $O(V)$ **and** the two-branch justification (forest ⟹ $E\le V-1$ · early termination after $\le V-1$ tree edges).
- 💡 **Answering "shortest cycle" with one traversal** ➔ any single-source search orders by distance from that source; only the per-source minimum orders by cycle length.
- 💡 **Testing degree without finishing the component** ➔ an early `return False` in P7's DFS leaves vertices unvisited and inflates the component count.

## 🧠 Active Recall
> [!FAQ]- The undirected cycle-detection algorithm is correct. Name the exact assumption it makes that a directed graph violates, and the minimum repair.
> > [!SUCCESS]- Answer
> > - **Short answer:** it assumes an edge can be traversed **both ways**, so any second arrival at a visited vertex closes a walk; the repair is a third vertex state, `active`, and firing only on edges into it.
> > - **Why:** **Undirected re-arrival implies a return route** ➔ reaching $v$ twice gives two edge-disjoint routes and the reverse of one is walkable, so a cycle exists. **Directed re-arrival implies nothing** ➔ $a\!\to\!b\!\to\!d$ and $a\!\to\!c\!\to\!d$ both point *away* from the current path, so no edge leads home. **`Active` names the current root-to-here path** ➔ set on entry, cleared on finish, so `status[v] == ACTIVE` is exactly "$v$ is my ancestor", and $u\to v$ closes the loop $v\rightsquigarrow u\to v$.

> [!FAQ]- Justify $O(V)$ — not $\Theta(V+E)$ — for deciding whether an undirected graph has a cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** split on the answer: acyclic graphs have $E\le V-1$, and cyclic ones terminate before more than $V-1$ edges have been examined.
> > - **Why:** **The acyclic case has no edges to pay for** ➔ an acyclic undirected graph is a forest, so $\Theta(V+E)=\Theta(V)$ outright. **The cyclic case stops early** ➔ every edge examined before the first already-visited vertex was a **tree** edge, and a DFS forest holds at most $V-1$; the cycle-producing edge terminates the run immediately. **The general lesson** ➔ an algorithm that halts on first success is bounded by the work **before** the halt, never by $\lvert E\rvert$ it never reads.

> [!FAQ]- Why must the shortest-cycle algorithm restart BFS at every vertex, when BFS already explores in shortest-distance order?
> > [!SUCCESS]- Answer
> > - **Short answer:** BFS sorts by distance **from its source**, and a short cycle can sit far from that source behind a long cycle that sits near it.
> > - **Why:** **The two orderings are independent** ➔ a length-$4$ cycle at distance $1$ is closed at depth $5$, while a length-$3$ cycle at distance $5$ is closed at depth $8$, so the first cycle found is the wrong one. **Rooting inside the cycle aligns them** ➔ if $s$ lies on a cycle of length $k$, BFS from $s$ closes it at exactly depth $k$, before any longer cycle through $s$; taking the minimum over all $\lvert V\rvert$ sources therefore returns the global minimum, at $O(V(V+E))$.
