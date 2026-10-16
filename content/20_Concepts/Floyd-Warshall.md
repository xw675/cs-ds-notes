---
unit: FIT2004
week: 8
source: [lecture, applied]
domain: A
parent: "[[Graph]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Floyd Warshall, Warshall's Algorithm, Transitive Closure, Reachability, All-Pair Shortest Distance, APSP]
---
# [[Floyd-Warshall]]

**Context:** [[FIT2004_MOC]] · **all-pair** shortest distance on an adjacency **matrix**, negative edges allowed — three nested loops that beat running [[Dijkstra's Algorithm|Dijkstra]] or [[Bellman-Ford]] from every vertex
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** for every intermediate vertex $k$ in turn, ask *"is $i\rightsquigarrow k\rightsquigarrow j$ cheaper than $i\rightsquigarrow j$?"* ➔ after all $\lvert V\rvert$ values of $k$, every entry is the true shortest distance.
> - **📦 Core Components:** **Warshall's** *(boolean, `or`/`and`)* ➔ transitive closure | **Floyd-Warshall** *(numeric, `min`/`+`)* ➔ distances | the **diagonal** ➔ negative-cycle certificate.
> - **⚡ Key Constraint:** $\Theta(V^{3})$ time and $\Theta(V^{2})$ space **unconditionally** — it never looks at $E$, so it is the wrong tool on a sparse graph and the right one on a dense one.

## 📝 How It Works
### 1. Warshall's Algorithm — Transitive Closure *(reachability)*
- **The object** ➔ given $G=(V,E)$, the **transitive closure** is $G'=(V,E')$: the **same vertices**, plus an edge $\langle u,v\rangle$ whenever a **path** $u\rightsquigarrow v$ exists in $G$.
- **The rule is transitivity** ➔ $A\to B$ and $B\to C$ therefore $A\to C$; on the boolean [[Graph Representations|adjacency matrix]] that reads $\texttt{m}[i][j]\ \texttt{and}\ \texttt{m}[j][k]\Rightarrow\texttt{m}[i][k]$.
- **One line of code** ➔ `m[i][j] = m[i][j] or (m[i][k] and m[k][j])` inside `for k / for i / for j`.
- **Answers the reachability question in $O(1)$ afterwards** ➔ the closure is a lookup table; building it once beats $V$ separate [[Uninformed Search (BFS and DFS)|traversals]] only when the graph is dense ($\Theta(V^{3})$ vs $\Theta(V(V+E))$).
- **Cost** ➔ time $\Theta(V^{3})$, space $\Theta(V^{2})$ for the matrix.

### 2. Floyd-Warshall — the Same Loop, With Distances
- **The upgrade** ➔ replace the boolean semiring $(\texttt{or},\texttt{and})$ with the arithmetic one $(\min,+)$: `m[i][j] = min(m[i][j], m[i][k] + m[k][j])`.
- **The transitivity becomes an inequality** ➔ $\text{dist}(A\rightsquigarrow B)+\text{dist}(B\rightsquigarrow C)$ is *a* cost of $A\rightsquigarrow C$; taking the $\min$ over every intermediate $B$ makes it *the* shortest.
- **Doing it for every $\langle i,j\rangle$ gives all pairs** ➔ the matrix is the output, so there is no source vertex and no per-source rerun.
- **Initialisation, in three moves** ➔ ①  diagonal $\text{m}[u][u]=0$ *(itself back to itself costs nothing)* ②  every edge $\langle u,v,w\rangle$ written as $\text{m}[u][v]=w$ ③  **$\infty$ for every non-edge**.
- **Negative edges are fine** ➔ nothing is finalised and nothing is compared for "closest", so [[Dijkstra's Algorithm|Dijkstra]]'s precondition never applies.

### 3. Why $k$ Must Be the OUTER Loop *(the DP layering — LO1)*
- **The subproblem** ➔ after the $k$-th outer iteration, $\text{m}[i][j]$ is the shortest $i\rightsquigarrow j$ walk whose **intermediate** vertices all come from $\{1,\dots,k\}$. The endpoints are unrestricted.
- **The recurrence** ➔ $\text{dist}^{(k)}[i][j]=\min\bigl(\text{dist}^{(k-1)}[i][j],\ \text{dist}^{(k-1)}[i][k]+\text{dist}^{(k-1)}[k][j]\bigr)$ — either the new intermediate $k$ helps, or it does not.
- **The lecture's phrasing** ➔ *"as we increment, we find the minimum distance going through vertex $k$; thus we would have the minimum through every vertex, updating as needed."*
- **This is [[Dynamic Programming]]** ➔ optimal substructure over a **growing set of permitted intermediates**, $V^{3}$ subproblems at $O(1)$ each ⟹ $\Theta(V^{3})$ falls straight out of the MEMO-sizing rule.
- **In-place is safe** ➔ row $k$ and column $k$ cannot change during iteration $k$ *(using $k$ as its own intermediate adds $0$)*, so one $V\times V$ matrix suffices instead of $\lvert V\rvert+1$ of them.

### 4. Negative-Cycle Detection — Read the Diagonal
- **The test** ➔ after the run, **any** $\text{m}[u][u]<0$ means a negative cycle exists. The diagonal is *"vertex $u$ back to vertex $u$"*, so a negative entry is literally a negative closed walk.
- **Stronger than [[Bellman-Ford]]'s** ➔ Bellman-Ford only sees cycles **reachable from its source**; Floyd-Warshall considers every vertex as a start, so it finds **any** negative cycle in the graph.
- **What to report** ➔ distances through a negative cycle are $-\infty$, not numbers; state that no shortest distance exists for those pairs rather than handing over the matrix.
- **The $-\infty$ post-process** *(applied P5)* ➔ for every $k$ with $\text{m}[k][k]<0$, set $\text{m}[u][v]=-\infty$ for every pair with $\text{m}[u][k]<\infty$ and $\text{m}[k][v]<\infty$ — $u$ reaches the cycle and the cycle reaches $v$ ⟹ one more triple loop, $O(V^{3})$, bound unchanged.
- **Contamination is wider than the diagonal** ➔ one flagged $k$ can send most of the matrix to $-\infty$, so a single negative diagonal entry invalidates far more than one cell.

### 5. Reading the Path Out, Not Just the Distance *(applied P4)*
- **Distances alone are not paths** ➔ keep a second $V\times V$ matrix, written **only** when the `min` takes the $u\to k\to v$ branch ⟹ still $\Theta(V^{3})$ time and $\Theta(V^{2})$ space.
- **`succ` — the sheet's preferred form** ➔ $\text{succ}[u][v]=$ the first vertex after $u$ on a shortest $u\rightsquigarrow v$. Init $\text{succ}[u][v]=v$ for every edge; on an update $\text{succ}[u][v]=\text{succ}[u][k]$ *(the first step towards $v$ is now the first step towards $k$)*. Rebuild by `u = succ[u][v]` until $u=v$ ⟹ $O(\ell)$ with plain appends.
- **`mid` — divide and conquer** ➔ on an update $\text{mid}[u][v]=k$; rebuild as path$(u,\text{mid})$ $+$ path$(\text{mid},v)$, dropping the duplicated middle vertex. $O(\ell)$ **only if** concatenation is $O(1)$ ⟹ linked lists.
- **`pred` — the mirror of `succ`** ➔ $\text{pred}[u][v]=\text{pred}[k][v]$, walked backwards from $v$ and reversed — the same move as [[Dijkstra's Algorithm|Dijkstra]]'s `v.previous`, one dimension wider.

## ⚙️ Core Implementation
### 🔹 Warshall's transitive closure
> [!code]- Code
> ```python
> # matrix[i][j] is True iff edge <i,j> exists; becomes True iff a PATH exists
> for k in range(count_vertex):
>     for i in range(count_vertex):
>         for j in range(count_vertex):
>             matrix[i][j] = matrix[i][j] or (matrix[i][k] and matrix[k][j])
> ```
> 💡 **Common Mistake:** **Writing the loops as `i, j, k`** ➔ the semantics live in the outer loop: $k$ is the *newly permitted intermediate*, and $i,j$ sweep every pair against it. Any other nesting computes paths of bounded length, not the closure, and one pass will not converge.

### 🔹 Floyd-Warshall all-pair shortest distance
> [!code]- Code
> ```python
> # init: matrix[u][u] = 0; matrix[u][v] = w and succ[u][v] = v for every edge; INF / None elsewhere
> for k in range(count_vertex):
>     for i in range(count_vertex):
>         for j in range(count_vertex):
>             if matrix[i][k] + matrix[k][j] < matrix[i][j]:
>                 matrix[i][j] = matrix[i][k] + matrix[k][j]
>                 succ[i][j]   = succ[i][k]          # first hop towards j = first hop towards k
>
> for u in range(count_vertex):
>     if matrix[u][u] < 0:
>         error("Graph contains a negative-weight cycle")
> ```
> 💡 **Common Mistake:** **Forgetting to zero the diagonal** ➔ leaving $\text{m}[u][u]=\infty$ makes the negative-cycle test unreachable and lets $\infty$ leak into sums; the diagonal is both an initial value **and** the output certificate.
> 💡 **Common Mistake:** **$\infty$ as a large integer** ➔ $\infty+\infty$ overflows or, worse, becomes a plausible finite distance. Guard the addition or use a genuine $\infty$ sentinel.

### 🔹 Path rebuild from `succ` *(applied P4)*
> [!code]- Code
> ```python
> def get_path(succ, u, v):                       # assumes matrix[u][v] < INF
>     path = [u]
>     while u != v:
>         u = succ[u][v]
>         path.append(u)
>     return path                                 # O(l) for a path of l edges
> ```
> 💡 **Common Mistake:** **Not initialising `succ[u][v] = v` per edge** ➔ a pair never improved through an intermediate keeps `None`, and every rebuild that should end on a direct edge crashes.

### 🔹 $-\infty$ post-process *(applied P5 — in place of the error, when the matrix is wanted)*
> [!code]- Code
> ```python
> for k in range(count_vertex):
>     if matrix[k][k] < 0:                        # k lies on a negative cycle
>         for u in range(count_vertex):
>             for v in range(count_vertex):
>                 if matrix[u][k] < INF and matrix[k][v] < INF:   # u reaches k, k reaches v
>                     matrix[u][v] = -INF
> ```

## ⚖️ Complexity
Adjacency **matrix** (mandatory — the algorithm indexes $\text{m}[i][k]$ in $O(1)$).

| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best $=$ Average $=$ Worst | $\Theta(V^{3})$ | $\Theta(V^{2})$ | three fixed nested loops — **no input-dependent branching**, so there is no bad case, only a big $V$ |
| Warshall's closure | $\Theta(V^{3})$ | $\Theta(V^{2})$ | identical loop, boolean payload |
| With path reconstruction | $\Theta(V^{3})$ | $\Theta(V^{2})$ | a second matrix is the same order |
| With $-\infty$ post-process | $\Theta(V^{3})$ | $\Theta(V^{2})$ | one more triple loop, only for flagged $k$ |

- **Derivation** ➔ $V\times V\times V$ iterations $\times$ $O(1)$ work $=\Theta(V^{3})$; init is $\Theta(V^{2})$ and the diagonal check $\Theta(V)$, both dominated.
- **The matrix is INPUT, the answer is OUTPUT** ➔ if the graph arrives as a matrix, the $\Theta(V^{2})$ is input space; a list-to-matrix conversion makes it auxiliary ([[Algorithmic Complexity]] §6). Say which you are counting.
- **$E$ never appears** ➔ a sparse graph costs exactly as much as a complete one, which is the whole selection rule below.

## ⚖️ Core Decision Matrix
| Requirement | Reach for | Cost | Negative edges? |
| :--- | :--- | :--- | :--- |
| Reachability, all pairs, dense | **Warshall's closure** | $\Theta(V^{3})$ | n/a |
| Reachability, all pairs, sparse | [[Uninformed Search (BFS and DFS)\|BFS/DFS]] from every vertex | $\Theta(V(V+E))$ | n/a |
| APSP, **dense** graph | **Floyd-Warshall** | $\Theta(V^{3})$ | ✅ (no negative *cycle*) |
| APSP, **sparse**, all $w\ge0$ | $V\times$ [[Dijkstra's Algorithm\|Dijkstra]] | $O(EV\log V)=O(V^{3}\log V)$ dense | ❌ |
| APSP, sparse, some $w<0$ | [[Johnson's Algorithm\|Johnson's]] *(applied)* | $O(VE\log V)$ | ✅ (no negative *cycle*) |
| Single source only | [[Dijkstra's Algorithm\|Dijkstra]] / [[Bellman-Ford]] | $O(E\log V)$ / $\Theta(VE)$ | — |
| Any negative cycle **anywhere** | **Floyd-Warshall** diagonal | $\Theta(V^{3})$ | that is the point |

> [!NOTE] **When It Flips:** the hinge is **density**, not weight sign. $V$ Dijkstras cost $O(EV\log V)$ — directly when $w\ge0$, after [[Johnson's Algorithm|Johnson's]] reweighting when some $w<0$ — and beat $\Theta(V^{3})$ exactly while $E\log V\lll V^{2}$, i.e. on a **sparse** graph. Once $E\approx V^{2}$, the lecture's comparison $\Theta(V^{3})<O(V^{3}\log V)<O(V^{4})$ makes Floyd-Warshall the outright winner.

## 📊 Exam Execution Trace & Applied Exercises
Lecture graph — $A\!\to\!C(-2)$, $C\!\to\!D(2)$, $D\!\to\!B(-1)$, $B\!\to\!A(4)$, $B\!\to\!C(3)$. Vertex order $A,B,C,D$.

**Initial matrix** *(diagonal $0$ · edges written in · $\infty$ elsewhere)*

| | $A$ | $B$ | $C$ | $D$ |
| :--- | :--- | :--- | :--- | :--- |
| $A$ | $0$ | $\infty$ | $-2$ | $\infty$ |
| $B$ | $4$ | $0$ | $3$ | $\infty$ |
| $C$ | $\infty$ | $\infty$ | $0$ | $2$ |
| $D$ | $\infty$ | $-1$ | $\infty$ | $0$ |

### Manual Execution Trace
Only cells that actually change are listed; every other cell survives the round unchanged.

| $k$ *(new intermediate)* | Cell | Old | New | Arithmetic |
| :--- | :--- | :--- | :--- | :--- |
| $A$ | $[B][C]$ | $3$ | $\mathbf{2}$ | $B\!\to\!A(4)+A\!\to\!C(-2)$ |
| $B$ | $[D][A]$ | $\infty$ | $\mathbf{3}$ | $D\!\to\!B(-1)+B\!\to\!A(4)$ |
| $B$ | $[D][C]$ | $\infty$ | $\mathbf{1}$ | $D\!\to\!B(-1)+B\rightsquigarrow C(2)$ |
| $C$ | $[A][D]$ | $\infty$ | $\mathbf{0}$ | $A\!\to\!C(-2)+C\!\to\!D(2)$ |
| $C$ | $[B][D]$ | $\infty$ | $\mathbf{4}$ | $B\rightsquigarrow C(2)+C\!\to\!D(2)$ |
| $D$ | $[A][B]$ | $\infty$ | $\mathbf{-1}$ | $A\rightsquigarrow D(0)+D\!\to\!B(-1)$ |
| $D$ | $[C][A]$ | $\infty$ | $\mathbf{5}$ | $C\!\to\!D(2)+D\rightsquigarrow A(3)$ |
| $D$ | $[C][B]$ | $\infty$ | $\mathbf{1}$ | $C\!\to\!D(2)+D\!\to\!B(-1)$ |

**Final Extracted Output**

| | $A$ | $B$ | $C$ | $D$ |
| :--- | :--- | :--- | :--- | :--- |
| $A$ | $\mathbf{0}$ | $-1$ | $-2$ | $0$ |
| $B$ | $4$ | $\mathbf{0}$ | $2$ | $4$ |
| $C$ | $5$ | $1$ | $\mathbf{0}$ | $2$ |
| $D$ | $3$ | $-1$ | $1$ | $\mathbf{0}$ |

- **Diagonal all $0$** ⟹ **no negative cycle**; independently, the only cycle $A\!\to\!C\!\to\!D\!\to\!B\!\to\!A$ weighs $-2+2-1+4=3>0$.
- **Every entry is finite** ⟹ the transitive closure of this digraph is the **complete** graph on $\{A,B,C,D\}$ — Warshall's on the same input returns all-`True`.
- **Read the trap** ➔ $[D][C]=1$ uses the **already-updated** $[B][C]=2$, not the original $3$. In-place updating is correct here *(§3)*, but you must carry the current matrix forward, not the initial one.
- **Read the layering** ➔ the round in which a cell first becomes finite is the round that admits the last intermediate its route needs; $[C][A]=5$ waits for $k=D$ because its route is $C\!\to\!D\!\to\!B\!\to\!A$.

### Applied Exercise — price the three all-pair routes *(lecture comparison)*
**Problem:** rank the three ways to get all-pair shortest distances on a **dense** graph.
$$
\begin{aligned}
V\times\text{[[Dijkstra's Algorithm|Dijkstra]]} &= O(V)\cdot O(E\log V)=O(EV\log V)=O(V^{3}\log V) \\
V\times\text{[[Bellman-Ford]]} &= O(V)\cdot O(VE)=O(V^{2}E)=O(V^{4}) \\
\text{Floyd-Warshall} &= \Theta(V^{3})
\end{aligned}
$$
**Final Extracted Output:** $\Theta(V^{3})<O(V^{3}\log V)<O(V^{4})$ ⟹ Floyd-Warshall wins on a dense graph. On a **sparse** graph the ranking inverts: $V$ Dijkstras win for $w\ge0$, and applied P7's [[Johnson's Algorithm|Johnson's]] extends the same $O(VE\log V)$ to negative edges.

### Applied Exercise — detect arbitrage *(applied P6)*
**Problem:** $n$ currencies; $r(a,b)=$ units of $a$ spent to get $1$ unit of $b$. Decide in $O(n^{3})$ whether some chain of conversions makes a profit.
$$
\begin{aligned}
\text{Model:}&\ \ \text{a vertex per currency, edge } a\to b \text{ with rate } r(a,b)\\
\text{A cycle costs:}&\ \ r_1r_2\cdots r_k \text{ per unit returned} \ \Rightarrow\ \text{profit} \iff r_1r_2\cdots r_k<1\\
\text{Take logs:}&\ \ \log(r_1\cdots r_k)=\textstyle\sum_i\log r_i,\qquad \log r<0\iff r<1\\
\text{Hence:}&\ \ \text{arbitrage}\iff\text{a negative cycle under } w=\log r\iff\exists u:\ \text{m}[u][u]<0
\end{aligned}
$$
**Final Extracted Output:** run plain Floyd-Warshall on $\log$ rates and read the diagonal, $\Theta(n^{3})$. **Alternative** ➔ keep the raw rates and swap $(\min,+)$ for $(\min,\times)$; arbitrage iff a diagonal entry is $<1$.
- **The modelling move** ➔ a product objective becomes a sum under $\log$, so a shortest-path algorithm runs unmodified — transform the input, not the algorithm.

## ⚠️ Common Mistakes
- 💡 **Nesting the loops `i, j, k`** ➔ the outer loop is the *set of permitted intermediates*; any other order breaks the DP layering and needs repeated passes to converge.
- 💡 **"Floyd-Warshall handles negative cycles"** ➔ it **detects** them, on the diagonal. Distances through a negative cycle are $-\infty$, not numbers.
- 💡 **Using it on a sparse graph** ➔ $\Theta(V^{3})$ is paid even when $E=O(V)$; the selection rule is **density**, and quoting it without naming the density is an LO3 mark loss ([[Graph]] §3) **· sparse with negatives:** [[Johnson's Algorithm|Johnson's]].
- 💡 **Quoting $\Theta(V^{2})$ for the time** ➔ that is the **space**. Three loops, $\Theta(V^{3})$ time, $\Theta(V^{2})$ space — state both, and say the matrix may be input rather than auxiliary.
- 💡 **Confusing closure with connectivity** ➔ the transitive closure is a **directed reachability** relation; $u\rightsquigarrow v$ does not give $v\rightsquigarrow u$ unless the graph is undirected.

## 🧠 Active Recall
> [!FAQ]- Warshall's and Floyd-Warshall are the same three loops. State every difference, and what each buys.
> > [!SUCCESS]- Answer
> > - **Short answer:** the payload only — boolean $(\texttt{or},\texttt{and})$ for **reachability**, numeric $(\min,+)$ for **distance**; both $\Theta(V^{3})$ time and $\Theta(V^{2})$ space.
> > - **Why:** **Transitivity and the triangle inequality are the same statement in two semirings** ➔ *"a path $i\to k$ and a path $k\to j$ give a path $i\to j$"* becomes *"the cost $i\to k$ plus the cost $k\to j$ is a candidate cost for $i\to j$"*. **The extra work is initialisation** ➔ booleans start `False` off-diagonal; distances start $\infty$ off-diagonal with the actual weights written in and the diagonal zeroed. **Floyd-Warshall gains an output the closure has no analogue for** ➔ the diagonal doubles as the negative-cycle certificate.

> [!FAQ]- All pairs, negative edges, no negative cycle, $\lvert V\rvert=2000$, $\lvert E\rvert=4000$. Which algorithm, and defend the choice against Floyd-Warshall.
> - **Hint:** compute every candidate's number before answering.
> > [!SUCCESS]- Answer
> > - **Short answer:** [[Johnson's Algorithm|Johnson's]] — $O(VE\log V)\approx2000\cdot4000\cdot11\approx9\times10^{7}$ vs Floyd-Warshall's $\Theta(V^{3})=8\times10^{9}$.
> > - **Why:** **Negative edges bar plain Dijkstra, not reweighted Dijkstra** ➔ one [[Bellman-Ford]] from a super source ($VE=8\times10^{6}$) gives potentials that make every weight $\ge0$, after which $V$ Dijkstras are legal. **$V\times$ Bellman-Ford is the wrong repetition** ➔ $O(V^{2}E)=1.6\times10^{13}$, because its own bound already carries a factor $V$. **State the rule, not the instance** ➔ all pairs: sparse ⟹ $V$ Dijkstras (via Johnson's if any $w<0$); dense ⟹ Floyd-Warshall.

> [!FAQ]- After the run, $\text{m}[C][C]=-4$. What has happened, what do you report, and which cells can you still trust?
> > [!SUCCESS]- Answer
> > - **Short answer:** a **negative cycle through $C$** exists; report that no shortest distance is defined, and trust no cell whose optimal route can reach the cycle.
> > - **Why:** **The diagonal is $u\rightsquigarrow u$** ➔ a negative entry is a closed walk of negative weight, and repeating it drives the cost to $-\infty$. **Contamination spreads** ➔ every pair $\langle i,j\rangle$ with $i\rightsquigarrow C$ and $C\rightsquigarrow j$ is also $-\infty$, so a single flagged vertex can invalidate most of the matrix. **This is the strength over [[Bellman-Ford]]** ➔ Bellman-Ford only detects cycles reachable from **its** source; Floyd-Warshall treats every vertex as a source, so it finds a negative cycle anywhere in $G$. **Repair** ➔ the §4 post-process writes $-\infty$ into exactly those cells in $O(V^{3})$.
