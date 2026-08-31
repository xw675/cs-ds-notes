---
unit: FIT2004
domain: A
week: 2
source: [lecture, applied]
parent: "[[Recursion]]"
tags:
  - CS/Algorithms
  - CS/Complexity
aliases:
  - recursive complexity pipeline
  - recursion stack space
  - auxiliary space of recursion
  - call stack complexity
---
# [[Analysing Recursive Algorithms (Time and Auxiliary Space)]]

**Context:** [[FIT2004_MOC]] · the lecture-2 spine — **pseudocode ➔ recurrence ➔ complexity** — plus the half [[Solving Recurrences (Telescoping)]] does not own: reading **auxiliary space** off the same recursion
**Parent Framework:** [[Recursion]]

> [!abstract] Quick Revision
> - **🎯 Objective:** one recursive function yields **two** answers ➔ solve the recurrence for **time**, measure the **deepest live frame chain** for **auxiliary space**.
> - **📦 Core Components:** **read $a$, shrink, work** off the code ➔ recurrence | **telescope** ➔ time | **max depth** ➔ space.
> - **⚡ Key Constraint:** auxiliary space is $\Theta(\text{max depth})$, **never** $\Theta(\text{total calls})$ — siblings run sequentially, so naive Fibonacci is $O(2^{N})$ time but only $\Theta(N)$ space.

## 📝 How It Works
### 1. Stage 1 — code ➔ recurrence
- **Read three things** ➔ $a$ = how many **recursive calls** the body makes · the **shrink** on the argument ($N-1$ vs $N/2$) · the **non-recursive work** per call ($c$, or $cN$ if the body scans).
- **$a$ counts call SITES, not multipliers** ➔ a scalar on the returned value is $\Theta(1)$ arithmetic and folds into $c$; only a second *invocation* raises $a$. `2 * f(n//3)` ⟹ $a=1$; `f(n//3) + f(n//3)` ⟹ $a=2$.
- **Write it piecewise with symbolic constants** ➔ base $T(n)=a$ for $n<k$, general $T(n)=\dots+c$ for $n\ge k$, where $k$ is the **guard threshold** read off the `if` — not a reflexive $T(1)=b$. Without the base line Stage 2 cannot fix the depth.
- **Sum, don't nest** ➔ two calls in one body give $T(N-1)+T(N-2)$, an additive branching term — not a product. Guards are $\Theta(1)$ and fold into $c$.
- **Scope: the argument must SHRINK** ➔ assessed recurrences decrease the search space each call (`n-1`, `n//2`, `n//3`); recursions whose argument *grows* are out of scope.

### 2. Stage 2 — recurrence ➔ time
- **Owned elsewhere** ➔ the solving itself, in the mandated **Steps 0→6b** format ➔ [[Solving Recurrences (Telescoping)]].
- **The one diagnostic** ➔ *subtracting* from the argument gives depth $\Theta(N)$; *dividing* gives depth $\Theta(\log N)$.

### 3. Stage 3 — recursion ➔ auxiliary space
- **What the stack costs** ➔ each live call holds a **frame** (parameters, locals, return address) ⟹ auxiliary space $=\Theta(\text{max depth})\times\text{frame size}$.
- **Depth reuses Stage 2's number** ➔ the $k$ that solved the recurrence **is** the depth: shrink-by-one ⟹ $\Theta(N)$ frames · halving ⟹ $\Theta(\log N)$ frames.
- **Only one root-to-leaf path is live** ➔ a sibling call cannot start until the previous one returned and popped, so a branching recursion pays for its **height**, not its node count.
- **Add, don't max, when a data buffer exists** ➔ [[Merge Sort]] allocates $\Theta(N)$ scratch **and** carries $\Theta(\log N)$ frames ⟹ $\Theta(N+\log N)=\Theta(N)$.
- **An iterative rewrite kills the stack term** ➔ same time, $O(1)$ auxiliary — why [[Binary Search]] is written with a `while` loop.

