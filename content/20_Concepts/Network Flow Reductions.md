---
unit: FIT2004
week: [11, 12]
source: [lecture, applied]
domain: A
parent: "[[Ford-Fulkerson Method]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Max-Flow Reductions, Bipartite Matching, Maximum Bipartite Matching, Super Sink, Vertex Capacities, Edge-Disjoint Paths, Vertex-Disjoint Paths, Min-Cut Partition, Minimum Path Cover, Project Selection, Image Segmentation]
---
# [[Network Flow Reductions]]

**Context:** [[FIT2004_MOC]] · the W11 applied sheet $+$ the lecture's matching agency $+$ the W12 applied matching and min-cut drills — **LO1**: transform the input so stock [[Ford-Fulkerson Method|Ford-Fulkerson]] answers a new problem · the flow-world sibling of [[State-Space Graph Modelling]]
**Parent Framework:** [[Ford-Fulkerson Method]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build a network whose **max flow** (or **min cut**) is the answer ➔ run FF unmodified ➔ read the answer off the flow value, the middle-edge flows, or the cut sides.
> - **📦 Core Components:** super source/sink | vertex split | bipartite $s\to L\to R\to t$ with quotas (incl. DAG path cover) | unit capacities $=$ disjoint paths | min cut $=$ cheapest two-way split, $\infty$ edges as hard constraints · lower bounds and fixed demands ➔ [[Circulation with Demands and Lower Bounds]].
> - **⚡ Key Constraint:** every answer owes **three** things — the construction (vertices, edges, capacities), why max flow $\iff$ the answer, and the read-off rule. Never modify FF: "reduce the problem by transforming the input" (applied footnote).

## 📝 How It Works
### 1. Many Sources or Sinks — Super Source and Super Sink *(applied P2)*
- **Construction** ➔ new $s^{*}$ with an edge to each source $s_i$, capacity $=$ total out-capacity of $s_i$ · new $t^{*}$ with an edge from each sink $t_j$, capacity $=$ total in-capacity of $t_j$ ➔ FF from $s^{*}$ to $t^{*}$.
- **Why the capacities** ➔ big enough never to bind, so they add no constraint that the original problem lacked.
- **Contrast with BFS** ➔ the BFS super source shifts distances by $1$ ([[State-Space Graph Modelling]] §5); here nothing shifts — the flow value is unchanged.

### 2. Vertex Capacities — Split Every Vertex *(applied P5)*
- **Construction** ➔ each $v\notin\{s,t\}$ becomes $v_{in}\to v_{out}$ with capacity $c(v)$ · every edge into $v$ now enters $v_{in}$, every edge out of $v$ leaves $v_{out}$ · delete $v$.
- **Why** ➔ all flow through $v$ must cross the single edge $v_{in}\to v_{out}$, so the vertex limit becomes an edge limit FF already enforces.

### 3. Bipartite Matching and Quota Assignment *(lecture · applied P3, P7)*
- **Matching agency (lecture)** ➔ men $L$, women $R$, a preference is an edge $\ell\to r$ of capacity $1$ · $s\to\ell$ capacity $1$, $r\to t$ capacity $1$ ➔ **max flow $=$ max number of matches** · matched pairs $=$ middle edges carrying $1$.
- **Why FF beats greedy** ➔ a greedy pairing stalls at $2$ on the lecture example where $3$ is possible; a backward edge re-assigns an earlier match to free a partner.
- **Quotas** ➔ the source edge's capacity is how many matches that vertex may take ("if Zach pays more" ⟹ $s\to\text{Zach}=4$) · in general $s\to\ell=$ supply, $r\to t=$ demand, $\ell\to r=$ how many times that pair may be used.
- **$0/1$ matrix with row sums $r_i$, column sums $c_j$ (P3)** ➔ $s\to a_i$ cap $r_i$ · $a_i\to b_j$ cap $1$ · $b_j\to t$ cap $c_j$ ➔ feasible $\iff$ max flow $=\sum r_i$ (every source edge saturated) ➔ $X_{ij}=f(a_i,b_j)$.
- **Radio songs (P7)** ➔ eras $\to$ genres, $s\to\text{era}_i$ cap $e_i$, $\text{era}_i\to\text{genre}_j$ cap $=$ number of distinct songs in that pair, $\text{genre}_j\to t$ cap $g_j$ ➔ feasible $\iff$ max flow $=\sum e_i$ ➔ $f(\text{era}_i,\text{genre}_j)=$ how many songs to pick from that pair.
- **Integrality is load-bearing** ➔ FF on integer capacities returns an integer flow on every edge ([[Ford-Fulkerson Method]] §5), so a middle edge carries exactly $0$ or $1$ — a valid matrix entry or match, never a fraction.
- **Circulation with demands** *(applied P3 aside, taught in W12)* ➔ $a_i$ demand $-r_i$, $b_j$ demand $c_j$, no $s$/$t$; the $s$/$t$ construction above is exactly that problem's reduction ➔ [[Circulation with Demands and Lower Bounds]] §2.
- **Minimum path cover of a DAG** *(W12 applied P2)* ➔ cover every vertex with vertex-disjoint paths (single-vertex paths allowed), as few as possible.
	- **Construction** ➔ two copies of $V$, $u_L$ left and $u_R$ right · DAG edge $u\to v$ ⟹ $u_L\to v_R$ · maximum bipartite matching $M$ by flow.
	- **Answer** ➔ minimum paths $=\lvert V\rvert-\lvert M\rvert$.
	- **Why** ➔ matching $u_L$ to $v_R$ $=$ choosing $v$ as $u$'s **successor** · capacity $1$ on both sides ⟹ $\le1$ successor and $\le1$ predecessor per vertex ⟹ the chosen edges form disjoint paths · unmatched $u_L$ $=$ a path **end**, unmatched $v_R$ $=$ a path **start** ⟹ paths $=$ ends $=\lvert V\rvert-\lvert M\rvert$, minimised by maximising $\lvert M\rvert$.

### 4. Disjoint Paths — Unit Capacities *(applied P6)*
- **Edge-disjoint** ➔ every edge capacity $1$ ➔ max flow $=$ maximum number of edge-disjoint $s$–$t$ paths.
- **Both directions** ➔ $k$ disjoint paths ⟹ send $1$ along each ⟹ a flow of $k$ · an integral flow of $k$ on unit edges ⟹ trace $k$ paths from $s$, each using its own saturated edges · a vertex carries at most $\min(\text{indeg}(v),\text{outdeg}(v))$ paths, matching its flow limit.
- **Vertex-disjoint (P6c)** ➔ add vertex capacity $1$ to every $v\notin\{s,t\}$, then split as in §2 — without the split a vertex still carries as many paths as its degree allows.

### 5. Min Cut as a Cheapest Two-Way Split *(W11 applied P4 · W12 applied P3, P5)*
- **Problem** ➔ each job runs on computer $1$ or $2$ at known costs; related pairs on different computers pay a penalty ➔ minimise total cost.
- **Construction** ➔ $s\to j$ cap $=$ cost on computer $1$ · $j\to t$ cap $=$ cost on computer $2$ · each related pair gets **two** edges $i\to k$ and $k\to i$, cap $=$ penalty.
- **Why min cut $=$ min cost** ➔ every $s$–$t$ cut puts each job on one side and pays: $j\in T$ cuts $s\to j$ (cost $1$) · $j\in S$ cuts $j\to t$ (cost $2$) · a related pair split across the cut cuts exactly one of its two edges (the $S\to T$ one) ⟹ penalty paid once.
- **Read-off — reversed** ➔ $S$ side ⟹ **computer 2**, $T$ side ⟹ **computer 1** · minimum cost $=$ max flow value · the sides come from residual reachability ([[Min-Cut Max-Flow Theorem]] §5).
- **Why two opposite edges** ➔ one edge $i\to k$ only charges when $i\in S$, $k\in T$; the reverse split would be free.
- **$\infty$ edge $=$ hard constraint** ➔ an edge $u\to v$ of capacity $\infty$ never crosses $S\to T$ in a finite min cut ⟹ "$u$ chosen ⟹ $v$ chosen" · $s\to v$ of $\infty$ pins $v$ to $S$.
- **Project selection (W12 P3)** ➔ $s\to x$ cap $p$ for profit $p>0$ · $x\to t$ cap $p$ for profit $-p$ · $x\to y$ cap $\infty$ when $y$ is a prerequisite of $x$.
	- **Read-off** ➔ $S$ side $=$ projects **done**, $T$ side $=$ skipped · a profitable $x\in S$ drags every prerequisite into $S$ through the $\infty$ edges.
	- **What the cut pays** ➔ $c(S,T)=$ cost of unprofitable projects forced into $S$ (their $x\to t$) $+$ profit given up on profitable projects left in $T$ (their $s\to x$).
	- **Answer** ➔ max profit $=\sum_{p_x>0}p_x-c(S,T)$ with $c(S,T)$ the **min** cut.
- **Land fencing / segmentation (W12 P5)** ➔ $S$ $=$ cells ending as ground, $T$ $=$ cells ending as holes · $s\to$ boundary cell cap $\infty$ (may never become a hole) · $s\to$ other ground cell cap $c_{\text{dig}}$ · hole $\to t$ cap $c_{\text{fill}}$ · each adjacent pair gets **two** opposite edges cap $c_{\text{fence}}$ ➔ minimum cost $=$ min cut $=$ max flow.
	- **Why no double count** ➔ a separated pair has exactly one of its two edges going $S\to T$, and a cut's capacity counts only those.
	- **Same shape as the job split** ➔ two terminal costs per item $+$ a penalty per separated neighbour pair — the lecture's "image segmentation" application.

## ⚖️ Complexity
FF costs $O(F\cdot E')$ on the built network; the construction is $O(V'+E')$.

| Construction | $V'$ | $E'$ | Bound on $F$ | Total |
| :--- | :--- | :--- | :--- | :--- |
| Super source/sink | $V+2$ | $E+\#$sources$+\#$sinks | unchanged | $O(FE')$ |
| Vertex split | $2V-2$ | $E+V-2$ | unchanged | $O(FE)$ |
| Matching, $L\times R$ | $L+R+2$ | $E+L+R$ | $\min(L,R)$ | $O(\min(L,R)\cdot E')=O(VE)$ |
| $0/1$ matrix $n\times m$ | $n+m+2$ | $nm+n+m$ | $\sum r_i\le nm$ | $O(\sum r_i\cdot nm)$ |
| Edge-disjoint paths | $V$ | $E$ | $\text{outdeg}(s)\le V-1$ | $O(E\cdot\text{outdeg}(s))=O(VE)$ |
| Job split, $n$ jobs, $p$ pairs | $n+2$ | $2n+2p$ | $\sum\text{cost}_1$ (cut $\{s\}$) | $O(F(n+p))$, pseudo-polynomial |
| DAG path cover | $2V+2$ | $E+2V$ | $\lvert M\rvert\le V$ | $O(V(V+E))$ |
| Project selection, $n$ projects, $q$ prerequisites | $n+2$ | $n+q$ | $\sum_{p_x>0}p_x$ (cut $\{s\}$) | $O(F(n+q))$, pseudo-polynomial |
| Fencing, $n\times m$ grid | $nm+2$ | $\le5nm$ | $\#\text{holes}\cdot c_{\text{fill}}$ (cut $\{t\}$) | $O(F\cdot nm)$, pseudo-polynomial |

## ⚖️ Core Decision Matrix
| Cue in the question | Construction | Answer read-off |
| :--- | :--- | :--- |
| "several sources / sinks" | super $s^{*}$, $t^{*}$ (§1) | flow value |
| "each node can handle at most $k$" | split $v_{in}\to v_{out}$ cap $k$ (§2) | flow value |
| "pair items from two groups, each used once / $q$ times" | $s\to L\to R\to t$, quotas on the outer edges (§3) | middle edges with flow |
| "exactly $r_i$ per row / $e_i$ per category" | outer edges $=$ quotas (§3) | feasible $\iff$ $\lvert f\rvert=\sum$ quotas |
| "paths sharing no edge / no vertex" | unit capacities, split for vertices (§4) | flow value $=$ path count |
| "assign each item to one of two options, penalty when related items split" | $s\to j$, $j\to t$, paired penalty edges (§5) | min cut sides, value $=$ cost |
| "choose a subset for max profit, prerequisites must hold" | profits from $s$, costs to $t$, $\infty$ prerequisite edges (§5) | $S$ side; profit $=\sum p^{+}-$ min cut |
| "fewest vertex-disjoint paths covering a DAG" | $u_L\to v_R$ per edge, matching (§3) | $\lvert V\rvert-\lvert M\rvert$ |
| "at least $\ell$" on a link, or fixed supplies and needs | [[Circulation with Demands and Lower Bounds]] | feasible $\iff$ super-edges saturated |

> [!NOTE] **When It Flips:** the question asks **how much / how many** ⟹ read the max-flow **value** · asks **which assignment** ⟹ read the **edge flows** · asks **which side / which option** ⟹ read the **min cut**.

## 📊 Exam Execution Trace & Applied Exercises
### Applied Exercise — $0/1$ matrix, feasible and infeasible
**Problem:** (i) $r=(2,1)$, $c=(1,1,1)$ · (ii) $r=(2,0)$, $c=(2,0)$. Decide each by max flow.
$$
\begin{aligned}
\text{(i) } & s\to a_1\to b_1\to t,\ \ s\to a_1\to b_2\to t,\ \ s\to a_2\to b_3\to t \ \Rightarrow\ \lvert f\rvert=3=\textstyle\sum r_i\\
& X=\begin{pmatrix}1&1&0\\0&0&1\end{pmatrix}\\
\text{(ii) } & b_1 \text{ is fed only by } a_1\to b_1\ (\text{cap } 1) \text{ and } a_2\ (r_2=0) \Rightarrow \lvert f\rvert=1<2=\textstyle\sum r_i
\end{aligned}
$$
**Final Extracted Output:** (i) feasible, matrix read off the middle edges · (ii) infeasible — column $1$ needs two $1$s but only row $1$ has any, and a cell holds at most one $1$; the unsaturated $s\to a_1$ is the evidence.

## ⚠️ Common Mistakes
- 💡 **Stopping at "run max flow"** ➔ feasibility questions need the test "$\lvert f\rvert=\sum$ quotas" and the read-off; without them the answer earns half.
- 💡 **Job allocation sides swapped** ➔ $S$ side runs on computer **2**: a job in $S$ pays through its $j\to t$ edge.
- 💡 **One edge per related pair** ➔ penalties then charge only one direction of split; use two opposite edges.
- 💡 **Vertex-disjoint without the split** ➔ unit edge capacities alone still let several paths share a vertex.
- 💡 **Project selection: min cut reported as the profit** ➔ the cut is what you **lose**; profit $=\sum_{p_x>0}p_x-c(S,T)$.
- 💡 **Prerequisite edge reversed** ➔ "$y$ is a prerequisite of $x$" is $x\to y$ (doing $x$ forces $y$), never $y\to x$.

## 🧠 Active Recall
> [!FAQ]- Why does the matching / $0/1$-matrix reduction need FF's integrality, and what goes wrong without it?
> > [!SUCCESS]- Answer
> > - **Short answer:** the answer is read off individual edge flows, which must be $0$ or $1$; FF on integer capacities guarantees integer flows.
> > - **Why:** **A max flow value alone is not a matrix** ➔ $X_{ij}=f(a_i,b_j)$ needs each middle edge to carry a whole unit. **Integer capacities ⟹ integer bottlenecks ⟹ integer flows** ➔ every augment adds a whole number, so every edge stays integral ([[Ford-Fulkerson Method]] §5). **A fractional flow** ➔ of the same value could split $\tfrac12$ across two cells and correspond to no $0/1$ matrix.

> [!FAQ]- How many edge-disjoint $s$–$t$ paths, and in what time? (applied P6)
> - **Hint:** what caps the flow out of $s$?
> > [!SUCCESS]- Answer
> > - **Short answer:** unit capacities, max flow $=$ path count, $O(E\cdot\text{outdeg}(s))\subseteq O(VE)$.
> > - **Why:** **Flow $\iff$ paths** ➔ each unit of integral flow follows its own capacity-$1$ edges from $s$ to $t$. **$F\le\text{outdeg}(s)$** ➔ the cut $(\{s\},V\setminus\{s\})$ has capacity $\text{outdeg}(s)\le V-1$. **FF** ➔ $O(FE)$ with that $F$.

> [!FAQ]- Why "transform the input" instead of modifying Ford-Fulkerson for vertex capacities?
> > [!SUCCESS]- Answer
> > - **Short answer:** the transformation keeps FF a black box, so its correctness proof transfers; a modified FF would need a new proof.
> > - **Why:** **One obligation instead of two** ➔ show the split network's max flow equals the original's — every unit through $v$ crosses $v_{in}\to v_{out}$, so the vertex limit is exactly an edge limit. **Same move as BFS's super source** ➔ [[State-Space Graph Modelling]] §5.

> [!FAQ]- Project selection (W12 P3): why do the $\infty$ edges enforce prerequisites, and how is profit recovered from the cut?
> > [!SUCCESS]- Answer
> > - **Short answer:** an $\infty$ edge never crosses $S\to T$ in a min cut, so a chosen project's prerequisites are chosen too; profit $=\sum_{p_x>0}p_x-c(S,T)$.
> > - **Why:** **$x\to y$ cap $\infty$** ➔ $x\in S$, $y\in T$ would cost $\infty$, never minimal ⟹ $y\in S$. **The cut charges exactly the losses** ➔ forced unprofitable projects cut their $x\to t$, abandoned profitable projects cut their $s\to x$. **Min cut $=$ min loss** ➔ subtracted from the best case $\sum p^{+}$ it leaves the max profit.
