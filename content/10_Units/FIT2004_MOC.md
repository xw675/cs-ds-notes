---
unit: FIT2004
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2004: Algorithms and Data Structures

> [!INFO] Map of Content
> Index for **FIT2004 Algorithms and Data Structures** (Y2S1) — rigorous algorithmics building on [[FIT1008_MOC]]. Much of the foundational material (Big-O, recursion, divide-and-conquer, merge sort) is **shared dual-unit** with FIT1008/FIT1058 and deepened here with **correctness proofs** and **recurrence analysis** rather than duplicated.

## 📊 Assessment Map (2026 S2)
- Tiered grading framework — **"Easy to Pass, Hard to Distinction (D/HD)."**
- **Pass Tier (Base 50 Marks) — Pass Tests (PT1, PT2, PT3)**
    - **Format:** 75-minute on-campus, closed-book Moodle exams using Safe Exam Browser (SEB).
    - **Section 1 (Pass):** Binary grade (Competent / Not Competent). Requires ≥80% (4/5) with up to 3 check-attempts per question.
    - **Section 2 (Bonus):** Optional written questions (+3 bonus marks each).
    - **Safety Net:** Reattempts (PTR1/PTR2) allowed for missed competencies, but bonus marks are forfeited.
- **Credit Tier (+10 Marks) — Credit Discussions (CD1, CD2)**
    - **Format:** 15-minute 1-on-1 Zoom oral interviews (closed-book, screen sharing). No reattempts.
    - **Structure:** Section 1 (+3 marks, guided prompts) and Section 2 (+2 marks, advanced unguided follow-up).
    - **Prerequisites:** Competent in all PTs, completion of ≥50% weekly quizzes, and timely EOI form submission.
- **Distinction / High Distinction Tier (+31 Marks) — D/HD Exam**
    - **Format:** 3-hour written paper exam on-campus in Week 15 (closed-book, high failure/zero-mark rate, covers unit content and beyond).    
    - **Prerequisites to Sit:** Competent in all PTs by PTR1, ≥9/12 weekly quizzes completed (100%), and a pre-exam score of ≥60 marks.
- **LO thread so far** ➔ analyse running time via recurrences; design divide-and-conquer algorithms; quote tight Big-O with mandatory complexity tables.

## 🧰 Unit Cheatsheet

- 📌 [[FIT2004 Unit Cheatsheet]] — analysis discipline, recurrence regimes, D&C shapes, per-algorithm bounds

## 📅 Knowledge Index

### Week 1 — Complexity Analysis, Divide & Conquer, and Solving Recurrences *(Lectures 1–2)*
- [[Karatsuba Integer Multiplication]] -> Parent Framework: [[Divide and Conquer]] *(**NOT EXAMINABLE** — lecturer-confirmed motivating hook only; read for D&C intuition, never drill it)*
- [[Solving Recurrences (Telescoping)]] -> Parent Framework: [[Big-O Notation]] *(the analysis hand skill — repeated substitution; Master Theorem flagged as supplementary)*
- [[Divide and Conquer]] -> Parent Framework: [[Recursion]] *(dual-unit — split/recurse/combine; analysed via recurrences)*
- [[Algorithmic Complexity]] -> Parent Framework: [[Algorithm]] *(dual-unit — input size, RAM model, best/avg/worst; + auxiliary space, tightest bound)*
- [[Big-O Notation]] -> Parent Framework: [[Algorithmic Complexity]] *(dual-unit — $O/\Omega/\Theta$, dominance, growth ladder)*
- [[Recurrence Relation]] -> Parent Framework: [[Sequence (Mathematics)]] *(dual-unit — the maths behind the running-time recurrences)*
- [[Merge Sort]] -> Parent Framework: [[Divide and Conquer]] *(dual-unit — the canonical $2T(n/2)+\Theta(n)=\Theta(n\log n)$ example)*

