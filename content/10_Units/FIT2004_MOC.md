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

### Week 1 — Divide & Conquer and Recurrence Analysis *(Lecture 1, parts 1–2)*
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

### 🔭 Coming later in the unit *(from the handbook outline — no notes yet)*
- Correctness proofs via **loop invariants** · amortised analysis · greedy algorithms · **dynamic programming** (the king — recurrence → memo table → trace) · $O(n)$ sorting (counting/radix) · order statistics · balanced BSTs (AVL), B-trees, tries, union-find · graph algorithms (BFS/DFS, Dijkstra, Bellman-Ford, Floyd-Warshall, MST, topological sort, network flow) · hashing.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = competency-test hand skill)*

- **W1 — analysis first, then the algorithm:** [[Algorithmic Complexity]] *(what we measure)* → **[[Big-O Notation]]** *(formal $O/\Omega/\Theta$, bound vs case)* → [[Arithmetic Series]] · [[Geometric Series]] *(the summation tools)* → **[[Solving Recurrences (Telescoping)]]** *(how to solve $T(n)$)* → [[Divide and Conquer]] → apply it end-to-end on [[Merge Sort]] · drill bounds on [[Binary Search Tree (BST)]]

## 🎯 Learning Outcomes (key skills per week)
- **W1** ➔
	- measure cost as a function of **input size** (often **bit-length**) on the RAM model; distinguish **total** vs **auxiliary** space; quote the **tightest** ($\Theta$) bound
	- set up a running-time **recurrence** $T(n)=a\,T(n/b)+f(n)$ for a recursive algorithm
	- solve it by **telescoping** (repeated substitution → general form → fix $k$ from the base case → back-substitute) *(the Master Theorem is a supplementary shortcut, not taught in Week 1)*
	- derive schoolbook multiplication as $\Theta(n^2)$ and the naive D&C split as $4T(n/2)+\Theta(n)=\Theta(n^2)$
	- read $a$ (recursive calls) and $b$ (shrink factor) off code and classify by $r=a/b$ — root-dominated $\Theta(n)$ · all-levels-equal $\Theta(n\log n)$ · leaf-dominated $\Theta(n^{\log_b a})$
	- state $O/\Omega/\Theta$ **formally with witnesses**; judge a bound **valid** separately from **tight** ($3n^2{+}100n=O(n^3)$ is TRUE, $\Theta(n^3)$ FALSE)
	- pair every bound with a **case** — "any operation" bounds cheapest/dearest, so an unqualified $\Theta$ needs them to agree
	- prove $\sum i=\tfrac{n(n+1)}{2}$ and $\sum r^{i}=\tfrac{r^{n+1}-1}{r-1}$ by induction, then **substitute** for $r{=}2$ and $r{=}\tfrac12$
	- drop **capped** parameters from a bound ($n\le10^6$, $arr[i]<2^{32}$ ⟹ $\Theta(1)$) and declare the **unit-cost** assumption
