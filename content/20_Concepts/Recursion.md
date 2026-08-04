---
unit: [FIT1008, FIT2102]
domain: [A, H]
week: [1, 6]
source: [lecture, applied]
parent: "[[Algorithm]]"
tags: [CS/Algorithms, SWE/OOP, CS/Complexity, CS/DataStructures, Tool/JavaScript]
---
# [[Recursion]]

**Context:** [[FIT1008_MOC]], [[FIT2102_MOC]] · defining an [[Algorithm]] in terms of itself · backbone clustering **Notation**, **Accumulator**, **Auxiliary Function**, **vs-Iteration**, **→Iteration-via-Stack**, and — from FIT2102 — **recursion as the declarative replacement for the loop**

> [!abstract] Quick Revision
> - **🎯 Objective:** reduce to smaller subproblems of the same kind until a base case ➔ cost via recurrence, correctness via induction.
> - **📦 Core Components:** base + call + **convergence** + combine | **classified** by count/route/tail | reshaped by **accumulator**/**auxiliary function**.
> - **⚡ Key Constraint:** $\Theta(\text{depth})$ **stack frames** (no TCO in Python, none in Chrome's V8) ➔ overflow; removed by an **accumulator** (forward) or explicit **[[Stack (ADT)]]** (backward).

## 📝 Core
### 1. Recursion (Four Components)
- **Core mechanism** ➔ a function **calls itself** on strictly smaller inputs.
- **Four parts** ➔ **base case(s)** + **recursive call(s)** + **convergence** + **combination**.
- **Cost / correctness** ➔ cost = **recurrence** (unroll/recursion tree); correctness = **structural induction**; no base ⟹ `RecursionError`.

### 2. Notation (Classifying)
- **Count** ➔ unary / binary / $n$-ary (the branching factor of the call tree).
- **Route** ➔ direct vs indirect/mutual.
- **Tail** ➔ recursive call's result *is* the result (nothing on the way back) ➔ binary ⟹ $2^n$ unless subproblems shrink fast or memoised.

### 3. Accumulator (Forward-Carry → Tail)
- **Mechanism** ➔ extra parameter **carries the partial result forward**, combining on the way *in*.
- **Effect** ➔ makes the recursion **tail-recursive**, kills recomputation (Fibonacci $\Theta(\varphi^n)\to\Theta(n)$).
- **Boundary** ➔ only when result builds **forward**; **memoisation/DP** is the general alternative ($\Theta(n)$ space).

### 4. Auxiliary Function (Driver + Worker)
- **Pattern** ➔ private worker carries a **converging argument** the public type can't shrink (a [[List (ADT)|LinkList]] can't recurse on `self`).
- **Parameter jobs** ➔ **converge** (`current.link`) | **accumulate** | **carry context** (`item`, `lo/hi`).
- **`or` short-circuit** ➔ a free second base case; plumbing hidden behind a clean public signature.

### 5. Recursion vs Iteration
- **Equivalence** ➔ loops vs self-calls are **Turing-equivalent**; difference = *where state lives*.
- **Practical cap** ➔ TCO-less languages ⟹ iteration *needed* for large $n$.
- **Conversion seed** ➔ the base case is the **negation of the loop's continuation guard**.

### 6. →Iteration via Explicit Stack
- **Mechanism** ➔ simulate the run-time stack with an explicit [[Stack (ADT)]] — push pending work, pop in a loop.
- **When** ➔ general conversion when an accumulator can't (work builds on the way *back*).
- **Payoff** ➔ same $\Theta(\text{depth})$ space but on the **heap** ➔ no fixed call-stack limit.

### 7. Recursion as the Loop Replacement (FIT2102)
- **Direction of use is reversed** ➔ FIT1008 converts recursion *to* iteration for safety; FIT2102 converts iteration *to* recursion because a loop needs a **mutable index and a mutable accumulator**, and mutation is what the [[Programming Paradigms|declarative]] style removes.
- **What the accumulator replaces** ➔ the `let` that the loop body updated. Carrying it as a parameter means every binding in sight can be `const`, and the function becomes **pure** — same arguments, same result, no state outside its own frame.
- **Prepend vs append is the whole trick** ➔ an accumulator built by *prepending* (`digit + acc`) emerges in the original left-to-right order even though the recursion peels the *last* piece first; appending silently reverses it. This is where the marks go on any digit/character-building recursion.
- **Recursion vs the Array HOFs** ➔ `map`/`filter`/`reduce` cover the traversals that visit each element once ➔ [[JavaScript Functions as Values]]. Reach for explicit recursion when the shrinking argument is **not** a collection (a number, a string being consumed, a [[Cons List (Closures as Data)|cons list]]) or when you must stop early.
- **Failure mode is unchanged** ➔ JavaScript specifies proper tail calls but **V8 does not implement them**, so the tail form is $\Theta(1)$ *conceptually* and $\Theta(n)$ frames *in Chrome*. The purity argument survives; the stack-safety argument does not.

## ⚙️ Core Implementation
### 🔹 Basic vs Accumulator (factorial / Fibonacci)
> [!code]- non-tail vs tail-recursive forms
> ```python
> def factorial(n):                  # NON-tail: '* n' happens AFTER the call
>     return 1 if n == 0 else n * factorial(n - 1)
>
> def factorial_acc(n, result=1):    # TAIL: accumulate the product going IN
>     return result if n == 0 else factorial_acc(n - 1, result * n)
>
> def fib(n):                        # carry the last two values -> O(n), not Θ(φ^n)
>     return fib_aux(n, 0, 1)
> def fib_aux(n, fm2, fm1):
>     return fm2 if n == 0 else fib_aux(n - 1, fm1, fm2 + fm1)
> ```
> 💡 **Common Mistake:** **Accumulator kills recomputation regardless of TCO** ➔ the time win ($\Theta(\varphi^n)\to\Theta(n)$) is independent of the space win; the tail form maps mechanically onto a `while` loop.

### 🔹 JavaScript: killing a loop with an accumulator (FIT2102)
> [!code]- the same job, imperative then declarative — note where the mutation went
> ```javascript
> // IMPERATIVE: two mutable variables (i and out) and an index to get wrong
> function reverseLoop(s) {
>     let out = "";
>     for (let i = 0; i < s.length; i++) { out = s[i] + out; }
>     return out;
> }
>
> // DECLARATIVE: driver + tail-recursive worker, every binding const, no index
> const reverseAcc = (s, acc) => (s === "" ? acc : reverseAcc(s.slice(1), s[0] + acc));
> const reverse    = s => reverseAcc(s, "");
>
> reverse("paradigm");   // "mgidarap"
> ```
> 💡 **Common Mistake:** **Prepend, don't append** ➔ `acc + s[0]` type-checks, runs, and returns the string *unreversed* — a same-shaped bug hits every accumulator that builds digits or characters. Decide the order by hand-tracing **two** elements before writing the line, and always seed the driver with the identity value (`""` for strings, `0` for sums) rather than the first element.

### 🔹 Auxiliary Function over a LinkList
> [!code]- `len_aux` / `contains_aux` (driver + worker)
> ```python
> def __len__(self) -> int:                  # driver: seed the pointer
>     return self.len_aux(self.head)
> def len_aux(self, current) -> int:         # worker: recurse on Node
>     return 0 if current is None else 1 + self.len_aux(current.link)
>
> def __contains__(self, item) -> bool:
>     return self.contains_aux(self.head, item)
> def contains_aux(self, current, item) -> bool:
>     if current is None: return False                                   # base 1: not found
>     return current.item == item or self.contains_aux(current.link, item)  # 'or' short-circuits
> ```
> 💡 **Common Mistake:** **Recurse on the `Node`, not `self`** ➔ a list-minus-head isn't a new `LinkList`; `len_aux` is still $\Theta(n)$ stack frames ⟹ a long list overflows where a loop wouldn't.

### 🔹 Explicit-Stack de-recursification (`power`)
> [!code]- recursive `power` → `power_iter`
> ```python
> def power(x, n):                       # recursive: multiplies AFTER the call (non-tail)
>     tmp = 1
>     if n > 0:
>         tmp = power(x, n // 2)
>         tmp = tmp * tmp if n % 2 == 0 else tmp * tmp * x
>     return tmp
>
> def power_iter(x, n):                  # explicit stack: push converging args, pop & combine
>     st = []
>     while n > 0:
>         st.append(n); n //= 2          # phase 1: push (mimics the descent)
>     tmp = 1
>     while st:                          # phase 2: pop (mimics the return path)
>         tmp = tmp * tmp if st.pop() % 2 == 0 else tmp * tmp * x
>     return tmp
> ```
> 💡 **Common Mistake:** **LIFO order is the trick** ➔ print-reverse pushes all items then pops; the explicit stack on the heap dodges Python's ~1000-frame `RecursionError`.

## ⚖️ Core Decision Matrix
| Recursion shape | Convert via | Recurrence → cost | Example |
| :--- | :--- | :--- | :--- |
| **Tail / forward** | accumulator → plain loop (no stack) | $T(n)=T(n-1)+\Theta(1)=\Theta(n)$ | factorial, `fib_aux` |
| **Non-tail, single call** | one explicit stack of arguments | $T(n)=T(n/2)+\Theta(1)=\Theta(\log n)$ | `power`, binary search |
| **Multiple calls (balanced)** | explicit stack of work items | $T(n)=2T(n/2)+\Theta(n)=\Theta(n\log n)$ | [[Merge Sort]] |
| **Multiple calls (overlapping)** | accumulator **or** memoisation/DP | $T(n)=T(n-1)+T(n-2)+\Theta(1)=\Theta(\varphi^n)$ | naive Fibonacci |

> [!NOTE] **When It Flips:** same time Big-O, but recursion uses $\Theta(\text{depth})$ space vs iteration's $\Theta(1)$ — TCO would erase it (Python/Java lack it). The equivalence is to *general* iteration; the primitive-recursive / bounded-`for` fragment can't express **Ackermann**.

## 📊 Exam Execution Trace

### Manual Execution Trace
`power_iter(2, 5)` (so $2^5 = 32$):

| Step / State | Trigger Op | `st` | `n` | `tmp` Payload |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | push | `[5]` | `2` | $-$ |
| 1 | push | `[5,2]` | `1` | $-$ |
| 2 | push | `[5,2,1]` | `0` | `1` |
| 3 | pop 1 (odd) | `[5,2]` | $-$ | $1^2\cdot2 = 2$ |
| 4 | pop 2 (even) | `[5]` | $-$ | $2^2 = 4$ |
| 5 | pop 5 (odd) | `[]` | $-$ | $4^2\cdot2 = 32$ |

### Applied Exercise
**Problem:** Unroll the factorial recurrence to its closed-form cost.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
T(n) &= T(n-1) + \Theta(1) = T(n-2) + 2\Theta(1) = \dots \\
&= T(0) + n\,\Theta(1) = \Theta(n)
\end{aligned}
$$
**Final Extracted Output:** unary recursion ⟹ a path of $n$ frames ⟹ $\Theta(n)$ time and $\Theta(n)$ stack space.

## 🧠 Active Recall
> [!FAQ]- How do you prove a recursive algorithm correct, and how does it differ from proving a loop correct?
> - **Hint:** Map recursion to induction, loops to invariants.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Structural induction** — base proved directly; step assumes calls correct on smaller inputs; convergence proves termination.
> > - **Why:** **Same induction** ➔ a loop uses a [[Invariant|loop invariant]] (init/maintenance/termination) + variant — iterative and recursive forms of the same argument.

> [!FAQ]- Why can a *correct* recursive function still crash in Python, and what are the fixes?
> - **Hint:** No TCO + a depth cap.
> > [!SUCCESS]- Answer
> > - **Short answer:** Python caps depth (~1000) and does **no tail-call optimisation** ➔ deep recursion overflows.
> > - **Why:** **De-recursify** ➔ convert to iteration, an explicit heap stack (no cap), or an accumulator + loop; raising the limit only delays it.

> [!FAQ]- Naive Fibonacci is exponential — compare the accumulator fix and the memoisation fix.
> - **Hint:** Forward-accumulation vs general caching.
> > [!SUCCESS]- Answer
> > - **Short answer:** Both reach $\Theta(n)$; accumulator is $\Theta(1)$ extra state, memoisation $\Theta(n)$ table.
> > - **Why:** **Generality** ➔ accumulation works only for forward-building results; memoisation handles *any* overlapping-subproblem structure.

> [!FAQ]- For factorial-as-tail, `power`, and Tower of Hanoi — does converting to iteration need nothing, an accumulator, or an explicit stack?
> - **Hint:** Match recursion shape to conversion device.
> > [!SUCCESS]- Answer
> > - **Short answer:** Tail factorial ➔ plain loop; `power` ➔ explicit stack of args; **[[Tower of Hanoi]]** ➔ explicit stack of *work items*.
> > - **Why:** **Pending state** ➔ Hanoi's two recursive calls must remember which sub-move to resume, exactly like call frames.

> [!FAQ]- FIT1008 converts recursion into loops; FIT2102 converts loops into recursion. Are the two units contradicting each other?
> - **Hint:** Ask what each conversion is optimising for.
> > [!SUCCESS]- Answer
> > - **Short answer:** No — different objectives. FIT1008 removes recursion to buy **stack safety** on large $n$; FIT2102 removes the loop to buy **purity and referential transparency**, because a loop cannot exist without a mutable index and accumulator.
> > - **Why:** **Same equivalence, opposite direction** ➔ both rest on loops and self-calls being Turing-equivalent, differing only in *where state lives* — in a `let` you mutate, or in a parameter you rebind per frame. Neither cost disappears: the accumulator form is still $\Theta(n)$ frames in Chrome, since **V8 implements no tail-call optimisation** despite the specification requiring it.

> [!FAQ]- Why does recursing over a `LinkList` need an auxiliary function, and what three jobs can its parameter do?
> - **Hint:** The public type can't shrink itself.
> > [!SUCCESS]- Answer
> > - **Short answer:** A driver seeds a worker recursing on the next **`Node`** (a valid smaller argument).
> > - **Why:** **Parameter roles** ➔ **converge** (`current.link`), **accumulate** a forward result, or **carry context** (`item`, `lo/hi`) — behind a clean public method.
