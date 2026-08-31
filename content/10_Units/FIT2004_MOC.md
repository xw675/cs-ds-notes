---
unit: FIT2004
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2004: Algorithms and Data Structures

> [!INFO] Map of Content
> Index for **FIT2004 Algorithms and Data Structures** (Y2S1) — rigorous algorithmics building on [[FIT1008_MOC]]. The foundational material (Big-O, recursion, divide-and-conquer, merge sort) is **shared dual-unit** with FIT1008/FIT1058 and deepened here with **correctness proofs** and **recurrence analysis** rather than duplicated.

## 📊 Assessment Map (2026 S2)
Tiered framework — **"Easy to Pass, Hard to Distinction (D/HD)."**

| Tier | Marks | Format | Hurdles to sit / pass |
| :--- | :--- | :--- | :--- |
| **Pass — PT1, PT2, PT3** | base $50$ | 75-min on-campus closed-book Moodle under SEB | **§1** binary Competent/Not: $\ge80\%$ (4/5), up to **3 check-attempts** per question · **§2** optional written, $+3$ bonus each |
| **Credit — CD1, CD2** | $+10$ | 15-min 1-on-1 Zoom oral, closed-book, screen sharing · **no reattempts** | §1 $+3$ (guided prompts) · §2 $+2$ (advanced unguided) · needs **all PTs Competent**, $\ge50\%$ weekly quizzes, timely EOI form |
| **D/HD Exam** | $+31$ | 3-hour written paper, on-campus **Week 15**, closed-book; covers unit content **and beyond**, high failure/zero-mark rate | all PTs Competent **by PTR1**, $\ge9/12$ weekly quizzes at 100%, **pre-exam score $\ge60$** |

- **Safety net** ➔ PTR1/PTR2 reattempts cover missed competencies, but **bonus marks are forfeited**.
- **LO thread so far** ➔ analyse running time via recurrences; design divide-and-conquer algorithms; quote tight Big-O with mandatory complexity tables.

## 🧰 Unit Cheatsheet
- 📌 [[FIT2004 Unit Cheatsheet]] — analysis discipline, recurrence regimes, D&C shapes, per-algorithm bounds

## 📅 Knowledge Index

### Week 1 — Complexity Analysis, Divide & Conquer, and Solving Recurrences *(lecture 1 · applied W1)*
- [[Karatsuba Integer Multiplication]] -> [[Divide and Conquer]] *(**NOT EXAMINABLE** — lecturer-confirmed motivating hook; read for D&C intuition, never drill it)*
- [[Solving Recurrences (Telescoping)]] -> [[Big-O Notation]] *(the analysis hand skill — repeated substitution; Master Theorem supplementary)*
- [[Divide and Conquer]] -> [[Recursion]] *(dual-unit — split/recurse/combine, analysed via recurrences)*
- [[Algorithmic Complexity]] -> [[Algorithm]] *(dual-unit — input size, RAM model, best/avg/worst; $+$ auxiliary space, tightest bound)*
- [[Big-O Notation]] -> [[Algorithmic Complexity]] *(dual-unit — $O/\Omega/\Theta$, dominance, growth ladder)*
- [[Recurrence Relation]] -> [[Sequence (Mathematics)]] *(dual-unit — the maths behind the running-time recurrences)*
- [[Merge Sort]] -> [[Divide and Conquer]] *(dual-unit — the canonical $2T(n/2)+\Theta(n)=\Theta(n\log n)$)*
- **Applied 1** *(assumed background, re-drilled with the $\Omega/\Theta$ apparatus)*: [[Arithmetic Series]] -> [[Algorithmic Complexity]] *($\sum i=\Theta(n^2)$ by induction; shrink-by-one costs)* · [[Geometric Series]] -> [[Summation Notation]] *($\sum r^i$ closed form; the $r{=}2$ and $r{=}\tfrac12$ corollaries bounding every D&C tree)* · [[Binary Search Tree (BST)]] -> [[Binary Tree]] *(the bound-vs-case vehicle; $n$ sorted inserts $=\Theta(n^2)$)*

