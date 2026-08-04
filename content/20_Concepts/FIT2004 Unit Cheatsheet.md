---
unit: FIT2004
domain: A
parent: "[[FIT2004_MOC]]"
tags: [CS/Algorithms, CS/Complexity]
type: cheatsheet
aliases: [FIT2004 Exam Crib, Algorithms II Cheatsheet]
---
# [[FIT2004 Unit Cheatsheet]]

**Context:** [[FIT2004_MOC]] · the WHOLE unit in one re-read, syllabus-ordered. This sheet holds the FIT2004 **rigour layer** (recurrences, derivations, bounds). *Currently covers W1–W2; extend each week.*
**Tier tags:** `[P]` PT-critical, must be automatic · `[C]` needed for Credit Discussions · `[D]` D/HD-exam rigour. Drill `[P]` to fluency **before** reading a `[D]` line.

> [!abstract] Quick Revision
> - **🎯 Objective:** every analysis question reduces to ➔ **write the recurrence** → **telescope to a level-sum** → **read the regime off the ratio** → quote the **tightest** $\Theta$ with its **case** and its space.
> - **⚡ Key Constraint:** naming a growth class without the derivation line earns nothing — the marks are in the general form in $k$ and the base case that fixes it.

## 1️⃣ Analysis Discipline (W1)
> [!warning] **Bound ≠ case** sank Q1 of the 2026 S1 D/HD paper. Every complexity claim names BOTH.

- **Two INDEPENDENT axes — never conflate** `[C]` ➔ the **case** picks *which* function you analyse; the **bound** fences that function **· precondition:** all pairings are legal — FIT1008 quoted $O$ for the **best** case and was right. "$\Omega$ means best case" is the misconception being examined.
- **The bound axis** `[P]` ➔ $O$ upper · $\Omega$ lower · $\Theta$ tight, i.e. $\Theta=O\cap\Omega$ **· pass-tier shortcut:** if you are only chasing Competent, answer $\Theta$ questions as you would $O$ — but this shortcut **fails** the moment a `[D]` question asks you to *justify* the $\Omega$ side.

| Case `[C]` | Analyses | W1 witness |
| :--- | :--- | :--- |
| Best | cheapest input of size $n$ | naive D&C multiply ➔ best $=$ worst, no branching |
| Worst | dearest input of size $n$ | quicksort, extreme pivot ➔ $\Theta(n^{2})$ |
| Average | expectation over an input **distribution** | quicksort, random pivot ➔ $\Theta(n\log n)$ |
| Amortised `[D]` | worst-case **total** over a sequence $\div$ length | a guarantee, **not** a probability — no distribution assumed |

