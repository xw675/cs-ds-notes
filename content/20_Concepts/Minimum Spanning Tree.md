---
unit: FIT2004
week: 6
source: [lecture, applied]
domain: A
parent: "[[Spanning Tree]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [MST, Minimum Cost Spanning Tree]
---
# [[Minimum Spanning Tree]]

**Context:** [[FIT2004_MOC]] · the cheapest way to connect every vertex — a [[Spanning Tree]] minimising $\sum w(e)$, built greedily by [[Prim's Algorithm]] *(grow one tree)* or [[Kruskal's Greedy Algorithm]] *(merge many trees)*
**Parent Framework:** [[Spanning Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** undirected weighted $G=(V,E,W)$ ➔ acyclic subgraph touching every vertex with **minimum total edge weight**.
> - **📦 Core Components:** [[Prim's Algorithm]] ➔ $O(E\log V)$, a [[Dijkstra's Algorithm|Dijkstra]] variant growing from a root | [[Kruskal's Greedy Algorithm]] ➔ $O(E\log V)$, sort $+$ [[Union-Find (Disjoint Set)]].
> - **⚡ Key Constraint:** the **weight** is unique, the **tree is not** — equal-weight edges give several MSTs of equal cost, so it is always *an* MST, never *the* MST.

## 📝 How It Works
### 1. The Three Words
- **Tree** ➔ no [[Cycle (Graph Theory)|cycle]] and **undirected**; equivalently the **maximum** edge set carrying no cycle.
- **Spanning** ➔ contains every vertex of $G$ and only edges of $G$ ([[Subgraph]]); equivalently the **minimum** edge set that connects them ⟹ exactly $\lvert V\rvert-1$ edges.
- **Minimum** ➔ minimises $w(T)=\sum_{e\in T}w(e)$, **not** the edge count — every spanning tree already has $\lvert V\rvert-1$ edges, so only the weights discriminate.
- **Precondition** ➔ $G$ **connected** and **undirected**; disconnected ⟹ a minimum spanning **forest**, one tree per [[Connectivity|component]].

### 2. Not Unique, and Not a Shortest-Path Tree
- **Ties duplicate answers** ➔ the lecture graph has $\text{Tree }3=5{+}3{+}2{+}1=11$ and $\text{Tree }4=5{+}2{+}3{+}1=11$: two different edge sets, one optimum cost.
- **Optimal cost is unique** ➔ so an exam answer is marked on $w(T)$ and on the **selection order**, which is why both algorithms are examined as ordered traces.
- **MST $\ne$ shortest-path tree** ➔ [[Dijkstra's Algorithm|Dijkstra]] minimises **accumulated** $u.\text{distance}+w$ from one source; MST minimises the **total** of the chosen edges and has no source. Swapping the relaxation formula is exactly the diff ➔ [[Prim's Algorithm]] §2.
- **What MST paths DO minimise** ➔ the **largest single edge** on the path (§4), not its total length.

### 3. Negative Weights Are Fine
- **Both algorithms survive** ➔ Prim and Kruskal only ever **compare** edge weights against each other; nothing is accumulated, so the sign is irrelevant.
- **Contrast with [[Dijkstra's Algorithm|Dijkstra]]** ➔ Dijkstra sums weights into a distance, so one negative edge can lower an **already-finalised** estimate and break the greedy step. MST greed never finalises a *distance*.
- **The proofs do not spend non-negativity** ➔ unlike Dijkstra's contradiction argument, neither MST correctness proof uses $w\ge0$ anywhere.
- **Shift argument (a second proof)** ➔ add a constant $c$ to every edge; each spanning tree gains exactly $(\lvert V\rvert-1)c$, so the ranking of trees is unchanged ⟹ the MST of the shifted non-negative graph is the MST of the original.
- **Negative cycles are harmless** ➔ a cycle is never built in the first place; there is no "cheaper by looping" failure mode.

### 4. The Bottleneck Property *(applied P4)*
- **Bottleneck path** ➔ an $s$–$t$ path minimising the **maximum** edge weight on it, instead of the total.
- **Theorem** ➔ every path inside an MST $M$ is a bottleneck path of $G$.
- **Converse fails** ➔ a bottleneck path need not lie in any MST (§Applied Exercise, counterexample).
- **Why it is the same greed** ➔ Kruskal adds edges cheapest-first, so any pair of vertices is joined by the lightest heaviest-edge available — the bottleneck guarantee falls straight out of the cut logic.

### 5. Reverse-Delete: Kruskal Run Backwards *(applied P5)*
- **Algorithm** ➔ sort $E$ **descending**, start with $T=E$, and delete each edge in turn **iff** $T-\{e\}$ stays connected.
- **Invariant** ➔ $T$ is always a **superset** of some MST *(Kruskal's is "$T$ is always a **subset** of some MST")*.
- **Termination shape** ➔ output is connected (never disconnects) and acyclic (any edge in a cycle could have been removed) ⟹ a spanning tree; superset $+$ equal edge counts ⟹ **is** an MST.
- **Transfer (LO1)** ➔ the same greedy correctness template runs in either direction; what changes is subset ➔ superset and *cheapest safe addition* ➔ *dearest safe deletion*.

## ⚖️ Core Decision Matrix
| Need | Reach for | Why | Cost |
| :--- | :--- | :--- | :--- |
| MST, **dense** graph, adjacency matrix | [[Prim's Algorithm]] | no edge sort; grows from one root, $V$ serves | $O(E\log V)$, $O(V^{2})$ with an array-based serve |
| MST, **sparse** graph, edge list given | [[Kruskal's Greedy Algorithm]] | the sort $O(E\log E)$ is the whole cost | $O(E\log V)$ |
| MST when edges arrive **already sorted** | [[Kruskal's Greedy Algorithm]] | sort is free ⟹ near-linear with [[Union-Find (Disjoint Set)]] | $O(E\,\alpha(V))$ |
| Minimise the **largest** edge on an $s$–$t$ path | any MST, then walk it | MST paths are bottleneck paths (§4) | $O(E\log V)+O(V)$ |
| Minimise **accumulated** distance from a source | [[Dijkstra's Algorithm]] | different objective entirely | $O(E\log V)$ |
| Graph is **directed** | neither | MST is defined on undirected graphs only | — |

> [!NOTE] **When It Flips:** density, not correctness, chooses the algorithm — both are $O(E\log V)$ and both accept negative weights. Kruskal wins when the edges are already a sorted list; Prim wins when the graph is dense and you never want to materialise all $E$ edges.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise — prove MST paths are bottleneck paths *(P4b)*
**Problem:** $G$ weighted connected undirected, $M$ an MST, $s,t\in V$. Show the unique $M$-path $p$ from $s$ to $t$ is a bottleneck path.
$$
\begin{aligned}
\textbf{Setup: } & M \text{ is a tree} \Rightarrow p \text{ is unique. Suppose } p \text{ is NOT a bottleneck path.} \\
\textbf{Then: } & \exists\, p' \text{ from } s \text{ to } t \text{ in } G \text{ with } \max_{e\in p'} w(e) < \max_{e\in p} w(e) = w(e^{*}). \\
\textbf{Cut: } & M - \{e^{*}\} \text{ splits into two subtrees } (S,\ V\setminus S) \text{ with } s,t \text{ on opposite sides.} \\
\textbf{Cross: } & p' \text{ joins } s \text{ to } t \Rightarrow \text{some } e'\in p' \text{ crosses the cut, and } w(e') < w(e^{*}). \\
\textbf{Swap: } & w\big(M - \{e^{*}\} + \{e'\}\big) = w(M) - w(e^{*}) + w(e') < w(M).
\end{aligned}
$$
**Final Extracted Output:** a spanning tree strictly lighter than $M$ — contradiction, so $p$ is a bottleneck path. **The reusable move is the cut-and-swap**: delete a tree edge, cross the induced cut with something cheaper, rebuild.

### Applied Exercise — the converse fails *(P4c)*
**Problem:** exhibit a bottleneck path that lies in no MST. **Graph:** $a\!-\!b(10)$, $b\!-\!d(10)$, $b\!-\!c(1)$, $c\!-\!d(1)$.
**Final Extracted Output:** $a\to b\to d$ is a bottleneck path (max edge $10$, unavoidable since $a$'s only edge is $10$) but the MST is $\{ab,bc,cd\}$ of weight $12$, and $a\to b\to d$ costs $20$ ⟹ edge $bd$ is in no MST. **Bottleneck-optimal $\ne$ MST-member.**

## ⚠️ Common Mistakes
- 💡 **"The MST"** ➔ say *a* minimum spanning tree; only the **cost** is unique. On a tie the marker expects your tie-break rule stated, not a claim of uniqueness.
- 💡 **Refusing negative weights** ➔ the non-negativity precondition belongs to [[Dijkstra's Algorithm|Dijkstra]], not to MST. Quoting it here is a straight mark loss on the highest-frequency short-answer question of the week.
- 💡 **Reading an MST as a shortest-path tree** ➔ the $s$–$t$ path in an MST minimises its **heaviest edge**, and can be arbitrarily longer in total than the true shortest path.

## 🧠 Active Recall
> [!FAQ]- Can Prim's and Kruskal's be run on a graph with negative edge weights? Give two independent justifications.
> - **Hint:** compare vs accumulate.
> > [!SUCCESS]- Answer
> > - **Short answer:** yes — both are unaffected by the sign of the weights.
> > - **Why:** **They only compare** ➔ the greedy step picks the *smallest available* edge; nothing is summed into a distance the way [[Dijkstra's Algorithm|Dijkstra]] sums $u.\text{distance}+w$, so no estimate can be retroactively lowered. **The shift argument** ➔ adding a constant $c$ to every edge raises **every** spanning tree by exactly $(\lvert V\rvert-1)c$, leaving the ranking — and hence the MST edge set — identical.

> [!FAQ]- An engineer needs the route between two towns that minimises the **worst** road on it, not the total distance. What do you build, and why is it correct?
> - **Hint:** bottleneck.
> > [!SUCCESS]- Answer
> > - **Short answer:** build any MST and read off the unique tree path between the two towns.
> > - **Why:** **Every MST path is a bottleneck path** ➔ if a cheaper-maximum route existed, deleting the heaviest edge $e^{*}$ of the tree path induces a cut that the rival route must cross with a **lighter** edge, and swapping it in yields a lighter spanning tree — contradicting minimality. **The converse is false** ➔ do not try to read bottleneck paths *back* into MST membership; a bottleneck path can miss every MST.

> [!FAQ]- Reverse-delete removes the heaviest edge whose deletion keeps the graph connected. State its invariant and why the output must be an MST.
> - **Hint:** superset, not subset.
> > [!SUCCESS]- Answer
> > - **Short answer:** invariant — $T$ always contains some MST as a subset; the output is a spanning tree, hence that MST itself.
> > - **Why:** **Maintenance** ➔ if the deleted $e\notin M$ nothing changes; if $e\in M$ then $e$ lies on a cycle of $T$, that cycle supplies an $e'$ reconnecting $M$'s two halves with $w(e')\le w(e)$ (else $e'$ would have been deleted first), so $M'=M-e+e'$ is still minimum and sits inside $T-\{e\}$. **Sealing** ➔ the output is connected by construction and acyclic (a cycle edge is always deletable), so it is a spanning tree; a spanning tree that is a **superset** of an MST must equal it, since all spanning trees have $\lvert V\rvert-1$ edges.
