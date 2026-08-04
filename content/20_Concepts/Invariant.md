---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 2]
source: [lecture]
parent: "[[Algorithm]]"
tags: [CS/Algorithms, CS/Foundations]
aliases: [Loop Invariant, Proof of Correctness]
---
# [[Invariant]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · the correctness-proof tool behind the elementary sorts, [[Binary Search]], [[Heap]] · induction over iterations
**FIT2004 emphasis:** correctness is a **two-part obligation — termination AND loop invariant** — and it is *commonly asked in the exam*: you are shown an algorithm (usually prose, not code) and asked to explain why it is correct.

> [!abstract] Quick Revision
> - **🎯 Objective:** a property that stays true at a program point / across an algorithm ➔ the rigorous tool for proving correctness and finding optimisations.
> - **📦 Core Components:** **initialization → maintenance → termination** (induction over iterations).
> - **⚡ Key Constraint:** maintenance + termination ⟹ **partial** correctness; add a **variant** for **total** correctness — an algorithm that never halts returns nothing, however good its invariant.

## 📝 Core
### 1. The Invariant (A Property Preserved)
- **Definition** ➔ a property that **remains true** at a program point or throughout an algorithm.
- **Loop invariant** ➔ holds before the loop, preserved by every iteration ➔ still holds at exit.
- **Payoff** ➔ anything provably always-true can be **exploited to skip work** ➔ the basis of every correctness proof.
- **Why prove instead of test** ➔ development cost and compute are finite, testing cannot cover the input space, and field failures are unbounded — Ariane 5 ($\sim\$7$B, bad horizontal-velocity conversion), the Patriot battery that missed a Scud (accumulated time-since-boot error, 28 dead). Proof is applied at **design** time, where testing cannot reach.

### 2. The Three-Part Proof
- **Initialization** ➔ $P$ holds before the first iteration.
- **Maintenance** ➔ $P$ before ⟹ $P$ after each iteration.
- **Termination** ➔ loop ends + negated guard ⟹ postcondition.
- **Total correctness** ➔ maintenance + termination give **partial**; a **variant** (non-negative integer measure strictly decreasing, e.g. `end - start`) proves halting ⟹ **total**.

### 3. Termination — the Co-Equal Obligation
- **What to state** ➔ which **update** guarantees the guard is eventually falsified, or which **base case** the recursion is guaranteed to reach.
- **The three-line template** ➔ *(i)* the domain is **finite** · *(ii)* the counter **starts** at a known point · *(iii)* every iteration moves it **monotonically** toward the bound ⟹ the guard fails after finitely many steps.
- **`find_min` worked** ➔ array is finite · `index` starts at $1$ · each iteration does `index += 1` ⟹ `index` reaches `len(array)` and the `while` exits.
- **Failure is not exotic** ➔ [[Binary Search]] written with `lo = mid` and `while lo < hi` **does not terminate** at $lo{=}5,hi{=}6$: $mid=\lfloor 11/2\rfloor=5$, so `lo = mid` is a no-op and no measure decreases ➔ see that note for the fix.

### 4. Design Order — Invariant First, Then Code
- **Reverse the usual order** ➔ *(1)* define the invariant you need at exit, *(2)* write the loop that maintains it. Code written to a stated invariant is correct by construction; an invariant reverse-engineered from finished code usually just paraphrases the code.
- **Keep it minimal** ➔ the invariant only has to be **strong enough to imply the postcondition** at exit; extra clauses are extra proof burden with no marks attached.
- **Exam shape** ➔ *"(1 mark) Write a loop invariant for the Floyd–Warshall algorithm that can be used to show it correctly computes all-pairs shortest distances."* — one sentence, quantified over the loop counter, that becomes the postcondition when the counter hits its bound.

## ⚖️ Core Decision Matrix
| Algorithm | Key loop invariant | Termination argument | What it enables |
| :--- | :--- | :--- | :--- |
| `find_min` | `my_min` holds the minimum of `array[0…index]` | finite array; `index` starts at $1$ and increments | at exit `index` $=N$ ⟹ global minimum |
| [[Sorting Problem\|Bubble Sort]] | after pass $i$, the $i$ largest are final at the tail | outer counter shrinks by $1$ per pass | early-exit ($O(n)$ best) |
| [[Sorting Problem\|Selection Sort]] | `my_list[0…i-1]` is sorted **AND** $\le$ every element of `my_list[i…N]` | both $i$ and $j$ only increment and reach the end | prefix is **final** ⟹ correctness; blocks adaptivity |
| [[Sorting Problem\|Insertion Sort]] | `my_list[0…i-1]` sorted, **not necessarily final** | `i` increments; inner `j` strictly decreases and is bounded below by $0$ | incremental inserts |
| [[Binary Search]] | if the key exists in `array[0…N]` it exists in `array[lo…hi]` | `hi - lo` must **strictly** shrink — the bug vector | shrink-by-half correctness |
| [[Heap]] | every node $\ge$ its children | sift index halves / doubles toward a bound | $O(\log n)$ `get_max` |
| [[Hash Table\|Linear Probing]] | key with hash $N$ sits between $N$ and first empty slot | probe count bounded by table size | search/delete correctness |

