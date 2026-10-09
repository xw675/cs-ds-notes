---
unit: FIT2004
week: 12
source: [lecture, applied]
domain: A
parent: "[[Ford-Fulkerson Method]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Circulation with Demands, Circulation with Lower Bounds, Circulation Problem, Feasible Circulation, Survey Design, Airline Scheduling, Baseball Elimination]
---
# [[Circulation with Demands and Lower Bounds]]

**Context:** [[FIT2004_MOC]] · the W12 lecture $+$ applied sheet — max flow recast as a **feasibility** test: no $s$/$t$, a demand on every vertex, a $[\ell,c]$ window on every edge · solved by one [[Ford-Fulkerson Method|Ford-Fulkerson]] run, the next step after [[Network Flow Reductions]]
**Parent Framework:** [[Ford-Fulkerson Method]]

> [!abstract] Quick Revision
> - **🎯 Objective:** demands ➔ super $s$/$t$ edges ➔ FF ➔ feasible $\iff$ every super-edge saturated · lower bounds ➔ pre-push $\ell$, adjust $d$ and $c$, solve the remainder, add $\ell$ back.
> - **📦 Core Components:** demands ➔ $\text{in}(v)-\text{out}(v)=d_v$ | lower bounds ➔ $\ell\le f\le c$ | modelling ➔ survey design, airline scheduling, rosters, baseball elimination.
> - **⚡ Key Constraint:** two signs decide everything — $d_v<0$ is a **supplier** (edge **from** $s$), $d_v>0$ a **consumer** (edge **to** $t$) · $d^{*}_v=d_v-\ell_{\text{in}}(v)+\ell_{\text{out}}(v)$, never the reverse.

## 📝 How It Works
### 1. Circulation with Demands
- **Capacity constraint** ➔ $0\le f(e)\le c(e)$, unchanged from max flow.
- **Demand constraint replaces conservation** ➔ $\text{in}(v)-\text{out}(v)=d_v$ at **every** vertex · no source, no sink.
- **Reading $d_v$** ➔ $d_v>0$ ⟹ $v$ **absorbs** $d_v$ (in $5$, out $3$, $d=2$) · $d_v<0$ ⟹ $v$ **supplies** $-d_v$ (in $3$, out $5$, $d=-2$) · $d_v=0$ ⟹ plain conservation, ignored by the construction.
- **Feasibility, not optimisation** ➔ "does **any** $f$ satisfy both constraints?" — answer yes/no, with the flow as the witness.

### 2. Deciding Feasibility With One Max Flow *(lecture)*
- **Construction** ➔ new $s$ with $s\to v$ of capacity $-d_v$ for every $d_v<0$ · new $t$ with $v\to t$ of capacity $d_v$ for every $d_v>0$ · original edges kept ⟹ network $G'$.
- **Run FF** ➔ $s$ to $t$ on $G'$, unmodified.
- **Test** ➔ feasible $\iff$ every $s$-edge **and** every $t$-edge is saturated $\iff\lvert f\rvert=D^{+}=D^{-}$, where $D^{+}=\sum_{d_v>0}d_v$, $D^{-}=\sum_{d_v<0}(-d_v)$ · $D^{+}\ne D^{-}$ ⟹ infeasible without running FF.
- **Read-off** ➔ delete $s$, $t$ and their edges; the flow left on the original edges is the circulation ("clean it up").
- **Why (⟸)** ➔ a saturated $s\to v$ hands $v$ exactly $-d_v$ of extra inflow; conservation in $G'$ then forces $\text{in}_G(v)-\text{out}_G(v)=d_v$ — symmetric for $v\to t$.
- **Why (⟹)** ➔ a feasible circulation plus full super-edges conserves at every $v$ and has value $D^{+}=c(\{s\},\cdot)$ ⟹ maximum by weak duality ([[Min-Cut Max-Flow Theorem]] §3), so FF reaches it too.
- **Integer witness** ➔ integer $c$, $d$ ⟹ FF returns an integer circulation ([[Ford-Fulkerson Method]] §5) — the lecture's "we only deal with integers", and what makes a $0/1$ edge read-off legal.

### 3. Lower Bounds — Pre-Push, Then Solve the Remainder *(lecture · applied P1)*
- **New constraint** ➔ $\ell(e)\le f(e)\le c(e)$ · demand constraint unchanged.
- **Step 1 — pre-push** ➔ $f_\ell(e)=\ell(e)$ on every edge; this alone usually breaks the demands.
- **Step 2 — reduced network $G^{*}$** ➔ same vertices and edges, **no** lower bounds:

$$
\begin{aligned}
c^{*}(u,v)&=c(u,v)-\ell(u,v)\\
d^{*}_v&=d_v-\sum_{u}\ell(u,v)+\sum_{w}\ell(v,w)
\end{aligned}
$$