- **Formal definitions — state the witnesses** `[C]` ➔ $O$: $\exists c,n_0>0$ with $f\le cg$ $\forall n\ge n_0$ · $\Omega$: $\exists c,n_0$ with $f\ge cg$ · $\Theta$: $\exists c_1,c_2,n_0$ with $c_1g\le f\le c_2g$ **· precondition:** every claim needs the constants **and** the range of $n$; a proof without witnesses scores nothing.
- **Valid ≠ tight** `[P]` ➔ $3n^{2}+15\log n+100n$ **is** $O(n^{3})$ (TRUE, $c{=}118,n_0{=}1$) and **is** $\Omega(n)$, but **not** $\Theta(n^{3})$ — killed because $T(n)/n^{3}\to0$ leaves no $c_1$ **· precondition:** on true/false questions answer from the definition; "not the tightest" never makes an $O$ claim false.
- **Unqualified "complexity" = worst case** `[P]` ➔ best/worst diverge **· precondition:** the code has a short-circuit (`break`/early return) or input-dependent branching; otherwise best $=$ worst (selection sort, [[Merge Sort]]) and you may state one $\Theta$ for all cases.
- **Input size $n$** `[C]` ➔ elements for a collection, but **bit-length** for a *number* ($n=\lceil\log_2(k+1)\rceil$) **· precondition:** state which you are counting — a loop running $k$ times on numeric input $k$ is $O(2^{n})$, not $O(n)$.
- **A CAPPED parameter is $\Theta(1)$ and vanishes** `[C]` ➔ $n\le10^{6}\Rightarrow\Theta(nm)$ becomes $\Theta(m)$; $arr[i]<2^{32}\Rightarrow$ bit-count constant $\Rightarrow\Theta(n)$ **· precondition:** list which parameters may grow before quoting any bound.
- **Space = AUXILIARY** `[P]` ➔ **space $=$ input space $+$ auxiliary space**; quote the auxiliary half, in-place $\equiv O(1)$ auxiliary **· precondition:** include the recursion stack — $\Theta(\text{depth})$ frames, only ONE root-to-leaf chain live at a time. Input space is not the algorithm's *choice*; auxiliary is, and it is the column that discriminates.
- **Time $\ge$ auxiliary space** `[P]` ➔ allocating and filling a cell costs $\ge1$ step **· use:** a self-check — a $\Theta(\log n)$-time answer paired with $\Theta(n)$ auxiliary is arithmetically impossible, so one of the two is wrong.
- **Output size $W$ is a FREE parameter** `[C]` ➔ a reporting algorithm costs $\Theta(\text{locate}+W)$; range report on a sorted array is $\Theta(N+W)=\Theta(N)$ scanning vs $\Theta(\log N+W)$ binary-then-scan **· precondition:** $W$ may grow with the instance, so it cannot be dropped — $O(\log N)$ alone is FALSE ➔ [[Output-Sensitive Complexity]].
- **Declare unit-cost** `[D]` ➔ "$+$ is $O(1)$" needs machine-word operands **· precondition:** values whose bit-length grows with $n$ cost $\Theta(\text{bits})$ per op — iterative Fibonacci is $\Theta(n)$ word-ops but $\Theta(n^{2})$ bit-ops.
- **Worst-case-per-op × count is an UPPER bound only** `[D]` ➔ tightness needs a **witness input** where the worst cases co-occur ($n$ *sorted* [[Binary Search Tree (BST)]] insertions ⟹ $\Theta(n^{2})$).
- **$\Omega$ for problems / $\Theta$ for algorithms is a CONVENTION** `[D]` ➔ an algorithm's $O$ meeting the problem's $\Omega$ ⟹ **provably optimal**; but $\Omega$ is defined on any function, so "any BST insertion is $\Omega(1)$" is well-formed and true.
- **Big-O algebra** `[P]` ➔ Sum $O(g_1)+O(g_2)=O(\max)$ · Product $O(g_1)O(g_2)=O(g_1g_2)$ **· precondition:** upper bounds only — this algebra cannot produce a lower bound.
- **Ladder** `[P]` ➔ $1\prec\log n\prec\sqrt n\prec n\prec n\log n\prec n^{1.585}\prec n^{2}\prec n^{3}\prec 2^{n}\prec n!$.

## 2️⃣ Identities That Do the Work (W1)
> [!warning] Assume **nothing is provided**. The PT formula sheet is not guaranteed — memorise every closed form below and be able to prove the two series by induction.

