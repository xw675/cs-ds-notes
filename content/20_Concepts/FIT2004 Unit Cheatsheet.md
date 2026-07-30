---
unit: FIT2004
domain: A
parent: "[[FIT2004_MOC]]"
tags: [CS/Algorithms, CS/Complexity]
type: cheatsheet
aliases: [FIT2004 Exam Crib, Algorithms II Cheatsheet]
---
# [[FIT2004 Unit Cheatsheet]]

**Context:** [[FIT2004_MOC]] · the WHOLE unit in one re-read, syllabus-ordered. Every claim is hand-derivable; wikilinks for depth only. FIT1008 foundations live in [[FIT1008 Unit Cheatsheet]] — this sheet holds the FIT2004 **rigour layer** (recurrences, derivations, bounds). *Currently seeded to W1; extend each week.*
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
- **Unqualified "complexity" = worst case** `[P]` ➔ best/worst diverge **· precondition:** the code has a short-circuit (`break`/early return) or input-dependent branching; otherwise best $=$ worst (selection sort, Karatsuba) and you may state one $\Theta$ for all cases.
- **Input size $n$** `[C]` ➔ elements for a collection, but **bit-length** for a *number* ($n=\lceil\log_2(k+1)\rceil$) **· precondition:** state which you are counting — a loop running $k$ times on numeric input $k$ is $O(2^{n})$, not $O(n)$.
- **A CAPPED parameter is $\Theta(1)$ and vanishes** `[C]` ➔ $n\le10^{6}\Rightarrow\Theta(nm)$ becomes $\Theta(m)$; $arr[i]<2^{32}\Rightarrow$ bit-count constant $\Rightarrow\Theta(n)$ **· precondition:** list which parameters may grow before quoting any bound.
- **Space = AUXILIARY** `[P]` ➔ extra beyond the input; in-place $\equiv O(1)$ auxiliary **· precondition:** include the recursion stack — $\Theta(\text{depth})$ frames, only ONE root-to-leaf chain live at a time.
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
**Protocol** `[P]`**:** write recurrence + base → expand 2–3 steps → general form in $k$ → fix $k$ from the base → back-substitute.

| Recurrence | Depth $k$ | Accumulates | Closed form |
| :--- | :--- | :--- | :--- |
| $T(N)=T(N-1)+c$ | $N-1$ | $k$ constants | $\Theta(N)$ |
| $T(N)=T(N-1)+cN$ | $N-1$ | arithmetic series $\tfrac{N(N+1)}{2}$ | $\Theta(N^{2})$ |
| $T(N)=T(N/2)+c$ | $\log_2 N$ | $k$ constants | $\Theta(\log N)$ |
| $T(N)=T(N/2)+cN$ | $\log_2 N$ | geometric $r=\tfrac12$ | $\Theta(N)$ |
| $T(n)=a\,T(n/b)+cn$ | $\log_b n$ | geometric $r=a/b$ | regime below |

- **Level-sum** `[C]` ➔ $T(n)=\sum_{i=0}^{\log_b n} c\,n\,(a/b)^{i}$ — level $i$ holds $a^{i}$ subproblems of size $n/b^{i}$ **· precondition:** subproblems are equal-sized and the combine is $\Theta(n)$.
- **Regime from the ratio $r=a/b$** `[C]` ➔ $r<1$ **root-dominated** $\Theta(n)$ · $r=1$ **all levels equal** $\Theta(n\log n)$ · $r>1$ **leaf-dominated** $\Theta(n^{\log_b a})$.
- **Leaf identity** `[D]` ➔ $n(a/b)^{\log_b n}=n^{\log_b a}$ — the collapse that produces every D&C exponent.
- **Diagnostic** `[P]` ➔ *subtract* from the argument ⟹ depth $\Theta(N)$; *divide* ⟹ depth $\Theta(\log N)$. Depth and per-level work are independent choices.
- 🔭 **Master Theorem** *(shortcut, not lectured in W1)* ➔ for $T(n)=aT(n/b)+\Theta(n^{d})$: $d<\log_b a\Rightarrow\Theta(n^{\log_b a})$ · $d=\log_b a\Rightarrow\Theta(n^{d}\log n)$ · $d>\log_b a\Rightarrow\Theta(n^{d})$ **· precondition:** cite telescoping in assessment unless formally introduced.

## 4️⃣ Divide & Conquer (W1)
- **Shape** `[P]` ➔ divide → conquer recursively → combine **· precondition:** subproblems are **independent**; overlapping ones recompute exponentially and demand memoisation/DP instead.
- **Balance sets depth** `[C]` ➔ even halves $\log_2 n$ levels ⟹ $\Theta(n\log n)$ · maximally lopsided $n$ levels ⟹ $\Theta(n^{2})$ · single half with $\Theta(1)$ work ⟹ $\Theta(\log n)$.
- **Split/combine trade** `[C]` ➔ [[Merge Sort]] trivial split / heavy combine · [[Quick Sort]] heavy split / trivial combine · [[Binary Search]] one subproblem ("decrease and conquer").
- **The $\log$ factor is bought by the combine, not the branching** `[D]` ➔ $2T(n/2)+\Theta(1)=\Theta(n)$ but $2T(n/2)+\Theta(n)=\Theta(n\log n)$.

## 5️⃣ W1 Algorithm Bounds
| Algorithm | Recurrence | Time (B/A/W) | Auxiliary space | Discriminator |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook multiply | — | $\Theta(n^{2})$ all | $\Theta(n)$ | every digit pair |
| Naive D&C multiply | $4T(n/2)+\Theta(n)$ | $\Theta(n^{2})$ all | $\Theta(n)$ | $a{=}4$ ⟹ no gain |
| [[Karatsuba Integer Multiplication]] | $3T(n/2)+\Theta(n)$ | $\Theta(n^{\log_2 3})$ all | $\Theta(n)$ | $a{=}3$ via Gauss trick |
| [[Merge Sort]] | $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ all | $\Theta(n)$ scratch | order-independent, **stable** |
| [[Quick Sort]] | avg $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ / $\Theta(n^{2})$ W | $O(\log n)$ stack | pivot quality |

- **Karatsuba identity** `[P]` ➔ $x_Ly_R+x_Ry_L=(x_L{+}x_R)(y_L{+}y_R)-x_Ly_L-x_Ry_R$ **· precondition:** $A=x_Ly_L$ and $C=x_Ry_R$ computed first and **reused**; shifts by $B^{m}$/$B^{2m}$ are $\Theta(n)$ combine work, never counted in $a$.
- **Karatsuba wins only ASYMPTOTICALLY** `[C]` ➔ the extra additions and shifts carry a large constant, so schoolbook is faster on small $n$ **· consequence:** an asymptotic win is never a claim about a particular input size.
- **Merge stability** `[C]` ➔ the tie-break `a[ia] <= a[ib]` emits from the **left** half **· precondition:** strict `<` breaks stability.