- **Sign intuition** ➔ lower-bound flow already **into** $v$ is demand already met ⟹ subtract · lower-bound flow already **out of** $v$ must be refilled ⟹ add.
- **Step 3** ➔ circulation with demands $\{d^{*}_v\}$ on $G^{*}$ by §2 ⟹ $f^{*}$, or infeasible.
- **Step 4 — combine** ➔ $f=f_\ell+f^{*}$ ⟹ $\ell\le f\le c$ because $0\le f^{*}\le c-\ell$ · annotate edges $\ell/f/c$ and restore the **original** $d_v$ ("don't forget the demand").
- **Equivalence** ➔ $f$ feasible in $G$ $\iff$ $f-f_\ell$ feasible in $G^{*}$ ⟹ $G^{*}$ infeasible means $G$ infeasible; nothing is lost.

### 4. Modelling With Circulations *(lecture · applied P4, P6)*
- **Recipe** ➔ fixed supplies $=$ negative demands, fixed needs $=$ positive demands, "at least $a$, at most $b$" $=$ edge window $[a,b]$ ➔ §3 then §2 ➔ read the assignment off edges carrying $1$.
- **Survey design (lecture)** ➔ $q\to c_i$ window $[c_i^-,c_i^+]$ (reviews asked of customer $i$) · $c_i\to p_j$ window $[0,1]$ if $i$ used $p_j$ (one review per product) · $p_j\to f$ window $[p_j^-,p_j^+]$ · closing edge $f\to q$ window $[\sum c_i^-,\sum c_i^+]$ · all demands $0$ ➔ bipartite matching **with lower bounds**; reviews $=$ middle edges carrying $1$.
- **Airline scheduling, $k$ planes (lecture)** ➔ route $r_i$ $=$ edge $\text{dep}_i\to\text{arr}_i$ window $[1,1]$ (vital ⟹ must fly) · $s$ ($d=-k$) $\to\text{dep}_i$ $[0,1]$ (start anywhere) · $\text{arr}_i\to t$ ($d=k$) $[0,1]$ (retire anywhere) · $\text{arr}_i\to\text{dep}_j$ $[0,1]$ when a plane can fly $r_j$ after $r_i$ · $s\to t$ $[0,k]$ for idle planes ➔ feasible $\iff$ $k$ planes cover every route · each unit $s\rightsquigarrow t$ is one plane's itinerary.
- **Lecture instance** ➔ SYD6–MEL7, CBR8–SYD9, MEL11–BNE1, PER11–SYD7 with $k=2$ ⟹ feasible: plane 1 flies $r_1\to r_4$, plane 2 flies $r_2\to r_3$.
- **Weekend roster (applied P4a)** ➔ $a$ ($d=-D$, $D=$ number of weekend days) $\to e_i$ window $[\ell_i,m_i]$ · $e_i\to w_j$ $[0,1]$ if available · $d_{w_j}=1$, $d_{e_i}=0$ ➔ roster $=$ edges $e_i\to w_j$ carrying $1$.
- **Why the extra vertex $a$** ➔ each day needs **exactly** one person (a demand) but each employee only a **range** (an edge window); only the total $D$ is fixed, so it sits on $a$.
- **At most one day per weekend (P4b)** ➔ a **selector** $s_{i,k}$ per employee per weekend: $e_i\to s_{i,k}$ $[0,1]$, $s_{i,k}\to w_j$ $[0,1]$ for each available day of weekend $k$ · a capacity on a **group** of edges — the vertex-split idea of [[Network Flow Reductions]] §2.
- **Baseball elimination (applied P6)** ➔ team $x$ wins every remaining game ⟹ $y$ wins · drop $x$'s games · one node $G_{i,j}$ per pair ($d=-r_{ij}$, games left between $i$ and $j$) $\to T_i$ and $\to T_j$, capacity $r_{ij}$ · $T_i\to A$ capacity $y-w_i$ · $d_A=\sum r_{ij}$ ➔ feasible $\iff$ $x$ can still finish at least tied · any $y-w_i<0$ ⟹ $x$ is out before building (the sheet's "trivial" case).