## ⚙️ Core Implementation
### 🔹 Reading $a$ off the code — the multiplier trap
> [!code]- same shrink, same constant work, different $a$
> ```python
> def bla_one(n):
>     if n < 3:
>         return n                     # base:    T(n) = a,             n < 3
>     return 2 * bla_one(n // 3) + 4   # ONE call; the *2 and +4 are O(1)
>                                      # general: T(n) = T(n/3) + c,    n >= 3
>
> def bla_two(n):
>     if n < 3:
>         return n
>     return bla_two(n // 3) + bla_two(n // 3) + 4   # TWO calls, same size
>                                      # general: T(n) = 2 T(n/3) + c,  n >= 3
> ```
> 💡 **Common Mistake:** **Writing $2T(n/3)$ for `2 * bla(n//3)`** ➔ the algebra looks identical but the call tree does not — $T(n/3)+c$ telescopes to $\Theta(\log n)$ (one chain), whereas $2T(n/3)+c$ is leaf-dominated $\Theta(n^{\log_3 2})\approx\Theta(n^{0.63})$. Count invocations in the source, never coefficients.

### 🔹 Linear vs halving recursion — the same shape, two classes
> [!code]- `power` ($\Theta(N)$) vs `power_better` ($\Theta(\log N)$)
> ```python
> def power(x, n):                     # T(n) = T(n-1) + c
>     if n == 0: return 1
>     if n == 1: return x
>     return x * power(x, n - 1)       # depth n-1 -> Theta(n) time, Theta(n) frames
>
> def power_better(x, n):              # T(n) = T(n/2) + c
>     if n == 0: return 1
>     if n == 1: return x
>     if n % 2 == 0:
>         return power_better(x * x, n // 2)      # square the base, halve the exponent
>     return x * power_better(x * x, n // 2)      # odd -> peel one factor first
> # depth floor(log2 n)+1 -> Theta(log n) time, Theta(log n) frames
> ```
> 💡 **Common Mistake:** **Squaring the base is what buys the halving** ➔ `power_better(x, n//2)` computes $x^{n/2}$, not $x^{n}$; the recursion must pass `x*x` because $x^{n}=(x^{2})^{n/2}$.

### 🔹 Duplicate calls — the halving that buys nothing *(Applied 2 P4)*
> [!code]- `power_naive` ($2T(p/2)+c=\Theta(p)$) vs the one-line repair ($\Theta(\log p)$)
> ```python
> def power_naive(x, p):               # T(p) = 2 T(p/2) + c
>     if p == 0: return 1
>     if p == 1: return x
>     if p % 2 == 0:
>         return power_naive(x, p // 2) * power_naive(x, p // 2)      # SAME argument, twice
>     return power_naive(x, p // 2) * power_naive(x, p // 2) * x
> # halving depth log2(p), but a BINARY call tree -> Theta(p) calls -> Theta(p) time
>
> def power_fast(x, p):                # T(p) = T(p/2) + c
>     if p == 0: return 1
>     y = power_fast(x, p // 2)        # compute ONCE, bind it
>     if p % 2 == 0:
>         return y * y
>     return y * y * x
> # one call per level -> Theta(log p) time, Theta(log p) frames
> ```
> 💡 **Common Mistake:** **Assuming "it halves, so it's $\Theta(\log p)$"** ➔ halving fixes only the tree's **height**; two calls per node fill that height with $\Theta(2^{\log_2 p})=\Theta(p)$ nodes. Depth and node count are separate questions.

- **The leaf-count argument** ➔ a binary tree of height $h$ holds at most $2^{h+1}-1$ nodes ⟹ $\Theta(2^{\log_2 p})=\Theta(p)$ calls of $O(1)$ work, via the **exponent swap** $a^{\log_b n}=n^{\log_b a}$ ➔ [[Solving Recurrences (Telescoping)]].
- **The transferable repair** ➔ *two recursive calls with **identical arguments** are a common subexpression* — bind and reuse. One `y =` takes $a$ from $2$ to $1$ and $\Theta(p)$ to $\Theta(\log p)$; eliminating such duplicates *across the whole tree* is what memoisation turns [[Divide and Conquer|dynamic programming]] into when the subproblems overlap.
- **Two independent routes to $\Theta(\log p)$** ➔ `power_fast` squares the *result*; `power_better` squares the *base*. Both make $a=1$; mixing them computes $x^{2p}$.

