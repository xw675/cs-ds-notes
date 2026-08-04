---
unit: FIT2102
week: 1
source: [applied]
domain: H
parent: "[[JavaScript Functions as Values]]"
tags: [CS/Languages, Tool/JavaScript, CS/DataStructures]
aliases: [Cons List, Church Encoding, Selector Function, Closures as Data, Functional Linked List]
---
# [[Cons List (Closures as Data)]]

**Context:** [[FIT2102_MOC]] · the W1 tutorial's punchline — a data structure made of **nothing but functions**, proving [[Higher-Order Function|HOFs]] are independent of any built-in container · closures come from [[JavaScript Functions as Values]]; the same chain shape, done with objects, is [[List (ADT)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** hide a pair inside a **closure** and read it back by handing the closure a **selector** ➔ a linked list with no `class`, no object literal, no mutation.
> - **📦 Core Components:** `cons` ➔ closure capturing `(head, rest)` | `head`/`rest` ➔ selectors asking the closure a question | recursive `map`/`filter`/`reduce` ➔ the Array HOFs re-derived for a type the language has never seen.
> - **⚡ Key Constraint:** **the list IS a function** — `cons(1, null)` returns a callable, so `console.log(list)` prints source text, and the terminator is `null`, which is **not** callable ⟹ `head(null)` must throw before it applies anything.

## 📝 How It Works

### 1. The Pair, Encoded as a Closure
- **Core Mechanism:** **Store, don't expose** ➔ `pair(a, b)` returns `sel => sel(a, b)`. The two values live only in the captured scope; there is no field, no `.head`, no way in except by supplying a function.
- **The caller chooses the projection** ➔ `fst` and `snd` differ *only* in which argument their selector returns. The structure has no accessors — the accessor is passed in.
- **Type signature** ➔ $\text{pair} : a \to b \to ((a \to b \to c) \to c)$. Read it as: *give me two values, I give you back something that answers questions of the form* $a \to b \to c$.
- **Why this is a paradigm point** ➔ objects and functions are **interchangeable encodings of state**; JavaScript already had everything needed for data abstraction before it had classes ➔ [[Programming Paradigms]].

### 2. Cons — the Pair, Right-Nested
- **Core Mechanism:** **A node is a pair of `head` and `rest`** ➔ `head` is the stored value, `rest` is the *rest of the list* (itself a cons, or `null`).
- **Shape** ➔ `cons(1, cons(2, cons(3, null)))` nests to the **right**; the whole list is one outermost closure, and each `rest` call peels exactly one layer.
- **Selectors** ➔ `head(l)` applies `l` to a selector that returns its first argument; `rest(l)` applies `l` to one that returns its second. Two functions, one line each, and the type is complete.
- **Type signature** ➔ $\text{cons} : a \to L_a \to ((a \to L_a \to b) \to b)$ where $L_a$ is a cons list of $a$ or `null`.

### 3. HOFs Re-derived over Cons
- **The universal skeleton** ➔ base case on `null` ➔ act on `head(list)` ➔ recurse on `rest(list)` ➔ **recombine with `cons`** (or fold into an accumulator). Every cons HOF is that shape with one slot changed.
- **What changes per HOF** ➔ `map` transforms the head then re-conses · `filter` decides whether to re-cons the head or drop it · `reduce` never re-conses, it threads an accumulator.
- **Tail-position split** ➔ `map` and `filter` are **non-tail** (the `cons` runs *after* the call returns); `reduce` is **tail** (the accumulator goes forward) ➔ [[Recursion]].
- **The point** ➔ `map`/`filter`/`reduce` are not "array methods" — they are **shapes of recursion** that any inductively defined type admits.

### 4. Purity and Referential Transparency
- **Nothing is ever mutated** ➔ `map` and `filter` build a **new chain**; the original list is untouched and still valid afterwards.
- **Structural sharing** ➔ `rest(l)` is not a copy — it is the *same closure* the original already held, so tails are shared for free. Immutability makes sharing safe.
- **Referential transparency** ➔ `head(l)` returns the same value on every call for the same `l`, so any occurrence can be replaced by its value without changing the program's meaning.

## ⚙️ Core Implementation

