---
unit: FIT2004
week: 11
source: [lecture, applied]
domain: [D, A]
parent: "[[Ford-Fulkerson Method]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Max-Flow Min-Cut Theorem, Minimum Cut, Min Cut, s-t Cut, Cut Capacity]
---
# [[Min-Cut Max-Flow Theorem]]

**Context:** [[FIT2004_MOC]] · the certificate that turns [[Ford-Fulkerson Method|Ford-Fulkerson]]'s "no augmenting path" into "the flow is maximum" · the read-off tool for min-cut problems in [[Network Flow Reductions]] §5
**Parent Framework:** [[Ford-Fulkerson Method]]

> [!abstract] Quick Revision
> - **🎯 Objective:** every cut carries exactly $\lvert f\rvert$, and no cut carries more than its capacity ⟹ max flow $\le$ min cut · Ford-Fulkerson stops at a cut where equality holds ⟹ **max-flow $=$ min-cut capacity**.
> - **📦 Core Components:** cut $(S,T)$ with $s\in S$, $t\in T$ | **capacity** $=\sum c$ over $S\to T$ edges only | **flow** $=\sum f(S\to T)-\sum f(T\to S)$ | **min cut** $=$ vertices reachable from $s$ in the final $G_f$.
> - **⚡ Key Constraint:** capacity **ignores** $T\to S$ edges, flow **subtracts** them — swap the two rules and every cut number is wrong.

## 📝 How It Works
### 1. Cuts and Their Two Numbers
- **Cut $(S,T)$** ➔ any partition of $V$ with $s\in S$, $t\in T$ · $S$ need not look contiguous on the drawing ($\{s,a,c\}$ is a lecture cut) · $2^{V-2}$ cuts, so enumerating them is exponential.
- **Capacity** ➔ $c(S,T)=\sum_{u\in S,\,v\in T}c(u,v)$ — outgoing edges only.
- **Flow** ➔ $f(S,T)=\sum_{u\in S,\,v\in T}f(u,v)-\sum_{u\in S,\,v\in T}f(v,u)$ — out minus in.
- **Lecture example** ➔ $S=\{s,a,b\}$: capacity $a\to c\,12+b\to d\,14=26$ · flow $12+11-4=19$ (the $4$ is $c\to b$, crossing back).

### 2. Lemma — Every Cut Carries the Whole Flow *(applied P1)*
- **Claim** ➔ $f(S,T)=\lvert f\rvert$ for every cut — the lecture's "flow of every cut $=$ flow of network".
- **Mechanism** ➔ conservation: inside $S$, every vertex but $s$ passes on what it receives, so all of $s$'s output must leave $S$ eventually, net of anything that comes back.
- **Applied P1** ➔ cut $(\{s\},V\setminus\{s\})$ gives net outflow of $s$; cut $(V\setminus\{t\},\{t\})$ gives net inflow of $t$; both equal $\lvert f\rvert$ ⟹ equal to each other.

### 3. Weak Duality — Any Flow $\le$ Any Cut
- **Bound** ➔ $f(S,T)\le c(S,T)$: out-flows are capped by capacities, in-flows are $\ge0$.
- **Consequence** ➔ every cut capacity bounds every flow · the lecture's capacities $29,35,26,34,24,52,31,34,23$ all bound a flow of $19$, and the smallest, $23$, is the true maximum.
- **Certificate** ➔ a flow equal to **some** cut's capacity is provably maximum, and that cut provably minimum.

### 4. The Theorem and Ford-Fulkerson's Stopping Condition
- **Theorem** ➔ $\max_f\lvert f\rvert=\min_{(S,T)}c(S,T)$.
- **FF stops at an equality cut** ➔ every $S\to T$ edge **saturated** and every $T\to S$ edge **empty** — out $=$ capacity, in $=0$.
- **Lecture check** ➔ final flow, $S=\{s,a,b,d\}$, $T=\{c,t\}$: $a\to c\,12/12$, $d\to c\,7/7$, $d\to t\,4/4$ saturated · $c\to b\,0/9$ empty ⟹ $12+7+4=23=\lvert f\rvert$.
- **A cut can match the capacity rule yet fail the empty rule** ➔ the lecture's "does this meet the requirement? NO" check: test **both** conditions.