### Week 2 — Analysing Recursion: Time and Auxiliary Space *(lecture 2 · applied W2)*
- [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] -> [[Recursion]] *(the pipeline spine — code ➔ recurrence ➔ time, **and** depth ➔ auxiliary space; owns the **call-site vs coefficient** trap · **applied**: P4 the **duplicate-call trap**, `POW(x,p/2)*POW(x,p/2)` is $\Theta(p)$, binding it once $\Theta(\log p)$)*
- [[Solving Recurrences (Telescoping)]] -> [[Big-O Notation]] *(**applied**: P1 branching-by-subtraction $2T(n{-}1){+}a=\Theta(2^{n})$ · P3 the **Proof Blueprint**, proving a GIVEN closed form by induction over $n{=}2^{k}$ — $T(2m)$, not $T(m{+}1)$)*
- [[Divide and Conquer]] -> [[Recursion]] *(**applied**: §3 the three-question checklist for a new problem, and "strengthen the recursive contract")*
- [[Binary Search]] -> [[Divide and Conquer]] *(dual-unit — decrease-and-conquer; the canonical best $\ne$ worst case)*
- [[Output-Sensitive Complexity]] -> [[Algorithmic Complexity]] *(range reporting — $\Theta(N{+}W)$ vs $\Theta(\log N{+}W)$)*
- [[Counting Inversions]] -> [[Merge Sort]] *(applied P5 — the flagship LO1 note: instrument the merge, count split inversions in blocks, $\Theta(N^{2})\to\Theta(N\log N)$)*
- [[2D Local Maximum (Peak Finding)]] -> [[Divide and Conquer]] *(applied P6 — $\Theta(n)$ on an $n^{2}$ input; the **correctness argument** is the deliverable, and halving ONE axis silently costs $\Theta(n\log n)$)*
- [[Fibonacci Sequence]] -> [[Recurrence Relation]] *(dual-unit — applied P7 adds the matrix identity by induction and the $F(2k)$ / $F(2k{+}1)$ **doubling identities** that halve the index)*
- *Applied P8–P17 **deliberately not noted** — P8–P14 repeat P1–P3's telescoping; P15 (Master Theorem proof), P16 (Strassen), P17 ($T(\sqrt n)$ substitution) are lecturer-flagged supplementary, and the Master Theorem already sits as a 🔭 block in [[Solving Recurrences (Telescoping)]].*

### Week 3 — Proof of Correctness and the Non-Comparison Sorts *(decks p1 Correctness · p2 Comparison-Based · p3p4 Counting & Radix · prep W3 · applied W3)*
- [[Invariant]] -> [[Algorithm]] *(dual-unit — **the W3 spine**: correctness $=$ **termination** $+$ **loop invariant**; owns the exam protocol "explain why this algorithm is correct" · **prep**: P1 `find_min` quotes its invariant at the **start** of an iteration, P2 [[Linear Search]] at the **end** — no early exit ⟹ it returns the **last** match)*
- [[Binary Search]] -> [[Divide and Conquer]] *(dual-unit — deepened with the **non-termination bug**: `lo = mid` stalls at $hi{=}lo{+}1$)*
- [[Sorting Problem]] -> [[Computational Problem]] *(dual-unit — comparison vs non-comparison, the $\Omega(N\log N)$ floor, the $O(k)$ comparison-cost multiplier, the recursion-stack/in-place rule · **applied `[P,C,D]`**: §5 forcing stability · §7 the dropped cost terms · §8 what sorting is FOR, incl. two-pointer dedup)*
- [[Counting Sort]] -> [[Sorting Problem]] *(non-comparison $\Theta(N{+}M)$; stability must be **engineered** via a prefix-sum position array · **negative-key offset** mapping · the PT-01 rule for bucket vs count$+$position)*
- [[Radix Sort]] -> [[Counting Sort]] *($K$ stable counting passes, LSD first — $\Theta(KN{+}KM)$; stability is load-bearing · base $b\le N$ buys linearity · string optimisation by length and alignment)*
- [[K-way Merge]] -> [[Merge Sort]] *(applied P3 `[P,C]` — $\Theta(Nk)$ ➔ $\Theta(N\log k)$ by swapping the linear scan for a min-[[Heap]])*
- [[Online Algorithm]] -> [[Algorithm]] *(applied P6 `[P,C,D]` — online vs offline, and the size-$k$ **max**-heap for the $k$ smallest)*
- *Prep P3 (radix on `4329, 5169, 4321, 3369, 2121, 2099`) duplicates the LSD hand-trace in [[Radix Sort]].*
- *Applied P7–P13 **deliberately not noted** — one-off puzzles with no transferable pattern. The only two keepers (the comparison model bounds only from below; "in-place" depends on the cost model) live as `[D]` lines in [[FIT2004 Unit Cheatsheet]] §9️⃣.*

