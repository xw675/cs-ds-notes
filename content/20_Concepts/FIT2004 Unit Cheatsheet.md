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

> [!abstract] Quick Revision
> - **🎯 Objective:** every analysis question reduces to ➔ **write the recurrence** → **telescope to a level-sum** → **read the regime off the ratio** → quote the **tightest** $\Theta$ with its case and its space.
> - **⚡ Critical Bottleneck:** naming a growth class without the derivation line earns nothing — the marks are in the general form in $k$ and the base case that fixes it.

## 1️⃣ Analysis Discipline (W1)
- **Input size $n$** ➔ elements for a collection, but **bit-length** for a *number* ($n=\lceil\log_2(k+1)\rceil$) **· precondition:** state which you are counting — a loop running $k$ times on numeric input $k$ is $O(2^{n})$, not $O(n)$.
- **Unqualified "complexity" = worst case** ➔ best/worst diverge **· precondition:** the code has a short-circuit (`break`/early return) or input-dependent branching; otherwise best $=$ worst (selection sort, Karatsuba).
- **Quote the tightest bound** ➔ $\Theta$ whenever best $=$ worst; $O$ only for a genuine upper-bound-only claim; $\Theta=O\cap\Omega$.
- **$\Omega$ belongs to PROBLEMS, $\Theta$ to ALGORITHMS** ➔ an algorithm's $O$ meeting the problem's $\Omega$ ⟹ **provably optimal**.
- **Space = AUXILIARY** ➔ extra beyond the input; in-place $\equiv O(1)$ auxiliary **· precondition:** include the recursion stack — $\Theta(\text{depth})$ frames, only ONE root-to-leaf chain live at a time.
- **Big-O algebra** ➔ Sum $O(g_1)+O(g_2)=O(\max)$ · Product $O(g_1)O(g_2)=O(g_1g_2)$ **· precondition:** upper bounds only — this algebra cannot produce a lower bound.
- **Ladder** ➔ $1\prec\log n\prec\sqrt n\prec n\prec n\log n\prec n^{1.585}\prec n^{2}\prec n^{3}\prec 2^{n}\prec n!$.

## 2️⃣ Recurrence Solving — Telescoping (W1)
**Protocol:** write recurrence + base → expand 2–3 steps → general form in $k$ → fix $k$ from the base → back-substitute.

| Recurrence | Depth $k$ | Accumulates | Closed form |
| :--- | :--- | :--- | :--- |
| $T(N)=T(N-1)+c$ | $N-1$ | $k$ constants | $\Theta(N)$ |
| $T(N)=T(N-1)+cN$ | $N-1$ | arithmetic series $\tfrac{N(N+1)}{2}$ | $\Theta(N^{2})$ |
| $T(N)=T(N/2)+c$ | $\log_2 N$ | $k$ constants | $\Theta(\log N)$ |
| $T(N)=T(N/2)+cN$ | $\log_2 N$ | geometric $r=\tfrac12$ | $\Theta(N)$ |
| $T(n)=a\,T(n/b)+cn$ | $\log_b n$ | geometric $r=a/b$ | regime below |

- **Level-sum** ➔ $T(n)=\sum_{i=0}^{\log_b n} c\,n\,(a/b)^{i}$ — level $i$ holds $a^{i}$ subproblems of size $n/b^{i}$ **· precondition:** subproblems are equal-sized and the combine is $\Theta(n)$.
- **Regime from the ratio $r=a/b$** ➔ $r<1$ **root-dominated** $\Theta(n)$ · $r=1$ **all levels equal** $\Theta(n\log n)$ · $r>1$ **leaf-dominated** $\Theta(n^{\log_b a})$.
- **Leaf identity** ➔ $n(a/b)^{\log_b n}=n^{\log_b a}$ — the collapse that produces every D&C exponent.
- **Diagnostic** ➔ *subtract* from the argument ⟹ depth $\Theta(N)$; *divide* ⟹ depth $\Theta(\log N)$. Depth and per-level work are independent choices.
- 🔭 **Master Theorem** *(shortcut, not lectured in W1)* ➔ for $T(n)=aT(n/b)+\Theta(n^{d})$: $d<\log_b a\Rightarrow\Theta(n^{\log_b a})$ · $d=\log_b a\Rightarrow\Theta(n^{d}\log n)$ · $d>\log_b a\Rightarrow\Theta(n^{d})$ **· precondition:** cite telescoping in assessment unless formally introduced.

## 3️⃣ Divide & Conquer (W1)
- **Shape** ➔ divide → conquer recursively → combine **· precondition:** subproblems are **independent**; overlapping ones recompute exponentially and demand memoisation/DP instead.
- **Balance sets depth** ➔ even halves $\log_2 n$ levels ⟹ $\Theta(n\log n)$ · maximally lopsided $n$ levels ⟹ $\Theta(n^{2})$ · single half with $\Theta(1)$ work ⟹ $\Theta(\log n)$.
- **Split/combine trade** ➔ [[Merge Sort]] trivial split / heavy combine · [[Quick Sort]] heavy split / trivial combine · [[Binary Search]] one subproblem ("decrease and conquer").
- **The $\log$ factor is bought by the combine, not the branching** ➔ $2T(n/2)+\Theta(1)=\Theta(n)$ but $2T(n/2)+\Theta(n)=\Theta(n\log n)$.

## 4️⃣ W1 Algorithm Bounds
| Algorithm | Recurrence | Time (B/A/W) | Auxiliary space | Discriminator |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook multiply | — | $\Theta(n^{2})$ all | $\Theta(n)$ | every digit pair |
| Naive D&C multiply | $4T(n/2)+\Theta(n)$ | $\Theta(n^{2})$ all | $\Theta(n)$ | $a{=}4$ ⟹ no gain |
| [[Karatsuba Integer Multiplication]] | $3T(n/2)+\Theta(n)$ | $\Theta(n^{\log_2 3})$ all | $\Theta(n)$ | $a{=}3$ via Gauss trick |
| [[Merge Sort]] | $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ all | $\Theta(n)$ scratch | order-independent, **stable** |
| [[Quick Sort]] | avg $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ / $\Theta(n^{2})$ W | $O(\log n)$ stack | pivot quality |

- **Karatsuba identity** ➔ $x_Ly_R+x_Ry_L=(x_L{+}x_R)(y_L{+}y_R)-x_Ly_L-x_Ry_R$ **· precondition:** $A$ and $C$ computed first and **reused**; shifts by $B^{m}$/$B^{2m}$ are $\Theta(n)$ combine work, never counted in $a$.
- **Merge stability** ➔ the tie-break `a[ia] <= a[ib]` emits from the **left** half **· precondition:** strict `<` breaks stability.