## ⚙️ Core Implementation
### 🔹 Feasible circulation with demands and lower bounds (applied P7)
> [!code]- Code — reuses `add_edge` / `ford_fulkerson` from [[Ford-Fulkerson Method]]
> ```python
> def circulation(n, edges, d):
>     """edges = [(u, v, lo, hi)]; d[v] = in - out. Returns per-edge flows, or None."""
>     d = d[:]                                        # becomes d*; never mutate the input
>     adj = [[] for _ in range(n + 2)]
>     s, t = n, n + 1
>     handles = []
>     for u, v, lo, hi in edges:                      # 1. pre-push lo        O(E)
>         d[v] -= lo                                  #    lo already arrived at v
>         d[u] += lo                                  #    u must refill what it shipped
>         handles.append((u, len(adj[u]), lo, hi))    #    index of the forward edge
>         add_edge(adj, u, v, hi - lo)                #    c* = c - l
>     pos = neg = 0
>     for v in range(n):                              # 2. super source/sink  O(V)
>         if d[v] < 0:
>             add_edge(adj, s, v, -d[v]); neg -= d[v]
>         elif d[v] > 0:
>             add_edge(adj, v, t, d[v]);  pos += d[v]
>     if pos != neg or ford_fulkerson(adj, s, t) != pos:
>         return None                                 # 3. some super-edge unsaturated
>     return [lo + (hi - lo - adj[u][i].cap)          # 4. f = l + f*,  f* = c* - residual
>             for u, i, lo, hi in handles]
> ```
> 💡 **Common Mistake:** **Testing only `ford_fulkerson(...) == pos`** ➔ with $D^{-}>D^{+}$ the $t$-edges can all fill while an $s$-edge stays short; check both sides.