### 5. Finding the Min Cut *(exam procedure)*
- **Steps** ➔ run FF to completion ➔ BFS/DFS from $s$ in the **final residual** $G_f$ ➔ $S=$ reached, $T=$ rest ➔ list the $S\to T$ edges of $G$ (all saturated) ➔ sum their capacities, confirm $=\lvert f\rvert$, confirm every $T\to S$ edge carries $0$.
- **Cost** ➔ $O(V+E)$ after FF — it is the final failed path search, kept.
- **Not unique** ➔ several cuts can share the minimum capacity; the lecture invites finding the cut behind MUA's different final network — the **capacity** is fixed by the network, never by which max flow you found.

## 🧮 Proof Blueprint
**Theorem.** For any valid flow $f$ and cut $(S,T)$: $f(S,T)=\lvert f\rvert\le c(S,T)$; and when [[Ford-Fulkerson Method|Ford-Fulkerson]] stops, $\lvert f\rvert=c(S,T)$ for the cut of residual-reachable vertices.

**Strategy.** Sum conservation over $S$ (lemma) ➔ bound term by term (weak duality) ➔ construct the equality cut from residual reachability (strong duality).

**Derivation — lemma and weak duality** (sum net outflow over $u\in S$; every $u\ne s$ in $S$ contributes $0$, and $t\notin S$):
$$
\begin{aligned}
\lvert f\rvert &= \sum_{u\in S}\Bigl(\sum_{v\in V}f(u,v)-\sum_{v\in V}f(v,u)\Bigr)\\
&= \sum_{u\in S,\,v\in T}f(u,v)-\sum_{u\in S,\,v\in T}f(v,u) \qquad \text{(each } S\text{–}S \text{ edge enters once with } + \text{, once with } -\text{)}\\
&= f(S,T)\\
&\le \sum_{u\in S,\,v\in T}c(u,v)-0 = c(S,T) \qquad (0\le f\le c)
\end{aligned}
$$

**Derivation — strong duality at termination.** FF stops ⟹ no $s\rightsquigarrow t$ path in $G_f$. Let $S=\{v:\ v \text{ reachable from } s \text{ in } G_f\}$, $T=V\setminus S$ ⟹ $s\in S$, $t\in T$, a valid cut. For $u\in S$, $v\in T$:
- **Edge $u\to v$ in $G$** ➔ if $f(u,v)<c(u,v)$ the forward residual $u\to v$ is positive ⟹ $v$ reachable, contradiction ⟹ $f(u,v)=c(u,v)$.
- **Edge $v\to u$ in $G$** ➔ if $f(v,u)>0$ the backward residual $u\to v$ is positive ⟹ contradiction ⟹ $f(v,u)=0$.
$$
\lvert f\rvert = f(S,T) = \sum c(S\to T) - 0 = c(S,T)
$$

**Sealing.** By weak duality no flow exceeds $c(S,T)$ and no cut is below $\lvert f\rvert$ ⟹ $f$ is a maximum flow and $(S,T)$ a minimum cut ⟹ $\max\lvert f\rvert=\min c(S,T)$. Q.E.D. With FF's termination (integer capacities) this completes FF's proof of correctness.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — one flow ($\lvert f\rvert=19$, lecture start network) through seven cuts
| $S$ | $S\to T$ edges (capacity) | $T\to S$ edges (flow) | $c(S,T)$ | $f(S,T)$ |
| :--- | :--- | :--- | :--- | :--- |
| $\{s\}$ | $s\to a\,16$, $s\to b\,13$ | — | $29$ | $11+8=19$ |
| $\{s,a\}$ | $s\to b\,13$, $a\to b\,10$, $a\to c\,12$ | $b\to a\,(1)$ | $35$ | $8+0+12-1=19$ |
| $\{s,a,b\}$ | $a\to c\,12$, $b\to d\,14$ | $c\to b\,(4)$ | $26$ | $12+11-4=19$ |
| $\{s,a,c\}$ | $s\to b\,13$, $a\to b\,10$, $c\to b\,9$, $c\to t\,20$ | $b\to a\,(1)$, $d\to c\,(7)$ | $52$ | $27-8=19$ |
| $\{s,a,b,c\}$ | $b\to d\,14$, $c\to t\,20$ | $d\to c\,(7)$ | $34$ | $11+15-7=19$ |
| $\{s,a,b,d\}$ | $a\to c\,12$, $d\to c\,7$, $d\to t\,4$ | $c\to b\,(4)$ | $\mathbf{23}$ | $23-4=19$ |
| $\{s,a,b,c,d\}$ | $c\to t\,20$, $d\to t\,4$ | — | $24$ | $15+4=19$ |

