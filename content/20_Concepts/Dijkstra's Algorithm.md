---
unit: FIT2004
week: [5, 6]
source: [lecture, applied]
domain: A
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory, CS/DataStructures]
aliases: [Dijkstra, Single Source Shortest Path, SSSP]
---
# [[Dijkstra's Algorithm]]

**Context:** [[FIT2004_MOC]] · single-source shortest **distance** on a **weighted** graph — [[Uninformed Search (BFS and DFS)|BFS]] with the [[Queue (ADT)|queue]] swapped for a min-[[Heap]]
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** serve the **closest non-finalised** vertex, relax its out-edges ➔ every served vertex leaves with its **final** $\text{dist}$.
> - **📦 Core Components:** min-[[Heap]] `discovered` ➔ $O(\log V)$ serve/update | `v.distance` ➔ best-known | `v.previous` ➔ backtracking for the **path** | `v.visited` ➔ finalised.
> - **⚡ Key Constraint:** **non-negative weights only** — the greedy finalisation is what a negative edge breaks, and it is also what the correctness proof rests on.

## 📝 How It Works
### 1. The Two Paradigms It Fuses
- **Dynamic programming** ➔ optimal substructure: $\min(A\rightsquigarrow C)$ is built from $\min(A\rightsquigarrow B)$ plus $B\rightarrow C$ — subproblem answers are reused, never recomputed.
- **Greedy** ➔ the closest reachable vertex is **finalised immediately**: if $B$ is nearest to $A$, no detour $A\rightarrow C\rightarrow B$ can beat it ➔ [[Greedy Algorithm]].
- **Where greed dies** ➔ a **negative** edge $C\rightarrow B$ makes the detour cheaper *after* $B$ was finalised ➔ Dijkstra is wrong on negative edges. *(It may still happen to be right when the negative edge sits outside any cycle — never rely on it.)*
- **The escape hatches** ➔ [[Bellman-Ford]] (single source, tolerates negative edges) and [[Floyd-Warshall]] (all pairs) — later in the unit.

