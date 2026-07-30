---
unit: [FIT1008, FIT2102]
domain: [B, H]
week: [1, 5]
source: [lecture]
parent: "[[Iterator]]"
tags: [CS/Programming, SWE/OOP, CS/Languages]
---
# [[Higher-Order Function]]

**Context:** [[FIT1008_MOC]], [[FIT2102_MOC]] · relies on functions being **first-class** · pairs with [[Generator Expression]] and [[List Comprehension]] · the `f` in a [[Binary Tree|Tree Traversal]] · JavaScript forms and the Array methods in [[JavaScript Functions as Values]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a function that takes and/or returns a function ➔ makes *behaviour* a parameter.
> - **📦 Core Components:** closures, currying/partial, **map/filter/reduce**, decorators.
> - **⚡ Key Constraint:** an ordinary $O(1)$-overhead call; total cost = number of applications (e.g. $O(n)$ over a collection).

## 📝 Core
### 1. The HOF (First-Class Functions)
- **Definition** ➔ takes a function as argument and/or returns a function.
- **Enabled by** ➔ functions being **first-class objects** (assignable, storable, passable, returnable).
- **Payoff** ➔ behaviour becomes a parameter ➔ foundation of `map`/`filter`/`reduce` and the callback `f` in a [[Binary Tree|Tree Traversal]].
- **Why JavaScript qualifies** ➔ functions *are* objects there, so `const hi = function(p) {…}` and passing `hi` onward have been legal since the language's inception — no language feature had to be added ([[Programming Paradigms]]).

### 2. The HOF Toolkit
- **Closure** ➔ inner function capturing enclosing-scope variables (outlives the outer call).
- **Currying/partial** ➔ `f(a,b)`→`f(a)(b)` (`functools.partial`; in JS just `x => y => …`).
- **map/filter/reduce** ➔ transform / select / aggregate ➔ compose into pipelines.
- **Decorator** ➔ a HOF wrapping a function (`@dec` is `f = dec(f)`) ➔ memoisation rescues naive [[Recursion|Fibonacci]].

## ⚙️ Core Implementation
### 🔹 Taking, returning, and the three list HOFs
> [!code]- Python: closures + map/filter/reduce
> ```python
> def my_call(f, x): f(x)                       # takes a function
>
> def return_f(x):                              # returns a CLOSURE capturing x
>     def f(y): return x + y
>     return f
> g = return_f(30); g(2)                        # 32  ('add 30')
>
> list(map(lambda x: x*2, [1,2,3]))             # map:    [2,4,6]
> list(filter(lambda x: x % 2, [1,2,3,4]))      # filter: [1,3]
> from functools import reduce
> reduce(lambda a,b: a+b, [1,2,3,4], 0)         # reduce/fold: 10
> ```
> 💡 **Common Mistake:** **A closure keeps a reference to the captured variable** ➔ even after the enclosing call returns — `g = return_f(30)` behaves as "add 30" forever; this is how HOFs build *configured* functions at run time.

### 🔹 JavaScript: the same three, as Array methods (FIT2102)
> [!code]- arrow functions + forEach/map/filter/reduce
> ```javascript
> function add(x) { return y => y + x; }        // returns a CLOSURE capturing x
> const addNine = add(9); addNine(10);          // 19  ('add nine' forever)
>
> const xs = [1, 2, 3, 4];
> xs.forEach(x => console.log(x));              // effect per element -> undefined
> xs.map(x => x * 2);                           // [2,4,6,8]      new array
> xs.filter(x => x % 2);                        // [1,3]          new array
> xs.reduce((t, x) => t + x, 0);                // 10             single value
> ```
> 💡 **Common Mistake:** **`forEach` returns `undefined`** ➔ it exists for the side effect, so chaining off it throws. Use `map` whenever you want the results — and always pass `reduce` an initial value.

## ⚖️ Core Decision Matrix
| Tool | Form | Replaces / adds |
| :--- | :--- | :--- |
| **map** | `map(f, xs)` · `xs.map(f)` | a transform loop |
| **filter** | `filter(p, xs)` · `xs.filter(p)` | a select loop |
| **reduce/fold** | `reduce(g, xs, init)` · `xs.reduce(g, init)` | an accumulate loop |
| **forEach** | `xs.forEach(f)` (JS) | a loop run purely for effect |
| **closure** | inner fn capturing scope | configured functions |
| **partial/curry** | `partial(f, a)` · `x => y => …` | specialise a general fn |
| **decorator** | `@dec` = `f = dec(f)` | wrap (logging, memoise, timing) |

> [!NOTE] **When It Flips:** abstraction/reuse (one `traverse(tree, f)` covers infinitely many behaviours) + composability ($f\circ g$ pipelines); the trade-off is that nested closures / point-free style can obscure control flow.

## 📊 Exam Execution Trace

### Manual Execution Trace
A lazy select→transform→aggregate pipeline:

| Step / State | Stage | Call | Streams |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | filter | `filter(p, xs)` | keep odds |
| 2 | map | `map(f, ...)` | square each |
| 3 | reduce | `reduce(add, ...)` | sum |

With [[Generator Expression|generators]] the whole pipeline is $O(1)$ memory (no intermediate lists). JS Array methods are **eager** by contrast — each stage materialises a new array.

### Applied Exercise
**Problem:** Show a decorator is a HOF.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\texttt{@dec}\ \texttt{def f(): ...} \;\equiv\; \texttt{f = dec(f)} \;:\; \text{dec takes } f, \text{ returns a wrapped } f
\end{aligned}
$$
**Final Extracted Output:** `@lru_cache` memoisation turns naive Fibonacci from $\Theta(\varphi^n)$ to $\Theta(n)$ — a HOF wrapper.

## 🧠 Active Recall
> [!FAQ]- What is a closure, and how does it let `return_f(x)` produce a function that "remembers" `x`?
> - **Hint:** Captured environment outlives the call.
> > [!SUCCESS]- Answer
> > - **Short answer:** A closure = inner function + captured enclosing-scope variables; `f` keeps `x = 30` after `return_f` finishes.
> > - **Why:** **Configured functions** ➔ the captured environment is the basis of currying, decorators, and callbacks.

> [!FAQ]- Map, filter, and reduce replace which constructs, and how do they compose with generators?
> - **Hint:** Transform/select/aggregate loops.
> > [!SUCCESS]- Answer
> > - **Short answer:** map = transform, filter = select, reduce/fold = accumulate; `reduce(add, map(f, filter(p, xs)))` is select→transform→aggregate.
> > - **Why:** **Lazy fusion** ➔ generator versions stream one element through all stages in $O(1)$ memory, no intermediate lists. JS Array methods do the same job **eagerly**, allocating an array per stage.

> [!FAQ]- How is a decorator a HOF, and give a use connecting to earlier material.
> - **Hint:** Wrap-and-return.
> > [!SUCCESS]- Answer
> > - **Short answer:** It takes a function and returns a wrapped one; `@dec def f` = `f = dec(f)`.
> > - **Why:** **Memoisation** ➔ `@lru_cache` caches results ⟹ naive [[Recursion|Fibonacci]] $\Theta(\varphi^n)\to\Theta(n)$.