- **Log algebra** `[P]` ➔ $\log_b b=1$ · $\log_b 1=0$ · $\log(xy)=\log x+\log y$ · $\log(x/y)=\log x-\log y$ · $\log(x^{k})=k\log x$ · **inverse pair** $b^{\log_b x}=x$ and $\log_b(b^{x})=x$ **· consequence:** base change $\log_b x=\frac{\log_a x}{\log_a b}$ is a constant factor ⟹ $\Theta(\log n)$ never needs a base.
- **Exponent swap** `[D]` ➔ $a^{\log_b n}=n^{\log_b a}$ **· proof:** $a^{\log_b n}=(b^{\log_b a})^{\log_b n}=(b^{\log_b n})^{\log_b a}$ — the exponent product is symmetric. Turns a leaf **count** into a **power of $n$**.
- **[[Arithmetic Series|Arithmetic]]** `[P]` ➔ $\sum_{i=1}^{n}i=\tfrac{n(n+1)}{2}=\Theta(n^{2})$ ➔ shrink-by-one recurrences, quadratic sorts, sorted BST builds.
- **[[Geometric Series|Geometric]]** `[P]` ➔ $\sum_{i=0}^{n}r^{i}=\tfrac{r^{n+1}-1}{r-1}$ **· precondition:** $r\neq1$ (at $r=1$, $S_n=n+1$).
- **$r=2$ corollary** `[P]` ➔ $\sum_{i=0}^{n}2^{i}=2^{n+1}-1$ ➔ complete-binary-tree node count; the leaf level alone outweighs everything above it.
- **$r=\tfrac12$ corollary** `[P]` ➔ $\sum_{i=0}^{n}2^{-i}=2-2^{-n}<2$ ➔ **strict, $n$-independent**: halving work totals $<2\times$ the top level. Both corollaries are **substitutions**, not new inductions.
- **Induction blueprint** `[C]` ➔ base $n=1$ → assume $P(k)$ → prove $P(k{+}1)$ by adding the $(k{+}1)$-th term to the **assumed closed form** and re-factoring **· precondition:** the inductive step must *cite* the hypothesis explicitly; algebra alone is not a proof.

## 3️⃣ Recurrence Solving — Telescoping (W1)
**Pipeline** `[P]`**:** pseudocode → **recurrence relation** → complexity. **Protocol for the middle arrow:** write recurrence + base → expand 2–3 steps → general form in $k$ → fix $k$ from the base → back-substitute.

**Stage 0 — writing the recurrence off the code** *(where the marks are actually lost)*
- **Piecewise, with symbolic constants** `[P]` ➔ base $T(n)=a$ for $n<k$ · general $T(n)=\langle\#\text{calls}\rangle\,T(\text{shrunk }n)+\langle\text{per-call work}\rangle$ for $n\ge k$ **· precondition:** $k$ is the **guard threshold in the source** (`if n < 3` ⟹ $k=3$), not a reflexive $T(1)$.
- **$a$ counts INVOCATIONS, not coefficients** `[P]` ➔ `2 * f(n//3) + 4` ⟹ $T(n)=T(n/3)+c$ · `f(n//3) + f(n//3) + 4` ⟹ $T(n)=2T(n/3)+c$ **· consequence:** $\Theta(\log n)$ vs $\Theta(n^{\log_3 2})$ — same source length, different growth class.
- **Only shrinking arguments are in scope** `[P]` ➔ the assessed recursions decrease the search space (`n-1`, `n//2`, `n//3`); recursions whose argument grows in **value** are out of assessment scope.
- **Threshold base shifts $k$ by a constant** `[C]` ➔ `if n < 3` with $n/3$ shrink ⟹ $n/3^{k}<3\Rightarrow k=\log_3 n-1=\Theta(\log n)$ — solve with the real threshold, discard the constant at the end.
- **Method scope — telescoping is the required one** `[P]`:

| | Telescoping | Master Theorem |
| :--- | :--- | :--- |
| $T(n/b)$ divide | ✅ | ✅ |
| $T(n-1)$ shrink-by-one | ✅ | ❌ no case fits |
| Bound yielded | closed form ⟹ $\Theta$ | $O$ only |
| Assessment | **required** | supplementary |


| Recurrence | Depth $k$ | Accumulates | Closed form |
| :--- | :--- | :--- | :--- |
| $T(N)=T(N-1)+c$ | $N-1$ | $k$ constants | $\Theta(N)$ |
| $T(N)=T(N-1)+cN$ | $N-1$ | arithmetic series $\tfrac{N(N+1)}{2}$ | $\Theta(N^{2})$ |
| $T(N)=T(N/2)+c$ | $\log_2 N$ | $k$ constants | $\Theta(\log N)$ |
| $T(N)=T(N/2)+cN$ | $\log_2 N$ | geometric $r=\tfrac12$ | $\Theta(N)$ |
| $T(n)=a\,T(n/b)+cn$ | $\log_b n$ | geometric $r=a/b$ | regime below |
| $T(N)=T(N-1)+T(N-2)+c$ | $N$ | branching tree, $\Theta(\varphi^{N})$ nodes | $O(2^{N})$ |