### 🔹 Selector encoding (pair first, list second)
> [!code]- `pair` / `fst` / `snd`, then the same trick as a list node
> ```javascript
> // pair : a -> b -> ((a -> b -> c) -> c)
> const pair = (a, b) => sel => sel(a, b);
> const fst  = p => p((a, _) => a);        // selector keeps the FIRST argument
> const snd  = p => p((_, b) => b);        // selector keeps the SECOND
>
> const p = pair(7, 8);
> fst(p);   // 7   -- the 7 was never stored anywhere but the closure
> snd(p);   // 8
> p;        // function -- printing the "data" prints source code
> ```
> 💡 **Common Mistake:** **`fst(p)` is not `p(0)` or `p.a`** ➔ there is no index and no field. The only way to observe the contents is to pass in a function that *does something with both* and returns what you want.

### 🔹 The given traversal template
> [!code]- `forEach` — the bundle hands you this one; every other cons HOF copies its skeleton
> ```javascript
> function forEach(f, list) {
>     if (list) {              // base case: null terminator is falsy -> stop
>         f(head(list));       // act on this node's value
>         forEach(f, rest(list));   // recurse on the remaining chain
>     }
> }
> ```
> 💡 **Common Mistake:** **`if (list)` is a truthiness guard, not a null check** ➔ it stops on `null` as intended, but it would also stop on `0`, `''`, or `false` if a *list itself* could be one of those. Safe here only because a non-empty list is always a function, and every function is truthy.

## ⚖️ Core Decision Matrix
| Encoding | How a node stores data | Cost of `head` / `rest` | What it buys | What it costs |
| :--- | :--- | :--- | :--- | :--- |
| **JS `Array`** | contiguous indexed slots | $O(1)$ random access | built-in `map`/`filter`/`reduce`, printable | `map` copies the whole array each stage; no tail sharing |
| **Object linked list** (`{head, rest}`) | named fields on a record | $O(1)$ field read | readable, debuggable, `JSON.stringify`-able | fields are **mutable** by default ⟹ purity is a convention, not a guarantee |
| **Closure cons** (this note) | captured scope + selector | $O(1)$ call, one closure invocation | **inaccessible except through the interface** ⟹ immutability is enforced by the encoding; free tail sharing | opaque to the debugger; $O(n)$ traversal for anything positional; recursion depth is the list length |

> [!NOTE] **When It Flips:** the closure encoding wins whenever the *lesson* is that data and behaviour are the same substance — which is why it appears in W1 and again in lambda calculus, where there are no records at all, only functions. For production JS you would use an `Array`; the closure form's payoff is conceptual, plus genuinely free structural sharing.

## 📊 Exam Execution Trace

### Manual Execution Trace
Evaluating `head(rest(cons(1, cons(2, null))))`, where `cons(h, r) = sel => sel(h, r)`:

| Step | Expression being reduced | Closure applied | Captured `(h, r)` | Result |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `cons(2, null)` | — | $(2, \text{null})$ | closure $C_2$ |
| 1 | `cons(1, C₂)` | — | $(1, C_2)$ | closure $C_1$ |
| 2 | `rest(C₁)` | $C_1$ applied to `(_, r) => r` | $(1, C_2)$ | $C_2$ |
| 3 | `head(C₂)` | $C_2$ applied to `(h, _) => h` | $(2, \text{null})$ | `2` |

**Reading:** each selector application discards one of the two captured values. No data structure was traversed — a **function call** was the traversal.

## ✍️ Practice
> [!QUESTION]- Practice 1: Write `length(list)` for a cons list, using only `head`, `rest`, and recursion. State whether it is tail-recursive as written, and give the tail version.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > // non-tail: the "+ 1" runs after the recursive call returns
> > const length = list => (list ? 1 + length(rest(list)) : 0);
> >
> > // tail: the count is carried forward in an accumulator
> > const lengthAcc = (list, n = 0) => (list ? lengthAcc(rest(list), n + 1) : n);
> > ```
> > - **Key move:** the base case is the **terminator**, `null`, not "one element left" — writing `if (!rest(list)) return 1` gets the right answer and then throws on the empty list. Prefer the accumulator form: it is the shape `reduce` generalises.

> [!QUESTION]- Practice 2: Write `append(list, value)`, returning a NEW cons list with `value` added at the **end**. Why is this $O(n)$ while adding at the front is $O(1)$, and which part of the original list gets shared?
> > [!SUCCESS]- Reference solution
> > ```javascript
> > const append = (list, value) =>
> >     list ? cons(head(list), append(rest(list), value))
> >          : cons(value, null);
> >
> > const prepend = (list, value) => cons(value, list);   // O(1)
> > ```
> > - **Key move:** the list points **forward only**, so reaching the end means rebuilding every node on the way — $O(n)$ new closures. `prepend` shares the *entire* original list as its `rest` and allocates one node. `append` shares **nothing**; the original is still intact, which is the trade immutability makes.

> [!QUESTION]- Practice 3: Write `any(p, list)` — `true` if any element satisfies predicate `p`. Make it stop at the first match, and say why `reduce` is the wrong tool here.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > const any = (p, list) =>
> >     list ? p(head(list)) || any(p, rest(list))
> >          : false;
> > ```
> > - **Key move:** `||` **short-circuits**, so a match at the head never evaluates the recursive call — the traversal stops there. A `reduce`-based version threads the accumulator through *every* node by construction, so it cannot exit early. Same answer, different work.