### 🔹 Branching recursion — exponential time, linear space
> [!code]- naive `fibonacci` — the space trap
> ```python
> def fibonacci(n):                    # T(n) = T(n-1) + T(n-2) + c
>     if n == 0: return 0
>     if n == 1: return 1
>     return fibonacci(n - 1) + fibonacci(n - 2)
> # calls  ~ Theta(phi^n) -> O(2^n) time
> # frames ~ n            -> Theta(n) auxiliary space
> ```
> 💡 **Common Mistake:** **Counting calls as frames** ➔ the call **tree** has $\Theta(\varphi^{n})$ nodes but its **height** is only $n$; `fibonacci(n-1)` fully returns and pops before `fibonacci(n-2)` is pushed.

## ⚖️ Complexity
*(Every function in the lecture-2 deck, both deliverables side by side.)*

| Function | Recurrence | Time (worst) | Auxiliary space | What sets the space |
| :--- | :--- | :--- | :--- | :--- |
| `power` | $T(N)=T(N-1)+c$ | $\Theta(N)$ | $\Theta(N)$ | one frame per decrement |
| `power_better` | $T(N)=T(N/2)+c$ | $\Theta(\log N)$ | $\Theta(\log N)$ | halving depth |
| `power_naive` (duplicate call) | $T(p)=2T(p/2)+c$ | $\Theta(p)$ | $\Theta(\log p)$ | binary tree of height $\log_2 p$ ⟹ $\Theta(p)$ **nodes** |
| `power_fast` (`y =` bound once) | $T(p)=T(p/2)+c$ | $\Theta(\log p)$ | $\Theta(\log p)$ | $a$ cut from $2$ to $1$ |
| recursive [[Linear Search]] | $T(N)=T(N-1)+c$ | $\Theta(N)$ | $\Theta(N)$ | one frame per element |
| [[Merge Sort]] | $2T(N/2)+\Theta(N)$ | $\Theta(N\log N)$ | $\Theta(N+\log N)=\Theta(N)$ | scratch array dominates the stack |
| naive `fibonacci` | $T(N)=T(N-1)+T(N-2)+c$ | $O(2^{N})$ | $\Theta(N)$ | **height**, not node count |

> [!NOTE] **When It Flips:** the two columns decouple whenever the recursion **branches**. With one call per body, time and space share the depth; with two or more, time counts **nodes** and space counts **height**, and the gap can be exponential.

## 📊 Exam Execution Trace

### Manual Execution Trace
`power_better(2, 13)` — the live stack, deepest frame at the bottom:

| Step | Frame entered / popped | `x` | `n` | Stack depth | Returns |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | push `pb(2, 13)` | 2 | 13 | 1 | odd ➔ defer $2\times{\dots}$ |
| 1 | push `pb(4, 6)` | 4 | 6 | 2 | even ➔ defer |
| 2 | push `pb(16, 3)` | 16 | 3 | 3 | odd ➔ defer $16\times{\dots}$ |
| 3 | push `pb(256, 1)` | 256 | 1 | **4 (max)** | base ➔ $256$ |
| 4 | pop to depth 3 | 16 | 3 | 3 | $16\times256=4096$ |
| 5 | pop to depth 2 | 4 | 6 | 2 | $4096$ |
| 6 | pop to depth 1 | 2 | 13 | 1 | $2\times4096=\mathbf{8192}$ |

**Read-off:** $4$ frames $=\lfloor\log_2 13\rfloor+1$ ⟹ $\Theta(\log N)$ auxiliary; $4$ multiplications ⟹ $\Theta(\log N)$ time; $8192=2^{13}$ ✓.

### Applied Exercise
**Problem:** `linear_search_recursive(array[1..N], target, index=1)` returns `False` if `index > N`, the index on a match, else recurses with `index+1`. Give worst-case time **and** auxiliary space, and say what the iterative version changes.
$$
T(N) = T(N-1)+c,\; T(0)=b \;\Rightarrow\; T(N)=T(N-k)+kc,\; k=N \;\Rightarrow\; \Theta(N);\quad \text{depth}=N \Rightarrow \text{auxiliary } \Theta(N)
$$
**Final Extracted Output:** $\Theta(N)$ time, $\Theta(N)$ auxiliary. The iterative scan keeps $\Theta(N)$ time but drops to $O(1)$ auxiliary — the recursion buys nothing, which is why [[Linear Search]] is a loop.

