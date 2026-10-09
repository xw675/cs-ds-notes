---
unit: FIT2004
week: 11
source: [lecture, applied]
domain: A
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Network Flow, Maximum Flow, Max Flow, Max-Flow Problem, Flow Network, Residual Network, Augmenting Path, Edmonds-Karp]
---
# [[Ford-Fulkerson Method]]

**Context:** [[FIT2004_MOC]] · the W11 max-flow engine — repeatedly find an $s\rightsquigarrow t$ path in the **residual network** by [[Uninformed Search (BFS and DFS)|BFS/DFS]] and push its bottleneck · proved optimal by the [[Min-Cut Max-Flow Theorem]] · reused unmodified by every [[Network Flow Reductions|reduction]]
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\lvert f\rvert=0$ ➔ while the residual network has an $s\rightsquigarrow t$ path, push its **bottleneck** and update both edge directions ➔ no path left ⟹ the flow is **maximum**.
> - **📦 Core Components:** **flow network** (capacities $+$ two constraints) | **residual network** (forward $=$ spare, backward $=$ cancellable) | **augmenting path** ($O(V+E)$ BFS/DFS) | **$\le F$ iterations** ⟹ $O(FE)$.
> - **⚡ Key Constraint:** the **backward edge** is the whole method — pushing only along unused capacity sticks at $19$ on the lecture graph; cancelling $4$ units on $c\to b$ reaches $23$. And $O(FE)$ is **pseudo-polynomial**: $F$ is a value, not an input size.

## 📝 How It Works
### 1. The Flow Network and Its Two Constraints
- **Flow network** ➔ directed graph, every edge weighted by a non-negative **capacity** $c(u,v)$ · **source** $s$ has no incoming edges · **target** $t$ has no outgoing edges.
- **Flow** ➔ $f(u,v)$, drawn `f/c` on the edge; an edge carrying nothing may be drawn as bare $c$.
- **Capacity constraint** ➔ $0\le f(u,v)\le c(u,v)$ — "you can't overload".
- **Flow conservation** ➔ every $v\notin\{s,t\}$: $\sum_{E_{in}(v)}f=\sum_{E_{out}(v)}f$ · lecture check at $b$: in $8+4+0=12$, out $1+11=12$.
- **Value** ➔ $\lvert f\rvert=$ net flow out of $s$ $=$ net flow into $t$ (equal by [[Min-Cut Max-Flow Theorem]] §2, applied P1).
- **Max-flow problem** ➔ find a valid $f$ maximising $\lvert f\rvert$ · the **value** is unique, the **assignment is not** (the lecture's run and MUA's slides both reach $23$ with different edge flows).

### 2. The Residual Network $G_f$
- **Same vertices, edges re-derived from the current flow** ➔ for each $u\to v$ in $G$:
	- **forward / residual edge** $u\to v$ of capacity $c(u,v)-f(u,v)$ ➔ room still unused.
	- **backward / reversible edge** $v\to u$ of capacity $f(u,v)$ ➔ flow already sent that may be **cancelled**.
- **Drop zeros** ➔ a saturated edge has no forward edge; an empty edge has no backward edge.
- **Merge parallels** ➔ $G_f$ is simple: $a\to b$ ($c{=}10$, $f{=}0$) and $b\to a$ ($c{=}4$, $f{=}1$) give $r(a,b)=10+1=11$, $r(b,a)=3+0=3$.
- **Self-check** ➔ $r(u,v)+r(v,u)=c(u,v)+c(v,u)$ — the slide's "sum of the edges between 2 vertices same as the edge capacity".
- **Size** ➔ at most $2E$ edges ⟹ built in $O(V+E)$.