- **Level-sum** `[C]` ➔ $T(n)=\sum_{i=0}^{\log_b n} c\,n\,(a/b)^{i}$ — level $i$ holds $a^{i}$ subproblems of size $n/b^{i}$ **· precondition:** subproblems are equal-sized and the combine is $\Theta(n)$.
- **Regime from the ratio $r=a/b$** `[C]` ➔ $r<1$ **root-dominated** $\Theta(n)$ · $r=1$ **all levels equal** $\Theta(n\log n)$ · $r>1$ **leaf-dominated** $\Theta(n^{\log_b a})$.
- **Worked instances** `[P]` ➔ $a{=}1,b{=}2$: $r{=}\tfrac12<1\Rightarrow\Theta(n)$ · $a{=}b{=}2$: $r{=}1\Rightarrow\Theta(n\log n)$ · $a{=}3,b{=}2$: $r{=}\tfrac32>1\Rightarrow\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$ · $a{=}4,b{=}2$: $r{=}2>1\Rightarrow\Theta(n^{2})$ **· precondition:** read $a$ off the number of **recursive calls**, never off the shifts/additions in the combine.
- **Leaf identity** `[D]` ➔ $n(a/b)^{\log_b n}=n^{\log_b a}$ — the collapse that produces every D&C exponent.
- **Diagnostic** `[P]` ➔ *subtract* from the argument ⟹ depth $\Theta(N)$; *divide* ⟹ depth $\Theta(\log N)$. Depth and per-level work are independent choices.
- 🔭 **Master Theorem** *(supplementary — see the scope table above)* ➔ for $T(n)=aT(n/b)+\Theta(n^{d})$: $d<\log_b a\Rightarrow\Theta(n^{\log_b a})$ · $d=\log_b a\Rightarrow\Theta(n^{d}\log n)$ · $d>\log_b a\Rightarrow\Theta(n^{d})$ **· precondition:** the argument must shrink **multiplicatively**; applying it to $T(n-1)$ yields a wrong answer, not just an unjustified one.

## 4️⃣ Recursive Time **and** Space in One Pass (W1)
**Protocol** `[P]`**:** read $a$ (recursive calls) + argument shrink + per-call work → recurrence → telescope for **time**; take the same depth $k$ → **auxiliary space** ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].

- **Auxiliary space $=\Theta(\text{max stack depth})$** `[P]` ➔ **never** $\Theta(\text{total calls})$ **· precondition:** siblings run sequentially — one root-to-leaf frame chain is live at a time.
- **Single-call recursion ⟹ time $=$ space class** `[P]` ➔ $T(N)=T(N{-}1)+c$: $\Theta(N)$/$\Theta(N)$ · $T(N)=T(N/2)+c$: $\Theta(\log N)$/$\Theta(\log N)$ **· consequence:** only **branching** ($a\ge2$) decouples the two columns.
- **Fibonacci is the decoupling witness** `[C]` ➔ $O(2^{N})$ time (counts **nodes**) but $\Theta(N)$ auxiliary (counts **height**) **· precondition:** state which of node-count and height you are measuring, or the answer is unmarkable.
- **Shrinking allocations SUM** `[C]` ➔ [[Merge Sort]] scratch $N+\tfrac N2+\tfrac N4+\dots<2N$ ⟹ $\Theta(N+\log N)=\Theta(N)$, not $\Theta(N\log N)$ **· precondition:** the $r=\tfrac12$ [[Geometric Series]] corollary.
- **Iterative rewrite drops the stack term** `[P]` ➔ same time, $O(1)$ auxiliary — why [[Binary Search]] and [[Linear Search]] are written as loops.
- **`power` vs `power_better`** `[P]` ➔ $x^{N}=(x^{2})^{N/2}$ ⟹ pass `x*x`, halve $N$ ⟹ $\Theta(\log N)$ time and space, against $\Theta(N)$/$\Theta(N)$ **· precondition:** squaring the base is the halving; leaving `x` alone computes the wrong value.