## ⚠️ Common Mistakes
- 💡 **Forgetting to re-`cons` in `map`** ➔ recursing and returning the mapped head alone (or pushing into an array) produces a value of the wrong type. `map` over a cons list must return a **cons list**: apply `f` to the head, then `cons` it onto the mapped rest.
- 💡 **The `filter` reject branch must return the recursion, not `null`** ➔ dropping a value means *skipping* it and continuing with the filtered rest; returning `null` truncates the list at the first rejected element and silently passes any test whose data happens to reject nothing early.
- 💡 **`reduce`'s parameter order is `(acc, value)`** ➔ swapping them still runs and still returns a number for `+`, so a sum test passes while a non-commutative reducer (subtraction, string concat, list building) is quietly wrong. The tutorial's own reduce test uses `(acc, x) => x - acc` precisely because it detects this.
- 💡 **`head(null)` / `rest(null)`** ➔ `null` is not a function, so applying it throws a bare `TypeError` from deep inside the call chain. Guard at the top of the selector with an explicit throw so the error names the actual problem.
- 💡 **No tail-call optimisation in V8** ➔ a cons list long enough to matter overflows the stack in Chrome even for the tail-recursive `reduce`. The encoding is $O(n)$ **stack frames**, not $O(1)$ ➔ [[Recursion]]. *(Not from the slides — but the unit tells you to run in Chrome.)*

## 🧠 Active Recall
> [!FAQ]- Where is the data actually stored in `cons(1, cons(2, null))`, and how does `head` retrieve something that has no field name?
> - **Hint:** Ask what a closure captures, and who supplies the accessor.
> > [!SUCCESS]- Answer
> > - **Short answer:** In the **closure** — `1` and the inner list are captured variables of the anonymous function `cons` returned; `head` retrieves one by **applying that function to a selector** that returns its first argument.
> > - **Why:** **Access is inversion of control** ➔ the structure does not expose values, it *applies a function you supply* to them. The type is $((a \to L_a \to b) \to b)$: the only thing you can do with a cons is hand it a two-argument function and take what it gives back.

> [!FAQ]- The unit already gave you `map`, `filter`, and `reduce` on arrays. Why re-implement them for cons lists?
> - **Hint:** Separate the *shape of the computation* from the container it runs on.
> > [!SUCCESS]- Answer
> > - **Short answer:** To show they are **recursion schemes, not Array features** — transform, select, and accumulate are definable on any inductively built type, including one you invented five minutes ago out of closures.
> > - **Why:** **Abstraction over structure** ➔ this is the seed of the Haskell half of the unit, where `Functor`/`Foldable` name exactly "a type that admits `map`" and "a type that admits `reduce`" ➔ [[Programming Paradigms]]. An interview answer that says "so we can use `map` on our own type" is half-marks; the full answer names the pattern.

> [!FAQ]- `map` over a cons list allocates a whole new chain and never mutates. What does that buy, and what does it cost?
> - **Hint:** Think about who else is holding a reference to the old list.
> > [!SUCCESS]- Answer
> > - **Short answer:** It buys **referential transparency** — every holder of the old list still sees the old list, so no caller can be surprised by an action at a distance; it costs **allocation**, one closure per element per stage.
> > - **Why:** **Sharing offsets the cost** ➔ operations that only extend the front (`prepend`, `cons`) share the entire existing tail, so the copy is $O(1)$; only operations that rebuild the spine (`map`, `filter`, `append`) pay $O(n)$. Mutable structures invert this: cheap in place, expensive in reasoning.
