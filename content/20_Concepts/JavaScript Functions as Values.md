---
unit: FIT2102
week: 1
source: [lecture, applied]
domain: H
parent: "[[Higher-Order Function]]"
tags: [CS/Languages, Tool/JavaScript]
type: pattern
aliases: [Arrow Function, Anonymous Function, JavaScript Closure, Array Methods, forEach, map filter reduce JavaScript, First-Class Functions, range JavaScript]
---
# [[JavaScript Functions as Values]]

**Context:** [[FIT2102_MOC]] · the payoff of [[Programming Paradigms]]' "avoid hand-coded loops" — how JS composes behaviour instead of writing indices · the language-neutral concept is [[Higher-Order Function]]; syntax basics in [[JavaScript Basics (Syntax, Types, Control Flow)]]
**Problem it solves:** pass behaviour around as a value, so traversal is written once (by the language) and only the per-element work is yours.

> [!abstract] Quick Revision
> - **🎯 Trigger:** about to write `for (let i = 0; …)` over an array ➔ reach for `forEach`/`map`/`filter`/`reduce` with an arrow function instead.
> - **⚡ Key Constraint:** a **closure captures a reference to the enclosing variable**, not a snapshot of its value — that capture is what makes `add(9)` a permanently-configured "add nine".

## 🔧 Minimal Working Example
```javascript
const tutors = ['tim', 'michael', 'yan', 'Yang', 'arthur', 'kelvin'];

tutors.forEach(person => console.log('hello ' + person));   // effect per element, returns undefined
tutors.map(person => 'hello ' + person);                    // ['hello tim', 'hello michael', ...]
tutors.filter(person => person[0] == 'y');                  // ['yan']  -- 'Yang' has a capital Y
tutors.map(p => p.length).reduce((t, s) => t + s, 0);       // 29
```
**Expected output:** six `hello …` lines logged; a 6-element mapped array; a **1**-element filter result; `29` ($3+7+3+4+6+6$).
*(The deck prints `['yan','yang']` for that filter while writing `'Yang'` in the array — the slide is internally inconsistent. String comparison is **case-sensitive**, so as written the answer is `['yan']`.)*

- **Three ways to have a function** ➔ **named** `function hi(person) { … }` · **anonymous assigned to a variable** `const hi = function(person) { … }` · **anonymous passed inline** `['tim','sally'].forEach(hi)`.
- **Arrow syntax** ➔ `function(x) { return <expr> }` is **(almost) equivalent to** `x => <expr>`; multi-parameter `function(a, b) { return <expr> }` becomes `(a, b) => <expr>`. The `return` and braces vanish because the body *is* the expression.
- **Higher-order function** ➔ one that **takes a function as an argument** and/or **returns a function**.
- **Closure** ➔ a function **plus the set of variables it accesses from its enclosing scope**.
- **The four Array HOFs** ➔ `forEach` (effect per element) · `map` (transform) · `filter` (select) · `reduce` (accumulate, with an initial value).

## 🧬 Evaluation Model
Type signatures make the difference between the four methods unambiguous, for arrays of $a$:

| Method | Signature | Returns |
| :-- | :-- | :-- |
| `forEach` | $(a \to \text{void}) \to \text{void}$ | nothing — it exists **for the effect** |
| `map` | $(a \to b) \to [b]$ | a **new** array, same length |
| `filter` | $(a \to \text{bool}) \to [a]$ | a **new** array, length $\le$ original |
| `reduce` | $((b, a) \to b) \to b \to b$ | a **single** value |

**Desugaring the arrow, and taking the function as a parameter:**
```javascript
function sumTo(n, f) { return n ? f(n) + sumTo(n - 1, f) : 0; }

sumTo(10, function square(x) { return x * x; });   // 385  -- named
sumTo(10, function (x) { return x * x; });         // 385  -- anonymous, verbose
sumTo(10, x => x * x);                             // 385  -- arrow: same value, same semantics
```
- **Reduction of the closure case** ➔ `add(9)` returns the *expression* `y => y + x` with `x` captured:
```javascript
function add(x) { return y => y + x; }   // add : number -> (number -> number)
const addNine = add(9);                  // the returned closure remembers x = 9
addNine(10);  // 19
addNine(1);   // 10   -- x is still 9; the capture outlived add()'s call
```

## 🔀 Variations
- **Effect vs value** ➔ `forEach` for side effects (logging), `map` when you want the results. Using `map` purely for its side effect builds and discards an array.
- **Chaining beats nesting** ➔ `tutors.map(p => p.length).reduce((t, s) => t + s, 0)` reads left-to-right as *transform then accumulate*; the equivalent loop needs an index and an accumulator you must initialise correctly.
- **`reduce` subsumes the other two** ➔ `map` and `filter` are both expressible as a `reduce` that appends conditionally — useful to know, rarely worth writing.
- **Generating the source array** ➔ the pipeline needs something to start from, and JS has no `range`. Two loop-free idioms, both producing $[0, n)$:
```javascript
const range = n => Array.from({ length: n }, (_, i) => i);   // preferred: builds AND fills
const range2 = n => [...Array(n).keys()];                    // spread the index iterator
range(5);    // [0, 1, 2, 3, 4]
range(0);    // []          -- the empty case falls out for free
```
- **The `filter → reduce` aggregation shape** ➔ *generate a domain, keep what qualifies, collapse to one number* is the single most reusable pipeline in the unit: `range(n).filter(pred).reduce((t, x) => t + x, 0)`. Naming each stage in an interview ("domain, predicate, fold") is worth more than the answer.

