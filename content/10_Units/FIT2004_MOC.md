---
unit: FIT2004
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2004: Algorithms and Data Structures

> [!INFO] Map of Content
> Index for **FIT2004 Algorithms and Data Structures** (Y2S1) — builds on [[FIT1008_MOC]]: shared foundations (Big-O, recursion, D&C, merge sort) deepened with **correctness proofs** and **recurrence analysis**.

## 📊 Assessment Map (2026 S2)
Tiered framework — **"Easy to Pass, Hard to Distinction (D/HD)."**

| Tier | Marks | Format | Hurdles to sit / pass |
| :--- | :--- | :--- | :--- |
| **Pass — PT1, PT2, PT3** | base $50$ | 75-min on-campus closed-book Moodle under SEB | **§1** binary Competent/Not: $\ge80\%$ (4/5), up to **3 check-attempts** per question · **§2** optional written, $+3$ bonus each |
| **Credit — CD1, CD2** | $+10$ | 15-min 1-on-1 Zoom oral, closed-book, screen sharing · **no reattempts** | §1 $+3$ (guided prompts) · §2 $+2$ (advanced unguided) · needs **all PTs Competent**, $\ge50\%$ weekly quizzes, timely EOI form |
| **D/HD Exam** | $+31$ | 3-hour written paper, on-campus **Week 15**, closed-book; covers unit content **and beyond**, high failure/zero-mark rate | all PTs Competent **by PTR1**, $\ge9/12$ weekly quizzes at 100%, **pre-exam score $\ge60$** |

- **Safety net** ➔ PTR1/PTR2 reattempts cover missed competencies, but **bonus marks are forfeited**.
- **PT-03 scope** ➔ W9 tries/suffix structures **and** W10 self-balancing trees — may start from a half-built tree and mix insert with delete · **no CD question on W10** · **plus two pass-level flow questions** (W11–12 sanity-check doc): **run max-flow/min-cut** by hand from a blank or mid-stage network ([[Ford-Fulkerson Method]], [[Min-Cut Max-Flow Theorem]]) and **model a scenario** — vertices, directed edges, edge count, capacities, lower bounds, demands ([[Network Flow Reductions]], [[Circulation with Demands and Lower Bounds]]).
- **LO thread so far** ➔ analyse running time via recurrences; design divide-and-conquer algorithms; quote tight Big-O with mandatory complexity tables.

## 🧰 Unit Cheatsheet
- 📌 [[FIT2004 Unit Cheatsheet]] — analysis discipline, recurrence regimes, D&C shapes, DP recurrences, per-algorithm bounds

## 📅 Knowledge Index

### Week 1 — Complexity Analysis, Divide & Conquer, and Solving Recurrences *(lecture 1 · applied W1)*
- [[Karatsuba Integer Multiplication]] -> [[Divide and Conquer]] *(**NOT EXAMINABLE** — lecturer-confirmed motivating hook; read for D&C intuition, never drill it)*
- [[Solving Recurrences (Telescoping)]] -> [[Big-O Notation]] *(the analysis hand skill — repeated substitution; Master Theorem supplementary)*
- [[Divide and Conquer]] -> [[Recursion]] *(dual-unit — split/recurse/combine, analysed via recurrences)*
- [[Algorithmic Complexity]] -> [[Algorithm]] *(dual-unit — input size, RAM model, best/avg/worst; $+$ auxiliary space, tightest bound)*
- [[Big-O Notation]] -> [[Algorithmic Complexity]] *(dual-unit — $O/\Omega/\Theta$, dominance, growth ladder)*
- [[Recurrence Relation]] -> [[Sequence (Mathematics)]] *(dual-unit — the maths behind the running-time recurrences)*
- [[Merge Sort]] -> [[Divide and Conquer]] *(dual-unit — the canonical $2T(n/2)+\Theta(n)=\Theta(n\log n)$)*
- **Applied 1** *(assumed background, re-drilled with $\Omega/\Theta$)*: [[Arithmetic Series]] · [[Geometric Series]] *(series bounds for D&C trees)* · [[Binary Search Tree (BST)]] *(bound vs case; sorted inserts $\Theta(n^2)$)*

