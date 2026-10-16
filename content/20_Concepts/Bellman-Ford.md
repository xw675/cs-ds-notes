---
unit: FIT2004
week: 8
source: [lecture, applied]
domain: A
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Bellman Ford, Negative Cycle Detection, SSSP with Negative Edges]
---
# [[Bellman-Ford]]

**Context:** [[FIT2004_MOC]] · single-source shortest distance when [[Dijkstra's Algorithm|Dijkstra]] is illegal — **negative edges allowed**, and a negative cycle is **reported** rather than silently wrong
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** relax **every** edge, $\lvert V\rvert-1$ times ➔ every shortest distance is final; **one extra pass** that still improves something proves a **negative cycle**.
> - **📦 Core Components:** ①  init $\Theta(V)$ | ②  distance calculation $\Theta(VE)$ | ③  negative-cycle check $\Theta(E)$ — the check is *not* optional, it is half the algorithm.
> - **⚡ Key Constraint:** $O(VE)$ buys negative edges. It is **not greedy** — nothing is ever finalised — so the price of dropping Dijkstra's non-negativity precondition is a factor of $\tfrac{V}{\log V}$.

## 📝 How It Works
### 1. Why It Is Not Greedy *(LO1)*
- **[[Dijkstra's Algorithm|Dijkstra]] finalises, Bellman-Ford does not** ➔ Dijkstra serves the closest vertex and freezes it; Bellman-Ford keeps every estimate mutable for the whole run, so a late-arriving negative edge can still lower it.
- **The cost of giving up the greedy step** ➔ with no "closest vertex" to serve there is no [[Priority Queue (ADT)|priority queue]] and no ordering to exploit ⟹ **every** edge must be re-examined every round.
- **[[Dynamic Programming]] is what pays for it** ➔ round $i$ computes $\text{dist}^{(i)}[v]=$ the cheapest walk $s\rightsquigarrow v$ using **at most $i$ edges**, built from round $i-1$'s answers. Optimal substructure without the greedy-choice property is exactly the [[Greedy Algorithm|greedy]]-vs-DP boundary.
- **Relaxation is identical to Dijkstra's** ➔ `if dist[u] + w < dist[v]: dist[v] = dist[u] + w; pred[v] = u`. Only the **schedule** of relaxations differs.

### 2. Why Exactly $\lvert V\rvert-1$ Rounds
- **A shortest path is simple** ➔ if it repeated a vertex it would contain a cycle; a non-negative cycle can be deleted without getting worse, and a negative one means no shortest path exists at all.
- **Simple ⟹ at most $\lvert V\rvert-1$ edges** ➔ *"this is the maximum number of jumps without a cycle"* — going $u\rightsquigarrow v$ you can pass through at most $\lvert V\rvert-1$ edges before revisiting a vertex.
- **One round extends every path by one edge** ➔ after round $i$ every distance realisable in $\le i$ edges is correct, so round $\lvert V\rvert-1$ closes the longest possible simple path.
- **Round order does not matter for correctness** ➔ only for how fast it converges; a lucky edge order finishes in one pass, an adversarial one needs all $\lvert V\rvert-1$.

### 3. The Negative-Cycle Check — Repeat It ONE MORE TIME
- **Why a negative cycle kills the problem** ➔ each lap round the cycle lowers the total, so the infimum is $-\infty$ ⟹ **there is no shortest distance**, and returning a number would be a lie.
- **The test** ➔ run the relaxation pass a $\lvert V\rvert$-th time. If **any** edge still relaxes, a path of $\ge\lvert V\rvert$ edges is beating every simple path ⟹ it must contain a cycle, and that cycle must be negative.
- **The lecture's phrasing** ➔ *"if a cycle exists, this additional traversal will form the biggest cycle"* — round $\lvert V\rvert$ is the first round that can only be reporting a non-simple walk.
- **Report, do not repair** ➔ the unit's pseudocode raises `error "Graph contains a negative-weight cycle"`; it does not return distances.
- **Only cycles REACHABLE from the source are found** ➔ a vertex still at $\infty$ never satisfies `dist[u] + w < dist[v]` in a meaningful way, so an unreachable negative cycle is invisible. Detecting *any* negative cycle needs a weight-$0$ super source (§5) or [[Floyd-Warshall]]'s diagonal.

### 4. The Required Early-Termination Optimisation
- **The observation** ➔ if a full pass over all $E$ edges relaxes **nothing**, no later pass can either — the state is a fixed point ⟹ **break**.
- **Implementation** ➔ one boolean `changed` per round, set on every successful relaxation, tested at the end of the round.
- **What it buys** ➔ best case collapses from $\Theta(VE)$ to $\Theta(V+E)$ *(one productive pass $+$ one confirming pass)*; the worst case is unmoved.
- **Free negative-cycle diagnosis** ➔ if `changed` is still true at the end of round $\lvert V\rvert-1$, the extra check pass is already implied — the two halves of the algorithm become one loop with a round counter.
- **Scope** ➔ the unit outline lists this optimisation as a requirement, discussed in the studio/applied session and the bonus video; drill the exact form from that video before the competency test.

### 5. Any Negative Cycle, and Which Vertices Form It *(applied P2, P3)*
- **Super source** ➔ add $q$ with a weight-$0$ edge to every vertex and run Bellman-Ford **once** from $q$ ⟹ every vertex is reachable, so every negative cycle is seen. $O(VE)$, vs $O(V^{2}E)$ for one run per source.
- **The disconnected caveat** ➔ the $V$ added edges make it $O(V(E+V))=O(VE+V^{2})$, which collapses to $O(VE)$ only when $G$ is connected ($E\ge V-1$) — $V$ isolated vertices with $E=0$ is the case that needs the $V^{2}$.
- **An updated vertex need not lie ON the cycle** ➔ the $\lvert V\rvert$-th pass also lowers vertices **downstream** of the cycle, and may leave some cycle vertices unchanged — which ones depends on the edge order. Never report the updated set as the cycle.
- **Extract by walking `pred` back** ➔ from any vertex updated in the $\lvert V\rvert$-th pass, follow `pred` until a vertex $u$ repeats; the cycle is $u$ plus every vertex between its two occurrences. A `visited` array costs $\Theta(V)$ auxiliary.
- **$O(1)$-auxiliary variant** ➔ step back $\lvert V\rvert-1$ times first — guaranteed to land on the cycle — then follow `pred` once round until returning to that vertex.
- **Cost** ➔ $O(VE)$ run $+$ $O(V)$ walk ⟹ $O(VE)$.

## ⚙️ Core Implementation
### 🔹 Bellman-Ford (unit pseudocode $+$ early exit)
> [!code]- Code
> ```python
> def bellman_ford(vertices, edges, source):
>     # Step 1: initialise                                     O(V)
>     dist = [INF] * len(vertices)
>     pred = [None] * len(vertices)
>     dist[source] = 0
>
>     # Step 2: relax every edge, V-1 times                    O(V) x O(E)
>     for i in range(1, len(vertices)):
>         changed = False
>         for (u, v, w) in edges:
>             if dist[u] != INF and dist[u] + w < dist[v]:
>                 dist[v] = dist[u] + w
>                 pred[v] = u
>                 changed = True
>         if not changed:                  # fixed point reached early
>             return dist, pred            # no negative cycle is possible
>
>     # Step 3: one more pass = negative-cycle check           O(E)
>     for (u, v, w) in edges:
>         if dist[u] != INF and dist[u] + w < dist[v]:
>             error("Graph contains a negative-weight cycle")
>     return dist, pred
> ```
> 💡 **Common Mistake:** **Omitting the `dist[u] != INF` guard** ➔ $\infty+(-4)<\infty$ evaluates true with a large sentinel integer, so unreached vertices leak finite garbage distances and the cycle check fires on a graph that has no cycle.
> 💡 **Common Mistake:** **Returning distances after detecting a cycle** ➔ the answer to *"what is the shortest distance"* is that **none exists**; a table of numbers is wrong, not partially right.

### 🔹 Extract one negative cycle *(applied P3)*
> [!code]- Code
> ```python
> def negative_cycle(n, edges):                 # vertices 0..n-1, edges (u, v, w)
>     q = n                                     # super source: weight-0 edge to every vertex
>     aug = edges + [(q, v, 0) for v in range(n)]
>     dist = [INF] * (n + 1)
>     pred = [None] * (n + 1)
>     dist[q] = 0
>     for _ in range(n):                        # |V'| - 1 = n rounds
>         for (u, v, w) in aug:
>             if dist[u] != INF and dist[u] + w < dist[v]:
>                 dist[v] = dist[u] + w
>                 pred[v] = u
>     x = None
>     for (u, v, w) in aug:                     # the check pass
>         if dist[u] != INF and dist[u] + w < dist[v]:
>             dist[v] = dist[u] + w
>             pred[v] = u
>             x = v                             # updated, but maybe OFF the cycle
>     if x is None:
>         return None                           # no negative cycle anywhere in G
>     for _ in range(n):                        # step back onto the cycle, O(1) aux
>         x = pred[x]
>     cycle, y = [x], pred[x]
>     while y != x:                             # one lap round the cycle
>         cycle.append(y)
>         y = pred[y]
>     return cycle[::-1]                        # in edge direction
> ```
> 💡 **Common Mistake:** **Returning `x` itself as a cycle vertex** ➔ the vertex that changed in the check pass may only hang off the cycle; the backward steps are what guarantee you are on it.

## ⚖️ Complexity
Adjacency **list** *(an edge list is enough — Bellman-Ford never asks for a vertex's neighbours)*.

| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best *(with early exit)* | $\Theta(V+E)$ | $\Theta(V)$ | one pass fixes everything, the second confirms it |
| Best *(textbook, no early exit)* | $\Theta(VE)$ | $\Theta(V)$ | the loop is input-independent — best $=$ worst |
| Average / Worst | $\Theta(VE)$ | $\Theta(V)$ | $V-1$ rounds $\times$ $E$ relaxations, $+\ E$ for the check |
| Dense instantiation | $\Theta(V^{3})$ | $\Theta(V)$ | $E\approx V^{2}$ |

- **Derivation** ➔ init $O(V)$ $+$ outer loop $O(V)$ $\times$ inner loop $O(E)$ $+$ check $O(E)$ $=O(V+VE+E)=O(VE)$.
- **Auxiliary is $\Theta(V)$, not $\Theta(VE)$** ➔ only `dist` and `pred` are stored; the $\lvert V\rvert-1$ rounds overwrite one array in place. The trace table's $V\times V$ grid is a **revision device**, not the implementation.
- **All-pairs by repetition** ➔ $O(V)\times O(VE)=O(V^{2}E)=O(V^{4})$ dense ⟹ strictly worse than [[Floyd-Warshall]]'s $\Theta(V^{3})$.

## ⚖️ Core Decision Matrix
| Situation | Reach for | Why | Cost |
| :--- | :--- | :--- | :--- |
| All $w\ge0$, single source | [[Dijkstra's Algorithm\|Dijkstra]] | greedy finalisation is sound | $O(E\log V)$ |
| Some $w<0$, single source | **Bellman-Ford** | nothing is finalised, so a late improvement still lands | $\Theta(VE)$ |
| Need to *know* whether a negative cycle exists | **Bellman-Ford** step 3 | the $\lvert V\rvert$-th pass is the certificate | $\Theta(E)$ extra |
| Negative cycle anywhere in $G$ | **Bellman-Ford** from a weight-$0$ super source (§5) | one run reaches every vertex | $O(VE)$ |
| … and the all-pair matrix is wanted too | [[Floyd-Warshall]] | a negative diagonal entry $\text{dist}[u][u]<0$ | $\Theta(V^{3})$ |
| All pairs, negatives, dense | [[Floyd-Warshall]] | $\Theta(V^{3})$ beats $\Theta(V^{2}E)$ | $\Theta(V^{3})$ |
| All pairs, negatives, sparse | [[Johnson's Algorithm\|Johnson's]] | one Bellman-Ford reweights every edge to $\ge0$, then $V$ Dijkstras | $O(VE\log V)$ |
| Weights $\ge0$ **and** all pairs **and** sparse | $V\times$ [[Dijkstra's Algorithm\|Dijkstra]] | $O(EV\log V)$ beats $\Theta(V^{3})$ when $E\lll V^{2}$ | $O(EV\log V)$ |

> [!NOTE] **When It Flips:** the hinge is the **sign of the weights**, then the **number of sources**, then **density**. One negative edge moves you from Dijkstra to Bellman-Ford; needing *all* pairs moves you to [[Floyd-Warshall]] on a dense graph and to [[Johnson's Algorithm|Johnson's]] — one Bellman-Ford, then $V$ Dijkstras — on a sparse one. $V$ separate Bellman-Fords is never the answer.

## 📊 Exam Execution Trace & Applied Exercises
Lecture graph — $s\!\to\!u(5)$, $s\!\to\!v(8)$, $u\!\to\!w(3)$, $w\!\to\!x(-1)$, $x\!\to\!v(-1)$, $v\!\to\!u(-4)$. Source $s$. Cells read *value* $+$ *predecessor*.

### Manual Execution Trace
| Vertex | $i=0$ | $i=1$ | $i=2$ | $i=3$ | $i=4$ | Checking pass |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $s$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ |
| $u$ | $\infty$ | $5s$ | $4v$ | $4v$ | $4v$ | $\mathbf{2v}$ ⟹ **break** |
| $v$ | $\infty$ | $8s$ | $8s$ | $8s$ | $6x$ | $\mathbf{5x}$ ⟹ **break too** |
| $w$ | $\infty$ | $\infty$ | $8u$ | $7u$ | $7u$ | $7u$ |
| $x$ | $\infty$ | $\infty$ | $\infty$ | $7w$ | $6w$ | $6w$ |

**Final Extracted Output:** the checking pass **still improves** $u$ and $v$ ⟹ **negative cycle**, so the algorithm returns an error, not the $i=4$ column. The culprit is $u\!\to\!w\!\to\!x\!\to\!v\!\to\!u$ at $3-1-1-4=\mathbf{-3}$, and every lap round it drives $u$ and $v$ down by a further $3$.

- **Read the trap** ➔ the $i=4$ column *looks* like a finished answer. Without step 3 you would hand it in. **A Bellman-Ford answer is only an answer once the extra pass changes nothing.**
- **Read the DP layering** ➔ $x$ is $\infty$ until $i=3$ because the shortest walk $s\to u\to w\to x$ needs three edges; a vertex first becomes finite in round $=$ its hop count from $s$.

### Applied Exercise — bound the damage of a single negative edge
**Problem:** show a graph where [[Dijkstra's Algorithm|Dijkstra]] is wrong but Bellman-Ford is right, using only the graph above's shape.
$$
\begin{aligned}
\text{Take } & s\to u(5),\ s\to v(8),\ v\to u(-4)\ \text{ only (no cycle).}\\
\text{Dijkstra: } & \text{serves } u \text{ at } 5,\ \textbf{finalises it},\ \text{then serves } v \text{ at } 8;\ v\to u \text{ is skipped as } u \text{ is visited} \Rightarrow \text{dist}[u]=5.\\
\text{Bellman-Ford: } & i=1 \Rightarrow u{=}5,\ v{=}8;\quad i=2 \Rightarrow 8+(-4)=4<5 \Rightarrow u{=}4.
\end{aligned}
$$
**Final Extracted Output:** $\text{dist}[u]=4$ via $s\to v\to u$. **The recipe:** a cheap-looking direct edge that is beaten by a longer route ending in a negative edge — exactly the greedy-finalisation failure, with no cycle needed.

### Applied Exercise — the updated vertex is off the cycle *(applied P3)*
**Problem:** $s\!\to\!a(0)$, $s\!\to\!b(0)$, $s\!\to\!c(0)$, $s\!\to\!d(0)$ *($s$ already plays the super source)*, $d\!\to\!a(-1)$, $d\!\to\!c(-5)$, $c\!\to\!b(1)$, $b\!\to\!d(2)$. Output the vertices of a negative cycle.
$$
\begin{aligned}
\text{After round } \lvert V\rvert-1:&\ \ a=-1\,(d),\ \ b=-4\,(c),\ \ c=-5\,(d),\ \ d=-2\,(b)\\
\text{Round } \lvert V\rvert:&\ \ a=-2-1=\mathbf{-3},\ \ c=-2-5=\mathbf{-7};\ \ b,\ d\ \text{unchanged}\\
\text{Walk pred from } a:&\ \ a\leftarrow d\leftarrow b\leftarrow c\leftarrow d\ \Rightarrow\ d\ \text{repeats}\\
\text{Cycle:}&\ \ d\to c\to b\to d=-5+1+2=\mathbf{-2}
\end{aligned}
$$
**Final Extracted Output:** the cycle is $\{d,c,b\}$. **Read the trap** ➔ the updated set $\{a,c\}$ contains $a$, which is **off** the cycle (it only hangs off $d$), and misses $b$ and $d$, which are **on** it.

## ⚠️ Common Mistakes
- 💡 **Looping $\lvert V\rvert$ times "to be safe"** ➔ the $\lvert V\rvert$-th pass **is** the cycle check; folding it into the main loop destroys the diagnosis and silently returns $-\infty$-bound garbage.
- 💡 **"Bellman-Ford handles negative cycles"** ➔ it **detects** them. No algorithm can return a shortest distance that does not exist.
- 💡 **Claiming it finds every negative cycle** ➔ only those **reachable from the source**. Say so, and offer the weight-$0$ super source or [[Floyd-Warshall]] as the fix.
- 💡 **Reporting the vertices updated in the $\lvert V\rvert$-th pass as the cycle** ➔ downstream vertices update too and some cycle vertices may not; walk `pred` back to a repeat (§5).
- 💡 **Quoting $O(V^{2})$ or $O(E\log V)$** ➔ the bound is $\Theta(VE)$; the dense instantiation is $\Theta(V^{3})$, and it must be stated with $E$ named ([[Graph]] §3).
- 💡 **Storing a $V\times V$ table** ➔ auxiliary space is $\Theta(V)$; the grid exists only for hand-tracing.

## 🧠 Active Recall
> [!FAQ]- Why exactly $\lvert V\rvert-1$ rounds — not $\lvert V\rvert$, not $\lvert E\rvert$?
> > [!SUCCESS]- Answer
> > - **Short answer:** a shortest path is **simple**, and a simple path in a $\lvert V\rvert$-vertex graph has at most $\lvert V\rvert-1$ edges.
> > - **Why:** **Each round extends reach by one edge** ➔ after round $i$, every distance achievable with $\le i$ edges is already correct, so $\lvert V\rvert-1$ rounds cover the longest path that can exist. **Fewer rounds is unsafe** ➔ a path of exactly $\lvert V\rvert-1$ edges is legal and would be missed. **More rounds is not "safer", it is the test** ➔ any improvement in round $\lvert V\rvert$ can only come from a walk with a repeated vertex, i.e. a **negative cycle** ➔ §3.

> [!FAQ]- Dijkstra is $O(E\log V)$ and Bellman-Ford is $\Theta(VE)$. What exactly did the extra factor buy, and which line of code spends it?
> - **Hint:** which vertex is finalised, and when?
> > [!SUCCESS]- Answer
> > - **Short answer:** it bought the removal of the **non-negativity precondition**; the spend is the outer `for i in 1..V-1` loop, which exists because **no vertex is ever finalised**.
> > - **Why:** **Dijkstra's $\log V$ is a queue cost, not a correctness cost** ➔ its cheapness comes from serving each vertex **once**, which is only sound when a finalised estimate can never fall. **A negative edge makes an estimate fall after finalisation** ➔ so the repair is to re-examine every edge until the estimates stop moving, and the number of rounds needed is bounded by the longest simple path. **The relaxation line is identical** ➔ what changed is the schedule, which is why the two algorithms share their `pred` backtracking and their DP framing ➔ [[Dynamic Programming]].

> [!FAQ]- Your run finishes and the $\lvert V\rvert$-th pass improves one vertex by $3$. What do you write, and what must you NOT write?
> > [!SUCCESS]- Answer
> > - **Short answer:** write *"a negative cycle reachable from $s$ exists, so no shortest distance is defined"* — do **not** write a distance table.
> > - **Why:** **The improvement certifies a non-simple walk** ➔ after $\lvert V\rvert-1$ rounds every simple path is already accounted for, so a further improvement uses $\ge\lvert V\rvert$ edges and must repeat a vertex; the repeated segment is a cycle whose total weight is negative. **The infimum is $-\infty$** ➔ each lap subtracts the same amount again, so no finite number is the answer. **Scope the claim** ➔ *reachable from $s$*; a negative cycle in an unreachable component is not detected by this run ➔ §5 super source, or [[Floyd-Warshall]] §4.

> [!FAQ]- The $\lvert V\rvert$-th pass improves vertex $a$. Is $a$ on the negative cycle, and how do you output the cycle's vertices in $O(VE)$?
> > [!SUCCESS]- Answer
> > - **Short answer:** not necessarily — walk `pred` back from $a$ until a vertex repeats; the vertices between its two occurrences are the cycle.
> > - **Why:** **Improvements ripple downstream** ➔ every vertex reachable from the cycle keeps falling, so $a$ may only hang off it (applied P3: $a$ hangs off $d$). **The `pred` chain must enter the cycle** ➔ each improvement was caused by its predecessor, the source never improves, and with finitely many vertices the chain must repeat. **Cost** ➔ an $O(V)$ walk on top of the $O(VE)$ run — with a `visited` array, or step back $\lvert V\rvert-1$ times and lap once for $O(1)$ auxiliary.