### 3. Path Augmentation
- **Augmenting path** ➔ any $s\rightsquigarrow t$ path in $G_f$, found by **BFS or DFS**.
- **Bottleneck** ➔ $b=\min$ **residual** capacity along the path — the most that fits through every edge.
- **Augment** ➔ each path edge: forward ⟹ $f(u,v)\mathrel{+}=b$ · backward ⟹ $f(v,u)\mathrel{-}=b$ ➔ $\lvert f\rvert\mathrel{+}=b$ ➔ refresh both residual directions.
- **What a backward edge means in $G$** ➔ re-routing, not reverse flow. Lecture, from $\lvert f\rvert=19$: path $s\to b\to c\to t$ ($b=\min(5,4,5)=4$) uses backward $b\to c$ ⟹ $c\to b$ drops $4\to0$, $c$ sends those $4$ to $t$ instead, and $s\to b$ ($8\to12$) refills $b$'s lost inflow ⟹ $\lvert f\rvert=23$.
- **Why a greedy push fails** ➔ the direct route $s\to b\to d\to c\to t$ needs $d\to c$ (already $7/7$) — "we can't, over capacity"; only the cancellation finds the extra $4$.

### 4. The Method
- **Loop** ➔ build $G_f$ ➔ `while` an augmenting path exists: take it, add its bottleneck to the flow, augment $G_f$ ➔ return the flow (lecture `ford_fulkerson`, slide 120).
- **Invariant** ➔ both constraints hold after every augment — the bottleneck never exceeds any residual capacity, and each interior path vertex gains and loses exactly $b$.
- **"Method", not "algorithm"** ➔ path choice is left open; BFS vs DFS changes the iteration count, never the final value (§6).

### 5. Termination and Correctness
- **Precondition** ➔ every capacity is an **integer**.
- **Termination** ➔ integer residuals ⟹ $b\ge1$ ⟹ $\lvert f\rvert$ rises by $\ge1$ per iteration · $\lvert f\rvert$ is bounded (by the capacity out of $s$, or any cut) ⟹ at most $F$ iterations.
- **Optimality** ➔ termination alone does not prove *maximum*; that needs the [[Min-Cut Max-Flow Theorem]] — the vertices still reachable from $s$ form a cut whose capacity equals $\lvert f\rvert$ ➔ its §Proof Blueprint.
- **W3 shape** ➔ correctness $=$ termination $+$ a property at exit, exactly as in [[Invariant]].
- **Integrality bonus** ➔ integer capacities ⟹ FF returns an integer flow on **every edge** — what lets [[Network Flow Reductions|reductions]] read matchings and $0/1$ entries straight off the flow.

### 6. Choosing the Path *(slides flag as FIT3155 optimisation)*
- **Why path choice matters** ➔ each iteration adds between $1$ and $F$; increments $8,13,41,\dots$ finish far sooner than $1,2,3,\dots$
- **Fewest edges** ➔ BFS ⟹ **Edmonds–Karp** ⟹ $O(VE^{2})$, independent of $F$ (proof in FIT3155) · fewer edges, lower chance of a small capacity on the path.
- **Largest bottleneck** ➔ the lecture's route is a **maximum spanning tree** — the bottleneck idea from [[Minimum Spanning Tree]] §4.

## ⚙️ Core Implementation
### 🔹 Ford-Fulkerson with BFS (applied P8) — paired residual edges
> [!code]- Code
> ```python
> from collections import deque
>
> class Edge:
>     def __init__(self, v, cap, rev):
>         self.v, self.cap, self.rev = v, cap, rev   # cap = RESIDUAL capacity; rev = twin's index in adj[v]
>
> def add_edge(adj, u, v, c):
>     adj[u].append(Edge(v, c, len(adj[v])))         # forward:  spare = c
>     adj[v].append(Edge(u, 0, len(adj[u]) - 1))     # backward: cancellable = 0
>
> def ford_fulkerson(adj, s, t):
>     flow = 0
>     while True:
>         parent = [None] * len(adj)                  # rebuilt EVERY iteration
>         parent[s] = (s, None)
>         q = deque([s])                              # q.pop() instead => DFS variant
>         while q and parent[t] is None:              # 1. augmenting path   O(V+E)
>             u = q.popleft()
>             for e in adj[u]:
>                 if e.cap > 0 and parent[e.v] is None:
>                     parent[e.v] = (u, e)
>                     q.append(e.v)
>         if parent[t] is None:                       # no path => maximum
>             return flow
>         b, v = float('inf'), t                      # 2. bottleneck        O(V)
>         while v != s:
>             u, e = parent[v]
>             b = min(b, e.cap)
>             v = u
>         v = t                                       # 3. augment           O(V)
>         while v != s:
>             u, e = parent[v]
>             e.cap -= b                              # forward loses b
>             adj[v][e.rev].cap += b                  # twin gains b (cancellable)
>             v = u
>         flow += b
> ```
> - **Edge flow afterwards** ➔ $f(u,v)=c(u,v)-$ `e.cap` on each forward edge.
> - **Twins replace merging** ➔ antiparallel input edges keep separate twins instead of one merged residual edge — same reachability, same answer.
> 💡 **Common Mistake:** **Updating only `e.cap`** ➔ without `adj[v][e.rev].cap += b` no backward edge ever appears and the method degenerates into the greedy push that sticks at $19$.