### Week 2 — Analysing Recursion: Time and Auxiliary Space *(lecture 2 · applied W2)*
- [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] -> [[Recursion]] *(pipeline spine: code ➔ recurrence ➔ time + space; the duplicate-call trap)*
- [[Solving Recurrences (Telescoping)]] -> [[Big-O Notation]] *(**applied**: branching $2T(n{-}1){+}a$ · prove a given closed form by induction)*
- [[Divide and Conquer]] -> [[Recursion]] *(**applied**: §3 the three-question checklist for a new problem, and "strengthen the recursive contract")*
- [[Binary Search]] -> [[Divide and Conquer]] *(dual-unit — decrease-and-conquer; the canonical best $\ne$ worst case)*
- [[Output-Sensitive Complexity]] -> [[Algorithmic Complexity]] *(range reporting — $\Theta(N{+}W)$ vs $\Theta(\log N{+}W)$)*
- [[Counting Inversions]] -> [[Merge Sort]] *(applied P5, flagship LO1: count split inversions in the merge ⟹ $\Theta(N\log N)$)*
- [[2D Local Maximum (Peak Finding)]] -> [[Divide and Conquer]] *(applied P6: $\Theta(n)$ by halving **both** axes; the correctness argument is the deliverable)*
- [[Fibonacci Sequence]] -> [[Recurrence Relation]] *(dual-unit — applied P7: matrix identity + doubling identities)*
- *Applied P8–P17 **not noted** — P8–P14 repeat telescoping; P15–P17 are lecturer-flagged supplementary (Master Theorem sits in a 🔭 block).*

### Week 3 — Proof of Correctness and the Non-Comparison Sorts *(decks p1 Correctness · p2 Comparison-Based · p3p4 Counting & Radix · prep W3 · applied W3)*
- [[Invariant]] -> [[Algorithm]] *(dual-unit — **W3 spine**: correctness $=$ termination $+$ loop invariant)*
- [[Binary Search]] -> [[Divide and Conquer]] *(dual-unit — deepened with the **non-termination bug**: `lo = mid` stalls at $hi{=}lo{+}1$)*
- [[Sorting Problem]] -> [[Computational Problem]] *(dual-unit — comparison vs non-comparison, the $\Omega(N\log N)$ floor, in-place rule)*
- [[Counting Sort]] -> [[Sorting Problem]] *($\Theta(N{+}M)$; stability engineered by the prefix-sum position array)*
- [[Radix Sort]] -> [[Counting Sort]] *($K$ stable LSD passes, $\Theta(KN{+}KM)$; base $b\le N$ buys linearity)*
- [[K-way Merge]] -> [[Merge Sort]] *(applied P3 `[P,C]` — $\Theta(Nk)$ ➔ $\Theta(N\log k)$ by swapping the linear scan for a min-[[Heap]])*
- [[Online Algorithm]] -> [[Algorithm]] *(applied P6 `[P,C,D]` — online vs offline, and the size-$k$ **max**-heap for the $k$ smallest)*
- *Prep P3 (radix on `4329, 5169, 4321, 3369, 2121, 2099`) duplicates the LSD hand-trace in [[Radix Sort]].*
- *Applied P7–P13 **not noted** — one-off puzzles; their two keepers are `[D]` lines in [[FIT2004 Unit Cheatsheet]] §9️⃣.*

### Week 4 — QuickSort Deep Dive, Selection, and the Partition Suite *(lecture W4 p1/p2 · prep W4 · applied W4 · PT-01)*
- [[Quick Sort]] -> [[Divide and Conquer]] *(dual-unit — pivot-policy ladder, average height $\log_{4/3}N$, never in-place)*
- [[Partitioning (Quicksort)]] -> [[Quick Sort]] *(out-of-place · Hoare · Lomuto · Dutch flag; $k$-partitioning in $\Theta(n\log k)$)*
- [[Quickselect]] -> [[Divide and Conquer]] *($k$-th smallest in $\Theta(N)$ expected by one-sided recursion; weighted-median adaptations)*
- [[Median of Medians]] -> [[Quickselect]] *(**now examinable** — hand execution, the $30/70$ guarantee, $\tfrac15+\tfrac{7}{10}<1$)*
- [[Merge Sort]] -> [[Divide and Conquer]] *(**applied**: hybrid insertion-sort cut-off)*
- *Applied P8–P9 already covered in [[Quickselect]] — no extra `[P]` time.*