**Applied sheet 1 — assumed background, drilled with the new $\Omega/\Theta$ apparatus:**
- [[Arithmetic Series]] -> Parent Framework: [[Algorithmic Complexity]] *(dual-unit — $\sum i=\Theta(n^2)$ by induction; shrink-by-one costs)*
- [[Geometric Series]] -> Parent Framework: [[Summation Notation]] *(dual-unit — $\sum r^i$ closed form; the $r{=}2$ and $r{=}\tfrac12$ corollaries that bound every D&C tree)*
- [[Binary Search Tree (BST)]] -> Parent Framework: [[Binary Tree]] *(dual-unit — the vehicle for bound-vs-case drills; $n$ sorted inserts $=\Theta(n^2)$)*

**Lecture 2 — the recursion analysis pipeline:**
- [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] -> Parent Framework: [[Recursion]] *(the pipeline spine — code ➔ recurrence ➔ time, **and** depth ➔ auxiliary space; owns the **call-site vs coefficient** trap)*
- [[Binary Search]] -> Parent Framework: [[Divide and Conquer]] *(dual-unit — decrease-and-conquer; the canonical best $\ne$ worst case)*
- [[Output-Sensitive Complexity]] -> Parent Framework: [[Algorithmic Complexity]] *(range reporting — $\Theta(N{+}W)$ vs $\Theta(\log N{+}W)$)*

### Week 2 — Proof of Correctness and the Sorting Suite *(decks p1 Correctness · p2 Comparison-Based · p3p4 Counting & Radix)*
- [[Invariant]] -> Parent Framework: [[Algorithm]] *(dual-unit — **the W2 spine**: correctness $=$ **termination** $+$ **loop invariant**; owns the exam protocol "explain why this algorithm is correct")*
- [[Binary Search]] -> Parent Framework: [[Divide and Conquer]] *(dual-unit — deepened with the **non-termination bug**: `lo = mid` stalls at $hi{=}lo{+}1$)*
- [[Sorting Problem]] -> Parent Framework: [[Computational Problem]] *(dual-unit — deepened with **comparison vs non-comparison**, the $\Omega(N\log N)$ floor, the $O(k)$ comparison-cost multiplier, and the recursion-stack/in-place rule)*
- [[Counting Sort]] -> Parent Framework: [[Sorting Problem]] *(non-comparison — $\Theta(N{+}M)$; stability must be **engineered** via a prefix-sum position array)*
- [[Radix Sort]] -> Parent Framework: [[Counting Sort]] *($K$ stable counting passes, LSD first — $\Theta(KN{+}KM)$; stability is load-bearing)*

**Applied sheet 2 — recurrences drilled, then D&C applied to two UNSEEN problems:**
- [[Solving Recurrences (Telescoping)]] -> Parent Framework: [[Big-O Notation]] *(**deepened**: P1 branching-by-subtraction $2T(n{-}1){+}a=\Theta(2^{n})$ · P3 the **Proof Blueprint** — proving a GIVEN closed form by induction over $n{=}2^{k}$, i.e. $T(2m)$ not $T(m{+}1)$)*
- [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] -> Parent Framework: [[Recursion]] *(**deepened**: P4 the **duplicate-call trap** — `POW(x,p/2)*POW(x,p/2)` is $\Theta(p)$, binding it once is $\Theta(\log p)$)*
- [[Counting Inversions]] -> Parent Framework: [[Merge Sort]] *(P5 — the flagship LO1 note: instrument the merge, count split inversions in blocks, $\Theta(N^{2})\to\Theta(N\log N)$)*
- [[2D Local Maximum (Peak Finding)]] -> Parent Framework: [[Divide and Conquer]] *(P6 — $\Theta(n)$ on an $n^{2}$ input; the **correctness argument** is the deliverable, and halving ONE axis silently costs $\Theta(n\log n)$)*
- [[Fibonacci Sequence]] -> Parent Framework: [[Recurrence Relation]] *(dual-unit — P7 deepens it with the matrix identity by induction and the $F(2k)$ / $F(2k{+}1)$ **doubling identities** that halve the index)*
- [[Divide and Conquer]] -> Parent Framework: [[Recursion]] *(**deepened**: §4 the three-question checklist for adapting D&C to a new problem, and "strengthen the recursive contract")*
- *Supplementary problems 8–17 **deliberately not noted** — P8–P14 are telescoping repetitions of P1–P3, and P15 (Master Theorem proof), P16 (Strassen) and P17 (the $T(\sqrt n)$ substitution) are lecturer-flagged supplementary. The Master Theorem already sits as a 🔭 block in [[Solving Recurrences (Telescoping)]].*

