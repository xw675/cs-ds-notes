---
unit: FIT2004
week: 6
source: [lecture, applied]
domain: A
parent: "[[Minimum Spanning Tree]]"
tags: [CS/Algorithms, Math/GraphTheory, CS/DataStructures]
aliases: [Prim, Prim-Dijkstra, Jarnik's algorithm]
---
# [[Prim's Algorithm]]

**Context:** [[FIT2004_MOC]] · **grow one tree** from a root — [[Dijkstra's Algorithm|Dijkstra]] with the relaxation formula changed from *distance from the source* to *distance from the tree*
**Parent Framework:** [[Minimum Spanning Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** repeatedly absorb the **vertex nearest the current tree** ➔ after $V-1$ absorptions the tree is a [[Minimum Spanning Tree|MST]].
> - **📦 Core Components:** min-[[Heap]] keyed on `v.distance` ➔ $O(\log V)$ serve/update | `v.distance` ➔ **weight of the single cheapest edge into the tree** | `v.previous` ➔ the MST edge itself.
> - **⚡ Key Constraint:** `v.distance = w`, **never** `u.distance + w` — writing Dijkstra's formula here produces a shortest-path tree and silently answers a different question.

## 📝 How It Works
### 1. Growing, Not Merging
- **One component throughout** ➔ the tree starts as $\{\text{root}\}$ and every step attaches exactly one new vertex; it is never fragmented, unlike [[Kruskal's Greedy Algorithm|Kruskal's]] forest.
- **The greedy choice** ➔ of all edges with one endpoint in the tree and one outside, take the **lightest**. That edge and its outside endpoint join together.
- **Root is arbitrary** ➔ any start vertex produces an MST of the same weight; the *order* of selection changes, which is why exam questions fix the root ("use $a$").
- **Acyclicity is free** ➔ each added edge lands on a vertex not yet in the tree, so no cycle can form; Prim needs no cycle test and therefore no [[Union-Find (Disjoint Set)|union-find]].

### 2. The Diff From [[Dijkstra's Algorithm|Dijkstra]] — one line
- **Same loop, same ADT** ➔ init all $\text{dist}=\infty$ except the root at $0$, serve the minimum, relax out-edges, finalise on serve. Nothing else changes.
- **Relaxation formula** ➔ Dijkstra `v.distance = u.distance + w` ➔ Prim **`v.distance = w`**.
- **Guard is unchanged** ➔ relax **only if** the new value is smaller: `if not v.visited and w < v.distance`.
- **What the key means** ➔ in Dijkstra `v.distance` is a path cost from the source; in Prim it is the **cost of one edge** — the cheapest known link from $v$ to the tree.
- **Reading the answer** ➔ the MST is $\{(v,v.\text{previous}) : v\ne \text{root}\}$; its weight is $\sum_v v.\text{distance}$ at finalisation, **not** the final key of any one vertex.
- **Nickname** ➔ the lecture calls it **Prim-Dijkstra** for exactly this reason.

### 3. Correctness — the Cut Argument
- **Invariant** ➔ the selected edge set is always a **subset of some MST**.
- **Maintenance (exchange)** ➔ let $e$ be the lightest edge crossing the cut *(tree, rest)*. If some MST $M$ omits $e$, then $M+\{e\}$ has a cycle which must re-cross the cut at some $e'$ with $w(e')\ge w(e)$; $M-\{e'\}+\{e\}$ is a spanning tree of weight $\le w(M)$, so it is also an MST and it contains $e$.
- **Termination** ➔ each iteration finalises one vertex from a finite $V$ ⟹ exactly $V$ serves, $V-1$ edges.
- **No sign condition** ➔ the argument compares $w(e')$ with $w(e)$ and never sums, so negative weights are legal ➔ [[Minimum Spanning Tree]] §3.

## ⚙️ Core Implementation
### 🔹 Prim with a min-heap
> [!code]- Code
> ```python
> def prim(graph, root):
>     for vertex in graph.vertices:          # O(V) init
>         vertex.distance = INF              # cheapest KNOWN edge into the tree
>         vertex.previous = None
>         vertex.visited = False             # True == already in the tree
>     root.distance = 0
>     frontier = MinHeap()                   # keyed on vertex.distance
>     frontier.push(root, 0)
>
>     while not frontier.is_empty():         # O(V) serves
>         u = frontier.serve()               # O(log V) - nearest vertex to the tree
>         if u.visited:
>             continue
>         u.visited = True                   # u joins via edge (u, u.previous)
>         for (v, w) in u.edges:             # O(E) over the whole run
>             if not v.visited and w < v.distance:   # <-- w, NOT u.distance + w
>                 v.distance = w
>                 v.previous = u
>                 frontier.update(v, w)      # O(log V) via the index map
>     return [(v, v.previous) for v in graph.vertices if v.previous is not None]
> ```
> 💡 **Common Mistake:** **Writing `u.distance + w`** ➔ compiles, runs, returns a **shortest-path tree**. On the lecture graph it changes $D$'s parent and the answer's weight; the two trees coincide often enough that testing on one small graph will not catch it.
> 💡 **Common Mistake:** **Summing the final keys of the wrong set** ➔ $w(T)=\sum_{v\ne\text{root}} v.\text{distance}$; including the root's $0$ is harmless, but re-adding an edge from both endpoints double-counts.

## ⚖️ Complexity
Binary [[Heap]] with an index map, adjacency list, connected $G$ so $E\ge V-1$.

| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best | $\Theta(E\log V)$ | $\Theta(V)$ | **no early exit exists** — every vertex must join the tree |
| Average | $\Theta(E\log V)$ | $\Theta(V)$ | same work regardless of weights |
| Worst | $\Theta(E\log V)$ | $\Theta(V)$ | same again; Prim has no bad-input case, only a bad graph **size** |

- **Derivation** ➔ $V$ serves at $O(\log V)$ $+$ $E$ relaxations each costing an $O(\log V)$ heap update $=O((V+E)\log V)=O(E\log V)$ once $E\ge V-1$ — **identical to [[Dijkstra's Algorithm|Dijkstra]]**, as the lecture states.
- **Dense instantiation** ➔ $E\approx V^{2}$ ⟹ $O(V^{2}\log V)$; replacing the heap with a linear array scan gives $O(V^{2})$, which **beats** the heap on a dense graph.
- **Space** ➔ $\Theta(V)$ auxiliary (heap $+$ three vertex fields) on top of the $\Theta(V+E)$ adjacency list, which is **input** space ➔ [[Algorithmic Complexity]] §6.
- **Update needs an index map** ➔ `vertex ➔ heap slot`, maintained by every rise/sink; scanning the heap for $v$ makes each update $O(V)$ and the algorithm $O(VE)$.

## 📊 Exam Execution Trace & Applied Exercises
Lecture graph, undirected: $A\!-\!B(6)$, $A\!-\!C(5)$, $B\!-\!C(3)$, $B\!-\!D(8)$, $C\!-\!D(9)$, $C\!-\!E(2)$, $D\!-\!E(9)$. Root $A$.

### Manual Execution Trace
| Step | Served (joins tree) | Edge added | Relaxations *(only if $w<$ current)* | $A$ | $B$ | $C$ | $D$ | $E$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0** | — | — | init | $0$ | $\infty$ | $\infty$ | $\infty$ | $\infty$ |
| $1$ | $A\ (0)$ | — | $B\!\leftarrow\!6$, $C\!\leftarrow\!5$ | $0$ | $6,A$ | $5,A$ | $\infty$ | $\infty$ |
| $2$ | $C\ (5)$ | $A\!-\!C$ | $B$: $3<6$ ✅ · $D\!\leftarrow\!9$ · $E\!\leftarrow\!2$ | $0$ | $3,C$ | $5,A$ | $9,C$ | $2,C$ |
| $3$ | $E\ (2)$ | $C\!-\!E$ | $D$: $9<9$ ✗ **no change** | $0$ | $3,C$ | $5,A$ | $9,C$ | $2,C$ |
| $4$ | $B\ (3)$ | $C\!-\!B$ | $D$: $8<9$ ✅ | $0$ | $3,C$ | $5,A$ | $8,B$ | $2,C$ |
| $5$ | $D\ (8)$ | $B\!-\!D$ | none left | $0$ | $3,C$ | $5,A$ | $8,B$ | $2,C$ |

**Final Extracted Output:** MST $=\{AC(5),\ CE(2),\ CB(3),\ BD(8)\}$, weight $18$ · selection order $A,C,E,B,D$ — **note it is NOT nondecreasing in key** ($5,2,3,8$), unlike Dijkstra's finalisation order.

- **Read the trap** ➔ step $3$ tests $9<9$ and **rejects**; a strict `<` is what keeps the earlier parent. Step $4$ then overwrites $D$ from $9,C$ to $8,B$ — the parent pointer, not just the number, must be rewritten.

### Applied Exercise — prep P2, root $a$
**Problem:** $a\!-\!b(5)$, $b\!-\!c(8)$, $b\!-\!e(1)$, $c\!-\!e(4)$, $a\!-\!d(2)$, $d\!-\!e(16)$, $d\!-\!f(4)$, $e\!-\!f(8)$, $e\!-\!g(9)$, $f\!-\!g(10)$.
$$
\begin{aligned}
\text{serve } a &\Rightarrow b{=}5(a),\ d{=}2(a) \\
\text{serve } d\ (2) &\Rightarrow e{=}16(d),\ f{=}4(d) \\
\text{serve } f\ (4) &\Rightarrow e{:}\ 8<16\ \checkmark\ e{=}8(f),\ g{=}10(f) \\
\text{serve } b\ (5) &\Rightarrow c{=}8(b),\ e{:}\ 1<8\ \checkmark\ e{=}1(b) \\
\text{serve } e\ (1) &\Rightarrow c{:}\ 4<8\ \checkmark\ c{=}4(e),\ g{:}\ 9<10\ \checkmark\ g{=}9(e) \\
\text{serve } c\ (4),\ \text{then } g\ (9) &\Rightarrow \text{tree complete}
\end{aligned}
$$
**Final Extracted Output:** edges in selection order $ad(2),\ df(4),\ ab(5),\ be(1),\ ec(4),\ eg(9)$, weight $25$. [[Kruskal's Greedy Algorithm|Kruskal]] returns the **same edge set in a different order** — quote the order, not just the set.

## ⚠️ Common Mistakes
- 💡 **Serving in key order and calling it the answer** ➔ Prim's keys are *edge* weights, so the finalisation order is **not** sorted. Do not sanity-check it the way you check Dijkstra's.
- 💡 **Forgetting the strict inequality** ➔ `w <= v.distance` still yields a valid MST but rewrites `previous` on ties, so your trace stops matching the model answer. Use `<` and state your tie-break rule.
- 💡 **Claiming Prim needs non-negative weights** ➔ that precondition is [[Dijkstra's Algorithm|Dijkstra]]'s. Prim compares single edges and never accumulates ➔ [[Minimum Spanning Tree]] §3.

## 🧠 Active Recall
> [!FAQ]- Prim and Dijkstra are the same loop. Name every line that differs and say what each difference buys.
> - **Hint:** one assignment.
> > [!SUCCESS]- Answer
> > - **Short answer:** exactly one line — `v.distance = w` replaces `v.distance = u.distance + w`.
> > - **Why:** **Dijkstra's key is a path cost** ➔ accumulating from the source is what makes the finalised value a shortest distance, and what makes a negative edge fatal. **Prim's key is one edge** ➔ it measures distance *to the tree*, so the greedy serve picks the lightest edge crossing the cut, which is the MST greedy choice. **Everything else is shared** ➔ min-heap frontier, `visited` finalisation, `previous` for reconstruction, and the same $O(E\log V)$.

> [!FAQ]- Why does Prim never need a cycle check, while Kruskal cannot run without one?
> - **Hint:** one component vs many.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prim only ever attaches a vertex that is **outside** the tree, so a cycle is structurally impossible.
> > - **Why:** **A cycle needs both endpoints inside** ➔ Prim's guard `not v.visited` already excludes that case at no cost. **Kruskal picks edges globally** ➔ its two endpoints may sit in the same grown component, so it must ask "same tree?" on every edge — that question is what [[Union-Find (Disjoint Set)]] exists to answer in near-$O(1)$.