## ⚖️ Core Decision Matrix
Read the loop body and ask what each line is *doing*; the answer names the method.

| The loop body does… | ➔ becomes | Initial value |
| :-- | :-- | :-- |
| `out.push(f(a[i]))` | `.map(f)` | — |
| `if (p(a[i])) out.push(a[i])` | `.filter(p)` | — |
| `acc = g(acc, a[i])` | `.reduce(g, init)` | whatever `acc` was set to **before** the loop |
| `count++` under a condition | `.filter(p).length` **or** `.reduce((c, x) => p(x) ? c + 1 : c, 0)` | `0` |
| track a running best | `.reduce((best, x) => x > best ? x : best, a[0])` | the **first element**, never `0` |
| transform **then** select | `.map(f).filter(p)` — order matters | — |

> [!NOTE] **When It Flips:** a loop that both transforms and tests (`tripled = a[i] * 3; if (tripled % 2)`) tests the **transformed** value ➔ `.map(x => x * 3).filter(x => x % 2 !== 0)`, in that order. Filter-then-map is cheaper (fewer elements transformed) and is the default — but only when the predicate reads the *original* value. Reading the loop backwards is how you tell.

## ✍️ Practice
> [!QUESTION]- Practice 1: Given `const tutors = ['tim','michael','yan','Yang','arthur','kelvin']`, return the total number of characters across all names whose name starts with a lowercase `y`. Then explain why `'Yang'` is or is not included.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > tutors.filter(p => p[0] === 'y')       // ['yan']  -- 'Yang' starts with 'Y'
> >       .map(p => p.length)              // [3]
> >       .reduce((t, s) => t + s, 0);     // 3
> > ```
> > - **Key move:** filter → map → reduce, cheap filter first. `'Yang'` is excluded: string comparison is **case-sensitive**, so `p[0] === 'y'` is `false` for `'Y'`. Check the data's actual casing before trusting a predicate — a case-insensitive test needs `p[0].toLowerCase() === 'y'`.

> [!QUESTION]- Practice 2: Write `multiplyBy` such that `const triple = multiplyBy(3); triple(7)` gives `21`. State its type signature and name the mechanism that makes `triple` remember `3`.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > const multiplyBy = x => y => x * y;    // multiplyBy : number -> (number -> number)
> > const triple = multiplyBy(3);
> > triple(7);   // 21
> > ```
> > - **Key move:** a **closure** — the returned function captures `x` from the enclosing scope and keeps a reference to it after `multiplyBy` has returned. This is the mechanism behind configured functions, callbacks, and currying.

> [!QUESTION]- Practice 3: Rewrite this loop with no index and no mutable variable.
> ```javascript
> let out = [];
> for (let i = 0; i < xs.length; i++) { if (xs[i] % 2 === 0) out.push(xs[i] * xs[i]); }
> ```
> > [!SUCCESS]- Reference solution
> > ```javascript
> > const out = xs.filter(x => x % 2 === 0).map(x => x * x);
> > ```
> > - **Key move:** the loop conflated three jobs — traverse, select, transform. Splitting them removes the index (and its off-by-one risk), removes `let`, and makes the intent readable in one line.

> [!QUESTION]- Practice 4: With no loop and no `Math.max`, return the sum of every number below $100$ that is a multiple of $4$ or $7$. Then state the three pipeline stages by name.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > const range = n => Array.from({ length: n }, (_, i) => i);
> > range(100)
> >     .filter(x => x % 4 === 0 || x % 7 === 0)
> >     .reduce((t, x) => t + x, 0);   // 1767
> > ```
> > - **Key move:** **domain → predicate → fold.** `range(100)` is $[0, 100)$, so "below 100" needs no adjustment — an inclusive bound would need `range(101)`. The `||` matters: `&&` counts only multiples of $28$, and chaining two `.filter` calls is that same mistake written differently. Multiples of both are visited **once**, so the single pass gives inclusion–exclusion for free: $1200 + 735 - 168 = 1767$.

## ⚠️ Common Mistakes
- 💡 **`new Array(n).map(…)` silently does nothing** ➔ it creates a **sparse** array of $n$ holes, and `map`/`filter`/`forEach` skip holes, so you get `[empty × n]` back. Use `Array.from({length: n}, (_, i) => i)`, which fills as it builds, or spread `[...Array(n).keys()]`.
- 💡 **Seeding a max-`reduce` with `0`** ➔ `reduce((m, x) => x > m ? x : m, 0)` returns `0` for an all-negative array. Seed with `array[0]` — and accept that the empty array then has no answer, which is the honest result.
- 💡 **Arrow functions are only *almost* equivalent** ➔ the slides say "(almost)" and do not explain why in Week 1. Do not claim exact equivalence in an interview; say the arrow form differs in how it binds context and that the unit covers it later.
- 💡 **A closure captures the variable, not a copy** ➔ if the enclosing variable is a mutable `let` that changes later, the closure sees the **new** value. Capturing a `const` avoids the whole class of bug.
- 💡 **`forEach` returns `undefined`** ➔ chaining off it (`xs.forEach(…).map(…)`) throws. Use `map` when you need the results.
- 💡 **`reduce` without an initial value** ➔ `reduce((t, s) => t + s)` on an empty array throws, and on a string array starts with a string accumulator. Always pass the initial `0`.
