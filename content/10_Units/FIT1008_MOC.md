---
unit: FIT1008
type: MOC
tags: [2026/S1]
---
# 📘 FIT1008: Introduction to Computer Science

> [!INFO] Map of Content
> Index for the **Algorithms & Algorithmic Complexity** strand (FIT1008/2085). Start with [[Algorithm]].

## 📊 Assessment Map

- **Assessment:** pracs + mid-semester test + final exam *(⚠ splits unverified — fill from unit outline)*.
- **Exam skills:** raw-code data structures (no magic methods), Best/Average/Worst complexity tables, hand-traces of sorts/hashing/trees.
- **Mid-semester test** ➔ Weeks 1–5 (complexity → ADTs → linked structures + iterators); **exam** ➔ whole unit, weighted to Weeks 6–11 structures.

## 🧰 Unit Cheatsheet

- 📌 [[FIT1008 Unit Cheatsheet]] — complexity tables, ADT matrix, sorting suite, trees/heaps/hashing

## 📅 Knowledge Index

### Week 1 — Algorithms and Complexity
- [[Algorithm]]
- [[Computational Problem]]
- [[Algorithmic Complexity]] — backbone (incl. **Input Size** + **Running Time** + **Time Complexity** + **Cost of Elementary Operations** + **Best/Worst-Case** subsections)
- [[Big-O Notation]] — backbone (incl. **Asymptotic Analysis** + **Big-Omega/Theta** + **Properties** + **Complexity Classes** subsections)
- [[Arithmetic Series]]
- [[Linear Search]]
- [[Binary Search]]
- [[Sorting Problem]] — backbone (incl. **Bubble** + **Selection** + **Insertion** sorts + **Stability** + **Incrementality** subsections)
- [[Invariant]]

### Week 2 — Intro to ADTs: Stack and Set ADT
- [[Abstract Data Type (ADT)]]
- [[Data Type]]
- [[Data Structure]]
- [[Array (Data Structure)]]
- [[Abstract Base Class]]
- [[Stack (ADT)]] — backbone (incl. **ArrayStack** + **LinkStack** subsections; LinkStack lands Week 5)
- [[Set (ADT)]] — backbone (incl. **ArraySet** + **BVSet** subsections)
- [[Bit Vector]]

### Week 3 — List ADT and Queue ADT
- [[List (ADT)]] — backbone (incl. **ArrayList** + **LinkList** + **LinkListIterator** subsections; linked parts land Weeks 4–5)
- [[Dynamic Array Resizing]]
- [[List Slicing]]
- [[List Comprehension]]
- [[Queue (ADT)]] — backbone (incl. **LinearQueue** + **CircularQueue** + **LinkQueue** subsections; LinkQueue lands Week 5)

### Week 4 — Sorted List ADT and Linked List
- [[Sorted List (ADT)]] — backbone (incl. **SortedArrayList** subsection)
- [[Binary Search]] *(revisited: the SortedList search engine)*
- [[Node]]
- [[Linked Node Data Structure]]
- [[List (ADT)]] → **LinkList** subsection *(extended in Week 4)*

### Week 5 — Linked Stack, Linked Queue, and Iterator
- [[Stack (ADT)]] → **LinkStack** subsection *(extended in Week 5)*
- [[Queue (ADT)]] → **LinkQueue** subsection *(extended in Week 5)*
- [[Iterable]]
- [[Iterator]]
- [[List (ADT)]] → **LinkListIterator** subsection *(extended in Week 5)*
- [[Generator Expression]]
- [[Higher-Order Function]]

*(Week 5.5 — mid-semester break; mid-sem test material = Weeks 1–5.)*

### Week 6 — Recursion
- [[Recursion]] — backbone (incl. **Notation** + **Accumulator** + **Auxiliary Function** + **vs Iteration** + **→Iteration via Stack** subsections)
- [[Tower of Hanoi]]

### Week 7 — Recursive Sorts
- [[Divide and Conquer]]
- [[Merge Sort]]
- [[Quick Sort]]

### Week 8 — Binary Trees and BSTs
- [[Tree]]
- [[Binary Tree]] — backbone (incl. **Tree Traversal** + **Expression Tree** subsections)
- [[Binary Search Tree (BST)]]

### Week 9 — Priority Queues and Binary Heaps
- [[Priority Queue (ADT)]]
- [[Heap]] — backbone (incl. **Bottom-Up Construction** subsection)
- [[Heapsort]]

### Week 10 — Dictionary ADT, Hash Functions, and Hash Tables
- [[Dictionary (ADT)]]
- [[Hash Table]] — backbone: **Hash Function** subsections this week (polynomial/Horner, prime discipline)

### Week 11 — Hash Tables and Collision Resolution
- [[Hash Table]] → **Collision Resolution** + **Open Addressing** + **Linear Probing** + **Load Factor** subsections *(extended in Week 11 — one clustered note spans both weeks)*

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = the week's core hand skill)*

