---
unit: [FIT1058, FIT2004]
week: [6, 12]
source: [lecture, applied]
domain: [A, D]
parent: "[[Minimum Spanning Tree]]"
tags: [Math/GraphTheory, CS/Algorithms, CS/DataStructures]
aliases: [Kruskal, Kruskal's Algorithm]
---
# [[Kruskal's Greedy Algorithm]]

**Context:** [[FIT2004_MOC]], [[FIT1058_MOC]] · **merge many trees** — sort every edge once, then absorb each one that joins two different components, tested by [[Union-Find (Disjoint Set)]]
**Parent Framework:** [[Minimum Spanning Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** sort $E$ ascending ➔ add each edge **iff** its endpoints lie in different trees ➔ stop at $\lvert V\rvert-1$ edges.
> - **📦 Core Components:** sort $O(E\log E)$ ➔ the bottleneck | `find(u)==find(v)` ➔ the cycle test | `union` ➔ the acceptance | partial result is always a [[Forest]].
> - **⚡ Key Constraint:** the cycle test **is** the algorithm's cost centre — a naive set copy makes it $O(EV)$, [[Union-Find (Disjoint Set)|union-find]] makes it free and hands the bill back to the sort.

## 📝 How It Works
### 1. Every Vertex Starts as Its Own Tree
- **Initial state** ➔ $\lvert V\rvert$ singleton trees — a [[Forest]] with no edges.
- **An edge merges two trees** ➔ adding $\langle u,v,w\rangle$ fuses the tree containing $u$ with the tree containing $v$.
- **Add only across trees** ➔ if $u$ and $v$ are already in the same tree the edge closes a [[Cycle (Graph Theory)|cycle]] ⟹ reject it.
- **Terminates as one tree** ➔ $\lvert V\rvert$ components minus $\lvert V\rvert-1$ successful merges $=1$; the scan may stop early the moment the count reaches one.
- **Contrast with [[Prim's Algorithm|Prim]]** ➔ Prim grows a **single** tree and never needs the test; Kruskal maintains **many** and cannot avoid it.

### 2. The Three-Line Algorithm
- **Sort** ➔ all $E$ edges by weight, ascending.
- **Scan** ➔ for each edge in order: `if find(u) != find(v): add it and union(u,v)`.
- **Stop** ➔ when $\lvert V\rvert-1$ edges are accepted.
- **Which sort** ➔ a comparison sort ([[Quick Sort]] / [[Merge Sort]]) at $O(E\log E)$. **[[Counting Sort]] and [[Radix Sort]] are not available** — they need bounded integer keys, and edge weights are arbitrary (often real-valued), so the $\Theta(N+M)$ trade only pays when the problem *states* a small integer weight range.
- **$\log E$ collapses to $\log V$** ➔ $E\le V^{2}\Rightarrow\log E\le 2\log V$ ⟹ $O(E\log E)=O(E\log V)$; quote whichever the question uses, but know they are the same bound.

### 3. Implementation Ladder — Where the Cost Goes
- **Rung 1, Python `set` per component** ➔ `find` is $O(1)$ via a **map array** `vertex ➔ set id`, but `union` copies a set and rewrites the map ⟹ $O(V)$. Total $O(E\log E+E(1+V))=O(EV)$.
- **Rung 2, copy the smaller set into the larger** ➔ each element is moved only when its set doubles ⟹ $O(\log V)$ **amortised** per union ⟹ $O(E\log V)$.
- **Rung 3, [[Union-Find (Disjoint Set)]] with union-by-rank $+$ path compression** ➔ both operations almost $O(1)$ amortised ⟹ total $O(E\log E)$, **entirely the sort**.
- **The reusable lesson (LO3)** ➔ the algorithm never changed; only the ADT backing "same component?" did, and it moved the bound by a factor of $V$ ➔ the same lever as [[K-way Merge]]'s scan ➔ heap swap.

### 4. Correctness — the Cut Argument
- **Invariant** ➔ the accepted edge set is always a **subset of some MST**.
- **Maintenance (exchange)** ➔ let $e$ be the next accepted edge, joining components $C$ and $C'$. If the MST $M$ containing the current set omits $e$, then $M+\{e\}$ has a cycle re-crossing the cut $(C,V\setminus C)$ at some $e'$; $e$ was the lightest remaining cross-edge so $w(e)\le w(e')$, and $M-\{e'\}+\{e\}$ is a spanning tree of weight $\le w(M)$ ⟹ also an MST, and it contains $e$.
- **Termination** ➔ the sorted list is finite and each iteration consumes one edge; connectedness guarantees $\lvert V\rvert-1$ acceptances.
- **Sealing** ➔ at the end the accepted set is a spanning tree **and** a subset of an MST; equal edge counts force equality ⟹ it **is** an MST.
- **No non-negativity anywhere** ➔ every step compares two weights ⟹ negative edges are legal ➔ [[Minimum Spanning Tree]] §3.

### 5. A Weaker Invariant That Looks Right *(applied P10)*
- **Candidate** ➔ "each component of the current forest is an MST **of its own vertices**."
- **True** ➔ it follows from the real invariant: if a component were not minimal on its vertices, swapping in its own MST would lighten $M$.
- **But useless** ➔ it is **strictly weaker** and cannot close the proof. Counterexample: on $ab(10),\ cd(10),\ bc(1),\ ad(1)$ the components $\{ab\}$ and $\{cd\}$ are each an MST of their vertices, yet no way of joining them yields the global MST.
- **The transfer (LO2)** ➔ an invariant must be strong enough that *invariant $+$ termination $\Rightarrow$ postcondition*. A true statement the algorithm happens to maintain is not automatically a proof ➔ [[Invariant]].

## ⚙️ Core Implementation
### 🔹 Kruskal with union-find
> [!code]- Code
> ```python
> def kruskal(vertices, edges):            # edges: list of (w, u, v)
>     edges.sort()                         # O(E log E)  <- the bottleneck
>     uf = UnionFind(len(vertices))
>     mst, total = [], 0
>     for w, u, v in edges:                # O(E) iterations
>         if uf.union(u, v):               # False when find(u) == find(v)
>             mst.append((u, v, w))
>             total += w
>             if len(mst) == len(vertices) - 1:
>                 break                    # early exit: the forest is one tree
>     return mst, total
> ```
> 💡 **Common Mistake:** **Testing `u == v` instead of `find(u) == find(v)`** ➔ compares vertex ids, so every edge is accepted and the result is the whole graph. The question is never "same vertex", it is "same **component**".
> 💡 **Common Mistake:** **Returning without checking the edge count** ➔ on a **disconnected** graph the loop ends with fewer than $\lvert V\rvert-1$ edges, i.e. a spanning **forest**. Say so rather than reporting an MST.

## ⚖️ Complexity
$G$ connected, edges supplied as a list.

| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best | $\Theta(E\log E)$ | $\Theta(V)$ | the sort runs in full even if the first $V-1$ edges are all accepted |
| Average | $\Theta(E\log E)=\Theta(E\log V)$ | $\Theta(V)$ | union-find cost is dominated |
| Worst | $\Theta(E\log E)$ | $\Theta(V)$ | every edge scanned and tested; the sort still dominates |
| Edges **pre-sorted** | $\Theta(E\,\alpha(V))$, almost $\Theta(E)$ | $\Theta(V)$ | the only case where union-find is the cost centre |

- **Naive rungs for comparison** ➔ set-copy union $O(EV)$ · smaller-into-larger $O(E\log V)$ ➔ §3.
- **Space** ➔ $\Theta(V)$ auxiliary for the parent array $+$ $\Theta(E)$ for the sorted edge list *(input, if the edge list was given)*; the accepted tree is $\Theta(V)$ output.
- **Against [[Prim's Algorithm|Prim]]** ➔ same $O(E\log V)$; the discriminator is density and input format, not the bound ➔ [[Minimum Spanning Tree]] Decision Matrix.

## 📊 Exam Execution Trace & Applied Exercises
Lecture graph, undirected: $A\!-\!B(10)$, $A\!-\!C(5)$, $B\!-\!C(3)$, $B\!-\!D(1)$, $C\!-\!D(9)$, $C\!-\!E(2)$, $D\!-\!E(4)$.
**Sorted:** $BD(1),\ CE(2),\ BC(3),\ DE(4),\ AC(5),\ CD(9),\ AB(10)$.

### Manual Execution Trace
| Step | Edge $(w)$ | `find(u)`, `find(v)` | Same tree? | Action | Forest after | $w(T)$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0** | — | — | — | init | $\{A\}\{B\}\{C\}\{D\}\{E\}$ | $0$ |
| $1$ | $BD\,(1)$ | $B,D$ | no | **add** | $\{A\}\{BD\}\{C\}\{E\}$ | $1$ |
| $2$ | $CE\,(2)$ | $C,E$ | no | **add** | $\{A\}\{BD\}\{CE\}$ | $3$ |
| $3$ | $BC\,(3)$ | $B,C$ | no | **add** | $\{A\}\{BDCE\}$ | $6$ |
| $4$ | $DE\,(4)$ | $B,B$ | **yes** | reject *(cycle)* | unchanged | $6$ |
| $5$ | $AC\,(5)$ | $A,B$ | no | **add** ➔ $4=V-1$ edges | $\{ABCDE\}$ | $11$ |
| — | $CD(9),AB(10)$ | — | — | never reached *(early exit)* | — | $11$ |

**Final Extracted Output:** MST $=\{BD(1),\ CE(2),\ BC(3),\ AC(5)\}$, weight $11$ — the same optimum the lecture found by enumerating spanning trees, and reached in **weight order**, unlike [[Prim's Algorithm|Prim]]'s.

- **Read the trap** ➔ step $4$ rejects $DE$ although $D$ and $E$ were never joined **directly**; they became connected through $B\!-\!C$ two steps earlier. The test is on roots, never on the edge's own history.

### Applied Exercise — prep P2
**Problem:** same graph as [[Prim's Algorithm]]'s prep exercise: $a\!-\!b(5)$, $b\!-\!c(8)$, $b\!-\!e(1)$, $c\!-\!e(4)$, $a\!-\!d(2)$, $d\!-\!e(16)$, $d\!-\!f(4)$, $e\!-\!f(8)$, $e\!-\!g(9)$, $f\!-\!g(10)$.
$$
\begin{aligned}
\textbf{sorted: } & be(1),\ ad(2),\ ce(4),\ df(4),\ ab(5),\ bc(8),\ ef(8),\ eg(9),\ fg(10),\ de(16) \\
be(1)\ \checkmark\ & \{b,e\} \qquad ad(2)\ \checkmark\ \{a,d\} \qquad ce(4)\ \checkmark\ \{b,e,c\} \qquad df(4)\ \checkmark\ \{a,d,f\} \\
ab(5)\ \checkmark\ & \{a,d,f,b,e,c\} \qquad bc(8)\ \times \qquad ef(8)\ \times \qquad eg(9)\ \checkmark\ \text{all } 7 \text{ vertices}
\end{aligned}
$$
**Final Extracted Output:** $\{be,ad,ce,df,ab,eg\}$, weight $25$ — the **same edge set** [[Prim's Algorithm|Prim]] returns from root $a$, in a different order. Quote the order; the set alone does not show the algorithm ran.

## ⚠️ Common Mistakes
- 💡 **Sorting with [[Counting Sort]] or [[Radix Sort]] "because it is linear"** ➔ only legal when the question bounds the weights to small integers. Unbounded or real weights force a comparison sort and the $\Omega(E\log E)$ floor ➔ [[Sorting Problem]].
- 💡 **Greedy $\ne$ optimal in general** ➔ Kruskal is one of the rare cases where cheapest-first provably wins; do not transfer the habit to shortest paths or scheduling without a proof ➔ [[Greedy Algorithm]].
- 💡 **Quoting the weak component-wise invariant as the proof** ➔ true but too weak (§5); the marked invariant is *subset of some MST*.

## 🧠 Active Recall
> [!FAQ]- State Kruskal's invariant and prove it is maintained.
> - **Hint:** cut and exchange.
> > [!SUCCESS]- Answer
> > - **Short answer:** the accepted edges are always a subset of some MST; the next accepted edge can be exchanged into that MST without raising its weight.
> > - **Why:** **Setup** ➔ let $T\subseteq M$ and let $e$ be the next accepted edge, joining components $C$ and $V\setminus C$. **If $e\notin M$** ➔ $M+\{e\}$ contains a cycle, which must cross the cut a second time at some $e'\notin T$. **Exchange** ➔ $e$ was the lightest remaining cross-edge so $w(e)\le w(e')$, hence $w(M-e'+e)\le w(M)$; minimality forces equality, so $M'=M-e'+e$ is an MST containing $T\cup\{e\}$. **Sealing** ➔ at termination $T$ is a spanning tree inside an MST with the same $\lvert V\rvert-1$ edges ⟹ $T$ **is** an MST.

> [!FAQ]- Kruskal is $O(E\log E)$ with union-find and $O(EV)$ with plain sets. Locate the factor of $V$ and say what removes it.
> - **Hint:** what a merge physically does.
> > [!SUCCESS]- Answer
> > - **Short answer:** it is in `union`, not in `find` — copying one component's members into another is $O(V)$ per edge.
> > - **Why:** **Naive sets** ➔ `find` is $O(1)$ through a map array, but merging rewrites up to $V$ map entries, so $E$ merges cost $O(EV)$. **Smaller into larger** ➔ an element only moves when its component doubles, so it moves $\le\log_2 V$ times ⟹ $O(E\log V)$ amortised. **[[Union-Find (Disjoint Set)|Union-find]]** ➔ a merge writes **two array cells** regardless of size, and union-by-rank $+$ path compression keep `find` almost constant ⟹ the sort becomes the only cost.

> [!FAQ]- Both endpoints of the next edge are already connected. What do you do, and what does it cost?
> - **Hint:** the query still did work.
> > [!SUCCESS]- Answer
> > - **Short answer:** reject the edge — it would close a cycle — and move on; the two `find` calls are the whole cost.
> > - **Why:** **The forest invariant** ➔ the partial result must stay acyclic, and a within-tree edge is exactly what breaks it ➔ [[Spanning Tree]]. **Not wasted** ➔ with path compression the rejected edge's `find` calls flatten both paths, speeding up every later query. **The count is the stopping rule** ➔ rejections do not advance the $\lvert V\rvert-1$ counter, which is why an early exit tests the edge count and not the loop index.

> [!abstract] 极速同步
> - **核心干货**：按权重**从小到大排序**所有边，**只要不形成环**就无脑加边，直到加满 $\lvert V\rvert-1$ 条。
> - **关键底层**：并查集（[[Union-Find (Disjoint Set)|Union-Find]]）判环 —— `find(u) == find(v)` 即成环，跳过；否则 `union` 合并。
> - **复杂度**：$O(E \log E) = O(E\log V)$，瓶颈在排序；负权边完全没问题（只比较、不累加）。
> - **对比 [[Prim's Algorithm|Prim]]**：Prim 是「长一棵树」，稠密图占优；Kruskal 是「合并多棵树」，稀疏图或边已排序时占优。