## ⚖️ Complexity
*(The lecture states no bound — each row applies [[Ford-Fulkerson Method]]'s $O(FE)$ to the built network.)*

| Step | Time | Aux space | Why |
| :--- | :--- | :--- | :--- |
| Lower-bound transform | $O(V+E)$ | $\Theta(V)$ | one pass for $c^{*}$ and both $\ell$-sums |
| Add $s$, $t$ | $O(V)$ | $\Theta(V)$ | $\le V$ super-edges ⟹ $E'\le E+V$ |
| FF on $G'$ | $O(D^{+}(V+E))$ | $\Theta(V+E)$ | $F\le c(\{s\},\cdot)=D^{-}$, and $=D^{+}$ when feasible — **pseudo-polynomial** in the demands |
| Combine $f=f_\ell+f^{*}$ | $O(E)$ | — | one addition per edge |
| **Whole pipeline** | $O(D^{*}(V+E))$ | $\Theta(V+E)$ | $D^{*}=\sum_{d^{*}_v>0}d^{*}_v$ |

## ⚖️ Core Decision Matrix
| Problem | Cue in the question | Construction | Answer |
| :--- | :--- | :--- | :--- |
| Max flow | one origin, one destination, "how much" | network as given | $\lvert f\rvert$ |
| Circulation with demands | fixed supplies and needs, no single $s$/$t$ | $s\to$ suppliers, consumers $\to t$ | feasible $\iff$ super-edges saturated |
| $+$ lower bounds | "at least" on a link (must fly, minimum workload) | pre-push $\ell$ ➔ $G^{*}$ ➔ demands | $f=f_\ell+f^{*}$ |

> [!NOTE] **When It Flips:** "**at least**" on an edge ⟹ lower bounds · "**exactly** / supplies / needs" on a vertex ⟹ demands · only "**at most**" and one origin ⟹ plain max flow or quota matching ([[Network Flow Reductions]] §3).

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — applied P1 (feasible)
Edges $\ell/c$: $x\to y$ $1/3$ · $v\to x$ $1/3$ · $y\to v$ $1/4$ · $v\to w$ $1/2$ · $y\to w$ $2/4$ · demands $d_x=-2$, $d_y=-4$, $d_v=2$, $d_w=4$.

| Vertex | $d_v$ | $\ell_{\text{in}}$ | $\ell_{\text{out}}$ | $d^{*}_v$ | Super-edge in $G'$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $x$ | $-2$ | $1$ | $1$ | $-2$ | $s\to x$ cap $2$ |
| $y$ | $-4$ | $1$ | $3$ | $-2$ | $s\to y$ cap $2$ |
| $v$ | $2$ | $1$ | $2$ | $3$ | $v\to t$ cap $3$ |
| $w$ | $4$ | $3$ | $0$ | $1$ | $w\to t$ cap $1$ |

| Edge | $\ell$ | $c$ | $c^{*}=c-\ell$ | $f^{*}$ (max flow) | $f=\ell+f^{*}$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $x\to y$ | $1$ | $3$ | $2$ | $2$ | $3$ |
| $v\to x$ | $1$ | $3$ | $2$ | $0$ | $1$ |
| $y\to v$ | $1$ | $4$ | $3$ | $3$ | $4$ |
| $v\to w$ | $1$ | $2$ | $1$ | $0$ | $1$ |
| $y\to w$ | $2$ | $4$ | $2$ | $1$ | $3$ |

- **Verdict** ➔ $\lvert f^{*}\rvert=4=D^{+}=D^{-}$ ($3+1$ vs $2+2$) ⟹ every super-edge saturated ⟹ **feasible**.
- **Self-check on $G$** ➔ $x$: $1-3=-2$ · $y$: $3-7=-4$ · $v$: $4-2=2$ · $w$: $1+3=4$ ✓.

### Applied Exercise — lecture "Clayton" network (infeasible)
**Problem:** $x\to y$, $x\to v$, $y\to w$ $1/3$ · $y\to v$, $v\to w$, $z\to y$, $w\to z$ $1/2$ · $d_x=-4$, $d_y=-3$, $d_v=2$, $d_w=5$, $d_z=0$.

$$
\begin{aligned}
d^{*}_x&=-4-0+2=-2, \quad d^{*}_y=-3-2+2=-3, \quad d^{*}_z=0-1+1=0\\
d^{*}_v&=2-2+1=1, \quad d^{*}_w=5-2+1=4 \ \Rightarrow\ D^{+}=D^{-}=5\\
c^{*}(y\to w)+c^{*}(v\to w)&=2+1=3<4=d^{*}_w\\
c(S,\{w,t\})&=\underbrace{2+1}_{\text{into } w}+\underbrace{1}_{v\to t}=4<5
\end{aligned}
$$

**Final Extracted Output:** **infeasible** — $w$ must net-absorb $4$ but at most $3$ can reach it, so $w\to t$ never saturates · certificate: the cut $(V'\setminus\{w,t\},\{w,t\})$ of capacity $4<D^{+}=5$.

## ⚠️ Common Mistakes
- 💡 **Demand sign flipped** ➔ $d_v<0$ is a **supplier**: edge $s\to v$, never $v\to t$.
- 💡 **$d^{*}$ sign flipped** ➔ incoming lower bounds are **subtracted**, outgoing **added** · self-check: $\sum d^{*}_v=\sum d_v$, since each $\ell$ is subtracted once at its head and added once at its tail.
- 💡 **Reporting $f^{*}$ as the circulation** ➔ the answer is $f=f_\ell+f^{*}$ under the **original** demands; $f^{*}$ alone breaks every lower bound.
- 💡 **"FF finished" read as "feasible"** ➔ FF always returns a max flow; feasibility is the extra saturation test.

## 🧠 Active Recall
> [!FAQ]- Why is "every super-edge saturated" exactly the feasibility test, in both directions?
> > [!SUCCESS]- Answer
> > - **Short answer:** saturated super-edges **are** the demands; a feasible circulation plus full super-edges is a flow of value $D^{+}$, which no flow can beat.
> > - **Why:** **(⟸)** ➔ deleting a saturated $s\to v$ of capacity $-d_v$ leaves $v$ with $\text{in}-\text{out}=d_v$; same for $t$-edges. **(⟹)** ➔ the cut $(\{s\},V'\setminus\{s\})$ has capacity $D^{-}=D^{+}$, so a flow of that value is maximum by weak duality ⟹ FF reaches it.

> [!FAQ]- Airline scheduling: why is a route an edge with window $[1,1]$, and why the edge $s\to t$?
> - **Hint:** what can a lower bound say that a capacity cannot?
> > [!SUCCESS]- Answer
> > - **Short answer:** "this route **must** be flown" is a lower bound, and lower bounds live on edges; $s\to t$ soaks up planes nobody needs.
> > - **Why:** **$\ell=c=1$** ➔ exactly one plane crosses $\text{dep}_i\to\text{arr}_i$ · **$[0,1]$ elsewhere** ➔ starting, retiring and chaining stay optional · **$s\to t$ $[0,k]$** ➔ without it $d_s=-k$ forces all $k$ planes to fly, making "$k$ is enough" fail whenever fewer suffice.

> [!FAQ]- Weekend roster (P4): why do days carry demand $1$ while employees need an extra vertex $a$?
> > [!SUCCESS]- Answer
> > - **Short answer:** a demand is an exact number; employees have a **range**, and ranges are edge windows.
> > - **Why:** **Days** ➔ exactly one person each ⟹ $d_{w_j}=1$ · **Employees** ➔ $\ell_i\le$ shifts $\le m_i$ ⟹ window on $a\to e_i$ · **Totals** ➔ only $\sum_j1=D$ is fixed, so the balancing supply $-D$ sits on $a$.

> [!FAQ]- Baseball elimination: why does capacity $y-w_i$ on $T_i\to A$ encode "nobody passes team $x$"?
> > [!SUCCESS]- Answer
> > - **Short answer:** it caps how many of the remaining games team $i$ may still win while staying $\le y$.
> > - **Why:** **Every game must be awarded** ➔ $d_{G_{i,j}}=-r_{ij}$ forces all $r_{ij}$ wins out to $T_i$ or $T_j$ · **No team exceeds $y$** ➔ $w_i+(\text{flow into }T_i)\le y$ · **Infeasible** ➔ some wins have nowhere legal to go ⟹ someone must pass $x$ ⟹ $x$ eliminated.