## ⚠️ Common Mistakes
- 💡 **"In-place" does not survive recursion silently** ➔ a recursive algorithm that allocates nothing still pays $\Theta(\text{depth})$ for frames; quote it or lose the space mark.
- 💡 **Quoting $\Theta(N\log N)$ space for [[Merge Sort]]** ➔ scratch arrays at different levels are **not** simultaneously live; $N,\tfrac N2,\tfrac N4,\dots$ sum to $<2N$ by the $r=\tfrac12$ bound in [[Geometric Series]].
- 💡 **Forgetting the base case in Stage 1** ➔ the general form in $k$ is unsolvable without it.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)* — CPython performs **no tail-call elimination**, so even a tail-recursive `linear_search_recursive` really does hold $N$ frames and raises `RecursionError` near depth $1000$.

## 🧠 Active Recall
> [!FAQ]- `return 2 * f(n//3) + 4` and `return f(n//3) + f(n//3) + 4` sit in otherwise identical functions. Write both recurrences and both complexities.
> - **Hint:** $a$ is a count of invocations; everything else in the return line is $\Theta(1)$.
> > [!SUCCESS]- Answer
> > - **Short answer:** both share the base $T(n)=a$ for $n<3$. The first is $T(n)=T(n/3)+c \Rightarrow \Theta(\log n)$; the second is $T(n)=2T(n/3)+c \Rightarrow \Theta(n^{\log_3 2})\approx\Theta(n^{0.63})$.
> > - **Why:** **Coefficients don't branch** ➔ multiplying one returned value is a single $\Theta(1)$ op inside one frame, so the call tree stays a **chain** of depth $\log_3 n$. Writing the call twice makes level $i$ hold $2^{i}$ frames, summing geometrically to $\Theta(n^{\log_3 2})$ — leaf-dominated, polynomial instead of logarithmic.

> [!FAQ]- A power function halves its exponent every call yet runs in $\Theta(p)$, not $\Theta(\log p)$. Diagnose it, and repair it in one line.
> - **Hint:** Height and node count are different measurements of the same tree.
> > [!SUCCESS]- Answer
> > - **Short answer:** it calls `power(x, p/2)` **twice with the same argument**, so $T(p)=2T(p/2)+c$ and the binary tree of height $\log_2 p$ holds $\Theta(p)$ nodes. Bind `y = power(x, p//2)` once and return `y*y` ⟹ $T(p)=T(p/2)+c=\Theta(\log p)$.
> > - **Why:** **Halving bounds the depth, branching fills it** ➔ with $a=2,b=2$ against a $\Theta(1)$ combine the level totals are leaf-dominated. Deleting one duplicate call is a change of growth class, not a micro-optimisation.

> [!FAQ]- Naive `fibonacci(n)` makes exponentially many calls yet uses only $\Theta(n)$ auxiliary space. Reconcile the two.
> - **Hint:** Ask what is *live at one instant*, not what happens over the whole run.
> > [!SUCCESS]- Answer
> > - **Short answer:** time counts every **node** of the call tree ($\Theta(\varphi^{n})$, bounded as $O(2^{n})$); space counts only the tree's **height** ($n$), because at most one root-to-leaf chain of frames exists at a time.
> > - **Why:** **Siblings are sequential** ➔ `fibonacci(n-1)`'s entire subtree pops off the stack **before** `fibonacci(n-2)` is pushed, so the two subtrees never coexist in memory though both are paid for in time.

> [!FAQ]- Why does [[Merge Sort]] end up $\Theta(N)$ auxiliary rather than $\Theta(N\log N)$, given every one of its $\log N$ levels allocates?
> - **Hint:** Two different sums — total allocated over time, and peak live at once.
> > [!SUCCESS]- Answer
> > - **Short answer:** peak live memory is what is quoted. Frames along one path hold scratch of sizes $N,\tfrac N2,\tfrac N4,\dots$, summing to $<2N=\Theta(N)$; the $\Theta(\log N)$ stack is dominated.
> > - **Why:** **Shrinking allocations sum, they do not multiply** ➔ by the $r=\tfrac12$ [[Geometric Series]] bound the chain costs less than twice the top level, so the $\log N$ levels contribute a constant factor, not a $\log$ factor.