### Week 3 — QuickSort Deep Dive, Selection, and the Applied Sorting Suite *(lecture W3 p1/p2 · prep W3 · applied W3 · PT-01)*
- [[Quick Sort]] -> Parent Framework: [[Divide and Conquer]] *(dual-unit — **deepened**: the pivot-policy ladder, the **average-case height** argument $h=\log_{4/3}N$, and why the sort is **never** in-place)*
- [[Partitioning (Quicksort)]] -> Parent Framework: [[Quick Sort]] *(**new** — out-of-place vs Hoare's vs Lomuto's vs Dutch national flag; invariants, swap counts, and why each is unstable for a **different** reason)*
- [[Quickselect]] -> Parent Framework: [[Divide and Conquer]] *(the $k$-th smallest — **one-sided** recursion turns $\Theta(N\log N)$ into $\Theta(N)$ expected; **deepened**: an **exact-median** pivot still leaves quicksort $\Theta(N^{2})$)*
- [[Median of Medians]] -> Parent Framework: [[Quickselect]] *(**scope changed** — the W3 deck strikes "not examinable" and writes **examinable from 2023 onwards**; own the **hand execution**, the $30/70$ guarantee, the co-recursion, and $\tfrac15+\tfrac{7}{10}<1$)*
- [[Counting Sort]] -> Parent Framework: [[Sorting Problem]] *(**deepened**: negative-key offset mapping, and the PT-01 rule for bucket vs count+position variant)*
- [[Radix Sort]] -> Parent Framework: [[Counting Sort]] *(**deepened**: base $b\le N$ is what buys linearity; string optimisation by length and alignment)*

**Prep sheet 3 — last week's obligations, re-drilled before the applied class:**
- [[Invariant]] -> Parent Framework: [[Algorithm]] *(**deepened**: P1 `find_min` quotes its invariant at the **start** of an iteration, P2 [[Linear Search]] at the **end** — no early exit ⟹ it returns the **last** match, so the invariant names the largest $j\le i$)*
- *P3 (radix-sort `4329, 5169, 4321, 3369, 2121, 2099`) duplicates the LSD hand-trace already in [[Radix Sort]] — **no new content**, run it from the PDF as a timed drill.*

**Applied sheet 3 — the CD1 problem set, tier tags as issued:**
- [[Sorting Problem]] -> Parent Framework: [[Computational Problem]] *(**deepened**: §6 forcing stability `[P,C,D]` · §8 the dropped cost terms · §9 what sorting is FOR, incl. two-pointer dedup `[C,D,HD]`)*
- [[K-way Merge]] -> Parent Framework: [[Merge Sort]] *(Problem 3 `[P,C]` — $\Theta(Nk)$ ➔ $\Theta(N\log k)$ by swapping the linear scan for a min-[[Heap]])*
- [[Online Algorithm]] -> Parent Framework: [[Algorithm]] *(Problem 6 `[P,C,D]` — online vs offline, and the size-$k$ **max**-heap for the $k$ smallest)*
- *The supplementary problems 7–13 are **deliberately not noted** — one-off puzzles with no transferable pattern; solve them from the PDF if they come up. The only two ideas worth keeping (the comparison model bounds only from below; "in-place" depends on the cost model) live as `[D]` lines in [[FIT2004 Unit Cheatsheet]] §9️⃣.*