> [!NOTE] **When It Flips:** the **strength** of the invariant, not the code, decides what optimisations are legal — selection sort's *final* prefix forbids the incremental insert that insertion sort's *sorted-not-final* prefix permits. Class invariants generalise the idea to objects (a [[Queue (ADT)|CircularQueue]]'s `front`/`rear`/`count` consistency). Invariants prove *correctness*; [[Big-O Notation|asymptotic analysis]] proves *cost*.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Show the invariant method is induction over iterations, and that termination is a separate obligation.
$$
\begin{aligned}
\textbf{base}\;(\text{initialization}) &: P \text{ holds before iteration } 1 \\
\textbf{step}\;(\text{maintenance}) &: P \text{ before iter } k \Rightarrow P \text{ before iter } k{+}1 \\
\therefore\; & P \text{ holds at every iteration reached} \\
\textbf{variant}\;(\text{termination}) &: V_k \in \mathbb{N},\; V_{k+1} < V_k \Rightarrow \text{finitely many iterations} \\
P \wedge \neg\text{guard} &\Rightarrow \text{postcondition} \quad \text{(total correctness)}
\end{aligned}
$$
**Final Extracted Output:** initialization = base case, maintenance = inductive step, variant = the well-ordering argument that the induction actually reaches its last step.

## ⚠️ Common Mistakes
- 💡 **Invariant ≠ termination** ➔ it proves correctness *if* the loop halts; you still need a separate **variant** (a strictly-decreasing non-negative measure) for total correctness.
- 💡 **"Eventually they meet" is not a termination proof** ➔ name the measure and show it **strictly** decreases; a move that can leave the measure unchanged (`lo = mid`) is exactly where infinite loops live.
- 💡 **Restating the code as the invariant** ➔ *"`i` increases each iteration"* is a fact about the loop, not a property that implies the postcondition; the invariant must mention the **data**, not just the counter.

## 🧠 Active Recall
> [!FAQ]- State the three obligations of a loop-invariant proof and which combination gives total vs partial correctness.
> - **Hint:** Partial vs total.
> > [!SUCCESS]- Answer
> > - **Short answer:** Initialization + maintenance + termination; maintenance + termination = **partial**, add a decreasing non-negative **variant** for **total**.
> > - **Why:** **Variant proves halting** ➔ correctness-if-it-halts becomes correct-and-halts.

> [!FAQ]- How does the loop-invariant method relate to mathematical induction?
> - **Hint:** Induction over iteration count.
> > [!SUCCESS]- Answer
> > - **Short answer:** Initialization = base case, maintenance = inductive step ⟹ holds at every iteration including the last.
> > - **Why:** **Discrete index** ➔ exactly induction on the iteration counter.

> [!FAQ]- Why is the *difference* between selection and insertion sort's invariants algorithmically significant?
> - **Hint:** Invariant strength gates optimisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Selection's prefix is **sorted and final** — it also dominates the whole suffix — while insertion's is "sorted but not final".
> > - **Why:** **Sound optimisations** ➔ the weaker invariant makes insertion sort incremental/online; the stronger one forbids it, because a later element can never be admitted into a prefix already declared final.

> [!FAQ]- You are shown an algorithm in prose and asked "explain why it is correct" for 2 marks. What exactly do you write?
> - **Hint:** Two obligations, one sentence each.
> > [!SUCCESS]- Answer
> > - **Short answer:** *(1)* the loop invariant, quantified over the counter; *(2)* the termination argument naming the measure that strictly decreases; then one line showing invariant $\wedge$ exit condition $\Rightarrow$ the required postcondition.
> > - **Why:** **Marks track obligations** ➔ an invariant with no termination argument proves only partial correctness, and a termination argument with no invariant proves only that the algorithm stops — possibly with the wrong answer.