## 5️⃣ Divide & Conquer (W1)
- **Shape** `[P]` ➔ divide → conquer recursively → combine **· precondition:** subproblems are **independent**; overlapping ones recompute exponentially and demand memoisation/DP instead.
- **Balance sets depth** `[C]` ➔ even halves $\log_2 n$ levels ⟹ $\Theta(n\log n)$ · maximally lopsided $n$ levels ⟹ $\Theta(n^{2})$ · single half with $\Theta(1)$ work ⟹ $\Theta(\log n)$.
- **Split/combine trade** `[C]` ➔ [[Merge Sort]] trivial split / heavy combine · [[Quick Sort]] heavy split / trivial combine · [[Binary Search]] one subproblem ("decrease and conquer").
- **The $\log$ factor is bought by the combine, not the branching** `[D]` ➔ $2T(n/2)+\Theta(1)=\Theta(n)$ but $2T(n/2)+\Theta(n)=\Theta(n\log n)$.

## 6️⃣ W1 Algorithm Bounds
| Algorithm | Recurrence | Time (B/A/W) | Auxiliary space | Discriminator |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook multiply | — | $\Theta(n^{2})$ all | $\Theta(n)$ | every digit pair |
| Naive D&C multiply | $4T(n/2)+\Theta(n)$ | $\Theta(n^{2})$ all | $\Theta(n)$ | $a{=}4$ ⟹ no gain |
| [[Merge Sort]] | $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ all | $\Theta(n)$ scratch $+\ \Theta(\log n)$ stack $=\Theta(n)$ | order-independent, **stable** |
| [[Quick Sort]] | avg $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ / $\Theta(n^{2})$ W | $O(\log n)$ stack | pivot quality |
| `find_min` (iterative) | — | $\Theta(n)$ all | $O(1)$ — **in-place** | no early exit ⟹ B $=$ W |
| `build_list(n)` | — | $\Theta(n)$ all | $\Theta(n)$ allocated | input is a *number*, output is the cost |
| [[Linear Search]] (recursive) | $T(n)=T(n-1)+c$ | $\Theta(1)$ / $\Theta(n)$ / $\Theta(n)$ | $\Theta(n)$ frames | early return on hit |
| [[Binary Search]] (iterative) | $T(n)=T(n/2)+c$ | $\Theta(1)$ / $\Theta(\log n)$ / $\Theta(\log n)$ | $O(1)$ · **recursive:** $\Theta(\log n)$ frames | early return on hit; input space $\Theta(n)$ |
| `f(n) = 2*f(n//3) + 4` | $T(n)=T(n/3)+c$ | $\Theta(\log n)$ all | $\Theta(\log n)$ frames | **one** call site |
| `f(n) = f(n//3)+f(n//3)+4` | $T(n)=2T(n/3)+c$ | $\Theta(n^{\log_3 2})\approx\Theta(n^{0.63})$ | $\Theta(\log n)$ frames | **two** call sites — leaf-dominated |
| `power` | $T(N)=T(N-1)+c$ | $\Theta(N)$ all | $\Theta(N)$ frames | decrement |
| `power_better` | $T(N)=T(N/2)+c$ | $\Theta(\log N)$ all | $\Theta(\log N)$ frames | squares the base |
| naive `fibonacci` | $T(N)=T(N{-}1)+T(N{-}2)+c$ | $O(2^{N})$ all | $\Theta(N)$ frames | **nodes vs height** |
| Range report, scan | — | $\Theta(N+W)=\Theta(N)$ | $O(1)$ | touches all $N$ |
| Range report, [[Binary Search]] $+$ scan | — | $\Theta(\log N+W)$ | $O(1)$ | **optimal** — meets $\Omega(\log N+W)$ |