### Week 5 — Graphs, Traversal, and Shortest Paths *(lecture W5 p1 Graph Traversal $+$ Dijkstra · p2 Directed Acyclic Graph · applied W5)*
- [[Graph]] -> [[Binary Relation]] *(dual-unit — $G=(V,E,W)$, max edges, sparse vs dense)*
- [[Graph Representations]] -> [[Graph]] *(dual-unit — matrix vs list; **the representation sets the bound**)*
- [[Uninformed Search (BFS and DFS)]] *($\Theta(V+E)$ and unweighted shortest path)*
- [[Dijkstra's Algorithm]] -> [[Graph]] *(DP $+$ greedy, $O(E\log V)$, proof by contradiction, why negative edges break it)*
- [[Directed Acyclic Graph (DAG)]] -> [[Types of Graphs]] *(the dependency model; acyclicity is what makes an order exist)*
- [[Topological Sort]] -> [[Directed Acyclic Graph (DAG)]] *(Kahn's vs DFS push-on-finish, both $\Theta(V+E)$)*
- [[Bipartite Graph]] -> [[Graph]] *(dual-unit, **upgraded** — DFS two-colouring in $\Theta(V+E)$, $2^{c}$ colourings)*
- [[Cycle Detection]] -> [[Uninformed Search (BFS and DFS)]] *(**new** — the third `active` state for digraphs; shortest cycle by BFS)*
- [[State-Space Graph Modelling]] -> [[Graph]] *(**new**, flagship **LO1** — put the extra constraint into the vertex)*
- [[Uninformed Search (BFS and DFS)]] *(**applied**: multi-source super source · iterative DFS)*
- [[Topological Sort]] -> [[Directed Acyclic Graph (DAG)]] *(**applied `[D]`**: guaranteed positions · Hamiltonian path iff unique order)*
- [[Graph Representations]] -> [[Graph]] *(**applied `[D]`**: universal sink in $O(V)$)*
- [[Bridges (Low-Link)]] -> [[Uninformed Search (BFS and DFS)]] *(**new**, `[D]` — every bridge in one $\Theta(V+E)$ DFS)*

### Week 6 — Minimum Spanning Trees, Union-Find and the Greedy Paradigm *(lecture W5 p2 MST · prep W6 · applied W6)*
- [[Minimum Spanning Tree]] -> [[Spanning Tree]] *(**new** hub — $\lvert V\rvert-1$ edges, cost unique but tree not, negative weights legal)*
- [[Prim's Algorithm]] -> [[Minimum Spanning Tree]] *(**new** — Dijkstra with one line changed, $O(E\log V)$)*
- [[Kruskal's Greedy Algorithm]] -> [[Minimum Spanning Tree]] *(dual-unit, **upgraded** — sort $+$ `find`, cut-and-swap proof)*
- [[Union-Find (Disjoint Set)]] -> [[Set (ADT)]] *(**new** — `parent` array, union-by-size/rank, path compression)*
- [[Greedy Algorithm]] -> [[Algorithm]] *(**new** — greedy choice $+$ optimal substructure; exchange vs stays-ahead proofs)*
- [[Dijkstra's Algorithm]] -> [[Graph]] *(**applied**: state graphs · 0-1 BFS · bucket queue)*

### Week 7 — Dynamic Programming *(lecture-06 deck DP · DP wrap-up · applied W7)*
- [[Dynamic Programming]] -> [[Algorithm]] *(**new** — **PT-02's subject**: MEMO $=$ subproblem, recurrence on the **output**, reconstruction)*
- [[Coin Change]] -> [[Dynamic Programming]] *(**new** — the PT-02 shape: brute force ➔ greedy fails ➔ DP; decision array)*
- [[Knapsack Problem]] -> [[Dynamic Programming]] *(**new** — unbounded 1-D vs 0/1 2-D state, both $O(NM)$)*
- [[Longest Increasing Subsequence (LIS)]] -> [[Dynamic Programming]] *(**new**, applied P4 — anchored "ending at $i$", answer $\max_i$)*
- [[Longest Common Subsequence (LCS)]] -> [[Dynamic Programming]] *(**new**, applied P5 — two-prefix grid, $\Theta(nm)$; edit distance lives here)*
- [[Maximum Subarray Sum]] -> [[Dynamic Programming]] *(**new**, applied P6 — prefix sums ➔ $\Theta(n)$)*
- [[Interval Dynamic Programming]] -> [[Dynamic Programming]] *(**new** — `DP[i][j]` filled by increasing length)*
- *Applied P12, P15, P16, P18, P20–P22 **not noted** — costumes over covered shapes; moves in [[FIT2004 Unit Cheatsheet]] §1️⃣2️⃣.*
- ⚠️ *Pass roster: rod cutting $=$ unbounded knapsack (not in the deck); edit distance deferred to tutorial videos ➔ held in [[Longest Common Subsequence (LCS)|LCS]].*

### Week 8 — Shortest Paths With Negative Weights *(lecture-07 deck Bellman-Ford/Warshall/Floyd-Warshall · applied W8)*
- [[Bellman-Ford]] -> [[Graph]] *(**new** — negative edges: $\lvert V\rvert-1$ rounds $+$ one check pass, $\Theta(VE)$ · **applied** P2 super source finds *any* cycle in $O(VE)$ · P3 walk `pred` back to extract it)*
- [[Floyd-Warshall]] -> [[Graph]] *(**new** — all-pairs, $\Theta(V^{3})$; absorbs Warshall's transitive closure · **applied** P4 `succ` rebuild in $O(\ell)$ · P5 $-\infty$ post-process · P6 arbitrage on $\log$ rates)*
- [[Johnson's Algorithm]] -> [[Graph]] *(**new**, applied P1/P7 — a constant shift fails, potentials telescope; sparse all-pairs with negatives in $O(VE\log V)$)*
- [[Dijkstra's Algorithm]] -> [[Graph]] *(the W8 contrast — the non-negativity these two remove)*
- *Supplementary P8–P13 **not noted** — P8 is implementation; P9, P10, P12, P13 share one shape, DP over a DAG in reverse topological order (`[D]` line in [[FIT2004 Unit Cheatsheet]] §1️⃣2️⃣); P11 (SPFA) is Bellman-Ford with a queue, same $O(VE)$ worst case.*

### Week 9 — Tries, Suffix Tries and Suffix Trees *(lecture-10 p2 Trie · sanity check W9 · prep W9 · applied W9 · PT-03)*
- [[Trie]] -> [[Tree]] *(**new** — `$` terminal, $O(M)$ search, payload augmentation)*
- [[Suffix Trie and Suffix Tree]] -> [[Trie]] *(**new** — **PT-03's subject**: draw, compress, count nodes)*
- *Suffix array $+$ prefix doubling **not examinable** this semester — one 🔭 block in [[Suffix Trie and Suffix Tree]].*

### Week 10 — Self-Balancing Search Trees *(lecture-11 p1 AVL deck · sanity check W10 · PT-03 notes · prep W10 · applied W10 · no CD content)*
- [[AVL Tree]] -> [[Binary Search Tree (BST)]] *(**new** — `h,bf` annotation, Ian's trinode restructure, delete cascades · applied P1, P4 proof, `[D]` P8 height bound)*
- [[2-3 Tree]] -> [[Tree]] *(**new** — split $+$ promote insert · **top-down** rotate/merge delete, applied P5)*
- [[Left-Leaning Red-Black Tree]] -> [[2-3 Tree]] *(**new** — rotate/flip insert, 2-3 cross-check · applied P6 black-height, P5b conversion)*
- [[Binary Search Tree (BST)]] -> [[Binary Tree]] *(recap — predecessor **or** successor delete · applied P2/P3 proofs, P7 minimal-height build)*

### Week 11 — Network Flow *(lecture-08 deck Network Flow · sanity check W11 · prep W11 · applied W11 · **PT-03**)*
- [[Ford-Fulkerson Method]] -> [[Graph]] *(**new** — residual network, augment by bottleneck, $O(FE)$ pseudo-polynomial · **sanity check**: flow $=$ backward weight, capacity $=$ forward $+$ backward, $O(1)$ twin updates, 🔭 the $O(VE^{2})$ argument)*
- [[Min-Cut Max-Flow Theorem]] -> [[Ford-Fulkerson Method]] *(**new** — cut capacity vs cut flow; why FF is correct · reachability **includes backward edges**, min cut not unique)*
- [[Network Flow Reductions]] -> [[Ford-Fulkerson Method]] *(**new**, the **LO1** note — super source, vertex split, matching, disjoint paths · **credit-discussion** P3/P4: the $r=\{3,1,2\}$ matrix drill and the supercomputer min cut $13$, flipping at penalty $6$)*
- [[Bipartite Graph]] -> [[Graph]] *(**§7 pointer** — maximum matching is a flow problem)*

### Week 12 — Circulation with Demands and Lower Bounds *(lecture-09 deck Circulation · applied W12)*
- [[Circulation with Demands and Lower Bounds]] -> [[Ford-Fulkerson Method]] *(**new** — demands via super-edges, lower bounds by pre-push; modelling drills)*
- [[Network Flow Reductions]] -> [[Ford-Fulkerson Method]] *(**applied**: DAG path cover · project selection · fencing)*

### 🔭 Coming later in the unit *(from the handbook outline — no notes yet)*
- Amortised analysis. *(Hashing was removed from the unit in 2025 S1; B-trees continue in FIT3155.)*

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
- **W7a — the paradigm, then the pass-level pair:** **[[Dynamic Programming]]** *(MEMO ➔ recurrence ➔ reconstruct)* → **[[Coin Change]]** *(the PT-02 costume)* → **[[Knapsack Problem]]** *(1-D vs 2-D state)*
- **W7b — the applied shapes, credit tier:** **[[Longest Increasing Subsequence (LIS)]]** *(anchored ⟹ scan)* → **[[Longest Common Subsequence (LCS)]]** *(two prefixes, $+$ edit distance)* → [[Maximum Subarray Sum]] *(prefix sums ➔ $\Theta(n)$)* → [[Interval Dynamic Programming]] *(fill by length)*
- **W8a — the negative-weight escape hatches:** [[Dijkstra's Algorithm]] *(where greed dies)* → **[[Bellman-Ford]]** *($V{-}1$ rounds $+$ the check)* → **[[Floyd-Warshall]]** *(all pairs, $\Theta(V^{3})$)* → [[Graph Representations]] *(density picks the winner)*
- **W8b — the applied sheet:** **[[Bellman-Ford]]** *(§5 super source, extract the cycle)* → **[[Floyd-Warshall]]** *(§4 $-\infty$ · §5 `succ` · arbitrage)* → **[[Johnson's Algorithm]]** *(why a shift fails, why potentials work)*
- **W9 — retrieval by character, then by suffix:** [[Trie]] *(the `$` terminal, $O(M)$, properties)* → **[[Suffix Trie and Suffix Tree]]** *(PT-03: draw, compress, count)* → [[Trie]] *(§4 payload augmentation)* → [[Suffix Trie and Suffix Tree]] *(§4 think in the trie, answer in the tree)*
- **W10 — balance, three ways (PT-03):** [[Binary Search Tree (BST)]] *(why balance)* → **[[AVL Tree]]** *(trinode restructure)* → **[[2-3 Tree]]** *(split · rotate · merge)* → **[[Left-Leaning Red-Black Tree]]** *(rotate · flip, verify via 2-3)*
- **W10b — the applied sheet, proofs then trees:** [[Binary Search Tree (BST)]] *(P2/P3 proofs · §5 min-height build)* → **[[AVL Tree]]** *(P1 · P4 proof · P8 height bound)* → **[[2-3 Tree]]** *(P5 top-down delete)* → **[[Left-Leaning Red-Black Tree]]** *(P6 black-height · P5b conversion)*
- **W11 — push, prove, reduce:** [[Graph]] *(directed, weighted)* → **[[Ford-Fulkerson Method]]** *(residual $+$ augment)* → **[[Min-Cut Max-Flow Theorem]]** *(why it stops at max · find the cut)* → **[[Network Flow Reductions]]** *(build the network)* → [[Bipartite Graph]] *(§7 matching)*
- **W12 — feasibility, then modelling:** [[Ford-Fulkerson Method]] *(the engine)* → **[[Circulation with Demands and Lower Bounds]]** *(§2 super-edges · §3 pre-push $\ell$)* → [[Circulation with Demands and Lower Bounds]] *(§4 survey · airline · roster · baseball)* → **[[Network Flow Reductions]]** *(§3 path cover · §5 $\infty$ edges, project selection, fencing)*

## 🎯 Learning Outcomes (key skills per week)
- **W1** ➔
	- measure cost against **input size** on the RAM model, splitting space into input $+$ **auxiliary** (in-place $=O(1)$ auxiliary)
	- solve a recurrence $T(n)=a\,T(n/b)+f(n)$ by **telescoping** in the mandated Steps 0→6b format — the required method, not the Master Theorem
	- read $a$ (recursive calls) and $b$ (shrink factor) off code and classify by $r=a/b$ — root-dominated $\Theta(n)$ · all-levels-equal $\Theta(n\log n)$ · leaf-dominated $\Theta(n^{\log_b a})$
	- derive schoolbook multiply as $\Theta(n^2)$ and the naive D&C split as $4T(n/2)+\Theta(n)=\Theta(n^2)$
	- state $O/\Omega/\Theta$ formally with witnesses, and judge **valid** separately from **tight** ($3n^2{+}100n=O(n^3)$ but not $\Theta(n^3)$)
	- prove $\sum i=\tfrac{n(n+1)}{2}$ and $\sum r^{i}=\tfrac{r^{n+1}-1}{r-1}$ by induction, then **substitute** for $r{=}2$ and $r{=}\tfrac12$
	- drop **capped** parameters ($n\le10^6$, $arr[i]<2^{32}$ ⟹ $\Theta(1)$) and declare the **unit-cost** assumption
- **W2** ➔
	- extract a piecewise recurrence from code, counting **call sites** not coefficients (`2*f(n//3)` is $T(n/3)+c$)
	- quote auxiliary space as $\Theta(\text{max stack depth})$, never total calls (Fibonacci: $O(2^{N})$ time, $\Theta(N)$ space)
	- state a reporting bound with its **output size** $W$ and prove $\Omega(\log N{+}W)$ optimality
	- telescope $T(n)=2T(n-1)+a$ to $2^{n}b+(2^{n}-1)a=\Theta(2^{n})$ via the $r{=}2$ series
	- prove a **given** closed form by induction over $n{=}2^{k}$ — the step is $T(2m)$, never $T(m{+}1)$
	- collapse two identical recursive calls into one binding ⟹ $\Theta(p)\to\Theta(\log p)$
	- count split inversions in **blocks** during a merge ⟹ $\Theta(N^{2})\to\Theta(N\log N)$
	- shrink **both** matrix axes for $\Theta(n)$ peak finding, and justify discarding three quadrants
	- read $F(2k)$ and $F(2k{+}1)$ off the Fibonacci matrix power, eliminating $F(k{-}1)$
- **W3** ➔
	- prove an algorithm correct with **both** a loop invariant and a termination argument (the strictly decreasing variant)
	- write the invariant first, then code to it — quoted at the **end** of an iteration when there is no early exit
	- state selection sort's two-clause invariant and insertion sort's sorted-prefix invariant
	- rank the sorting suite on time, **auxiliary** space and stability — recursion stack counts, so recursive sorts are not in-place
	- justify the $\Omega(N\log N)$ floor as a claim about **comparison-based** sorts only
	- derive [[Counting Sort]]'s $\Theta(N{+}M)$ and make it stable with the prefix-sum position array
	- run [[Radix Sort]] LSD-first by hand, justify the stable subsort, and derive $\Theta(KN{+}KM)$ time
	- trade base $M$ against column count $K$, and choose $b\le N$ for linear time
	- radix-sort ragged strings in $\Theta(n)$ *(total characters)* — length-sort ascending, then sweep with a live-window pointer
	- force stability on an unstable sort via a parallel index list, proving **time is unchanged**
	- swap [[K-way Merge]]'s $\Theta(k)$ minimum scan for a min-[[Heap]] ⟹ $\Theta(N\log k)$, and state the root invariant
	- classify a problem **online vs offline** before quoting any bound, picking the size-$k$ heap on the **opposite** extreme
	- prove a bound **optimal by reduction** — singleton lists turn [[K-way Merge]] into a sort, inheriting $\Omega(N\log N)$
	- let an **in-place** requirement pick the sort — dedup needs [[Heapsort]], the only $O(1)$-auxiliary $\Theta(N\log N)$ option
	- `[D]` the comparison model proves $\Omega$, never $O$ — optimal comparisons $\ne$ optimal running time
- **W4** ➔
	- state which Hoare contract you use — this unit's returns the pivot's **final index**, the textbook's a split point
	- rank partition schemes by **writes**, switch to the Dutch flag for duplicates, and explain why each is unstable
	- state Hoare's `L_bad`/`R_bad` invariants and the Dutch flag's **four** regions, one empty at exit
	- derive the average-case height from $N(\tfrac34)^{h}=1\Rightarrow h=\log_{4/3}N$, then $2h=\Theta(\log N)$ by **change of base**
	- say why quicksort is **never** in-place even with an in-place partition — the $\Theta(\log N)$ stack is auxiliary
	- price sort-then-slice at $O(NM\log N)+O(k)$ and say why [[Counting Sort]]/[[Radix Sort]] cannot be **assumed**
	- derive [[Quickselect]]'s $T(N)=T(N/2)+\Theta(N)=\Theta(N)$, and why an exact-median pivot still leaves quicksort $\Theta(N^{2})$
	- run [[Median of Medians]] **by hand** on groups of five, check the $30/70$ band, and state the $\tfrac15+\tfrac7{10}<1$ recurrence and why groups of $5$ not $3$
	- rank pivot policies: randomisation beats the adversary, [[Median of Medians]] beats the worst case; constant-**fraction** splits stay $\Theta(N\log N)$
	- generalise partitioning to $k$ pivots, $\Theta(n\log k)$, optimal by **reduction**
	- adapt [[Quickselect]] to the **weighted median** and the $k$ **closest to the median**
- **W5** ➔
	- state $G=(V,E,W)$, quote max edges, and classify sparse vs dense **before** quoting any bound
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
	- `[D]` universal sink in $O(V)$ · bridges by low-link · guaranteed topological positions · DAG Hamiltonian path by unique order
- **W6** ➔
	- define an MST and justify exactly $\lvert V\rvert-1$ edges ⟹ only the weights discriminate
	- answer "negative weights in Prim/Kruskal?" — **yes**: they only compare edges, and a $+c$ shift moves every tree equally
	- derive [[Prim's Algorithm|Prim]] from Dijkstra (`v.distance = w`) and hand-trace it from a named root
	- hand-trace [[Kruskal's Greedy Algorithm|Kruskal]] in sorted-edge order with the `find` roots, stopping at $\lvert V\rvert-1$ edges
	- state the **cut-and-swap** exchange proof for both MST algorithms, and name the invariant *subset of some MST* (Kruskal) vs *superset of some MST* (reverse-delete)
	- reject a **true but too weak** invariant with a counterexample, quoting the rule invariant $+$ termination $\Rightarrow$ postcondition
	- prove that every path in an MST is a **bottleneck path**, and give a bottleneck path that lies in no MST
	- hand-trace [[Union-Find (Disjoint Set)|union-find]] in one `parent` array under union-by-size, with path compression
	- prove $\text{size}(r)\ge2^{\text{height}(r)}$ by induction ⟹ $O(\log V)$ per union ⟹ $O(V\log V)$ for all $V-1$ unions
	- locate the factor $V$ in naive Kruskal (in **union**) and quote $O(EV)\to O(E\log V)\to\Theta(E\log E)$
	- name the greedy paradigm's two ingredients and pick the right proof template — **exchange** for MST, **stays ahead** for scheduling
	- solve interval scheduling by **earliest finish time** and prove it stays ahead
	- replace the priority queue when weights allow — deque for $\{0,1\}$, bucket array for small integers — both $\Theta(V+E)$
	- model an extra resource as a **state graph** ($\langle\text{town},\text{litres}\rangle$) and run Dijkstra unmodified
	- break "update only on first discovery" with an expensive first route and a cheap later one
- **W7** ➔
	- write the **output** recurrence: base, general and edge cases
	- size the MEMO ⟹ auxiliary space; time $=$ cells $\times$ work each
	- separate DP from divide & conquer: **optimal** sub-solutions that **overlap**
	- decide the state: is one parameter enough? *(unbounded vs 0/1 knapsack)*
	- rebuild the combination by decision array or backtracking
- **W8** ➔
	- justify [[Bellman-Ford]]'s $\lvert V\rvert-1$ rounds and its extra check pass
	- find **any** negative cycle with ONE Bellman-Ford from a weight-$0$ super source in $O(VE)$, and extract its vertices by walking `pred` back to a repeat
	- rebuild a [[Floyd-Warshall]] path in $O(\ell)$ from `succ`, and post-process every pair through a negative cycle to $-\infty$ in $O(V^{3})$
	- reduce arbitrage to a negative cycle on $\log$ rates
	- break the constant-shift repair with a counterexample, and prove potential reweighting preserves shortest paths by telescoping
	- select Dijkstra / Bellman-Ford / Floyd-Warshall / [[Johnson's Algorithm|Johnson's]] by weight sign, number of sources and density
- **W9** ➔
	- justify the `$` terminal and its `links[0]` slot, and quote trie search as $O(M)$ with $N$ absent
	- bound a trie by its properties — nodes $O(T)$, leaves $\le N$, height $M+1$ — and choose it over a sorted array, BST or hash table from the query type
	- augment the node payload to answer a query in $O(m)$ — prefix count, scored prefix, predecessor
	- draw the suffix trie of `S$` and compress it to a `[start,end]` suffix tree
	- count nodes, inner nodes, leaves and height of both (PT-03)
	- solve a substring problem in the suffix trie, then translate it to the tree
- **W10** ➔
	- annotate every node `h,bf` with $bf=h(L)-h(R)$ and find the **lowest** node with $\lvert bf\rvert>1$
	- classify LL/RR/LR/RL by two steps down the taller side — a tie on step 2 repeats step 1
	- restructure by Ian's way: median up, smaller left, bigger right, $T_1..T_4$ re-hung in-order
	- delete via predecessor **or** successor and keep rebalancing up to the root
	- justify AVL operations as $O(\log N)$: stored heights, $\le2$ rotations per fix
	- insert into a 2-3 tree by split $+$ promote, cascading to a root split
	- delete from a 2-3 tree top-down — rotate or merge before entering each 2-node (root first), then split leftover 4-nodes on the way out
	- insert into an LLRB as a red leaf and fix by rotate left / rotate right / colour flip, then blacken the root
	- convert 2-3 ⟷ LLRB and check equal black-height on every branch
	- state the LLRB black-height after each insert, and say why it rises only when red reaches the root
	- prove the successor of a two-child node has no left child, and that a new key has exactly one insertion point
	- build a minimal-height BST from sorted keys, prove height $\le\log n$, and prove $\Theta(n\log n)$ optimal by reduction to sorting
	- `[D]` prove AVL height $O(\log n)$ via $n(h)=F(h+2)-1\ge1.5^{h+1}-1$
- **W11** ➔
	- state the capacity constraint and flow conservation, and read $\lvert f\rvert$ off a network
	- draw the residual network — forward $c-f$, backward $f$, zeros dropped, parallels merged
	- hand-run Ford-Fulkerson: path, **residual** bottleneck, augment (cancelling via backward edges), repeat to no path
	- derive $O(FE)$, call it pseudo-polynomial, and quote BFS (Edmonds–Karp) $O(VE^{2})$
	- compute a cut's capacity ($S\to T$ only) and flow (out $-$ in), and prove every cut carries $\lvert f\rvert$
	- prove max-flow $=$ min-cut from residual reachability, and extract the min cut after FF
	- verify a mid-stage PT-03 answer by re-running from blank — same max-flow, possibly a different min cut
	- reduce a new problem to max flow — super source/sink, vertex split, matching with quotas, disjoint paths, min-cut split — and state the read-off
- **W12** ➔
	- state the demand constraint $\text{in}(v)-\text{out}(v)=d_v$ and read a negative demand as a supplier
	- decide circulation feasibility by one max flow — $s\to v$ cap $-d_v$, $v\to t$ cap $d_v$, feasible $\iff$ every super-edge saturated
	- remove lower bounds by pre-pushing $\ell$ — $c^{*}=c-\ell$, $d^{*}_v=d_v-\ell_{\text{in}}+\ell_{\text{out}}$ — then return $f=f_\ell+f^{*}$
	- certify infeasibility with a cut of capacity $<D^{+}$
	- model "at least / at most / exactly" as edge windows and demands — survey design, airline scheduling, rosters, baseball elimination
	- cap a group of edges with a selector vertex
	- reduce DAG minimum path cover to bipartite matching, answer $\lvert V\rvert-\lvert M\rvert$
	- encode prerequisites as $\infty$ edges in a min cut and recover profit $=\sum p^{+}-c(S,T)$