## ⚖️ Complexity
| Step / variant | Time | Aux space | Why |
| :--- | :--- | :--- | :--- |
| Build $G_f$ | $O(V+E)$ | $\Theta(V+E)$ | $\le2E$ residual edges |
| One iteration | $O(V+E)$ | $\Theta(V)$ | one BFS/DFS $+$ two $O(V)$ path walks |
| Iterations | $\le F$ | — | integer capacities ⟹ $b\ge1$ |
| **FF, any path (DFS)** | $O(F(V+E))=O(FE)$ | $\Theta(V+E)$ | $E\ge V-1$ once every vertex lies on an $s$–$t$ path |
| **FF with BFS (Edmonds–Karp)** | $O(\min(FE,\ VE^{2}))$ | $\Theta(V+E)$ | $VE^{2}$ proved in FIT3155 |
| Unit capacities | $O(VE)$ | $\Theta(V+E)$ | $F\le\deg^{+}(s)\le V-1$ ([[Network Flow Reductions]] §4) |

- **Pseudo-polynomial** ➔ $F$ is a **number** in the input; capacities near $2^{32}$ make $F$ exponential in the input's **bit-length** ([[Algorithmic Complexity]]) even though $V$ and $E$ are tiny.

## 📊 Exam Execution Trace & Applied Exercises
Lecture graph: $s\to a\,16$, $s\to b\,13$, $a\to b\,10$, $b\to a\,4$, $a\to c\,12$, $c\to b\,9$, $b\to d\,14$, $d\to c\,7$, $c\to t\,20$, $d\to t\,4$.

### Manual Execution Trace — lecture trial run from $\lvert f\rvert=0$
| Iter | Augmenting path in $G_f$ | Residual caps on path | $b$ | $\lvert f\rvert$ | Newly saturated |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | $s\to a\to c\to t$ | $16,12,20$ | $12$ | $12$ | $a\to c$ |
| $2$ | $s\to b\to d\to t$ | $13,14,4$ | $4$ | $16$ | $d\to t$ |
| $3$ | $s\to b\to d\to c\to t$ | $9,10,7,8$ | $7$ | $23$ | $d\to c$ |
| $4$ | none — from $\{s,a,b,d\}$ every exit is saturated | — | — | $\mathbf{23}$ | stop |

**Final Extracted Output:** $\lvert f\rvert=23$ · $s\to a\,12/16$ · $s\to b\,11/13$ · $a\to c\,12/12$ · $b\to d\,11/14$ · $d\to c\,7/7$ · $d\to t\,4/4$ · $c\to t\,19/20$ · all others $0$. The reached set $\{s,a,b,d\}$ in iteration $4$ **is** the min cut ➔ [[Min-Cut Max-Flow Theorem]] §4.