- **W1 — algorithms & complexity:** [[Algorithm]] → [[Computational Problem]] → [[Algorithmic Complexity]] → **[[Big-O Notation]]** → [[Linear Search]] vs [[Binary Search]] → [[Sorting Problem]] *(bubble/selection/insertion via [[Invariant]] + [[Arithmetic Series]])*
- **W2 — ADTs, Stack & Set:** [[Abstract Data Type (ADT)]] → [[Data Type]] · [[Data Structure]] → [[Array (Data Structure)]] → [[Abstract Base Class]] → **[[Stack (ADT)]]** *(ArrayStack)* → [[Set (ADT)]] + [[Bit Vector]] *(ArraySet vs BVSet)*
- **W3 — List & Queue:** [[List (ADT)]] *(ArrayList)* → **[[Dynamic Array Resizing]]** *(amortised $O(1)$)* → [[List Slicing]] · [[List Comprehension]] → [[Queue (ADT)]] *(Linear → Circular)*
- **W4 — Sorted List & Linked List:** [[Sorted List (ADT)]] → [[Binary Search]] *(revisited)* → [[Node]] → **[[Linked Node Data Structure]]** → [[List (ADT)]] §LinkList
- **W5 — linked variants & iterators:** [[Stack (ADT)]] §LinkStack → [[Queue (ADT)]] §LinkQueue → [[Iterable]] → **[[Iterator]]** → [[Generator Expression]] → [[Higher-Order Function]]
- **W6 — recursion:** **[[Recursion]]** *(base + call + convergence; aux functions, accumulator, stack conversion)* → [[Tower of Hanoi]]
- **W7 — recursive sorts:** [[Divide and Conquer]] → **[[Merge Sort]]** vs **[[Quick Sort]]** *(split/combine mirror)*
- **W8 — trees & BSTs:** [[Tree]] → [[Binary Tree]] *(+ traversals, Expression Tree)* → **[[Binary Search Tree (BST)]]** *(insert return-and-relink, 3-case delete)*
- **W9 — priority queues & heaps:** [[Priority Queue (ADT)]] → **[[Heap]]** *(rise/sink, $\Theta(n)$ bottom-up build)* → [[Heapsort]]
- **W10 — dictionaries & hashing:** [[Dictionary (ADT)]] → **[[Hash Table]]** *(hash functions: Horner + primes)*
- **W11 — collision resolution:** [[Hash Table]] §Collision Resolution → §Open Addressing → **§Linear Probing** → §Load Factor

## 🎯 Learning Outcomes (key skills per week)

- **W1** ➔ 
	- define algorithm vs problem (lower bounds live on problems) 
	- measure $T(n)$ best/worst 
	- apply Big-O algebra + the class ladder 
	- state search preconditions (binary = sorted + random access) 
	- analyse the three $O(n^2)$ sorts via invariants, stability, adaptivity
- **W2** ➔ 
	- separate contract (ADT) from cost (implementation) 
	- code ArrayStack with $O(1)$ ops 
	- choose ArraySet vs BVSet by data type + universe size
- **W3** ➔ 
	- code ArrayList ops + shift costs 
	- explain factor-growth amortised $O(1)$ append (vs additive $\Theta(n^2)$) 
	- code Linear and Circular queues (mod-arithmetic ring)
- **W4** ➔ 
	- state SortedList's add-replaces-insert contract + $O(\log n)$/$O(n)$ split 
	- code LinkList relink ops 
	- argue array vs linked as mirror images
- **W5** ➔ 
	- code LinkStack/LinkQueue (never full, pointer overhead) 
	- write an Iterator (`__iter__`/`__next__`/`StopIteration`, single-use) 
	- use lazy generators for $O(1)$ memory
- **W6** ➔ 
	- write recursion with base + call + convergence 
	- convert recursion↔iteration (accumulator forward, explicit stack backward) 
	- trace Hanoi's $2^n - 1$ moves 
	- analyse via recurrences
- **W7** ➔ 
	- derive $\Theta(n\log n)$ from balanced splits 
	- code merge sort (stable, $\Theta(n)$ scratch) 
	- code quicksort + explain pivot pathology ($\Theta(n^2)$)
- **W8** ➔ 
	- use tree vocabulary + $O(\text{height})$ law 
	- run pre/in/post/level traversals 
	- code BST insert (return-and-relink) + delete (in-order successor) 
	- explain the degenerate stick
- **W9** ➔ 
	- show every linear PQ has one $O(N)$ op 
	- code heap rise/sink at $O(\log n)$ 
	- prove bottom-up build is $\Theta(n)$ 
	- run heapsort in place, unstable
- **W10** ➔ 
	- state the Dictionary contract 
	- design hash functions (Horner's method, prime base + TABLESIZE) 
	- derive expected $\Theta(1+\alpha)$
- **W11** ➔ 
	- compare chaining vs open addressing 
	- maintain the linear-probing invariant (incl. deletion) 
	- trigger rehash from load factor $\alpha$