- **Asymptotic win ≠ faster in practice** `[C]` ➔ a lower exponent bought with extra additions/shifts carries a large constant, so the "worse" algorithm wins on small $n$ **· consequence:** an asymptotic claim is never a claim about a particular input size.
- **Merge stability** `[C]` ➔ the tie-break `a[ia] <= a[ib]` emits from the **left** half **· precondition:** strict `<` breaks stability.

## 7️⃣ Proof of Correctness (W2)
> [!warning] Correctness is **two** obligations. An invariant with no termination argument proves only *partial* correctness; a termination argument with no invariant proves only that it stops — possibly with the wrong answer.

- **The answer template** `[P]` ➔ *(1)* loop invariant, quantified over the counter · *(2)* termination: the measure that **strictly** decreases · *(3)* one line: invariant $\wedge\ \neg\text{guard}\Rightarrow$ postcondition **· precondition:** the invariant must mention the **data**, not just the counter — "`i` increases" is not an invariant.
- **Three-part induction** `[P]` ➔ **initialization** (base) · **maintenance** (step) · **termination** (exit) ➔ [[Invariant]].
- **Termination template** `[P]` ➔ domain is **finite** · counter **starts** at a known point · every iteration moves it **monotonically** toward the bound **· recursive variant:** name the argument that shrinks and the base case it reaches.
- **Variant** `[C]` ➔ $V_k\in\mathbb{N}$ with $V_{k+1}<V_k$ **· precondition:** *strictly* — a step that may leave $V$ unchanged is where infinite loops live.
- **Design order** `[C]` ➔ define the invariant, **then** code to it; keep it the **weakest** statement that implies the postcondition — extra clauses are extra proof burden, no extra marks.
- **Exam shape** `[P]` ➔ *"(1 mark) write a loop invariant for Floyd–Warshall that shows it computes all-pairs shortest distances"* — prose algorithm in, one quantified sentence out.

| Algorithm | Loop invariant | Termination measure |
| :--- | :--- | :--- |
| `find_min` | `my_min` $=\min($`array[0…index]`$)$ | `index` starts at $1$, increments, array finite |
| Selection sort | `my_list[0…i-1]` sorted **AND** $\le$ all of `my_list[i…N]` | $i$ and $j$ only increment, both reach the end |
| Insertion sort | `my_list[0…i-1]` sorted (not final) | $i$ increments; inner $j$ decreases, bounded by $0$ |
| [[Binary Search]] | key in `array[0…N]` $\Rightarrow$ key in `array[lo…hi]` | $hi-lo$ must **strictly** shrink ⟹ the bug vector |

- **The `lo = mid` hang** `[P]` ➔ at $lo{=}5,hi{=}6$: $mid=5$, so `lo = mid` is a **no-op** ⟹ never terminates **· fix:** `mid + 1`, or guard `while lo < hi - 1` with an **exclusive** `hi = len(array)` so the space shrinks to size $1$.

## 8️⃣ Sorting — the Four-Axis Suite (W2)
> [!warning] Rank every sort on **correctness · time (B/A/W) · auxiliary space · stability**. Two multipliers are dropped constantly: the $O(k)$ comparison cost and the recursion stack.

