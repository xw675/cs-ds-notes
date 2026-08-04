---
unit: FIT2004
domain: A
week: 1
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

**Context:** [[FIT2004_MOC]] · the Week 1 lecture-2 spine — **pseudocode ➔ recurrence ➔ complexity** — and the half [[Solving Recurrences (Telescoping)]] does not own: reading **auxiliary space** off the same recursion
**Parent Framework:** [[Recursion]]

> [!abstract] Quick Revision
> - **🎯 Objective:** one recursive function yields **two** answers ➔ solve the recurrence for **time**, measure the **deepest live frame chain** for **auxiliary space**.
> - **📦 Core Components:** **read $a$, shrink, work** off the code ➔ recurrence | **telescope** ➔ time | **max depth** ➔ space.
> - **⚡ Key Constraint:** auxiliary space is $\Theta(\text{max depth})$, **never** $\Theta(\text{total calls})$ — siblings run sequentially, so naive Fibonacci is $O(2^{N})$ time but only $\Theta(N)$ space.

## 📝 How It Works
### 1. Stage 1 — code ➔ recurrence
- **Read three things** ➔ $a$ = how many **recursive calls** the body makes · the **shrink** on the argument ($N-1$ vs $N/2$) · the **non-recursive work** per call ($c$ constant, or $cN$ if the body scans).
- **$a$ counts call SITES, not multipliers** ➔ a scalar on the returned value is $\Theta(1)$ arithmetic and folds into $c$; only a second *invocation* raises $a$. `2 * f(n//3)` ⟹ $a=1$; `f(n//3) + f(n//3)` ⟹ $a=2$ — worked below.
- **Write it piecewise with symbolic constants** ➔ base $T(n)=a$ for $n<k$, general $T(n)=\dots+c$ for $n\ge k$, where $k$ is the **guard threshold** read off the `if` — not a reflexive $T(1)=b$. Without the base line Stage 2 cannot fix the depth.
- **Sum, don't nest** ➔ two calls in one body give $T(N-1)+T(N-2)$, an additive branching term — not a product.
- **Guards are $\Theta(1)$** ➔ `if N == 0` / `if index > N` fold into $c$; they never change the growth class.
- **Scope: the argument must SHRINK** ➔ assessed recurrences decrease the search space each call (`n-1`, `n//2`, `n//3`); recursions whose argument *grows in value* are out of assessment scope.

### 2. Stage 2 — recurrence ➔ time
- **Owned elsewhere** ➔ the solving itself, in the mandated **Steps 0→6b** exam format (levels ➔ substitute ➔ general form ➔ base ➔ closed form ➔ complexity ➔ verify) ➔ [[Solving Recurrences (Telescoping)]].
- **The one diagnostic** ➔ *subtracting* from the argument gives depth $\Theta(N)$; *dividing* gives depth $\Theta(\log N)$.

### 3. Stage 3 — recursion ➔ auxiliary space
- **What the stack costs** ➔ each live call holds a **frame** (parameters, locals, return address) ⟹ auxiliary space $=\Theta(\text{max depth})\times\text{frame size}$.
- **Depth reuses Stage 2's number** ➔ the $k$ that solved the recurrence **is** the depth: shrink-by-one ⟹ $\Theta(N)$ frames · halving ⟹ $\Theta(\log N)$ frames.
- **Only one root-to-leaf path is live** ➔ a sibling call cannot start until the previous one has returned and popped, so a branching recursion pays for its **height**, not its node count.
- **Add, don't max, when a data buffer exists** ➔ [[Merge Sort]] allocates $\Theta(N)$ scratch **and** carries $\Theta(\log N)$ frames ⟹ $\Theta(N+\log N)=\Theta(N)$; the lecture writes both terms, the tightest quote collapses them.
- **An iterative rewrite kills the stack term** ➔ same recurrence-derived time, $O(1)$ auxiliary — the reason [[Binary Search]] is written with a `while` loop.

