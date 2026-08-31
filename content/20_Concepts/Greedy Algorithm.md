---
unit: FIT2004
week: 6
source: [lecture, applied]
domain: A
parent: "[[Algorithm]]"
tags: [CS/Algorithms]
aliases: [Greedy, Greedy Paradigm, Interval Scheduling, Activity Selection]
---
# [[Greedy Algorithm]]

**Context:** [[FIT2004_MOC]] · the paradigm behind [[Prim's Algorithm|Prim]], [[Kruskal's Greedy Algorithm|Kruskal]] and [[Dijkstra's Algorithm|Dijkstra]] — take the best-looking option **now**, never reconsider, and **prove** the result is globally optimal
**Parent Framework:** [[Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** one irrevocable locally-optimal choice per step ➔ a globally optimal solution, **when** the problem has the greedy-choice property.
> - **📦 Core Components:** a **ranking rule** *(sort key)* ➔ a **feasibility test** ➔ a **proof** by exchange argument or stays-ahead induction.
> - **⚡ Key Constraint:** the algorithm is trivial and the **proof is the deliverable** — an unproved greedy is a guess, and most plausible ranking rules are wrong.

## 📝 How It Works
### 1. The Shape
- **Ranking rule** ➔ sort or heap the candidates by the quantity the greed maximises — edge weight for [[Kruskal's Greedy Algorithm|Kruskal]], finish time for interval scheduling.
- **Feasibility test** ➔ accept the next candidate **iff** it keeps the partial solution legal (acyclic for MST, non-overlapping for scheduling).
- **Irrevocable** ➔ an accepted choice is never undone; this is what separates greedy from **dynamic programming**, which keeps every subproblem's answer and combines them later.
- **Cost profile** ➔ almost always $\Theta(n\log n)$ from the sort $+$ $\Theta(n)$ or $\Theta(n\,\alpha(n))$ scanning ⟹ the sort is the bound.

### 2. When Greed Is Provably Right
- **Greedy-choice property** ➔ some optimal solution **contains** the first greedy choice; hence choosing it loses nothing.
- **Optimal substructure** ➔ after committing that choice, the remaining problem is the same problem on a smaller instance.
- **Both are needed** ➔ optimal substructure alone gives dynamic programming; the greedy-choice property is the extra fact that lets you skip the search.
- **The lecture's framing** ➔ *choose local optimal, believe you get the global optimal — then prove it.*

### 3. The Two Proof Templates *(LO2)*
- **Exchange argument** ➔ assume an optimal solution $M$ that **omits** your greedy choice $e$; show $M$ can be edited to include $e$ without getting worse ⟹ an optimal solution containing $e$ exists. This is the cut-and-swap used for [[Prim's Algorithm|Prim]] and [[Kruskal's Greedy Algorithm|Kruskal]].
- **Stays-ahead induction** ➔ show that after $k$ choices your partial solution is **at least as far along** as any optimal solution's first $k$ choices; conclude the optimum can never be strictly longer.
- **Contradiction wrapper** ➔ both are usually written as "suppose a better solution exists" and terminate in an impossible inequality, exactly as [[Dijkstra's Algorithm|Dijkstra]]'s proof does.
- **Termination is still owed** ➔ a greedy proof needs the [[Invariant]] pair: the maintained property **and** the argument that the loop ends.

### 4. Interval Scheduling — the Worked Case *(applied P7)*
- **Problem** ➔ requests $i$ with start $s_i$ and finish $f_i$; a subset is **compatible** if no two overlap; maximise the **number** accepted.
- **Rule** ➔ sort by **finishing time** ascending; scan, accepting each request compatible with the last accepted one.
- **Intuition** ➔ freeing the machine as early as possible leaves the most room for everything after it.
- **Cost** ➔ $\Theta(n\log n)$ sort $+$ $\Theta(n)$ scan; only the finish time of the **last accepted** request need be remembered.
- **Not a weight problem** ➔ this maximises the **count**; weighted interval scheduling is a dynamic-programming problem, not a greedy one.

### 5. Ranking Rules That Look Sensible and Fail
- **Earliest start time** ➔ the request that starts first may be the one that finishes last, blocking everything ➔ a single long job beats the whole schedule.
- **Shortest duration** ➔ counterexample from the sheet: $(1,10)$, $(9,12)$, $(11,20)$. The shortest is $(9,12)$, and taking it excludes **both** others ⟹ $1$ accepted where $2$ were possible.
- **Fewest conflicts** ➔ also fails in general; plausibility is not a proof.
- **The lesson (LO1)** ➔ enumerate two or three candidate ranking rules, **kill the wrong ones with explicit counterexamples**, and only then prove the survivor. That counterexample hunt is itself a marked step.

## ⚖️ Core Decision Matrix
| Problem | Greedy rule | Proof template | Bound |
| :--- | :--- | :--- | :--- |
| [[Minimum Spanning Tree]] via [[Kruskal's Greedy Algorithm\|Kruskal]] | lightest edge joining two components | exchange across a cut | $O(E\log E)$ |
| [[Minimum Spanning Tree]] via [[Prim's Algorithm\|Prim]] | lightest edge leaving the tree | exchange across a cut | $O(E\log V)$ |
| Single-source shortest path ([[Dijkstra's Algorithm\|Dijkstra]]) | nearest non-finalised vertex | contradiction on the first bad serve | $O(E\log V)$ |
| Interval scheduling *(max count)* | earliest **finish** time | stays ahead | $\Theta(n\log n)$ |
| **Weighted** interval scheduling | none — greedy fails | — | dynamic programming |
| Shortest path with **negative** edges | none — greedy fails | — | Bellman-Ford $\Theta(VE)$ |

> [!NOTE] **When It Flips:** greed survives exactly while a locally best choice can be **exchanged into** some optimal solution. Add weights to the intervals, or negative edges to the graph, and that exchange stops going through — the algorithm must change, not its constant factors.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)*: the structures on which "always take the cheapest feasible element" is provably optimal are **matroids** — [[Kruskal's Greedy Algorithm|Kruskal]] is the graphic matroid's instance. FIT2004 asks for the exchange proof, not the theory.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise — prove interval scheduling optimal *(P7, stays ahead)*
**Problem:** let the algorithm output $i_1,\dots,i_m$ in time order and suppose some compatible set $j_1,\dots,j_n$ has $n>m$.
$$
\begin{aligned}
\textbf{Claim: } & f_{i_k}\le f_{j_k}\quad \text{for } k=1,\dots,m. \\
\textbf{Base: } & k=1 \text{: the algorithm picks the globally earliest finish} \Rightarrow f_{i_1}\le f_{j_1}. \\
\textbf{Step: } & \text{assume } f_{i_{k-1}}\le f_{j_{k-1}}. \text{ Then } s_{j_k}\ge f_{j_{k-1}}\ge f_{i_{k-1}}, \\
& \text{so } j_k \text{ was still compatible when the algorithm chose } i_k \Rightarrow f_{i_k}\le f_{j_k}. \\
\textbf{Close: } & f_{i_m}\le f_{j_m}\le s_{j_{m+1}} \Rightarrow j_{m+1} \text{ was compatible and available.}
\end{aligned}
$$
**Final Extracted Output:** the algorithm would have accepted $j_{m+1}$ instead of stopping at $m$ — contradiction, so $n\le m$ and the output is of **maximum size**. **The reusable move:** index the two solutions in parallel and prove yours never falls behind.

### Applied Exercise — kill the rival rules
**Problem:** show *shortest duration* and *earliest start* are not optimal.
**Final Extracted Output:** on $(1,10),(9,12),(11,20)$ shortest-duration takes $(9,12)$ and accepts $1$; earliest-finish takes $(1,10)$ then $(11,20)$ and accepts $2$. On the same instance earliest-**start** also takes $(1,10)$ first and here coincides — so exhibit a separate instance for it, e.g. one long request starting at time $0$ that overlaps every short one. **One counterexample kills one rule; do not reuse it for both.**

## ⚠️ Common Mistakes
- 💡 **Presenting the rule without the proof** ➔ "sort by finish time and scan" is $2$ lines of an answer whose marks live in the stays-ahead induction. The same applies to every MST answer.
- 💡 **Assuming a plausible sort key** ➔ shortest-first, most-constrained-first and cheapest-first are all wrong somewhere. Name the rule, then attack it.
- 💡 **Calling [[Dijkstra's Algorithm|Dijkstra]] "just greedy"** ➔ it is greedy **and** dynamic programming: it reuses sub-minima *and* finalises irrevocably. The negative-edge failure is the greedy half breaking, not the DP half.

## 🧠 Active Recall
> [!FAQ]- Two ingredients make a greedy algorithm correct. Name them and say which one dynamic programming also needs.
> - **Hint:** one is shared.
> > [!SUCCESS]- Answer
> > - **Short answer:** the greedy-choice property and optimal substructure; **optimal substructure** is the shared one.
> > - **Why:** **Optimal substructure** ➔ an optimal solution is built from optimal solutions of subproblems — true for both paradigms, which is why [[Dijkstra's Algorithm|Dijkstra]] is described as DP $+$ greedy. **The greedy-choice property is the extra** ➔ some optimal solution contains the first greedy choice, so the search over alternatives can be skipped entirely. **Losing it costs a paradigm** ➔ weighted interval scheduling keeps the substructure but loses the choice property, and must fall back to a DP table.

> [!FAQ]- Sorting requests by shortest duration seems to fit more of them in. Give the counterexample and the rule that works.
> - **Hint:** one short job in the middle.
> > [!SUCCESS]- Answer
> > - **Short answer:** $(1,10),(9,12),(11,20)$ — the shortest request $(9,12)$ blocks both others; sort by **earliest finish time** instead.
> > - **Why:** **Duration is the wrong quantity** ➔ what constrains the future is when the machine becomes free, not how long the job ran. **Earliest finish maximises the remaining window** ➔ every accepted request leaves at least as much room as any alternative, which is exactly the stays-ahead invariant $f_{i_k}\le f_{j_k}$. **Earliest start fails for the mirror reason** ➔ the first request to start can be the last to finish.