- **$\Omega(N\log N)$ is a claim about a CLASS** `[P]` ➔ it binds **comparison-based** sorts only **· consequence:** [[Merge Sort]]/[[Heapsort]] are *provably optimal* there; [[Counting Sort]]/[[Radix Sort]] escape it by assuming **bounded integer keys**, not by beating it.
- **Comparison cost multiplies EVERYTHING** `[P]` ➔ comparing words/tuples costs $O(k)$ ⟹ $O(kN^{2})$ elementary, $O(kN\log N)$ merge **· precondition:** declare $k$ constant or carry it.
- **Recursion stack is auxiliary space** `[P]` ➔ $\Theta(\log N)$ live frames, $\Theta(k\log N)$ if a frame holds $k$ words ⟹ recursive sorts are **not in-place** even with zero heap allocation **· consequence:** in-place $\equiv O(1)$ auxiliary, so the iterative rewrite is the only route.
- **Selection sort has no best case** `[C]` ➔ the minimum must be located in full every pass ⟹ B $=$ A $=$ W $=\Theta(N^{2})$; **unstable** via the long-distance swap (`[4a,2,3,4b,1]`$\to$`[1,2,3,4b,4a]`).
- **Insertion sort is stable because it SHIFTS** `[C]` ➔ equal keys are never moved past each other; best $O(N)$ when the inner `while` never fires.

| Algorithm | Best | Average | Worst | Auxiliary | Stable | In-place |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Selection | $\Theta(N^{2})$ | $\Theta(N^{2})$ | $\Theta(N^{2})$ | $O(1)$ | No | Yes |
| Insertion | $\Theta(N)$ | $\Theta(N^{2})$ | $\Theta(N^{2})$ | $O(1)$ | **Yes** | Yes |
| [[Heapsort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $O(1)$ | No | Yes |
| [[Merge Sort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N)+\Theta(\log N)$ | **Yes** | No |
| [[Quick Sort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N^{2})$ | $O(\log N)$ | Depends | No |
| [[Counting Sort]] | $\Theta(N{+}M)$ | $\Theta(N{+}M)$ | $\Theta(N{+}M)$ | $\Theta(M)$ · $\Theta(M{+}N)$ stable | engineered | No |
| [[Radix Sort]] | $\Theta(KN{+}KM)$ | $\Theta(KN{+}KM)$ | $\Theta(KN{+}KM)$ | $\Theta(M{+}N)$ | **required** | No |

- **[[Counting Sort]] phases** `[P]` ➔ max $\Theta(N)$ → allocate $\Theta(M)$ → tally $\Theta(N)$ (key **is** the index) → rebuild $\Theta(N{+}M)$ **· precondition:** $M$ is the **key range**; quoting $\Theta(N)$ requires stating that $M$ is capped (alphabet $26$, digits $10$).
- **Stability is engineered, not inherited** `[P]` ➔ prefix-sum positions: `position[first] = 1`, $\text{position}[i]=\text{position}[i-1]+\text{count}[i-1]$, then scan the input **forwards** writing `output[position[key]]` and incrementing.
- **Bucket space is $\Theta(M{+}N)$, NOT $\Theta(M\cdot N)$** `[P]` ➔ lecturer-flagged *very common misconception* — buckets **partition** the input, $\sum_v\text{count}[v]=N$, so slots and payloads **add**.
- **[[Radix Sort]] $=$ $K$ stable counting sorts** `[P]` ➔ LSD (rightmost) first **· precondition:** each pass **must** be stable, or the order won by lower-significance passes is destroyed and nothing later repairs it.
- **The $M$ notation clash** `[C]` ➔ in counting sort $M$ is the **maximum key**; in radix sort $M$ is the **base** (distinct symbols per column) — name which before quoting.
- **Auxiliary carries no $K$** `[D]` ➔ the count/position/output arrays are **reused** each pass ⟹ $\Theta(M{+}N)$; only the *input* is $\Theta(KN)$.
- **$K$ vs base trade** `[C]` ➔ $K=\lceil\log_M(\text{max key})\rceil$ — raising $M$ shrinks $K$ but grows the $\Theta(KM)$ term and $\Theta(M)$ auxiliary **· precondition:** worth it while $M\ll N$.
- **"Radix is $\Theta(N)$" needs a hypothesis** `[D]` ➔ true only for **capped** key width; $N$ distinct base-$M$ keys force $K\ge\log_M N$, recovering $\Theta(N\log N)$.
- **Ragged keys** `[C]` ➔ pad to a common width with a filler that sorts below every real symbol **· precondition:** right-aligned padding gives numeric order, left-aligned gives lexicographic — they differ.