### Week 4 — QuickSort Deep Dive, Selection, and the Partition Suite *(lecture W4 p1/p2 · prep W4 · applied W4 · PT-01)*
- [[Quick Sort]] -> [[Divide and Conquer]] *(dual-unit — the pivot-policy ladder, the **average-case height** $h=\log_{4/3}N$, why the sort is **never** in-place · **prep §3**: a **minimum** pivot is $\Theta(n^{2})$ in the *best* case too, a $10$th-percentile pivot is still $\Theta(n\log n)$ · **applied**: the **mean-pivot** trap on $a_i=i!$ ⟹ $\Theta(n^{2})$, and **cross-pivoting** to match $n$ locks to $n$ keys)*
- [[Partitioning (Quicksort)]] -> [[Quick Sort]] *(out-of-place vs Hoare's vs Lomuto's vs Dutch national flag; invariants, swap counts, and why each is unstable for a **different** reason · **prep**: the unit notes' **naive 3-way** partition traced beside Hoare's on one array — duplicates grouped vs scattered · **applied §6**: **$k$-partitioning**, $\Theta(nk)$ ➔ $\Theta(n\log k)$ by D&C, optimal by **reduction to sorting**)*
- [[Quickselect]] -> [[Divide and Conquer]] *(the $k$-th smallest — **one-sided** recursion turns $\Theta(N\log N)$ into $\Theta(N)$ expected; an **exact-median** pivot still leaves quicksort $\Theta(N^{2})$ · **applied §6**: the **coin-flip** expected-$O(n)$ argument · the **weighted median** · the $k$ **closest to the median** in $\Theta(n)$ · `[D]` order statistic across two sorted arrays)*
- [[Median of Medians]] -> [[Quickselect]] *(**scope changed** — the W4 deck strikes "not examinable" and writes **examinable from 2023 onwards**; own the **hand execution**, the $30/70$ guarantee, the co-recursion, and $\tfrac15+\tfrac{7}{10}<1$)*
- [[Merge Sort]] -> [[Divide and Conquer]] *(**applied §4**: the **hybrid cut-off** — mergesort to size $k$ then insertion sort $=\Theta(nk+n\log\tfrac{n}{k})$)*
- *Applied P8 (iterative quickselect) is already the note's implementation, and P9 (order statistic of two sorted arrays) is one `[D]` bullet in [[Quickselect]] §6 — do not spend `[P]` time on either.*

