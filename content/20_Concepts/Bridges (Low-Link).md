---
unit: FIT2004
week: 5
source: [applied]
domain: A
parent: "[[Uninformed Search (BFS and DFS)]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Bridge, Cut Edge, Low-Link, dfs_ord, Tarjan Bridges]
---
# [[Bridges (Low-Link)]]

**Context:** [[FIT2004_MOC]] · W5 applied **advanced** (D/HD tier) — the single-DFS answer to *which edges hold the graph together* ➔ one extra number per vertex turns [[Cycle Detection|"is this edge on a cycle?"]] into an $O(1)$ comparison
**Parent Framework:** [[Uninformed Search (BFS and DFS)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** an edge is a **bridge** iff removing it raises the [[Connectivity|component]] count ➔ equivalently, iff it lies on **no** [[Cycle (Graph Theory)|cycle]] ➔ testable in one DFS by asking whether the subtree below it can reach back **above** it.
> - **📦 Core Components:** $\texttt{dfs\_ord}[v]$ ➔ the visit counter | $\texttt{low\_link}[v]$ ➔ the **earliest** vertex the subtree at $v$ can reach without reusing an edge | the test $\texttt{low\_link}[v]>\texttt{dfs\_ord}[u]$.
> - **⚡ Key Constraint:** the comparison is **strict** and **mixed** — $\texttt{low\_link}$ of the child against $\texttt{dfs\_ord}$ of the parent. Equality means the child can reach $u$ itself, which is already a cycle, so the edge is **not** a bridge.

## 📝 How It Works
### 1. Correctness — Bridge $\iff$ On No Cycle *(LO2)*
- **Direction 1 ($e$ is a bridge $\Rightarrow$ $e$ lies on no cycle)** ➔ by contradiction. Suppose the bridge $e=\langle u,v\rangle$ lies on a cycle. Take any path $x\rightsquigarrow y$ that used $e$; because $e$ is on a cycle there is a detour $u\rightsquigarrow v$ around it, so $x\rightsquigarrow u\rightsquigarrow v\rightsquigarrow y$ avoids $e$ entirely ⟹ deleting $e$ disconnects nothing, contradicting *bridge*.
- **Direction 2 ($e$ on no cycle $\Rightarrow$ $e$ is a bridge)** ➔ contrapositive. If $e=\langle u,v\rangle$ is **not** a bridge, then $u$ and $v$ stay connected after deleting $e$, so a path $u\rightsquigarrow v$ exists avoiding $e$; appending $e$ closes it ⟹ $e$ lies on a cycle.
- **What this buys** ➔ the structural question becomes a **reachability** question, and reachability is what DFS already computes ➔ [[Cycle Detection]].

### 2. The Two Quantities
- **$\texttt{dfs\_ord}[v]$** ➔ the position of $v$ in DFS **discovery** order, $1,2,3,\dots$ — a timestamp saying *how early* $v$ was reached, so smaller means closer to the root.
- **$\texttt{low\_link}[v]$** ➔ the smallest $\texttt{dfs\_ord}$ reachable from $v$ using **unused** edges after $v$ was visited, formally
$$
\texttt{low\_link}[v]=\min\bigl(\texttt{dfs\_ord}[v],\ \min\{\texttt{dfs\_ord}[u]:u\ \text{reachable from}\ v\ \text{via unused edges}\}\bigr)
$$
- **Plain English** ➔ *the earliest vertex the subtree hanging below $v$ can climb back up to, without walking back through the edge it came in on.*
- **Both are per-vertex** ➔ two integer arrays, $\Theta(V)$ auxiliary, alongside the DFS's own $\Theta(V)$ stack.

### 3. Computing $\texttt{low\_link}$ in $\Theta(V+E)$
- **The recurrence** ➔ a vertex reachable from $v$ by a path of length $>1$ is reachable from one of $v$'s own unused neighbours, so the minimum propagates one hop at a time:
$$
\texttt{low\_link}[v]=\min\Bigl(\texttt{dfs\_ord}[v],\ \min_{\substack{u\ \text{adjacent to}\ v\\ \langle v,u\rangle\ \text{unused}}}\texttt{low\_link}[u]\Bigr)
$$
- **Where it is applied** ➔ during the DFS itself: descend into each child, and on the way **back up** fold the child's $\texttt{low\_link}$ into the parent's.
- **Why the cost does not move** ➔ one $\min$ per edge is $O(1)$ extra work on a traversal that already inspects every edge ⟹ still $\Theta(V+E)$ ➔ [[Uninformed Search (BFS and DFS)]].
- **"Unused" is what excludes the parent edge** ➔ marking the tree edge traversed before recursing stops the child from trivially "reaching back" to its parent along the same edge, which would make every $\texttt{low\_link}$ equal to the root's.

### 4. The Bridge Test
- **The criterion** ➔ for a tree edge $\langle u,v\rangle$ oriented in the direction DFS traversed it,
$$
\langle u,v\rangle\ \text{is a bridge}\iff \texttt{low\_link}[v]>\texttt{dfs\_ord}[u]
$$
- **Reading it** ➔ $\texttt{low\_link}[v]$ describes the earliest vertex $v$ can reach without reusing edges. If that is still **later** than $u$, nothing below $v$ can climb back to $u$ or above it ⟹ no cycle contains $\langle u,v\rangle$ ⟹ bridge.
- **Why equality fails the test** ➔ $\texttt{low\_link}[v]=\texttt{dfs\_ord}[u]$ means $v$ **can** reach $u$ by another route; that route plus $\langle u,v\rangle$ *is* a cycle, so the edge is not a bridge.
- **Reaching strictly above $u$** ➔ $\texttt{low\_link}[v]<\texttt{dfs\_ord}[u]$ means $v$ reaches an ancestor of $u$, so the cycle is merely larger — still not a bridge.
- **Only tree edges are candidates** ➔ a non-tree (back) edge always closes a cycle by construction, so it can never be a bridge; the test is applied exactly where DFS recursed.

## ⚙️ Core Implementation
### 🔹 `FIND_BRIDGES` — one DFS, two arrays
> [!code]- Code
> ```python
> def find_bridges(graph):
>     dfs_counter = 1
>     dfs_ord = [None] * len(graph.vertices)
>     low_link = [None] * len(graph.vertices)
>     bridges = []
>     for u in graph.vertices:                  # every component
>         if dfs_ord[u.id] is None:
>             dfs(u, dfs_ord, low_link, bridges)
>     return bridges
>
> def dfs(u, dfs_ord, low_link, bridges):
>     global dfs_counter
>     dfs_ord[u.id] = low_link[u.id] = dfs_counter
>     dfs_counter += 1
>     for e in u.edges:                         # e = <u, v>
>         v = e.other_end(u)
>         if not e.traversed:                   # the parent edge is already marked
>             if dfs_ord[v.id] is None:
>                 e.traversed = True            # mark BEFORE recursing
>                 dfs(v, dfs_ord, low_link, bridges)
>                 if low_link[v.id] > dfs_ord[u.id]:
>                     bridges.append(e)         # nothing below v climbs back to u
>             low_link[u.id] = min(low_link[u.id], low_link[v.id])
> ```
> 💡 **Common Mistake:** **Comparing `low_link[v] > low_link[u]`** ➔ the test is deliberately **mixed**: the child's `low_link` against the parent's `dfs_ord`. Using two `low_link`s compares two reach-summaries and misses bridges.
> 💡 **Common Mistake:** **Marking the tree edge traversed *after* the recursive call** ➔ the child then walks straight back along it, sets its own `low_link` to the parent's `dfs_ord`, and every bridge disappears.
> 💡 **Common Mistake:** **Seeding at one vertex** ➔ bridges exist in every component; the outer loop over all vertices is not optional.

## ⚖️ Complexity
| Quantity | Cost | Where it comes from |
| :--- | :--- | :--- |
| Time (adjacency list) | $\Theta(V+E)$ | one DFS; the $\min$ fold is $O(1)$ per edge |
| Time (adjacency matrix) | $\Theta(V^{2})$ | the neighbour scan, not the algorithm ➔ [[Graph Representations]] |
| Auxiliary space | $\Theta(V)$ | $\texttt{dfs\_ord}$ $+$ $\texttt{low\_link}$ $+$ recursion depth |
| Edge marks | $\Theta(E)$ | one `traversed` bit per edge — part of the graph, not auxiliary |
| Naive alternative | $\Theta(E(V+E))$ | delete each edge, re-run a [[Connectivity\|connectivity]] check |

- **The gain is a factor of $E$** ➔ the low-link fold answers "is this edge on a cycle?" for **all** $E$ edges in the cost of **one** traversal, replacing $E$ separate connectivity tests.
- **Same shape as [[Cycle Detection]]** ➔ both upgrade DFS's per-vertex bookkeeping (a third state there, two counters here) rather than changing the traversal.

## 📊 Exam Execution Trace
Undirected $G$: $a\!-\!b$, $b\!-\!c$, $c\!-\!d$, $d\!-\!b$. Adjacency lists in that order; DFS seeded at $a$, counter starting at $1$. The triangle $b,c,d$ hangs off $a$ by the single edge $a\!-\!b$.

### Manual Execution Trace
| Step | Event | $\texttt{dfs\_ord}$ | $\texttt{low\_link}$ after | Bridge test |
| :--- | :--- | :--- | :--- | :--- |
| $1$ | enter $a$ | $a{=}1$ | $a{=}1$ | — |
| $2$ | tree edge $\langle a,b\rangle$, enter $b$ | $b{=}2$ | $b{=}2$ | pending |
| $3$ | tree edge $\langle b,c\rangle$, enter $c$ | $c{=}3$ | $c{=}3$ | pending |
| $4$ | tree edge $\langle c,d\rangle$, enter $d$ | $d{=}4$ | $d{=}4$ | pending |
| $5$ | $d$ sees $\langle d,b\rangle$, $b$ already visited | — | $d=\min(4,\texttt{low}[b]{=}2)=\mathbf{2}$ | back edge — never a bridge |
| $6$ | return to $c$ | — | $c=\min(3,\texttt{low}[d]{=}2)=\mathbf{2}$ | $\texttt{low}[d]{=}2>\texttt{dfs\_ord}[c]{=}3$? **no** |
| $7$ | return to $b$ | — | $b=\min(2,\texttt{low}[c]{=}2)=\mathbf{2}$ | $\texttt{low}[c]{=}2>\texttt{dfs\_ord}[b]{=}2$? **no** |
| $8$ | $b$ sees $\langle b,d\rangle$, $d$ already visited | — | $b=\min(2,\texttt{low}[d]{=}2)=2$ | back edge |
| $9$ | return to $a$ | — | $a=\min(1,\texttt{low}[b]{=}2)=\mathbf{1}$ | $\texttt{low}[b]{=}2>\texttt{dfs\_ord}[a]{=}1$? **YES ➔ bridge** |

**Final Extracted Output:** the only bridge is $a\!-\!b$. Every vertex of the triangle carries $\texttt{low\_link}=2$, i.e. *we can all climb back to $b$*, so no triangle edge passes the strict test; $b$ cannot climb above itself to $a$, so the edge that attaches the triangle is the cut edge — and deleting it does split $G$ into $\{a\}$ and $\{b,c,d\}$.

## ⚠️ Common Mistakes
- 💡 **Testing a non-tree edge** ➔ back edges close cycles by definition; run the comparison only where DFS actually recursed.
- 💡 **Using $\ge$ instead of $>$** ➔ $\ge$ turns every edge into a bridge at equality, and equality is exactly the case where a rival route home exists.
- 💡 **Claiming a bridge is any edge whose removal disconnects two *specific* vertices** ➔ the definition is about the **number of [[Connectivity|components]]** rising, which is the same as no cycle containing it.
- 💡 **Storing `low_link` as a vertex label rather than a running minimum** ➔ it must be **re-folded on every return** from a child, or the subtree's reach never propagates upward.

## 🧠 Active Recall
> [!FAQ]- State the bridge test, and explain in one sentence why the two arrays it compares are deliberately different.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\langle u,v\rangle$ (traversed $u\to v$) is a bridge iff $\texttt{low\_link}[v]>\texttt{dfs\_ord}[u]$ — the child's **reach** against the parent's **timestamp**.
> > - **Why:** **$\texttt{low\_link}[v]$ summarises escape routes** ➔ it is the earliest vertex the whole subtree at $v$ can reach without reusing an edge. **$\texttt{dfs\_ord}[u]$ is a fixed landmark** ➔ the question is whether any of those escape routes lands at $u$ or earlier. **Strictly later means trapped** ➔ if the best escape is still after $u$, no route bypasses $\langle u,v\rangle$, so it is on no cycle and is a bridge; at equality the subtree reaches $u$ by another road, which with $\langle u,v\rangle$ forms a cycle.

> [!FAQ]- Prove that an edge is a bridge if and only if it lies on no simple cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** a cycle through $e$ supplies a detour around it (so $e$ is not a bridge); a graph still connected without $e$ supplies a path that closes into a cycle with $e$.
> > - **Why:** **Forward, by contradiction** ➔ let $e=\langle u,v\rangle$ be a bridge lying on a cycle. Any path that used $e$ can be rerouted $\dots\rightsquigarrow u\rightsquigarrow v\rightsquigarrow\dots$ around the cycle, so removing $e$ disconnects no pair — contradicting *bridge*. **Backward, by contrapositive** ➔ if $e$ is not a bridge, $u$ and $v$ are still connected in $G-e$, giving a path $u\rightsquigarrow v$ that avoids $e$; appending $e$ yields a cycle containing $e$. **Why it matters algorithmically** ➔ it converts a deletion-and-recount question into a reachability question, which one DFS answers for all $E$ edges at once.
