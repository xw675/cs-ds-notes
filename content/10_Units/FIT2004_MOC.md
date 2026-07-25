---
unit: FIT2004
type: MOC
tags: [CS/Algorithms, CS/Complexity]
---
# 📘 FIT2004: Algorithms and Data Structures

> [!INFO] Map of Content
> Index for **FIT2004 Algorithms and Data Structures** (Y2S1) — rigorous algorithmics building on [[FIT1008_MOC]]. Much of the foundational material (Big-O, recursion, divide-and-conquer, merge sort) is **shared dual-unit** with FIT1008/FIT1058 and deepened here with **correctness proofs** and **recurrence analysis** rather than duplicated.

## 📊 Assessment Map
- **Learning Project Portfolio (100%)** ➔ continuous production — the assignments *are* the unit.
- **In-class tests (0%) — competency hurdle** ➔ must meet the standard to pass; **one supplementary attempt**. These are the **hand-execution checkpoints** (trace tables, complexity derivations).
- **No exam** ➔ portfolio-driven; drill the in-class competency tests as the hand-skill gate.
- **LO thread so far** ➔ analyse running time via recurrences; design divide-and-conquer algorithms; quote tight Big-O with mandatory complexity tables.

## 📅 Knowledge Index

### Week 1 — Divide & Conquer and Recurrence Analysis *(Lecture 1, parts 1–2)*
- [[Karatsuba Integer Multiplication]] -> Parent Framework: [[Divide and Conquer]] *(the flagship D&C algorithm; 4→3 sub-multiplications)*
- [[Solving Recurrences (Telescoping)]] -> Parent Framework: [[Big-O Notation]] *(the analysis hand skill — repeated substitution; Master Theorem flagged as supplementary)*
- [[Divide and Conquer]] -> Parent Framework: [[Recursion]] *(dual-unit — split/recurse/combine; analysed via recurrences)*
- [[Algorithmic Complexity]] -> Parent Framework: [[Algorithm]] *(dual-unit — input size, RAM model, best/avg/worst; + auxiliary space, tightest bound)*
- [[Big-O Notation]] -> Parent Framework: [[Algorithmic Complexity]] *(dual-unit — $O/\Omega/\Theta$, dominance, growth ladder)*
- [[Recurrence Relation]] -> Parent Framework: [[Sequence (Mathematics)]] *(dual-unit — the maths behind the running-time recurrences)*
- [[Merge Sort]] -> Parent Framework: [[Divide and Conquer]] *(dual-unit — the canonical $2T(n/2)+\Theta(n)=\Theta(n\log n)$ example)*

### 🔭 Coming later in the unit *(from the handbook outline — no notes yet)*
- Correctness proofs via **loop invariants** · amortised analysis · greedy algorithms · **dynamic programming** (the king — recurrence → memo table → trace) · $O(n)$ sorting (counting/radix) · order statistics · balanced BSTs (AVL), B-trees, tries, union-find · graph algorithms (BFS/DFS, Dijkstra, Bellman-Ford, Floyd-Warshall, MST, topological sort, network flow) · hashing.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = competency-test hand skill)*

- **W1 — analysis first, then the algorithm:** [[Algorithmic Complexity]] *(what we measure)* → [[Big-O Notation]] *($O/\Omega/\Theta$)* → **[[Solving Recurrences (Telescoping)]]** *(how to solve $T(n)$)* → [[Divide and Conquer]] → **[[Karatsuba Integer Multiplication]]** *(apply it end-to-end)* · compare with [[Merge Sort]]

## 🎯 Learning Outcomes (key skills per week)
- **W1** ➔
	- measure cost as a function of **input size** (often **bit-length**) on the RAM model; distinguish **total** vs **auxiliary** space; quote the **tightest** ($\Theta$) bound
	- set up a running-time **recurrence** $T(n)=a\,T(n/b)+f(n)$ for a recursive algorithm
	- solve it by **telescoping** (repeated substitution → general form → fix $k$ from the base case → back-substitute) *(the Master Theorem is a supplementary shortcut, not taught in Week 1)*
	- derive schoolbook multiplication as $\Theta(n^2)$ and the naive D&C split as $4T(n/2)+\Theta(n)=\Theta(n^2)$
	- apply the **Karatsuba (Gauss) trick** to cut 4 sub-multiplications to 3 via $(x_L{+}x_R)(y_L{+}y_R)-A-C$, giving $3T(n/2)+\Theta(n)=\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$
	- know that shifts/additions are the $\Theta(n)$ combine term (not counted as multiplications), and that Karatsuba wins only **asymptotically**