### Week 5 — Graphs, Traversal, and Shortest Paths *(lecture W5 p1 Graph Traversal $+$ Dijkstra · p2 Directed Acyclic Graph · applied W5)*
- [[Graph]] -> [[Binary Relation]] *(dual-unit — directed/weighted $G=(V,E,W)$, **simple** graphs, max edges $V(V-1)$ vs $\tfrac{V(V-1)}{2}$, and the **sparse/dense** split every later bound depends on)*
- [[Graph Representations]] -> [[Graph]] *(dual-unit — matrix $\Theta(V^{2})$/$O(1)$ lookup/$O(V)$ neighbours vs list $\Theta(V+E)$/$O(X)$ output-sensitive; **the representation, not the algorithm, sets the bound** — LO3)*
- [[Uninformed Search (BFS and DFS)]] -> [[Search Problem Formulation]] *(dual-unit — discovered/visited states, the $\Theta(V+E)$ derivation, the $O(1)$ **flag** that makes it hold, unweighted shortest **distance $+$ path**)*
- [[Dijkstra's Algorithm]] -> [[Graph]] *(DP $+$ greedy, relaxation, min-[[Heap]] with an index map, $O(E\log V)$, the **proof by contradiction**, and exactly why a negative edge breaks it)*
- [[Directed Acyclic Graph (DAG)]] -> [[Types of Graphs]] *(the dependency model; acyclicity is what makes an order exist)*
- [[Topological Sort]] -> [[Directed Acyclic Graph (DAG)]] *(Kahn's peel-the-sources vs DFS **push-on-finish**, both $\Theta(V+E)$; the answer is never unique)*
- [[Bipartite Graph]] -> [[Graph]] *(dual-unit, **upgraded** — applied P1/P2/P8: the greedy $\Theta(V+E)$ DFS two-colouring, the first colour is **free** and every other is forced · $2^{c}$ colourings for $c$ components, $0$ if any fails · bipartite $\iff$ two-colourable, so one algorithm answers both)*
- [[Cycle Detection]] -> [[Uninformed Search (BFS and DFS)]] *(**new** — applied P3/P10: the **third vertex state** (`active`) and why the undirected rule false-positives on a diamond · undirected existence is $O(V)$, **independent of $E$** · P6 shortest cycle by BFS from **every** source · P7 pure-cycle components by $\deg(v)=2$)*
- [[State-Space Graph Modelling]] -> [[Graph]] *(**new** — applied P5, the flagship **LO1** note: a needed **revisit** proves the vertex is not a sufficient state ⟹ $\langle\text{vertex},\text{was previous edge dotted}\rangle$, legality wired into **which edges exist**, answer $=\min$ over all accepting states)*
- [[Uninformed Search (BFS and DFS)]] -> [[Search Problem Formulation]] *(**applied**: P4 multi-source BFS and the **super source** — transform the input, keep the algorithm a black box, subtract $1$ · P9 iterative DFS, testing `visited` **on pop**)*
- [[Topological Sort]] -> [[Directed Acyclic Graph (DAG)]] *(**applied `[D]`**: P11 a guaranteed position in **every** order is a **reachability** question, $r\ge n-m$ / $s\ge m$, $O(V^{2}+VE)$ · P12 a **Hamiltonian path** in a DAG exists iff the topological order is unique)*
- [[Graph Representations]] -> [[Graph]] *(**applied `[D]`**: P13 the **universal sink** in $O(V)$ — one candidate eliminated per matrix cell read, live candidates in a linked list)*
- [[Bridges (Low-Link)]] -> [[Uninformed Search (BFS and DFS)]] *(**new**, **applied `[D]`** P14 — bridge $\iff$ on no cycle $\iff$ $\texttt{low\_link}[v]>\texttt{dfs\_ord}[u]$, all $E$ edges decided in **one** $\Theta(V+E)$ DFS)*

### Week 6 — Minimum Spanning Trees, Union-Find and the Greedy Paradigm *(lecture W5 p2 MST · prep W6 · applied W6)*
- [[Minimum Spanning Tree]] -> [[Spanning Tree]] *(**new** — the hub: $\lvert V\rvert-1$ edges so only **weights** discriminate · cost unique, tree **not** · **negative weights are legal** (the week's most-asked short answer) · **applied P4** the bottleneck-path theorem and its false converse · **applied P5** reverse-delete and the **superset** invariant)*
- [[Prim's Algorithm]] -> [[Minimum Spanning Tree]] *(**new** — [[Dijkstra's Algorithm|Dijkstra]] with **one line** changed, `v.distance = w`; $O(E\log V)$; grows one tree so no cycle test · **prep P2** the root-$a$ hand trace)*
- [[Kruskal's Greedy Algorithm]] -> [[Minimum Spanning Tree]] *(dual-unit, **upgraded** — sort $+$ `find(u) != find(v)`; the implementation ladder $O(EV)\to O(E\log V)\to$ all-sort · the **subset-of-some-MST** invariant and its cut-and-swap proof · **applied P10** a true invariant that is still too weak)*
- [[Union-Find (Disjoint Set)]] -> [[Set (ADT)]] *(**new** — one `parent` array, negative $=$ root size/rank · union-by-size, union-by-rank, path compression · **prep P3** the 10-element hand trace · **applied P8** the $\text{size}\ge2^{\text{height}}$ induction ⟹ $O(V\log V)$ for all unions)*
- [[Greedy Algorithm]] -> [[Algorithm]] *(**new** — the paradigm behind all three: greedy-choice $+$ optimal substructure, proved by **exchange** or **stays ahead** · **applied P7** interval scheduling by earliest finish time, and the ranking rules that fail)*
- [[Dijkstra's Algorithm]] -> [[Graph]] *(**applied**: P1 the *update-only-on-discovery* bug and how to break it · P3 **state-graph** modelling (fuel $\times$ town) · P6 **$0$-$1$ BFS** on a deque in $\Theta(V+E)$ · P9 the **bucket** priority queue for bounded integer weights)*

### 🔭 Coming later in the unit *(from the handbook outline — no notes yet)*
- Amortised analysis · **dynamic programming** (the king — recurrence → memo table → trace) · balanced BSTs (AVL), B-trees, tries · the remaining graph algorithms (**Bellman-Ford**, **Floyd-Warshall**, network flow) · hashing.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = competency-test hand skill)*

- **W1a — analysis first, then the algorithm:** [[Algorithmic Complexity]] *(what we measure)* → **[[Big-O Notation]]** *(bound vs case)* → [[Arithmetic Series]] · [[Geometric Series]] *(the summation tools)* → **[[Solving Recurrences (Telescoping)]]** *(solving $T(n)$)* → [[Divide and Conquer]] → [[Merge Sort]] end-to-end · bounds drill on [[Binary Search Tree (BST)]]
- **W2a — the whole pipeline on one function:** [[Algorithmic Complexity]] *(§6 input vs auxiliary space)* → **[[Analysing Recursive Algorithms (Time and Auxiliary Space)]]** *(code ➔ recurrence ➔ time + space)* → [[Solving Recurrences (Telescoping)]] *(the branching row)* → [[Binary Search]] *(best $\ne$ worst)* → [[Output-Sensitive Complexity]] *(bounds carrying $W$)*
- **W2b — the applied sheet, recurrences then new problems:** **[[Solving Recurrences (Telescoping)]]** *(D4 $\Theta(2^{n})$ · induction blueprint)* → [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] *(duplicate-call trap)* → [[Divide and Conquer]] *(§3 adaptation checklist)* → **[[Counting Inversions]]** *(instrument the combine)* → **[[2D Local Maximum (Peak Finding)]]** *(shrink both axes)* → [[Fibonacci Sequence]] *(§4 doubling)*
- **W3a — prove it, then rank it:** **[[Invariant]]** *(termination + invariant)* → [[Binary Search]] *(§3 non-termination bug)* → **[[Sorting Problem]]** *(four-axis suite + the $\Omega(N\log N)$ floor)* → **[[Counting Sort]]** *(escape the floor)* → **[[Radix Sort]]** *(escape the $M$ blow-up)*
- **W3b — the applied suite, in CD1 order:** **[[Sorting Problem]]** *(§5 stability, §7 cost terms, §8 uses)* → **[[K-way Merge]]** *(ADT swap ⟹ $\Theta(N\log k)$)* → **[[Radix Sort]]** *(§3 base choice, §5 strings)* → **[[Online Algorithm]]** *(size-$k$ heap)*
- **W4a — partition, then stop sorting:** **[[Quick Sort]]** *(driver, pivot policy, average case)* → **[[Partitioning (Quicksort)]]** *(three schemes $+$ Dutch flag)* → **[[Quickselect]]** *(recurse one side)* → **[[Median of Medians]]** *(the guarantee — now examinable)*
- **W4b — the applied partition suite:** **[[Quick Sort]]** *(§3 pivot rules)* → **[[Partitioning (Quicksort)]]** *(naive 3-way · $k$-partitioning)* → **[[Quickselect]]** *(§6 adaptations)* → [[Merge Sort]] *(hybrid cut-off)*
- **W5a — the structure, then the traversal:** [[Graph]] *(directed, weighted, sparse vs dense)* → **[[Graph Representations]]** *(the bound lives here)* → **[[Uninformed Search (BFS and DFS)]]** *($\Theta(V+E)$, unweighted distance)* → **[[Dijkstra's Algorithm]]** *(queue ➔ min-heap)*
- **W5b — order instead of distance:** [[Directed Acyclic Graph (DAG)]] *(acyclicity is the precondition)* → **[[Topological Sort]]** *(Kahn's · push-on-finish)*
- **W5c — the applied sheet, traversal recast:** **[[Bipartite Graph]]** *(greedy colouring, $2^{c}$)* → **[[Cycle Detection]]** *(the third state)* → [[Uninformed Search (BFS and DFS)]] *(§7 super source)* → **[[State-Space Graph Modelling]]** *(state in the vertex)*
- **W5d — the applied sheet, D/HD tier:** [[Topological Sort]] *(§4 reachability guarantees · §5 Hamiltonian path)* → [[Graph Representations]] *(§3 universal sink in $O(V)$)* → [[Bridges (Low-Link)]] *(low-link in one DFS)*
- **W6a — the object, then the two builders:** [[Minimum Spanning Tree]] *(what is being minimised)* → **[[Prim's Algorithm]]** *(Dijkstra, one line changed)* → **[[Kruskal's Greedy Algorithm]]** *(sort $+$ cycle test)* → **[[Union-Find (Disjoint Set)]]** *(the test, made free)*
- **W6b — why the greed is allowed:** [[Greedy Algorithm]] *(choice property $+$ substructure)* → **[[Kruskal's Greedy Algorithm]]** *(§4 cut-and-swap)* → [[Minimum Spanning Tree]] *(§5 reverse-delete, superset)* → [[Invariant]] *(weak vs sufficient)*
- **W6c — the applied sheet, shortest paths revisited:** **[[Dijkstra's Algorithm]]** *(§4 deque · bucket queue, §5 state graph)* → [[Greedy Algorithm]] *(§4 interval scheduling)* → **[[Union-Find (Disjoint Set)]]** *(§Applied the height lemma)*

## 🎯 Learning Outcomes (key skills per week)
- **W1** ➔
	- measure cost against **input size** (often **bit-length**) on the RAM model; split space into **input** $+$ **auxiliary**, label $O(1)$ auxiliary **in-place**, and use **time $\ge$ auxiliary space** as a self-check
	- set up a running-time recurrence $T(n)=a\,T(n/b)+f(n)$, then solve it by **telescoping** in the mandated **Steps 0→6b** format (levels → substitute → general form in $k$ → fix $k$ from the base → closed form → complexity → **verify base + general**) — the **required** method: it covers $T(n-1)$ *and* $T(n/b)$ and yields $\Theta$, where the Master Theorem covers only $T(n/b)$ and yields $O$
	- read $a$ (recursive calls) and $b$ (shrink factor) off code and classify by $r=a/b$ — root-dominated $\Theta(n)$ · all-levels-equal $\Theta(n\log n)$ · leaf-dominated $\Theta(n^{\log_b a})$
	- derive schoolbook multiply as $\Theta(n^2)$ and the naive D&C split as $4T(n/2)+\Theta(n)=\Theta(n^2)$
	- state $O/\Omega/\Theta$ **formally with witnesses**; judge a bound **valid** separately from **tight** ($3n^2{+}100n=O(n^3)$ TRUE, $\Theta(n^3)$ FALSE), and pair every bound with a **case** — "any operation" bounds cheapest and dearest, so an unqualified $\Theta$ needs them to agree
	- prove $\sum i=\tfrac{n(n+1)}{2}$ and $\sum r^{i}=\tfrac{r^{n+1}-1}{r-1}$ by induction, then **substitute** for $r{=}2$ and $r{=}\tfrac12$
	- drop **capped** parameters ($n\le10^6$, $arr[i]<2^{32}$ ⟹ $\Theta(1)$) and declare the **unit-cost** assumption
- **W2** ➔
	- extract a **piecewise** recurrence from code — base $T(n)=a$ at the guard threshold, general $T(n)=aT(\cdot)+c$ — counting $a$ as **call sites**, not coefficients (`2*f(n//3)` is $T(n/3)+c$; `f(n//3)+f(n//3)` is $2T(n/3)+c$)
	- quote **auxiliary space** as $\Theta(\text{max stack depth})$, never $\Theta(\text{total calls})$ — hence [[Merge Sort]]'s $\Theta(N{+}\log N)=\Theta(N)$ — and separate time from space on a **branching** recursion (Fibonacci $O(2^{N})$ time, $\Theta(N)$ space)
	- state a reporting bound with its **output size** $W$ and prove $\Omega(\log N{+}W)$ optimality
	- telescope $T(n)=2T(n-1)+a$ to $2^{n}b+(2^{n}-1)a=\Theta(2^{n})$ via the $r{=}2$ series
	- prove a **given** closed form by induction over $n{=}2^{k}$ — the step is $T(2m)$, never $T(m{+}1)$
	- collapse two identical recursive calls into one binding ⟹ $\Theta(p)\to\Theta(\log p)$
	- count split inversions in **blocks** during a merge ⟹ $\Theta(N^{2})\to\Theta(N\log N)$
	- shrink **both** matrix axes for $\Theta(n)$ peak finding, and justify discarding three quadrants
	- read $F(2k)$ and $F(2k{+}1)$ off the Fibonacci matrix power, eliminating $F(k{-}1)$
- **W3** ➔
	- prove an algorithm correct by stating **both** obligations — loop invariant **and** termination — writing the termination as *finite domain · known start · monotone update* (`find_min`) and naming the **variant** that strictly decreases, plus where it fails (`lo = mid` at $hi{=}lo{+}1$)
	- write the invariant **first**, then code to it: minimal, data-mentioning, implies the postcondition — and quote it at the **end** of an iteration when there is no early exit (`linear_search` returns the **last** match)
	- state selection sort's two-clause invariant and insertion sort's sorted-prefix invariant
	- rank the sorting suite on **four** axes (correctness, time B/A/W, **auxiliary** space, stability), multiplying every comparison-based bound by the comparison cost $O(k)$ and counting the **recursion stack** as auxiliary ⟹ recursive sorts are **not in-place**
	- justify the $\Omega(N\log N)$ floor as a claim about **comparison-based** sorts only
	- derive [[Counting Sort]]'s $\Theta(N{+}M)$, engineer stability via the **prefix-sum position array**, map negative keys by offset, and reject the $\Theta(N\cdot M)$ bucket-space misconception (buckets partition $N$ ⟹ $\Theta(M{+}N)$)
	- run [[Radix Sort]] LSD-first by hand, justify why the subsort **must** be stable, and derive $\Theta(KN{+}KM)$ time, $\Theta(KN{+}M{+}N)$ space, $\Theta(M{+}N)$ auxiliary (**no $K$**)
	- trade base $M$ against column count $K=\lceil\log_M(\text{max key})\rceil$, pad ragged keys, choose $b\le N$ and prove $M=O(N^{d})\Rightarrow\Theta(N)$
	- radix-sort ragged strings in $\Theta(n)$ *(total characters)* — length-sort ascending, then sweep with a live-window pointer
	- force stability on an unstable sort via a parallel index list, proving **time is unchanged**
	- swap [[K-way Merge]]'s $\Theta(k)$ minimum scan for a min-[[Heap]] ⟹ $\Theta(N\log k)$, and state the root invariant
	- classify a problem **online vs offline** before quoting any bound, picking the size-$k$ heap on the **opposite** extreme
	- prove a bound **optimal by reduction** — singleton lists turn [[K-way Merge]] into a sort, inheriting $\Omega(N\log N)$
	- let an **in-place** requirement pick the sort — dedup needs [[Heapsort]], the only $O(1)$-auxiliary $\Theta(N\log N)$ option
	- `[D]` the comparison model proves $\Omega$, never $O$ — optimal comparisons $\ne$ optimal running time
- **W4** ➔
	- **state which partition contract you are using** — this unit's Hoare parks the pivot and returns its **final index** (recurse `j-1` / `j+1`); the textbook Hoare returns a **split point** that stays on the left (recurse `j` / `j+1`)
	- rank the three schemes by **writes**, not comparisons; reach for the 3-way Dutch flag once duplicates are common; and explain why out-of-place partitioning is **still** unstable, with the third-buffer repair
	- state Hoare's `L_bad`/`R_bad` invariants and the Dutch flag's **four** regions, one empty at exit
	- derive the average-case height from $N(\tfrac34)^{h}=1\Rightarrow h=\log_{4/3}N$, then $2h=\Theta(\log N)$ by **change of base**
	- say why quicksort is **never** in-place even with an in-place partition — the $\Theta(\log N)$ stack is auxiliary
	- price sort-then-slice at $O(NM\log N)+O(k)$ and say why [[Counting Sort]]/[[Radix Sort]] cannot be **assumed**
	- derive [[Quickselect]]'s $T(N)=T(N/2)+\Theta(N)=\Theta(N)$, say where quicksort's $\log N$ went, and show an **exact-median** pivot still leaves quicksort $\Theta(N^{2})$ via $N^{2}+\tfrac{N^{2}}{2}+\tfrac{N^{2}}{4}+\dots$
	- run [[Median of Medians]] **by hand** on groups of five, check the $30/70$ band, and state the $\tfrac15+\tfrac7{10}<1$ recurrence and why groups of $5$ not $3$
	- rank pivot policies by what each removes — randomisation kills the *adversary*, [[Median of Medians]] kills the *case* — and read any rule for **proportional** reduction (minimum, $10$th percentile, mean): a constant-**fraction** split ($1{:}9$) is still $\Theta(N\log N)$, only constant-**size** splits are $\Theta(N^{2})$
	- generalise partitioning to $k$ pivots, $\Theta(n\log k)$, optimal by **reduction**
	- adapt [[Quickselect]] to the **weighted median** and the $k$ **closest to the median**
- **W5** ➔
	- state $G=(V,E)$ or $G=(V,E,W)$, declare **directed** / **weighted** / **simple**, quote max edges (directed $V(V-1)$, undirected $\tfrac{V(V-1)}{2}$, both $O(V^{2})$), and classify **sparse** or **dense** *before* quoting any bound
	- pick matrix vs list from the operation mix and state the resulting traversal bound
	- derive $\Theta(V+E)$ — each vertex served once, each edge inspected twice — naming the $O(1)$ `discovered` flag as the reason no queue scan happens
	- trace BFS and DFS writing **both** the `Discovered` and `Visited` rows, getting unweighted distance from `u.distance + 1` and the path from `v.previous`
	- explain [[Dijkstra's Algorithm|Dijkstra]] as **dynamic programming $+$ greedy**, and where the greed dies
	- hand-trace Dijkstra, writing every vertex's distance **estimate** at every serve
	- derive $O((V+E)\log V)=O(E\log V)$, and place the slide's $O(V^{2}\log V)$ as the dense case
	- prove Dijkstra correct by contradiction, pointing at the step that spends non-negativity
	- define a **DAG** and say why acyclicity is the existence condition for an order
	- run **Kahn's** and the **push-on-finish DFS**, detecting a cycle from a short output, and reject a DFS **pre-order** as a topological order with the counterexample
	- two-colour a graph by greedy DFS, justify why the first colour is free, and count the colourings as $2^{c}$ over components
	- upgrade DFS to **three** states for a digraph, firing only on an edge into an **active** vertex, and say why the undirected rule false-positives
	- justify $O(V)$ — not $\Theta(V+E)$ — for undirected cycle existence, from *forest $\Rightarrow E\le V-1$* plus early termination
	- find the **shortest** cycle by BFS from every vertex, $O(V(V+E))$, and say why one BFS returns the wrong one
	- solve multi-source shortest path by **super source** $+$ subtract $1$, and defend transforming the input over modifying the algorithm
	- model a constraint as $\langle\text{vertex},\text{extra}\rangle$, wire only legal transitions, and answer $\min$ over **all** accepting states
	- `[D]` eliminate one candidate per matrix cell for a universal sink in $O(V)$; decide bridges by $\texttt{low\_link}[v]>\texttt{dfs\_ord}[u]$; bound a guaranteed topological position by $r\ge n-m$ / $s\ge m$; decide a DAG Hamiltonian path by order uniqueness
- **W6** ➔
	- define an MST and justify $\lvert V\rvert-1$ edges as **both** the minimum that connects and the maximum that avoids a cycle ⟹ only the **weights** discriminate between spanning trees
	- answer "can Prim/Kruskal take negative weights?" with **yes** and two justifications — they only **compare** edges, and shifting every weight by $+c$ raises every spanning tree by exactly $(\lvert V\rvert-1)c$
	- derive [[Prim's Algorithm|Prim]] from [[Dijkstra's Algorithm|Dijkstra]] by changing `v.distance = u.distance + w` to **`v.distance = w`**, and hand-trace it from a named root writing every key as $w,\text{parent}$
	- hand-trace [[Kruskal's Greedy Algorithm|Kruskal]] in sorted-edge order, writing the `find` roots and the forest after every accept/reject, and stopping at $\lvert V\rvert-1$ edges
	- state the **cut-and-swap** exchange proof for both MST algorithms, and name the invariant *subset of some MST* (Kruskal) vs *superset of some MST* (reverse-delete)
	- reject a **true but too weak** invariant with a counterexample, quoting the rule invariant $+$ termination $\Rightarrow$ postcondition
	- prove that every path in an MST is a **bottleneck path**, and give a bottleneck path that lies in no MST
	- encode [[Union-Find (Disjoint Set)|union-find]] as one `parent` array (positive $=$ parent, negative $=$ root size/rank), hand-trace $10$ unions under **union-by-size** with the stated tie-break, and say where path compression changes the final height
	- prove $\text{size}(r)\ge2^{\text{height}(r)}$ by induction ⟹ $O(\log V)$ per union ⟹ $O(V\log V)$ for all $V-1$ unions
	- locate the factor of $V$ in naive-set Kruskal (it is in **union**, not `find`) and quote the ladder $O(EV)\to O(E\log V)\to\Theta(E\log E)$
	- name the greedy paradigm's two ingredients and pick the right proof template — **exchange** for MST, **stays ahead** for scheduling
	- solve interval scheduling by **earliest finish time**, prove $f_{i_k}\le f_{j_k}$ by induction, and kill shortest-duration with $(1,10),(9,12),(11,20)$
	- replace the priority queue when the weights allow — a **deque** for $\{0,1\}$ and a **bucket array** for $0\le w\le c$, both $\Theta(V+E)$ — and keep the relaxation test that plain BFS drops
	- model an extra resource as a **state graph** ($\langle\text{town},\text{litres}\rangle$, weight-$0$ travel edges, weight-$p_u$ refuel edges) and run Dijkstra unmodified
	- break "update only on first discovery" with an expensive first route and a cheap later one