### Applied Exercise — prep P1: warm start, one cancellation per round
**Problem:** $s\to a\,1/3$, $s\to b\,4/4$, $b\to a\,1/1$, $a\to c\,5/5$, $d\to a\,3/4$, $c\to d\,0/1$, $c\to t\,5/5$, $b\to d\,3/4$, $d\to t\,0/3$ ⟹ $\lvert f\rvert=5$. Residual (a): $s\to a\,2$ · $a\to s\,1$ · $b\to s\,4$ · $a\to b\,1$ (cancel $b\to a$) · $c\to a\,5$ · $a\to d\,3$ (cancel $d\to a$) · $d\to a\,1$ · $c\to d\,1$ · $t\to c\,5$ · $b\to d\,1$ · $d\to b\,3$ · $d\to t\,3$.
$$
\begin{aligned}
\text{Aug 1: } & s\to a\to b\to d\to t,\ \ b=\min(2,1,1,3)=1 \Rightarrow b\to a\ 1\to0,\ b\to d\ 3\to4,\ d\to t\ 0\to1,\ \lvert f\rvert=6\\
\text{Aug 2: } & s\to a\to d\to t,\ \ b=\min(1,3,2)=1 \Rightarrow d\to a\ 3\to2,\ s\to a\ 2\to3,\ d\to t\ 1\to2,\ \lvert f\rvert=7\\
\text{Stop: } & s\to a\ 3/3 \text{ and } s\to b\ 4/4 \Rightarrow s \text{ has no residual out-edge}
\end{aligned}
$$
**Final Extracted Output:** $\lvert f\rvert=7$ · both augments run through a **backward** edge ($a\to b$, then $a\to d$) · other paths give other valid final networks ➔ min cut $(\{s\},\text{rest})$ in [[Min-Cut Max-Flow Theorem]] §Applied.

## ⚠️ Common Mistakes
- 💡 **Bottleneck from original capacities** ➔ use **residual** ones: prep $s\to a$ has $c=3$ but residual $2$.
- 💡 **Drawing a backward edge into $G$** ➔ a backward edge lives only in $G_f$; augmenting along it **decreases** the flow on the real edge, it never creates a reverse edge.
- 💡 **Calling $O(FE)$ polynomial** ➔ it is pseudo-polynomial; the polynomial bound needs BFS ($O(VE^{2})$).
- 💡 **"The max flow"** ➔ the value is unique, the edge assignment is not — mark schemes accept any valid final network.

## 🧠 Active Recall
> [!FAQ]- Why does the residual network need backward edges? Give the lecture case that breaks without them.
> > [!SUCCESS]- Answer
> > - **Short answer:** an early path can route flow badly; backward edges let a later path **cancel** it, which no forward-only search can do.
> > - **Why:** **At $\lvert f\rvert=19$** ➔ every forward route to $t$ is blocked ($d\to c$ is $7/7$), so a forward-only search stops at $19$. **Backward $b\to c$ ($=f(c,b)=4$)** ➔ path $s\to b\to c\to t$ moves $c$'s $4$ units off $c\to b$ onto $c\to t$ and refills $b$ from $s$ ⟹ $23$. **Optimality depends on it** ➔ the [[Min-Cut Max-Flow Theorem]] proof needs "no residual path" to mean every T$\to$S edge is empty, which only holds when cancellation was possible.

> [!FAQ]- Why is Ford-Fulkerson $O(FE)$, and why is that pseudo-polynomial?
> - **Hint:** count iterations by the flow, not by the graph.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\le F$ iterations of $O(V+E)$ each; $F$ is a capacity **value**, so it can be exponential in the input's bit-length.
> > - **Why:** **Per iteration** ➔ one BFS/DFS over $G_f$ ($\le2E$ edges) $+$ $O(V)$ to read and augment the path. **Iterations** ➔ integer capacities make each bottleneck $\ge1$, so at most $F$ rounds. **Illustration** *(not in the slides)* ➔ diamond $s\to a$, $s\to b$, $a\to t$, $b\to t$ at $10^{6}$ plus $a\to b$ at $1$: a DFS alternating $s\to a\to b\to t$ and $s\to b\to a\to t$ augments by $1$ each time ⟹ $2\times10^{6}$ rounds, while BFS takes the two 2-edge paths ⟹ $2$ rounds.

> [!FAQ]- BFS or DFS for the augmenting path — does it change correctness, the answer, or the bound?
> > [!SUCCESS]- Answer
> > - **Short answer:** neither correctness nor the value; only the bound — any path gives $O(FE)$, BFS adds $O(VE^{2})$.
> > - **Why:** **Correctness** ➔ the proof uses only "no augmenting path at exit", which holds for any search. **Value** ➔ the max flow equals the min cut capacity, a property of the network alone. **Bound** ➔ BFS picks a fewest-edge path (Edmonds–Karp), capping iterations at $O(VE)$ independent of $F$ — the FIT3155 result the slides quote.
