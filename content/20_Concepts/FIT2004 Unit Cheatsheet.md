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
> - **⚡ Key Constraint:** naming a growth class without the derivation line earns nothing — the marks are in the general form in $k$ and the base case that fixes it.

## 1️⃣ Analysis Discipline (W1)
- **Formal definitions — state the witnesses** ➔ $O$: $\exists c,n_0>0$ with $f\le cg$ $\forall n\ge n_0$ · $\Omega$: $\exists c,n_0$ with $f\ge cg$ · $\Theta$: $\exists c_1,c_2,n_0$ with $c_1g\le f\le c_2g$ **· precondition:** every claim needs the constants **and** the range of $n$; a proof without witnesses scores nothing.
- **Valid ≠ tight** ➔ $3n^{2}+15\log n+100n$ **is** $O(n^{3})$ (TRUE, $c{=}118,n_0{=}1$) and **is** $\Omega(n)$, but **not** $\Theta(n^{3})$ **· precondition:** on true/false questions answer from the definition — "not the tightest" never makes an $O$ claim false.
- **Kill a $\Theta$ by breaking either side** ➔ $\Theta(n^{3})$ fails because $T(n)/n^{3}\to0$ leaves no $c_1$.
- **Notation ⊥ case** ➔ $O/\Omega/\Theta$ bound a function; best/worst pick *which* function **· precondition:** name both — "any operation is $O(g)$" bounds the **dearest**, "$\Omega(g)$" the **cheapest**; an unqualified $\Theta$ asserts they agree.
- **Input size $n$** ➔ elements for a collection, but **bit-length** for a *number* ($n=\lceil\log_2(k+1)\rceil$) **· precondition:** state which you are counting — a loop running $k$ times on numeric input $k$ is $O(2^{n})$, not $O(n)$.
- **A CAPPED parameter is $\Theta(1)$ and vanishes** ➔ $n\le10^{6}\Rightarrow\Theta(nm)$ becomes $\Theta(m)$; $arr[i]<2^{32}\Rightarrow$ bit-count constant $\Rightarrow\Theta(n)$ **· precondition:** list which parameters may grow before quoting any bound.
- **Unqualified "complexity" = worst case** ➔ best/worst diverge **· precondition:** the code has a short-circuit (`break`/early return) or input-dependent branching; otherwise best $=$ worst (selection sort, Karatsuba).
- **Quote the tightest bound when CHARACTERISING** ➔ $\Theta$ whenever best $=$ worst; $\Theta=O\cap\Omega$.
- **$\Omega$ for problems / $\Theta$ for algorithms is a CONVENTION** ➔ an algorithm's $O$ meeting the problem's $\Omega$ ⟹ **provably optimal**; but $\Omega$ is defined on any function, so "any BST insertion is $\Omega(1)$" is well-formed and true.
- **Worst-case-per-op × count is an UPPER bound only** ➔ tightness needs a **witness input** where the worst cases co-occur ($n$ *sorted* BST insertions ⟹ $\Theta(n^{2})$).
- **Space = AUXILIARY** ➔ extra beyond the input; in-place $\equiv O(1)$ auxiliary **· precondition:** include the recursion stack — $\Theta(\text{depth})$ frames, only ONE root-to-leaf chain live at a time.
- **Declare unit-cost** ➔ "$+$ is $O(1)$" needs machine-word operands **· precondition:** values whose bit-length grows with $n$ cost $\Theta(\text{bits})$ per op — iterative Fibonacci is $\Theta(n)$ word-ops but $\Theta(n^{2})$ bit-ops.
- **Big-O algebra** ➔ Sum $O(g_1)+O(g_2)=O(\max)$ · Product $O(g_1)O(g_2)=O(g_1g_2)$ **· precondition:** upper bounds only — this algebra cannot produce a lower bound.
- **Ladder** ➔ $1\prec\log n\prec\sqrt n\prec n\prec n\log n\prec n^{1.585}\prec n^{2}\prec n^{3}\prec 2^{n}\prec n!$.