## ⚙️ Core Implementation
### 🔹 Reading $a$ off the code — the multiplier trap
> [!code]- same shrink, same constant work, different $a$
> ```python
> def bla_one(n):                      # n is an integer
>     if n < 3:
>         return n                     # base:    T(n) = a,             n < 3
>     return 2 * bla_one(n // 3) + 4   # ONE call; the *2 and +4 are O(1)
>                                      # general: T(n) = T(n/3) + c,    n >= 3
>
> def bla_two(n):
>     if n < 3:
>         return n                     # base:    T(n) = a,             n < 3
>     return bla_two(n // 3) + bla_two(n // 3) + 4   # TWO calls, same size
>                                      # general: T(n) = 2 T(n/3) + c,  n >= 3
> ```
> 💡 **Common Mistake:** **Writing $2T(n/3)$ for `2 * bla(n//3)`** ➔ the algebra looks identical on the page but the call tree does not — $T(n/3)+c$ telescopes to $\Theta(\log n)$ ($a/b=\tfrac13$, one chain), whereas $2T(n/3)+c$ is leaf-dominated $\Theta(n^{\log_3 2})\approx\Theta(n^{0.63})$. Count the invocations in the source, never the coefficients.

### 🔹 Linear vs halving recursion — the same shape, two classes
> [!code]- `power` ($\Theta(N)$) vs `power_better` ($\Theta(\log N)$)
> ```python
> def power(x, n):                     # T(n) = T(n-1) + c
>     if n == 0:
>         return 1
>     if n == 1:
>         return x
>     return x * power(x, n - 1)       # depth n-1  ->  Theta(n) time, Theta(n) frames
>
> def power_better(x, n):              # T(n) = T(n/2) + c
>     if n == 0:
>         return 1
>     if n == 1:
>         return x
>     if n % 2 == 0:
>         return power_better(x * x, n // 2)      # square the base, halve the exponent
>     return x * power_better(x * x, n // 2)      # odd -> peel one factor first
> # depth floor(log2 n)+1  ->  Theta(log n) time, Theta(log n) frames
> ```
> 💡 **Common Mistake:** **Squaring the base is what buys the halving** ➔ `power_better(x, n//2)` (base left alone) computes $x^{n/2}$, not $x^{n}$; the recursion must pass `x*x` because $x^{n}=(x^{2})^{n/2}$.

### 🔹 Branching recursion — exponential time, linear space
> [!code]- naive `fibonacci` — the space trap
> ```python
> def fibonacci(n):                    # T(n) = T(n-1) + T(n-2) + c
>     if n == 0:
>         return 0
>     if n == 1:
>         return 1
>     return fibonacci(n - 1) + fibonacci(n - 2)
> # calls  ~ Theta(phi^n)  -> O(2^n) time
> # frames ~ n             -> Theta(n) auxiliary space
> ```
> 💡 **Common Mistake:** **Counting calls as frames** ➔ the call **tree** has $\Theta(\varphi^{n})$ nodes but its **height** is only $n$; `fibonacci(n-1)` fully returns and pops before `fibonacci(n-2)` is entered, so the stack never holds more than $n$ frames.

## ⚖️ Complexity
*(Every function in the lecture-2 deck, both deliverables side by side.)*

| Function | Recurrence | Time (worst) | Auxiliary space | What sets the space |
| :--- | :--- | :--- | :--- | :--- |
| `power` | $T(N)=T(N-1)+c$ | $\Theta(N)$ | $\Theta(N)$ | one frame per decrement |
| `power_better` | $T(N)=T(N/2)+c$ | $\Theta(\log N)$ | $\Theta(\log N)$ | halving depth |
| recursive [[Linear Search]] | $T(N)=T(N-1)+c$ | $\Theta(N)$ | $\Theta(N)$ | one frame per element |
| [[Merge Sort]] | $2T(N/2)+\Theta(N)$ | $\Theta(N\log N)$ | $\Theta(N+\log N)=\Theta(N)$ | scratch array dominates the stack |
| naive `fibonacci` | $T(N)=T(N-1)+T(N-2)+c$ | $O(2^{N})$ | $\Theta(N)$ | **height**, not node count |

> [!NOTE] **When It Flips:** the two columns decouple whenever the recursion **branches**. With one call per body, time and space share the depth ($\Theta(N)$/$\Theta(N)$, $\Theta(\log N)$/$\Theta(\log N)$); with two or more, time counts **nodes** and space counts **height**, and the gap can be exponential.

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
\begin{aligned}
T(N) &= T(N-1)+c,\qquad T(0)=b \\
&= T(N-k)+kc \;\Rightarrow\; k=N \;\Rightarrow\; T(N)=b+Nc=\Theta(N) \\
\text{depth} &= N \text{ frames live at the miss} \;\Rightarrow\; \text{auxiliary } \Theta(N)
\end{aligned}
$$
**Final Extracted Output:** $\Theta(N)$ time, $\Theta(N)$ auxiliary. The iterative scan keeps $\Theta(N)$ time but drops to $O(1)$ auxiliary — the recursion buys nothing here, which is why the [[Linear Search]] reference implementation is a loop.

