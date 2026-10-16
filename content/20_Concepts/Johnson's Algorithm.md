---
unit: FIT2004
week: 8
source: [applied]
domain: [A, D]
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Johnson's, Johnson Algorithm, Potential Reweighting, Vertex Potentials]
---
# [[Johnson's Algorithm]]

**Context:** [[FIT2004_MOC]] · all-pair shortest distance on a **sparse** graph with **negative edges** — one [[Bellman-Ford]] makes every weight non-negative, then $\lvert V\rvert$ runs of [[Dijkstra's Algorithm|Dijkstra]]; the sparse counterpart to [[Floyd-Warshall]]
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** potentials $p[u]=$ [[Bellman-Ford]] distance from a weight-$0$ super source ➔ reweight $w'(u,v)=p[u]-p[v]+w(u,v)\ge0$ ➔ $\lvert V\rvert\times$ Dijkstra ➔ undo with $d(u,v)=d'(u,v)-p[u]+p[v]$.
> - **📦 Core Components:** ① super source $+$ Bellman-Ford $O(VE)$ | ② reweight $O(E)$ | ③ $V\times$ Dijkstra $O(VE\log V)$ | ④ undo $O(V^{2})$.
> - **⚡ Key Constraint:** the shift must be **per vertex**, not per edge — adding a constant to every edge (applied P1) charges long paths more than short ones; potentials **telescope**, so every $u\rightsquigarrow v$ path moves by the same $p[u]-p[v]$. No negative **cycle** allowed — step ① detects one and stops.

## 📝 How It Works
### 1. Why a Constant Shift Fails *(applied P1)*
- **The tempting repair** ➔ subtract the minimum weight $w_{\min}$ from every edge, run Dijkstra, add it back.
- **The flaw** ➔ a $k$-edge path moves by $k\lvert w_{\min}\rvert$ — the shift depends on **edge count**, so a many-edge shortest path is overtaken by a few-edge rival.
- **Counterexample recipe** ➔ a shortest path with **more edges** than an alternative ➔ worked below.

### 2. Potentials Make Every Edge Non-Negative *(applied P7a)*
- **Definition** ➔ $p[u]=d[u]$, the shortest distance to $u$ from a fixed source.
- **Claim** ➔ $w'(u,v)=p[u]-p[v]+w(u,v)\ge0$ for every edge $(u,v)$.
- **Proof $=$ the triangle inequality** ➔ $d[u]+w(u,v)\ge d[v]$, else $s\rightsquigarrow u\to v$ beats the shortest path to $v$ — contradiction. Subtract $d[v]$ from both sides. ∎

### 3. Computing Valid Potentials *(applied P7b)*
- **An arbitrary source almost works** ➔ a vertex it cannot reach gets $p=\infty$, and $w'$ becomes undefined.
- **Fix: the super source** ➔ add $q$ with a weight-$0$ edge to every vertex and run [[Bellman-Ford]] from $q$ ⟹ every $p[v]\le0$ is finite — the same move as [[Bellman-Ford]] §5.
- **Free safety check** ➔ that run's $\lvert V\rvert$-th pass reports any negative cycle ⟹ stop; no all-pair answer exists.

### 4. Reweighting Preserves Shortest Paths *(applied P7c)*
- **Telescoping** ➔ for a path $P=v_1\to v_2\to\dots\to v_k$:
$$
\begin{aligned}
w'(P) &= \sum_{i=1}^{k-1}\bigl(p[v_i]-p[v_{i+1}]+w(v_i,v_{i+1})\bigr) \\
&= p[v_1]-p[v_k]+w(P)
\end{aligned}
$$
- **Endpoint-only offset** ➔ $p[v_1]-p[v_k]$ is the same for **every** $v_1\rightsquigarrow v_k$ path, so the ranking of paths is unchanged ⟹ a shortest path under $w'$ is a shortest path under $w$. ∎
- **Undo** ➔ $d(u,v)=d'(u,v)-p[u]+p[v]$.

### 5. Assembling the Algorithm *(applied P7d)*
- **The pipeline** ➔ ① potentials by super source $+$ Bellman-Ford ② reweight every edge ③ Dijkstra from **every** vertex on $w'\ge0$ ④ undo the shift on each finite answer.
- **Bellman-Ford runs once, Dijkstra $V$ times** ➔ negative weights exist only before step ②; after it Dijkstra's precondition holds, so the expensive algorithm pays once and the cheap one does the repetition.

## ⚙️ Core Implementation
### 🔹 Johnson's all-pair shortest distance
> [!code]- Code
> ```python
> def johnson(n, edges):                        # vertices 0..n-1, edges (u, v, w)
>     # 1. potentials: super source q = n, weight-0 edge to every vertex      O(VE)
>     q = n
>     aug = edges + [(q, v, 0) for v in range(n)]
>     p, _ = bellman_ford(n + 1, aug, q)        # raises on a negative cycle
>
>     # 2. reweight: w' = p[u] - p[v] + w >= 0                                 O(E)
>     adj = [[] for _ in range(n)]
>     for (u, v, w) in edges:
>         adj[u].append((v, p[u] - p[v] + w))
>
>     # 3 + 4. Dijkstra from every vertex, then undo the shift              O(VE log V)
>     dist = [[INF] * n for _ in range(n)]
>     for u in range(n):
>         d_prime = dijkstra(adj, u)
>         for v in range(n):
>             if d_prime[v] != INF:
>                 dist[u][v] = d_prime[v] - p[u] + p[v]
>     return dist
> ```
> 💡 **Common Mistake:** **Returning $d'$** ➔ the reweighted distances are not the answer; every finite entry needs $-p[u]+p[v]$.

## ⚖️ Complexity
| Step | Time | Space |
| :--- | :--- | :--- |
| ① Bellman-Ford on $V+1$ vertices, $E+V$ edges | $O(V(E+V))=O(VE)$ *(connected)* | $\Theta(V)$ |
| ② Reweight | $O(E)$ | $\Theta(V+E)$ new adjacency list |
| ③ $V\times$ [[Dijkstra's Algorithm\|Dijkstra]] | $V\cdot O(E\log V)=O(VE\log V)$ | $\Theta(V)$ per run |
| ④ Undo | $O(V^{2})$ | $\Theta(V^{2})$ output |
| **Total** | $O(VE\log V)$ | $\Theta(V^{2})$ output $+$ $\Theta(V+E)$ auxiliary |

- **Sparse** $E=O(V)$ ➔ $O(V^{2})+O(V^{2}\log V)=O(V^{2}\log V)$ — the sheet's bound, beating [[Floyd-Warshall]]'s $\Theta(V^{3})$.
- **Dense** $E\approx V^{2}$ ➔ $O(V^{3}\log V)$ — loses to Floyd-Warshall; the all-pair selection rule lives in [[Floyd-Warshall]] §Decision Matrix.

## 📊 Exam Execution Trace & Applied Exercises
Applied P1 graph — $s\!\to\!a(-5)$, $a\!\to\!d(-3)$, $d\!\to\!b(-4)$, $s\!\to\!b(-4)$. True shortest $s\rightsquigarrow b$ is $s\to a\to d\to b=\mathbf{-12}$.

### Applied Exercise — the constant shift breaks it *(applied P1)*
$$
\begin{aligned}
w_{\min}=-5\ \Rightarrow&\ \ \text{add } 5:\ \ s\!\to\!a(0),\ a\!\to\!d(2),\ d\!\to\!b(1),\ s\!\to\!b(1) \\
\text{3-edge path:}&\ \ 0+2+1=3 \quad(\text{moved by } 3\times5=15) \\
\text{1-edge path:}&\ \ 1 \quad(\text{moved by only } 5) \\
\text{Dijkstra returns}&\ \ s\to b \ \Rightarrow\ 1-5=\mathbf{-4}\ne-12
\end{aligned}
$$
**Final Extracted Output:** wrong answer $-4$ — the shift penalised the 3-edge shortest path three times as hard as its 1-edge rival.

### Manual Execution Trace — potentials fix it *(same graph)*
Super source $q$ with weight-$0$ edges to $s,a,d,b$; Bellman-Ford from $q$, then reweight.

| Edge | $p[u]$ | $p[v]$ | $w$ | $w'=p[u]-p[v]+w$ |
| :--- | :--- | :--- | :--- | :--- |
| $s\to a$ | $0$ | $-5$ | $-5$ | $\mathbf{0}$ |
| $a\to d$ | $-5$ | $-8$ | $-3$ | $\mathbf{0}$ |
| $d\to b$ | $-8$ | $-12$ | $-4$ | $\mathbf{0}$ |
| $s\to b$ | $0$ | $-12$ | $-4$ | $\mathbf{8}$ |

**Final Extracted Output:** Dijkstra from $s$ takes $s\to a\to d\to b$ at $d'=0$ over the direct edge at $8$ ⟹ $d(s,b)=0-p[s]+p[b]=0-0+(-12)=\mathbf{-12}$ ✓.
- **Read the zeros** ➔ edges on the super source's shortest-path tree make the triangle inequality tight, so they reweight to exactly $0$; only slack edges stay positive.

## ⚠️ Common Mistakes
- 💡 **Shifting every edge by a constant** ➔ the shift scales with edge count (§1); only per-vertex potentials telescope.
- 💡 **Potentials from an ordinary source** ➔ unreachable vertices get $p=\infty$; use the weight-$0$ super source.
- 💡 **Quoting $O(V^{2}\log V)$ unconditionally** ➔ that is the **sparse** instantiation; the general bound is $O(VE\log V)$, and on a dense graph Floyd-Warshall wins.
- 💡 **"Johnson's handles negative cycles"** ➔ no all-pair answer exists then; step ① detects and reports, exactly as [[Bellman-Ford]] does.

## 🧠 Active Recall
> [!FAQ]- Adding a constant to every edge and adding $p[u]-p[v]$ to every edge both shift weights. Why does only one preserve shortest paths?
> > [!SUCCESS]- Answer
> > - **Short answer:** the potential shift depends only on a path's **endpoints**; the constant shift depends on its **number of edges**.
> > - **Why:** **Telescoping** ➔ $w'(P)=w(P)+p[v_1]-p[v_k]$, identical for every $v_1\rightsquigarrow v_k$ path, so the order of paths is preserved. **Constant shift** ➔ $w'(P)=w(P)+kc$ with $k$ varying by path, so few-edge paths gain ground ➔ applied P1's $s\to b$ beats $s\to a\to d\to b$ after the shift.

> [!FAQ]- Why is every reweighted edge $\ge0$, and why must the potentials come from a super source?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **triangle inequality** $d[u]+w(u,v)\ge d[v]$ rearranges to $w'(u,v)\ge0$; a super source makes every $d[v]$ finite.
> > - **Why:** **The inequality is a shortest-path optimality fact** ➔ if it failed, $s\rightsquigarrow u\to v$ would beat $d[v]$. **An ordinary source leaves gaps** ➔ an unreachable $v$ has $d[v]=\infty$ and $p[u]-p[v]$ is undefined. **Weight-$0$ edges from $q$ add no shortcut between real vertices** ➔ $q$ has no incoming edge, so it never sits inside an original $u\rightsquigarrow v$ path.

> [!FAQ]- Johnson's uses both Bellman-Ford and Dijkstra. Why that split, and what would $V$ Bellman-Fords cost instead?
> > [!SUCCESS]- Answer
> > - **Short answer:** Bellman-Ford is needed only while negative weights exist — once, for the potentials; afterwards Dijkstra is legal and cheaper per source. $V$ Bellman-Fords cost $O(V^{2}E)$.
> > - **Why:** **Pay the expensive algorithm once** ➔ $O(VE)$ buys non-negative $w'$. **Repeat the cheap one** ➔ $V\cdot O(E\log V)$. **The comparison** ➔ $O(VE\log V)$ vs $O(V^{2}E)$: the $\log V$ replaces a factor of $V$.