## 2️⃣ Identities That Do the Work (W1)
- **Exponent swap** ➔ $a^{\log_b n}=n^{\log_b a}$ **· proof:** $a^{\log_b n}=(b^{\log_b a})^{\log_b n}=(b^{\log_b n})^{\log_b a}$ — the exponent product is symmetric. Turns a leaf **count** into a **power of $n$**.
- **Halving depth** ➔ $\log_2\!\big(\tfrac{k+1}{2}\big)+1=\log_2(k+1)$ ➔ one extra halving adds exactly $1$ to the depth.
- **[[Arithmetic Series|Arithmetic]]** ➔ $\sum_{i=1}^{n}i=\tfrac{n(n+1)}{2}=\Theta(n^{2})$ ➔ shrink-by-one recurrences, quadratic sorts, sorted BST builds.
- **[[Geometric Series|Geometric]]** ➔ $\sum_{i=0}^{n}r^{i}=\tfrac{r^{n+1}-1}{r-1}$ **· precondition:** $r\neq1$ (at $r=1$, $S_n=n+1$).
- **$r=2$ corollary** ➔ $\sum_{i=0}^{n}2^{i}=2^{n+1}-1$ ➔ complete-binary-tree node count; the leaf level alone outweighs everything above it.
- **$r=\tfrac12$ corollary** ➔ $\sum_{i=0}^{n}2^{-i}=2-2^{-n}<2$ ➔ **strict, $n$-independent**: halving work totals $<2\times$ the top level. Both corollaries are **substitutions**, not new inductions.

## 3️⃣ Recurrence Solving — Telescoping (W1)
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

## 4️⃣ Divide & Conquer (W1)
- **Shape** ➔ divide → conquer recursively → combine **· precondition:** subproblems are **independent**; overlapping ones recompute exponentially and demand memoisation/DP instead.
- **Balance sets depth** ➔ even halves $\log_2 n$ levels ⟹ $\Theta(n\log n)$ · maximally lopsided $n$ levels ⟹ $\Theta(n^{2})$ · single half with $\Theta(1)$ work ⟹ $\Theta(\log n)$.
- **Split/combine trade** ➔ [[Merge Sort]] trivial split / heavy combine · [[Quick Sort]] heavy split / trivial combine · [[Binary Search]] one subproblem ("decrease and conquer").
- **The $\log$ factor is bought by the combine, not the branching** ➔ $2T(n/2)+\Theta(1)=\Theta(n)$ but $2T(n/2)+\Theta(n)=\Theta(n\log n)$.

## 5️⃣ W1 Algorithm Bounds
| Algorithm | Recurrence | Time (B/A/W) | Auxiliary space | Discriminator |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook multiply | — | $\Theta(n^{2})$ all | $\Theta(n)$ | every digit pair |
| Naive D&C multiply | $4T(n/2)+\Theta(n)$ | $\Theta(n^{2})$ all | $\Theta(n)$ | $a{=}4$ ⟹ no gain |
| [[Karatsuba Integer Multiplication]] | $3T(n/2)+\Theta(n)$ | $\Theta(n^{\log_2 3})$ all | $\Theta(n)$ | $a{=}3$ via Gauss trick |
| [[Merge Sort]] | $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ all | $\Theta(n)$ scratch | order-independent, **stable** |
| [[Quick Sort]] | avg $2T(n/2)+\Theta(n)$ | $\Theta(n\log n)$ / $\Theta(n^{2})$ W | $O(\log n)$ stack | pivot quality |

- **Karatsuba identity** ➔ $x_Ly_R+x_Ry_L=(x_L{+}x_R)(y_L{+}y_R)-x_Ly_L-x_Ry_R$ **· precondition:** $A$ and $C$ computed first and **reused**; shifts by $B^{m}$/$B^{2m}$ are $\Theta(n)$ combine work, never counted in $a$.
- **Merge stability** ➔ the tie-break `a[ia] <= a[ib]` emits from the **left** half **· precondition:** strict `<` breaks stability.