## ⚠️ Common Mistakes
- 💡 **"In-place" does not survive recursion silently** ➔ a recursive algorithm that allocates nothing still pays $\Theta(\text{depth})$ for frames; quote it or lose the space mark.
- 💡 **Quoting $\Theta(N\log N)$ space for [[Merge Sort]]** ➔ the scratch arrays at different levels are **not** simultaneously live; sizes $N,\tfrac N2,\tfrac N4,\dots$ sum to $<2N$ by the $r=\tfrac12$ bound in [[Geometric Series]].
- 💡 **Forgetting the base case in Stage 1** ➔ the general form in $k$ is unsolvable without it; a recurrence written as $T(N)=T(N-1)+c$ alone earns no marks.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)* — CPython performs **no tail-call elimination**, so even a tail-recursive `linear_search_recursive` really does hold $N$ frames and raises `RecursionError` near depth $1000$. The $\Theta(\text{depth})$ space cost is a runtime fact here, not just an accounting convention.

## 🧠 Active Recall
> [!FAQ]- `return 2 * f(n//3) + 4` and `return f(n//3) + f(n//3) + 4` sit in otherwise identical functions. Write both recurrences and both complexities.
> - **Hint:** $a$ is a count of invocations; everything else in the return line is $\Theta(1)$.
> > [!SUCCESS]- Answer
> > - **Short answer:** Both share the base $T(n)=a$ for $n<3$. The first is $T(n)=T(n/3)+c \Rightarrow \Theta(\log n)$; the second is $T(n)=2T(n/3)+c \Rightarrow \Theta(n^{\log_3 2})\approx\Theta(n^{0.63})$.
> > - **Why:** **Coefficients don't branch** ➔ multiplying one returned value by $2$ is a single $\Theta(1)$ op inside one frame, so the call tree stays a **chain** of depth $\log_3 n$. Writing the call twice makes level $i$ hold $2^{i}$ frames, and with a $\Theta(1)$ combine the level totals sum geometrically to $\Theta(2^{\log_3 n})=\Theta(n^{\log_3 2})$ — leaf-dominated, polynomial instead of logarithmic.

> [!FAQ]- Naive `fibonacci(n)` makes exponentially many calls yet uses only $\Theta(n)$ auxiliary space. Reconcile the two.
> - **Hint:** Ask what is *live at one instant*, not what happens over the whole run.
> > [!SUCCESS]- Answer
> > - **Short answer:** Time counts every **node** of the call tree ($\Theta(\varphi^{n})$, bounded as $O(2^{n})$); space counts only the tree's **height** ($n$), because at most one root-to-leaf chain of frames exists at a time.
> > - **Why:** **Siblings are sequential** ➔ `fibonacci(n-1)` runs to completion and its entire subtree pops off the stack **before** `fibonacci(n-2)` is pushed, so the two subtrees never coexist in memory even though both are paid for in time.

> [!FAQ]- Two functions both recurse once per call and do $\Theta(1)$ work. Why is one $\Theta(N)$ and the other $\Theta(\log N)$ in **both** time and space?
> - **Hint:** How the argument shrinks fixes the depth, and the depth fixes both columns.
> > [!SUCCESS]- Answer
> > - **Short answer:** Subtracting ($T(N)=T(N-1)+c$) needs $N$ steps to reach the base; halving ($T(N)=T(N/2)+c$) needs $\log_2 N$. With one call per body, that depth *is* both the step count and the frame count.
> > - **Why:** **Single-chain recursion** ➔ the call tree degenerates to a path, so nodes $=$ height; only branching ($a\ge2$) separates the time and space answers.

> [!FAQ]- Why does [[Merge Sort]] end up $\Theta(N)$ auxiliary rather than $\Theta(N\log N)$, given every one of its $\log N$ levels allocates?
> - **Hint:** Two different sums — the total allocated over time, and the peak live at once.
> > [!SUCCESS]- Answer
> > - **Short answer:** Peak live memory is what is quoted. Frames along one path hold scratch of sizes $N,\tfrac N2,\tfrac N4,\dots$, summing to $<2N=\Theta(N)$; the $\Theta(\log N)$ stack is dominated and vanishes.
> > - **Why:** **Shrinking allocations sum, they do not multiply** ➔ by the $r=\tfrac12$ [[Geometric Series]] bound the whole chain costs less than twice the top level, so the $\log N$ levels contribute a constant factor, not a $\log$ factor.