### 2. The Diff From BFS
- **Queue ➔ priority queue** ➔ BFS serves by *arrival*, Dijkstra by **smallest `distance`**; that single ADT swap ([[Priority Queue (ADT)]]) is the whole algorithm.
- **Increment ➔ relaxation** ➔ BFS sets `v.distance = u.distance + 1`; Dijkstra sets `v.distance = u.distance + w` and, on an **already discovered** vertex, **updates downward** if $v.\text{distance} > u.\text{distance} + w$.
- **Two flags, not one** ➔ `discovered` (in the heap, estimate may still fall) vs `visited`/finalised (served, distance frozen). A finalised neighbour is **skipped**, never relaxed.
- **Unweighted case** ➔ if all weights are equal, BFS already solves it in $\Theta(V+E)$ — do not pay for a heap you do not need.
- **Same loop, third variant** ➔ change the relaxation to `v.distance = w` and the algorithm computes a [[Minimum Spanning Tree]] instead ➔ [[Prim's Algorithm]].

### 3. Reading the Answer Out
- **Distance** ➔ `v.distance` at the moment $v$ is served; it never changes again.
- **Path** ➔ set `v.previous = u` on every successful relaxation, then **backtrack** from the target and reverse.
- **Single target** ➔ terminate the moment the target is moved to `visited`; the remaining heap is irrelevant.
- **Unreachable** ➔ a vertex never discovered keeps $\text{dist}=\infty$; the loop ends with an empty heap, not an error.

### 4. Beating the $\log V$ When the Weights Are Restricted *(applied P6, P9)*
- **Where the $\log$ lives** ➔ entirely in the [[Priority Queue (ADT)|priority queue]]. Restrict the weights enough and a cheaper queue exists, dropping the whole algorithm to $\Theta(V+E)$.
- **Zero-one shortest paths** ➔ weights $\in\{0,1\}$. A BFS queue always holds vertices of only **two** distinct distances $d$ and $d+1$; a $0$-weight edge lands its target at the **same** distance, so push it to the **front** and a $1$-weight edge to the **back** of a **deque**. That deque *is* a priority queue with at most two keys ⟹ $O(1)$ per operation.
- **Still needs relaxation** ➔ unlike BFS, the first discovery is no longer final (a vertex may be reached by a $1$-edge before a $0$-edge finds it), so keep the `dist[u] + w < dist[v]` test and skip stale deque entries with `if d == dist[u]`.
- **Bounded integer weights** ➔ $0\le w\le c$ for constant $c$. Every distance is $<cV$, and the minimum served **never decreases**, so store an array of $cV$ buckets of linked lists: insert and update are $O(1)$, and one forward sweep over all buckets costs $O(cV)=O(V)$ **in total** ⟹ $\Theta(V+E)$.
- **The transferable move (LO3)** ➔ read the constraint on the *keys*, then replace the ADT — the same lever as [[Counting Sort]] escaping the $\Omega(N\log N)$ comparison floor.
- **Alternative for $0$-$1$** ➔ contract every zero-weight [[Connectivity|component]] (found by a DFS) into one vertex, then run plain BFS on the contracted graph.

### 5. State-Graph Modelling — Change the Graph, Not the Algorithm *(applied P3)*
- **The paradigm** ➔ when the answer depends on more than *where you are*, put the extra state **into the vertex** and run unmodified Dijkstra on the enlarged graph.
- **Worked shape (road trip with fuel)** ➔ vertex $\langle u,c\rangle$ $=$ town $u$ holding $c$ litres, giving $(C+1)n$ vertices for fuel capacity $C$.
- **Two edge families** ➔ *travel* $\langle u,c\rangle\to\langle v,c-x\rangle$ for every $c\ge x$, weight $\mathbf{0}$ *(driving costs no money)* · *refuel* $\langle u,c\rangle\to\langle u,c+1\rangle$ for $c<C$, weight $p_u$ *(the town's petrol price)*.
- **One litre at a time** ➔ adding $\langle u,c\rangle\to\langle u,c+2\rangle$ at weight $2p_u$ is redundant and only makes the graph denser.
- **Answer** ➔ run Dijkstra from $\langle s,0\rangle$ and read $\langle t,0\rangle$; the edge weights now model **money**, and the fuel constraint is enforced by which edges exist.
- **The general paradigm** ➔ transforming the input so a **known unmodified algorithm** applies is the LO1 move, reused across the W5 and W6 applied sheets ➔ [[State-Space Graph Modelling]] holds the recipe, the unweighted BFS instance, and the sizing rule $V'=kV$.

## ⚙️ Core Implementation
### 🔹 Dijkstra with a min-heap
> [!code]- Code
> ```python
> def dijkstra(graph, source):
>     for vertex in graph.vertices:            # O(V) init
>         vertex.distance = INF
>         vertex.previous = None
>         vertex.discovered = False
>         vertex.visited = False
>     source.distance = 0
>     source.discovered = True
>     discovered = MinHeap()                   # keyed on vertex.distance
>     discovered.push(source, 0)
>
>     while not discovered.is_empty():         # O(V) iterations
>         u = discovered.serve()               # O(log V) - closest non-finalised
>         u.visited = True                     # FINALISED: u.distance is correct
>         for (v, w) in u.edges:               # edge <u,v,w>; O(E) over the whole run
>             if v.visited:
>                 continue                     # finalised - never relax again
>             if not v.discovered:
>                 v.distance = u.distance + w
>                 v.previous = u
>                 v.discovered = True
>                 discovered.push(v, v.distance)      # O(log V)
>             elif v.distance > u.distance + w:
>                 v.distance = u.distance + w
>                 v.previous = u
>                 discovered.update(v, v.distance)    # O(log V)
> ```
> 💡 **Common Mistake:** **Searching the heap for $v$** ➔ `update` must reach $v$'s slot in $O(1)$, so the heap keeps an **index map** `vertex ➔ position` maintained by every rise/sink. Scanning for $v$ turns each update into $O(V)$ and the algorithm into $O(VE)$.
> 💡 **Common Mistake:** **Updating `distance` without `previous`** ➔ the distances come out right and the path comes out wrong; `previous` must be rewritten on **every** successful relaxation, not only on first discovery. Backtrack it from the target and reverse in place, exactly as BFS does.

### 🔹 Zero-one BFS *(applied P6)*
> [!code]- Code
> ```python
> def zero_one_bfs(graph, s):                  # weights restricted to {0, 1}
>     dist = [INF] * graph.n
>     pred = [None] * graph.n
>     dq = Deque()
>     dist[s] = 0
>     dq.push_back((s, 0))
>
>     while not dq.is_empty():
>         u, d = dq.pop_front()
>         if d != dist[u]:
>             continue                         # stale entry - a better one was queued later
>         for (v, w) in graph.edges[u]:
>             if dist[u] + w < dist[v]:        # still a relaxation, unlike plain BFS
>                 dist[v] = dist[u] + w
>                 pred[v] = u
>                 if w == 0:
>                     dq.push_front((v, dist[v]))   # same layer -> front
>                 else:
>                     dq.push_back((v, dist[v]))    # next layer -> back
>     return dist, pred
> ```
> 💡 **Common Mistake:** **Dropping the `d != dist[u]` guard** ➔ a vertex can be pushed twice at different estimates; without the staleness check the older, larger estimate re-expands its neighbours and the $O(V+E)$ bound is lost.

## ⚖️ Complexity
Binary [[Heap]], graph as an adjacency list, $E\ge V-1$ (connected).

| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best | $\Theta(V)$ | $\Theta(V)$ | single target adjacent to the source, early exit — the $\Theta(V)$ init still runs |
| Average / Worst | $\Theta(E\log V)$ | $\Theta(V)$ | every edge relaxed once, every vertex served once — Dijkstra has **no bad-input case**, only a bad-graph *size* |
| Weights $\in\{0,1\}$ *(deque)* | $\Theta(V+E)$ | $\Theta(V)$ | the queue holds at most two distinct keys |
| Weights integer, $0\le w\le c$ *(bucket queue)* | $\Theta(V+E)$ | $\Theta(cV)=\Theta(V)$ | distances bounded by $cV$, minimum never decreases |

- **Slide derivation** ➔ outer loop $O(V)$ $\times$ [ serve $O(\log V)$ $+$ edge scan $O(V)$ $\times$ update $O(\log V)$ ] $=O(V^{2}\log V)=O(E\log V)$, using $E\approx V^{2}$ for a **dense** graph.
- **Aggregate derivation (tighter, prefer it)** ➔ $V$ serves at $O(\log V)$ **plus** $E$ relaxations at $O(\log V)$ ➔ $O((V+E)\log V)=O(E\log V)$ once $E\ge V-1$. The slide's $V^{2}$ is the dense instantiation, not a separate bound.
- **Fibonacci heap** ➔ $O(1)$ amortised `update` ➔ $O(E+V\log V)$, collapsing on a dense graph to $O(V^{2})$.
- **Space** ➔ $\Theta(V)$ auxiliary (heap $+$ `distance`/`previous`/flags) on top of the $\Theta(V+E)$ adjacency list, which is **input**, not auxiliary ([[Algorithmic Complexity]] §6).

## ⚖️ Core Decision Matrix
| Situation | Reach for | Why | Cost |
| :--- | :--- | :--- | :--- |
| Unweighted (or all-equal weights) | [[Uninformed Search (BFS and DFS)\|BFS]] | hop count already **is** the distance | $\Theta(V+E)$ |
| Weights $\in\{0,1\}$ | $0$-$1$ BFS with a **deque** | the queue never holds more than two keys | $\Theta(V+E)$ |
| Integer weights $0\le w\le c$ | Dijkstra $+$ **bucket** priority queue | minimum never decreases ⟹ one forward sweep | $\Theta(V+E)$ |
| Weighted, all $w\ge0$ | **Dijkstra** | greedy finalisation is sound | $\Theta(E\log V)$ |
| Some $w<0$, single source | [[Bellman-Ford]] | relaxes $V-1$ rounds, detects negative cycles | $\Theta(VE)$ |
| All pairs, negatives allowed | [[Floyd-Warshall]] | transitive closure over all intermediates | $\Theta(V^{3})$ |
| Dense **and** update-heavy | Dijkstra $+$ Fibonacci heap | `update` drops to $O(1)$ amortised | $O(E+V\log V)$ |
| Cost depends on extra state *(fuel, tolls, time of day)* | **state graph** $+$ unmodified Dijkstra | put the state in the vertex, not in the code | $O(E'\log V')$ on the enlarged graph |

> [!NOTE] **When It Flips:** the hinge is the **sign of the weights**, not their presence. One negative edge invalidates the finalisation step and no heap choice repairs it — the algorithm must change, not its ADT. Restricting the weights **upward** ($\{0,1\}$, bounded integers) flips the other way: the algorithm stays, the ADT gets cheaper.

## 📊 Exam Execution Trace & Applied Exercises
Lecture's directed weighted graph — $A\!\to\!B(10)$, $A\!\to\!C(5)$, $B\!\to\!C(2)$, $B\!\to\!D(1)$, $C\!\to\!B(3)$, $C\!\to\!D(9)$, $C\!\to\!E(2)$, $D\!\to\!E(4)$, $E\!\to\!D(6)$. Source $A$.

### Manual Execution Trace
| Step | Served (finalised) | Relaxations performed | $A$ | $B$ | $C$ | $D$ | $E$ | Heap after |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0** | — | init | $0$ | $\infty$ | $\infty$ | $\infty$ | $\infty$ | $\{A{:}0\}$ |
| $1$ | $A\ (0)$ | $B\!\leftarrow\!10$, $C\!\leftarrow\!5$ | $0$ | $10$ | $5$ | $\infty$ | $\infty$ | $\{C{:}5,B{:}10\}$ |
| $2$ | $C\ (5)$ | $B$: $5{+}3{=}8<10$ ✅ · $D\!\leftarrow\!14$ · $E\!\leftarrow\!7$ | $0$ | $8$ | $5$ | $14$ | $7$ | $\{E{:}7,B{:}8,D{:}14\}$ |
| $3$ | $E\ (7)$ | $D$: $7{+}6{=}13<14$ ✅ | $0$ | $8$ | $5$ | $13$ | $7$ | $\{B{:}8,D{:}13\}$ |
| $4$ | $B\ (8)$ | $C$ finalised ➔ skip · $D$: $8{+}1{=}9<13$ ✅ | $0$ | $8$ | $5$ | $9$ | $7$ | $\{D{:}9\}$ |
| $5$ | $D\ (9)$ | $E$ finalised ➔ skip | $0$ | $8$ | $5$ | $9$ | $7$ | $\varnothing$ |

**Final Extracted Output:** $\text{dist}=\{A{:}0,\ C{:}5,\ E{:}7,\ B{:}8,\ D{:}9\}$ · finalisation order $A,C,E,B,D$ is **nondecreasing in distance** · shortest path to $D$ backtracks $D\!\leftarrow\!B\!\leftarrow\!C\!\leftarrow\!A$, i.e. $A,C,B,D$ at cost $9$.

- **Read the trap** ➔ $D$ was written **three** times ($14\to13\to9$) and only the value it held when **served** is the answer. A vertex's `distance` is an *estimate* until it is finalised.

### Applied Exercise — break the "update only on discovery" bug *(applied P1)*
**Problem:** an implementation writes `v.distance` the **first** time $v$ is discovered and never relaxes it again. Exhibit a graph where it fails.
**Graph:** $s\to a(1)$, $a\to c(1000)$, $s\to b(2)$, $b\to c(1)$, $c\to d(1)$.
$$
\begin{aligned}
\text{serve } s &\Rightarrow a{=}1,\ b{=}2 \\
\text{serve } a\ (1) &\Rightarrow c \text{ discovered at } 1+1000=1001\ \textbf{and locked} \\
\text{serve } b\ (2) &\Rightarrow 2+1=3<1001 \text{ but the buggy code refuses to update}
\end{aligned}
$$
**Final Extracted Output:** $\text{dist}[c]=1001$ and $\text{dist}[d]=1002$ instead of $3$ and $4$. **The recipe for breaking it:** a vertex whose *first* discovery is via an expensive edge and whose true optimum arrives on a later, cheaper route.

### Applied Exercise — state and discharge the correctness claim
**Claim:** for every vertex $v$ removed from the queue, $\text{dist}[v]$ is correct. Let $S=V\setminus Q$ be the finalised set.
$$
\begin{aligned}
\textbf{Base: } & \text{dist}[s]=0 \text{ is optimal, since no edge weight is negative.} \\
\textbf{IH: } & \text{dist}[x] \text{ correct for every } x\in S. \\
\textbf{Step: } & \text{let } u \text{ be served next; suppose a shorter path } P:s\rightsquigarrow u,\ \text{len}(P)<\text{dist}[u]. \\
& \text{let } x \text{ be the furthest vertex of } P \text{ inside } S,\ y \text{ the next vertex on } P. \\
& \text{len}(s\rightsquigarrow y)\le\text{len}(P)<\text{dist}[u] \quad (\text{non-negative weights}) \;\Rightarrow\; \text{dist}[y]<\text{dist}[u].
\end{aligned}
$$
**Final Extracted Output:** contradiction either way — if $y\ne u$ then $y$ had the smaller key and would have been served **before** $u$; if $y=u$ then $\text{dist}[u]<\text{dist}[u]$. The inequality $\text{len}(s\rightsquigarrow y)\le\text{len}(P)$ is **exactly** where non-negativity is spent.

## ⚠️ Common Mistakes
- 💡 **Relaxing a finalised vertex** ➔ writing to `v.distance` after $v$ was served silently corrupts an already-correct answer and hides the negative-weight failure. Test `v.visited` **first**.
- 💡 **Relaxing only on first discovery** ➔ the mirror error, and the one the applied sheet examines: an estimate must be allowed to **fall** while $v$ is still in the heap.
- 💡 **Quoting $O(V^{2}\log V)$ as the bound** ➔ that is the **dense** case. The bound that survives marking is $O(E\log V)$ with $E$ named and the sparse/dense distinction stated ([[Graph]] §3).
- 💡 **"Dijkstra fails on negative edges because distances go negative"** ➔ no — it fails because a vertex is **finalised too early**; state it as a broken greedy choice, with the $A\rightarrow B$ vs $A\rightarrow C\rightarrow B$ counterexample.

## 🧠 Active Recall
> [!FAQ]- BFS and Dijkstra are the same loop. Name every line that differs, and say why each difference is forced.
> > [!SUCCESS]- Answer
> > - **Short answer:** the ADT ([[Queue (ADT)|queue]] ➔ min-[[Heap]]), the increment ($+1$ ➔ $+w$), and the added downward **update** branch.
> > - **Why:** **FIFO orders by hop count** ➔ correct only when every edge costs the same. **Serving the minimum key restores the ordering** ➔ vertices leave in nondecreasing distance, the property the correctness proof consumes. **The update branch is needed because an estimate can fall** ➔ in BFS the first arrival is final; in Dijkstra a cheaper route can appear while $v$ still sits in the heap.

> [!FAQ]- Exactly where does the correctness proof use non-negativity, and what does a single negative edge break?
> > [!SUCCESS]- Answer
> > - **Short answer:** at $\text{len}(s\rightsquigarrow y)\le\text{len}(P)$ — a prefix is never longer than the whole path only when no edge is negative.
> > - **Why:** **A negative suffix makes a prefix cost more than the full path** ➔ the inequality reverses and the contradiction evaporates. **Operationally the greedy step dies** ➔ $u$ is finalised while a route through a later negative edge is cheaper, and Dijkstra never revisits a finalised vertex. **The repair is a different algorithm** ➔ [[Bellman-Ford]] relaxes every edge $V-1$ times instead of finalising once.

> [!FAQ]- Every edge weight is $0$ or $1$ and you are told to beat $O(E\log V)$. What do you build, and what must you keep from Dijkstra?
> - **Hint:** how many distinct keys can the queue hold?
> > [!SUCCESS]- Answer
> > - **Short answer:** BFS on a **deque** — push $0$-weight targets to the front, $1$-weight targets to the back — and keep the relaxation test.
> > - **Why:** **The queue holds only $d$ and $d+1$** ➔ a two-key priority queue needs no heap, so every queue operation is $O(1)$ and the total is $\Theta(V+E)$. **A $0$-edge does not advance the layer** ➔ its target belongs at the current distance, i.e. the front. **First discovery is no longer final** ➔ a vertex can be reached by a $1$-edge before a $0$-edge finds it, so plain BFS's "set once" is unsafe; keep `dist[u]+w < dist[v]` and skip stale deque entries.

> [!FAQ]- The cost of a move depends on how much fuel you are carrying. Dijkstra takes a graph, not a simulator — what do you do?
> - **Hint:** widen the vertex.
> > [!SUCCESS]- Answer
> > - **Short answer:** build a **state graph** whose vertices are $\langle\text{town},\text{fuel}\rangle$ and run unmodified Dijkstra on it.
> > - **Why:** **The extra state moves into the vertex** ➔ $(C+1)n$ vertices, one per town per litre level, so "where am I *and* what do I have" is a single node. **Edges become transitions** ➔ driving is a weight-$0$ edge $\langle u,c\rangle\to\langle v,c-x\rangle$ that simply does not exist when $c<x$, which is how the fuel constraint is enforced; refuelling is a weight-$p_u$ edge $\langle u,c\rangle\to\langle u,c+1\rangle$, which is how money becomes the distance. **The algorithm is untouched** ➔ transforming the input so a known algorithm applies is the paradigm being examined, not a Dijkstra variant.