### Week 4 — Graphs, Traversal, and Shortest Paths *(lecture W4 p1 Graph Traversal $+$ Dijkstra · p2 Directed Acyclic Graph · prep W4 · applied W4)*
- [[Graph]] -> Parent Framework: [[Binary Relation]] *(dual-unit — **deepened**: directed/weighted $G=(V,E,W)$, **simple** graphs, max edges $V(V-1)$ vs $\tfrac{V(V-1)}{2}$, and the **sparse/dense** split every later bound depends on)*
- [[Graph Representations]] -> Parent Framework: [[Graph]] *(dual-unit — **deepened**: matrix $\Theta(V^{2})$ / $O(1)$ lookup / $O(V)$ neighbours vs list $\Theta(V+E)$ / $O(X)$ output-sensitive; **the representation, not the algorithm, sets the bound** — LO3)*
- [[Uninformed Search (BFS and DFS)]] -> Parent Framework: [[Search Problem Formulation]] *(dual-unit — **deepened**: discovered/visited states, the $\Theta(V+E)$ derivation, the $O(1)$ **flag** that makes it hold, and unweighted shortest **distance $+$ path**)*
- [[Dijkstra's Algorithm]] -> Parent Framework: [[Graph]] *(**new** — DP $+$ greedy, relaxation, min-[[Heap]] with an index map, $O(E\log V)$, the **proof by contradiction**, and exactly why a negative edge breaks it)*
- [[Directed Acyclic Graph (DAG)]] -> Parent Framework: [[Types of Graphs]] *(**new** — the dependency model; acyclicity is what makes an order exist)*
- [[Topological Sort]] -> Parent Framework: [[Directed Acyclic Graph (DAG)]] *(**new** — Kahn's peel-the-sources vs DFS **push-on-finish**, both $\Theta(V+E)$; the answer is never unique)*

**Prep sheet 4 — last week's quicksort obligations, re-drilled:**
- [[Quick Sort]] -> Parent Framework: [[Divide and Conquer]] *(**deepened**: §3b reading a pivot rule — a **minimum** pivot is $\Theta(n^{2})$ in the *best* case too, while a $10$th-percentile pivot is still $\Theta(n\log n)$)*
- [[Partitioning (Quicksort)]] -> Parent Framework: [[Quick Sort]] *(**deepened**: the unit notes' **naive 3-way** partition named and traced, beside Hoare's on the same array — duplicates grouped vs scattered)*

**Applied sheet 4 — the W3 problem set, adapting the partition to NEW problems:**
- [[Quickselect]] -> Parent Framework: [[Divide and Conquer]] *(**deepened**: §6 the **coin-flip** expected-$O(n)$ argument · the **weighted median** · the $k$ **closest to the median** in $\Theta(n)$ · `[D]` order statistic across two sorted arrays)*
- [[Partitioning (Quicksort)]] -> Parent Framework: [[Quick Sort]] *(**deepened**: §6 **$k$-partitioning** — $\Theta(nk)$ sequential ➔ $\Theta(n\log k)$ by D&C, proved optimal by **reduction to sorting**)*
- [[Quick Sort]] -> Parent Framework: [[Divide and Conquer]] *(**deepened**: the **mean-pivot** trap on $a_i=i!$ ⟹ $T(n)=T(n-2)+\Theta(n)=\Theta(n^{2})$ · **cross-pivoting** to match $n$ locks to $n$ keys)*
- [[Merge Sort]] -> Parent Framework: [[Divide and Conquer]] *(**deepened**: §4 the **hybrid cut-off** — mergesort to size $k$ then insertion sort $=\Theta(nk+n\log\tfrac{n}{k})$)*
- *Supplementary P8 (iterative quickselect) is already the note's implementation, and P9 (order statistic of two sorted arrays) is carried as a single `[D]` bullet in [[Quickselect]] §6 — do not spend `[P]` time on it.*

### 🔭 Coming later in the unit *(from the handbook outline — no notes yet)*
- Amortised analysis · greedy algorithms · **dynamic programming** (the king — recurrence → memo table → trace) · balanced BSTs (AVL), B-trees, tries, union-find · the remaining graph algorithms (**Bellman-Ford**, **Floyd-Warshall**, MST, network flow) · hashing.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = competency-test hand skill)*

- **W1a — analysis first, then the algorithm:** [[Algorithmic Complexity]] *(what we measure)* → **[[Big-O Notation]]** *(formal $O/\Omega/\Theta$, bound vs case)* → [[Arithmetic Series]] · [[Geometric Series]] *(the summation tools)* → **[[Solving Recurrences (Telescoping)]]** *(how to solve $T(n)$)* → [[Divide and Conquer]] → apply it end-to-end on [[Merge Sort]] · drill bounds on [[Binary Search Tree (BST)]]
- **W1b — the whole pipeline on one function:** [[Algorithmic Complexity]] *(§6 input vs auxiliary space)* → **[[Analysing Recursive Algorithms (Time and Auxiliary Space)]]** *(code ➔ recurrence ➔ time + space)* → [[Solving Recurrences (Telescoping)]] *(the branching row)* → [[Binary Search]] *(best $\ne$ worst)* → [[Output-Sensitive Complexity]] *(bounds carrying $W$)*
- **W2 — prove it, then rank it:** **[[Invariant]]** *(termination + invariant)* → [[Binary Search]] *(§3 the non-termination bug)* → **[[Sorting Problem]]** *(the four-axis suite + $\Omega(N\log N)$ floor)* → **[[Counting Sort]]** *(escape the floor)* → **[[Radix Sort]]** *(escape the $M$ blow-up)*
- **W2b — the applied sheet, recurrences then new problems:** **[[Solving Recurrences (Telescoping)]]** *(D4 $\Theta(2^{n})$ · the induction blueprint)* → [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] *(the duplicate-call trap)* → [[Divide and Conquer]] *(§4 the adaptation checklist)* → **[[Counting Inversions]]** *(instrument the combine)* → **[[2D Local Maximum (Peak Finding)]]** *(shrink both axes)* → [[Fibonacci Sequence]] *(§4 doubling)*
- **W3a — partition, then stop sorting:** **[[Quick Sort]]** *(driver, pivot policy, average case)* → **[[Partitioning (Quicksort)]]** *(three schemes $+$ Dutch flag)* → **[[Quickselect]]** *(recurse one side)* → **[[Median of Medians]]** *(the guarantee — now examinable)*
- **W4a — the structure, then the traversal:** [[Graph]] *(directed, weighted, sparse vs dense)* → **[[Graph Representations]]** *(the bound lives here)* → **[[Uninformed Search (BFS and DFS)]]** *($\Theta(V+E)$, unweighted distance)* → **[[Dijkstra's Algorithm]]** *(queue ➔ min-heap)*
- **W4b — order instead of distance:** [[Directed Acyclic Graph (DAG)]] *(acyclicity is the precondition)* → **[[Topological Sort]]** *(Kahn's · push-on-finish)*
- **W4c — the W3 re-drill, applied:** **[[Quick Sort]]** *(§3b pivot rules)* → **[[Partitioning (Quicksort)]]** *(naive 3-way · $k$-partitioning)* → **[[Quickselect]]** *(§6 adaptations)* → [[Merge Sort]] *(hybrid cut-off)*
- **W3b — the applied suite, in CD1 order:** **[[Sorting Problem]]** *(§6 stability, §8 cost terms, §9 uses)* → **[[K-way Merge]]** *(ADT swap ⟹ $\Theta(N\log k)$)* → **[[Radix Sort]]** *(§3 base choice, §5 strings)* → **[[Online Algorithm]]** *(size-$k$ heap)*

## 🎯 Learning Outcomes (key skills per week)
- **W1** ➔
	- measure cost as a function of **input size** (often **bit-length**) on the RAM model; distinguish **total** vs **auxiliary** space; quote the **tightest** ($\Theta$) bound
	- set up a running-time **recurrence** $T(n)=a\,T(n/b)+f(n)$ for a recursive algorithm
	- solve it by **telescoping** written in the mandated **Steps 0→6b** exam format (levels → substitute → general form in $k$ → fix $k$ from the base → closed form → complexity → **verify base + general**) — the **required** method: it covers $T(n-1)$ *and* $T(n/b)$ and yields $\Theta$, where the Master Theorem covers only $T(n/b)$ and yields $O$
	- derive schoolbook multiplication as $\Theta(n^2)$ and the naive D&C split as $4T(n/2)+\Theta(n)=\Theta(n^2)$
	- read $a$ (recursive calls) and $b$ (shrink factor) off code and classify by $r=a/b$ — root-dominated $\Theta(n)$ · all-levels-equal $\Theta(n\log n)$ · leaf-dominated $\Theta(n^{\log_b a})$
	- state $O/\Omega/\Theta$ **formally with witnesses**; judge a bound **valid** separately from **tight** ($3n^2{+}100n=O(n^3)$ is TRUE, $\Theta(n^3)$ FALSE)
	- pair every bound with a **case** — "any operation" bounds cheapest/dearest, so an unqualified $\Theta$ needs them to agree
	- prove $\sum i=\tfrac{n(n+1)}{2}$ and $\sum r^{i}=\tfrac{r^{n+1}-1}{r-1}$ by induction, then **substitute** for $r{=}2$ and $r{=}\tfrac12$
	- drop **capped** parameters from a bound ($n\le10^6$, $arr[i]<2^{32}$ ⟹ $\Theta(1)$) and declare the **unit-cost** assumption
	- split space into **input** $+$ **auxiliary**, label $O(1)$ auxiliary **in-place**, and **time $\ge$ auxiliary space**
	- extract a **piecewise** recurrence from code — base $T(n)=a$ at the guard threshold, general $T(n)=aT(\cdot)+c$
	- count $a$ as **call sites**, not coefficients — `2*f(n//3)` is $T(n/3)+c$, `f(n//3)+f(n//3)` is $2T(n/3)+c$
	- quote **auxiliary space** as $\Theta(\text{max stack depth})$, never $\Theta(\text{total calls})$ — hence [[Merge Sort]]'s $\Theta(N{+}\log N)=\Theta(N)$
	- separate time from space on a **branching** recursion (Fibonacci $O(2^{N})$ time, $\Theta(N)$ space)
	- state a reporting bound with its **output size** $W$ and prove $\Omega(\log N{+}W)$ optimality
- **W2** ➔ 
	- prove an algorithm correct by stating **both** obligations — loop invariant **and** termination
	- write a termination argument as *finite domain · known start · monotone update* (`find_min`)
	- name the **variant** that strictly decreases, and spot where it fails (`lo = mid` at $hi{=}lo{+}1$)
	- write the invariant **first**, then code to it — minimal, data-mentioning, implies the postcondition
	- quote it at the **end** of an iteration when the loop has no early exit — `linear_search` returns the **last** match
	- state selection sort's two-clause invariant and insertion sort's sorted-prefix invariant
	- rank the sorting suite on **four** axes: correctness, time (B/A/W), **auxiliary** space, stability
	- multiply every comparison-based bound by the comparison cost $O(k)$ ⟹ $O(kN^{2})$, $O(kN\log N)$
	- count the **recursion stack** as auxiliary ⟹ recursive sorts are **not in-place**, $\Theta(k\log N)$
	- justify the $\Omega(N\log N)$ floor as a claim about **comparison-based** sorts only
	- derive [[Counting Sort]]'s $\Theta(N{+}M)$ and engineer stability via the **prefix-sum position array**
	- reject the $\Theta(N\cdot M)$ bucket-space misconception — buckets partition $N$ ⟹ $\Theta(M{+}N)$
	- run [[Radix Sort]] LSD-first by hand and justify why the subsort **must** be stable
	- derive $\Theta(KN{+}KM)$ time, $\Theta(KN{+}M{+}N)$ space, and $\Theta(M{+}N)$ auxiliary (**no $K$**)
	- trade base $M$ against column count $K=\lceil\log_M(\text{max key})\rceil$, and pad ragged keys
	- telescope $T(n)=2T(n-1)+a$ to $2^{n}b+(2^{n}-1)a=\Theta(2^{n})$ via the $r{=}2$ series
	- prove a **given** closed form by induction over $n{=}2^{k}$ — the step is $T(2m)$, never $T(m{+}1)$
	- collapse two identical recursive calls into one binding ⟹ $\Theta(p)\to\Theta(\log p)$
	- count split inversions in **blocks** during a merge ⟹ $\Theta(N^{2})\to\Theta(N\log N)$
	- shrink **both** matrix axes for $\Theta(n)$ peak finding, and justify discarding three quadrants
	- read $F(2k)$ and $F(2k{+}1)$ off the Fibonacci matrix power, eliminating $F(k{-}1)$
- **W3** ➔ 
	- **state which partition contract you are using** — this unit's Hoare parks the pivot and returns its **final index** (recurse `j-1` / `j+1`); the textbook Hoare returns a **split point** that stays on the left (recurse `j` / `j+1`)
	- rank the three schemes by **writes**, not comparisons, and reach for the 3-way Dutch flag once duplicates are common
	- state Hoare's `L_bad`/`R_bad` invariants and the Dutch flag's **four** regions, one of which is empty at exit
	- explain why out-of-place partitioning is **still** unstable, and give the third-buffer repair
	- derive the average-case height from $N(\tfrac34)^{h}=1\Rightarrow h=\log_{4/3}N$, then $2h=\Theta(\log N)$ by **change of base**
	- say why quicksort is **never** in-place even with an in-place partition — the $\Theta(\log N)$ stack is auxiliary
	- price sort-then-slice at $O(NM\log N)+O(k)$ and say why [[Counting Sort]]/[[Radix Sort]] cannot be **assumed**
	- show an **exact-median** pivot leaves quicksort $\Theta(N^{2})$ via $N^{2}+\tfrac{N^{2}}{2}+\tfrac{N^{2}}{4}+\dots$
	- run [[Median of Medians]] **by hand** on groups of five and check the $30/70$ band
	- rank pivot policies by what each removes — randomisation kills the *adversary*, [[Median of Medians]] kills the *case*
	- show a constant-**fraction** split ($1:9$) is still $\Theta(N\log N)$; only constant-**size** splits are $\Theta(N^{2})$
	- derive [[Quickselect]]'s $T(N)=T(N/2)+\Theta(N)=\Theta(N)$ and say where quicksort's $\log N$ went
	- state the $\tfrac15+\tfrac7{10}<1$ [[Median of Medians]] recurrence, and why groups of $5$ not $3$
	- force stability on an unstable sort via a parallel index list, proving **time is unchanged**
	- swap [[K-way Merge]]'s $\Theta(k)$ minimum scan for a min-[[Heap]] ⟹ $\Theta(N\log k)$, and state the root invariant
	- classify a problem **online vs offline** before quoting any bound, and pick the size-$k$ heap on the **opposite** extreme
	- choose radix base $b\le N$ and prove $M=O(N^{d})\Rightarrow\Theta(N)$; map negative keys by offset in [[Counting Sort]]
	- prove a bound **optimal by reduction** — singleton lists turn [[K-way Merge]] into a sort, inheriting $\Omega(N\log N)$
	- let an **in-place** requirement pick the sort — dedup needs [[Heapsort]], the only $O(1)$-auxiliary $\Theta(N\log N)$ option
	- radix-sort ragged strings in $\Theta(n)$ *(total characters)* — length-sort ascending, then sweep with a live-window pointer
	- `[D]` the comparison model proves $\Omega$, never $O$ — optimal comparisons $\ne$ optimal running time
- **W4** ➔ 
	- state $G=(V,E)$ or $G=(V,E,W)$ and declare **directed** / **weighted** / **simple**
	- quote max edges — directed $V(V-1)$, undirected $\tfrac{V(V-1)}{2}$, both $O(V^{2})$
	- classify a graph **sparse** or **dense** *before* quoting any bound
	- pick matrix vs list from the operation mix, and state the resulting traversal bound
	- derive $\Theta(V+E)$ — each vertex served once, each edge inspected twice
	- name the $O(1)$ `discovered` flag as the reason no queue scan happens
	- trace BFS and DFS writing **both** the `Discovered` and `Visited` rows
	- get unweighted distance from `u.distance + 1` and the path from `v.previous`
	- explain [[Dijkstra's Algorithm|Dijkstra]] as **dynamic programming $+$ greedy**, and where the greed dies
	- hand-trace Dijkstra, writing every vertex's distance **estimate** at every serve
	- derive $O((V+E)\log V)=O(E\log V)$, and place the slide's $O(V^{2}\log V)$ as the dense case
	- prove Dijkstra correct by contradiction, pointing at the step that spends non-negativity
	- define a **DAG** and say why acyclicity is the existence condition for an order
	- run **Kahn's** and the **push-on-finish DFS**, detecting a cycle from a short output
	- reject a DFS **pre-order** as a topological order, with the counterexample
	- read a pivot rule for **proportional** reduction — minimum, $10$th percentile, mean
	- generalise partitioning to $k$ pivots, $\Theta(n\log k)$, optimal by **reduction**
	- adapt [[Quickselect]] to the **weighted median** and the $k$ **closest to the median**