**Final Extracted Output:** the flow column never moves (lemma) · the minimum capacity, $23$, is the max flow · the min cut's gap $23-19$ is exactly the $4$ units on $c\to b$ crossing back — the very units the augmenting path in [[Ford-Fulkerson Method]] §3 cancels.

### Applied Exercise — prep P1(e)
**Problem:** final flow $s\to a\,3/3$, $s\to b\,4/4$, $a\to c\,5/5$, $d\to a\,2/4$, $b\to d\,4/4$, $c\to t\,5/5$, $d\to t\,2/3$, others $0$. Find the min cut and verify it.
$$
\begin{aligned}
G_f \text{ from } s: &\ s\to a \text{ and } s\to b \text{ saturated} \Rightarrow s \text{ has no residual out-edge}\\
S=\{s\},\ T &= \{a,b,c,d,t\}\\
c(S,T) &= c(s\to a)+c(s\to b)=3+4=7=\lvert f\rvert
\end{aligned}
$$
**Final Extracted Output:** min cut $(\{s\},\{a,b,c,d,t\})$, capacity $7$ — the source's own out-capacity is the bottleneck.

## ⚠️ Common Mistakes
- 💡 **Counting $T\to S$ capacity** ➔ capacity sums $S\to T$ edges only; $c\to b$ adds nothing to $c(\{s,a,b\},\cdot)$.
- 💡 **Forgetting to subtract $T\to S$ flow** ➔ $f(\{s,a,b\})=23$ is wrong, $19$ is right.
- 💡 **Reachability in $G$ instead of $G_f$** ➔ in $G$ almost everything is reachable from $s$; only the **residual** search finds $S$.

## 🧠 Active Recall
> [!FAQ]- Why does a $T\to S$ edge enter a cut's flow but not its capacity?
> > [!SUCCESS]- Answer
> > - **Short answer:** capacity measures how much $S$ can **send** to $T$; flow measures what actually got across net, so returning flow is deducted.
> > - **Why:** **Capacity** ➔ the upper bound on net transfer needs only outgoing room, because incoming flow can only reduce the net. **Flow** ➔ $f(S,T)=\text{out}-\text{in}$ is what conservation makes equal to $\lvert f\rvert$; dropping the "in" term breaks the lemma ($\{s,a,b\}$ would read $23$, not $19$).

> [!FAQ]- Ford-Fulkerson stops when no augmenting path exists. Why does that prove the flow is maximum?
> - **Hint:** look at the vertices that are still reachable.
> > [!SUCCESS]- Answer
> > - **Short answer:** the residual-reachable set $S$ defines a cut whose capacity equals $\lvert f\rvert$, and no flow can exceed any cut.
> > - **Why:** **$S\to T$ edges saturated** ➔ else a positive forward residual would extend $S$. **$T\to S$ edges empty** ➔ else a positive backward residual would extend $S$. **So** $\lvert f\rvert=f(S,T)=c(S,T)$ ➔ by weak duality $f$ is maximum and $(S,T)$ minimum.

> [!FAQ]- Prove that the net flow out of $s$ equals the net flow into $t$ (applied P1).
> > [!SUCCESS]- Answer
> > - **Short answer:** both are the flow of a cut, and every cut carries $\lvert f\rvert$.
> > - **Why:** **Cut $(\{s\},V\setminus\{s\})$** ➔ its flow is $s$'s net outflow. **Cut $(V\setminus\{t\},\{t\})$** ➔ its flow is $t$'s net inflow. **Lemma** ➔ both equal $\lvert f\rvert$.
