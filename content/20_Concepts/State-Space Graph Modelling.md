---
unit: FIT2004
week: [5, 6]
source: [applied]
domain: A
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [State Graph, State-Space Graph, Problem Transformation, Super Source]
---
# [[State-Space Graph Modelling]]

**Context:** [[FIT2004_MOC]] · the W5–W6 applied **LO1 paradigm** — when a problem breaks a standard algorithm, change the **graph**, not the algorithm ➔ vehicles are [[Uninformed Search (BFS and DFS)|BFS]] (unweighted) and [[Dijkstra's Algorithm|Dijkstra]] (weighted)
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a vertex stops being *a place* and becomes **a situation** ➔ every variable that controls what you may do next is folded into the vertex, and the untouched algorithm runs on the enlarged graph.
> - **📦 Core Components:** **state** $=\langle\text{location},\text{extra}\rangle$ | **edges** $=$ **legal transitions** only | **start** $=$ the initial state | **answer** $=\min$ over **all accepting** states.
> - **⚡ Key Constraint:** modifying a known algorithm risks its correctness proof; **transforming the input** keeps the algorithm a black box, so its guarantee transfers for free — that trade-off *is* the examinable point.

## 📝 How It Works
### 1. The Symptom — the Standard Algorithm Must Revisit a Vertex
- **The tell** ➔ the optimal route needs to **enter a vertex twice**, which every `visited` flag forbids by construction.
- **Worked symptom (dotted/solid edges)** ➔ edges are *solid* or *dotted*, and no path may use **two consecutive dotted** edges. On $s\!-\!a$ dotted, $a\!-\!b$ solid, $a\!-\!t$ dotted, the only legal route is $s\to a\to b\to a\to t$: step out to $b$ and back purely to spend a solid edge before the final dotted one.
- **Why plain BFS returns nothing** ➔ it marks $a$ visited on first arrival, never returns to it, and reports $t$ unreachable — the answer is not merely suboptimal, it is **wrong**.
- **The diagnosis, stated for marks** ➔ the current vertex is **not** a sufficient description of the situation; a second variable (*was the last edge dotted?*) decides which edges are legal from here.

### 2. Choosing the State
- **The rule** ➔ the state must capture **everything that changes what you may do next**, and nothing else. Too little ⟹ the algorithm is wrong; too much ⟹ the graph blows up.
- **Dotted/solid** ➔ $v=\langle\text{current vertex},\ \text{was previous edge dotted}\rangle$ ⟹ $2\lvert V\rvert$ states.
- **Fuel (W6 applied P3)** ➔ $v=\langle\text{town},\text{litres held}\rangle$ ⟹ $(C+1)\lvert V\rvert$ states ➔ [[Dijkstra's Algorithm]] §5 for the weighted worked shape.
- **Reading the multiplier off the question** ➔ the extra variable is whatever the constraint sentence mentions besides position: "cannot use two dotted in a row" ⟹ a **boolean**; "tank holds $C$ litres" ⟹ a **counter** $0..C$; "at most $k$ transfers" ⟹ $0..k$.
- **A revisit becomes two distinct vertices** ➔ visiting $a$ twice in the original graph is visiting $\langle a,\text{True}\rangle$ and $\langle a,\text{False}\rangle$ **once each** in the state graph, which is exactly what restores the `visited` flag's legality.

### 3. Wiring the Edges — Legality Is Structural, Not Conditional
- **The rule** ➔ an edge exists **iff** the transition is legal; the algorithm then needs no extra test, because an illegal move is simply not in the graph.
- **From $\langle u,\text{False}\rangle$** (last edge was solid, or we are at the start) ➔ everything is permitted: solid $u\!-\!v$ gives $\langle u,\text{False}\rangle\to\langle v,\text{False}\rangle$ · dotted $u\!-\!v$ gives $\langle u,\text{False}\rangle\to\langle v,\text{True}\rangle$.
- **From $\langle u,\text{True}\rangle$** (last edge was dotted) ➔ **only** solid $u\!-\!v$, giving $\langle u,\text{True}\rangle\to\langle v,\text{False}\rangle$; the dotted edges out of $u$ are absent, which is how "no two consecutive dotted" is enforced.
- **The graph turns directed** ➔ even from an undirected input, transitions carry a before/after asymmetry, so the state graph is a **digraph** — say so before tracing.
- **Weights come from the cost model, not the topology** ➔ in the fuel problem *travelling* is weight $0$ and *refuelling* is weight $p_u$, because money is what is minimised; here every transition is one edge of the original walk, so all weights are $1$ and [[Uninformed Search (BFS and DFS)|BFS]] suffices.

### 4. Start, Accept, and Reading the Answer
- **Start state** ➔ $\langle s,\text{False}\rangle$ — at the source no edge has been used, so both edge types are available.
- **Accepting states** ➔ arriving at $t$ is a win **however** we got there ⟹ **both** $\langle t,\text{False}\rangle$ and $\langle t,\text{True}\rangle$ count.
- **The answer** ➔ $\min(\text{dist}[\langle t,\text{False}\rangle],\ \text{dist}[\langle t,\text{True}\rangle])$ — forgetting the $\min$ over accepting states is the most common way a correct model still scores zero.
- **Never re-derive the algorithm** ➔ run [[Uninformed Search (BFS and DFS)|BFS]] unmodified for unit costs, [[Dijkstra's Algorithm|Dijkstra]] unmodified for non-negative weights; the shortest-path guarantee transfers because the state graph is just a graph.

### 5. The Sibling Move — Transform the Input, Not the Code *(applied P4)*
- **Same paradigm, other direction** ➔ multi-source shortest path is solved either by *modifying BFS* (seed the queue with all $k$ sources at distance $0$) or by *modifying the graph* (add a **super source** joined to every source, run stock BFS, subtract $1$).
- **Why the sheet prefers the transformation** ➔ modifying a complex algorithm risks breaking a correctness proof you did not write; transforming the input leaves the algorithm a **black box**, so you only have to justify that the transformation preserves the answer.
- **They coincide** ➔ the super source's first BFS iteration puts exactly the $k$ sources in the queue at distance $1$ — the seeded-queue solution offset by one ➔ [[Uninformed Search (BFS and DFS)]] §7.
- **The examinable sentence (LO1)** ➔ *map the problem onto one a known algorithm already solves, and justify that the mapping is answer-preserving* — the transferable pattern outranks any named algorithm.

## ⚙️ Core Implementation
### 🔹 Build the state graph, then call BFS unchanged
> [!code]- Code
> ```python
> # state id: vertex u with flag f in {0,1} is encoded as 2*u + f
> def build_state_graph(n, edges):              # edges: (u, v, is_dotted)
>     adj = [[] for _ in range(2 * n)]
>     for (u, v, dotted) in edges:
>         for (x, y) in ((u, v), (v, u)):       # input is undirected
>             if dotted:
>                 adj[2 * x + 0].append(2 * y + 1)   # <x,F> -dotted-> <y,T>
>             else:
>                 adj[2 * x + 0].append(2 * y + 0)   # <x,F> -solid--> <y,F>
>                 adj[2 * x + 1].append(2 * y + 0)   # <x,T> -solid--> <y,F>
>     return adj                                # no dotted edge leaves any <x,T>
>
> def shortest_constrained(n, edges, s, t):
>     adj = build_state_graph(n, edges)
>     dist = bfs(adj, source=2 * s + 0)         # STOCK BFS - not one line changed
>     return min(dist[2 * t + 0], dist[2 * t + 1])
> ```
> 💡 **Common Mistake:** **Returning `dist[<t,False>]` alone** ➔ the destination is often only reachable *via* a dotted edge, so the answer sits in the `True` copy; take the minimum over **all** accepting states.
> 💡 **Common Mistake:** **Adding a legality `if` inside BFS** ➔ that re-opens the algorithm's correctness question. Legality belongs in **which edges exist**, so the traversal stays stock.

## ⚖️ Complexity
Let $k$ be the number of values the extra variable can take.

| Quantity | Original graph | State graph | Note |
| :--- | :--- | :--- | :--- |
| Vertices | $V$ | $V'=kV$ | dotted/solid $k=2$ · fuel $k=C+1$ |
| Edges | $E$ | $E'\le kE$ | each original edge spawns $\le k$ transitions |
| BFS (unit costs) | $\Theta(V+E)$ | $\Theta(kV+kE)=\Theta(V+E)$ for constant $k$ | the $2$ is a constant factor |
| [[Dijkstra's Algorithm\|Dijkstra]] (weighted) | $O(E\log V)$ | $O(E'\log V')=O(kE\log(kV))$ | fuel: $O(CE\log(CV))$ |
| Auxiliary space | $\Theta(V)$ | $\Theta(kV)$ | one `dist`/`visited` slot per **state** |

- **Constant $k$ is free, parametric $k$ is not** ➔ a boolean flag leaves the bound unchanged; a capacity $C$ from the input multiplies it, so quote the bound in $C$ and say so.
- **Do not add redundant transitions** ➔ $\langle u,c\rangle\to\langle u,c+2\rangle$ at weight $2p_u$ is already the composition of two single-litre edges; it only makes $E'$ larger.

## 📊 Exam Execution Trace & Applied Exercises
Input: $s\!-\!a$ **dotted**, $a\!-\!b$ **solid**, $a\!-\!t$ **dotted**. State graph edges, with $F$/$T$ for *was the previous edge dotted*:
$\langle s,F\rangle\to\langle a,T\rangle$ · $\langle t,F\rangle\to\langle a,T\rangle$ · $\langle a,T\rangle\to\langle b,F\rangle$ · $\langle a,F\rangle\to\langle b,F\rangle$ · $\langle a,F\rangle\to\langle s,T\rangle$ · $\langle a,F\rangle\to\langle t,T\rangle$ · $\langle b,F\rangle\to\langle a,F\rangle$ · $\langle b,T\rangle\to\langle a,F\rangle$.

### Manual Execution Trace
BFS from $\langle s,F\rangle$.

| Step | Served | Newly discovered | Queue after | `dist` set |
| :--- | :--- | :--- | :--- | :--- |
| $1$ | $\langle s,F\rangle$ | $\langle a,T\rangle$ | $[\langle a,T\rangle]$ | $\langle a,T\rangle=1$ |
| $2$ | $\langle a,T\rangle$ | $\langle b,F\rangle$ | $[\langle b,F\rangle]$ | $\langle b,F\rangle=2$ |
| $3$ | $\langle b,F\rangle$ | $\langle a,F\rangle$ | $[\langle a,F\rangle]$ | $\langle a,F\rangle=3$ |
| $4$ | $\langle a,F\rangle$ | $\langle s,T\rangle$, $\langle t,T\rangle$ | $[\langle s,T\rangle,\langle t,T\rangle]$ | both $=4$ |
| $5$ | $\langle s,T\rangle$ | — | $[\langle t,T\rangle]$ | — |
| $6$ | $\langle t,T\rangle$ | — | $[\ ]$ | — |

**Final Extracted Output:** $\text{dist}[\langle t,F\rangle]=\infty$, $\text{dist}[\langle t,T\rangle]=4$ ⟹ answer $\min(\infty,4)=\mathbf{4}$, realising $s\to a\to b\to a\to t$. The forbidden revisit of $a$ appears in the trace as **two different vertices** served at steps $2$ and $4$ — $\langle a,T\rangle$ and $\langle a,F\rangle$ — which is the whole point of the construction.

### Applied Exercise
**Problem:** a graph has $\lvert V\rvert=10^{4}$ towns and $\lvert E\rvert=5\times10^{4}$ roads; a tank holds $C=50$ litres and refuelling costs $p_u$ per litre in town $u$. Size the state graph and quote the bound.
$$
V' = (C+1)V = 51\times10^{4} \approx 5.1\times10^{5}, \qquad E' \le (C+1)E + CV = 2.55\times10^{6}+5\times10^{5}
$$
$$
O(E'\log V') = O\bigl(CE\log(CV)\bigr) \approx 3\times10^{6}\times21 \approx 6\times10^{7}
$$
**Final Extracted Output:** feasible, and the bound must be quoted **in $C$** — writing $O(E\log V)$ hides a factor of $51$ that came from the modelling decision, not from the algorithm.

## ⚠️ Common Mistakes
- 💡 **Under-specifying the state** ➔ if two situations with the same state permit different next moves, the model is wrong; test the candidate state by asking *does this alone determine my legal edges?*
- 💡 **Keeping the answer at one accepting state** ➔ take the $\min$ over every state that counts as "arrived", here $\langle t,F\rangle$ and $\langle t,T\rangle$.
- 💡 **Forgetting the graph became directed** ➔ transitions are asymmetric even from undirected input; drawing undirected edges in part (d) loses the constraint entirely.
- 💡 **Patching the algorithm instead of the graph** ➔ an `if` inside [[Dijkstra's Algorithm|Dijkstra]] invalidates the correctness proof you are relying on; the black-box argument is what makes the transformation defensible.

## 🧠 Active Recall
> [!FAQ]- Plain BFS fails on the dotted/solid graph. Say precisely why, and what the failure tells you about the state.
> > [!SUCCESS]- Answer
> > - **Short answer:** the optimal walk must **revisit** $a$, and BFS's `visited` flag forbids that; the need to revisit proves the current vertex is not a sufficient state.
> > - **Why:** **$t$ hangs off a dotted edge** ➔ arriving at $a$ along the dotted $s\!-\!a$ makes the dotted $a\!-\!t$ illegal, so the walk must spend a solid edge first, out to $b$ and back. **BFS marks $a$ on first arrival** ➔ the return is never explored and $t$ is reported unreachable, so the output is wrong, not merely long. **Revisiting is the diagnostic** ➔ whenever the optimum needs a second visit, the missing information is a second state variable — here *was the previous edge dotted*, and the two visits split into $\langle a,T\rangle$ and $\langle a,F\rangle$.

> [!FAQ]- Multi-source shortest path can be solved by seeding BFS with all sources, or by adding a super source. Both work — why does the unit push you toward the second?
> > [!SUCCESS]- Answer
> > - **Short answer:** transforming the input keeps the algorithm a black box, so its existing correctness guarantee transfers; modifying the algorithm puts that guarantee back on you.
> > - **Why:** **You only owe one argument** ➔ that the transformation preserves the answer — here, every distance grows by exactly $1$, so subtract $1$. **Modification scales badly** ➔ a seeded queue is obviously fine, but in a more intricate algorithm an innocuous edit can silently break an invariant. **The two coincide anyway** ➔ the super source's first expansion enqueues exactly the $k$ real sources at distance $1$, which is the seeded solution offset by one.
