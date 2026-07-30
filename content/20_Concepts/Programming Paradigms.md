---
unit: FIT2102
week: 1
source: [lecture]
domain: H
parent: "[[FIT2102_MOC]]"
tags: [CS/Languages]
aliases: [Paradigm, Imperative Programming, Declarative Programming, Functional Programming, Referential Transparency, Purity, Pure Function]
---
# [[Programming Paradigms]]

**Context:** [[FIT2102_MOC]] · the unit's spine — a paradigm is a **model for computation**, so the differences are [[Syntax versus Semantics|semantic]], not cosmetic · the ladder it climbs is [[Levels of Abstraction (Machine to High-Level)]] · the JavaScript machinery is [[JavaScript Functions as Values]]

> [!abstract] Quick Revision
> - **🎯 Objective:** **imperative** = tell the computer *how*, step by step; **declarative** = describe *what* you want ➔ same result, different model of computation.
> - **📦 Core Components:** imperative ➔ mutable state + statements | declarative/functional ➔ pure expressions + [[Recursion|recursion]]/[[Higher-Order Function|HOFs]] | OO ➔ composition via objects.
> - **⚡ Key Constraint:** declarative code buys **referential transparency** (an expression can be replaced by its value) at the cost of a **stack-overflow ceiling** on deep recursion — neither style is free.

## 📝 How It Works

### 1. What a paradigm is
- **A model for computation** ➔ not a syntax family. Most modern languages support several paradigms; languages differ in which ones they support *well*.
- **The four in scope** ➔ **imperative** · **declarative** · **functional** · **object oriented**, plus the orthogonal axis of **strong vs dynamic type systems**.
- **Imperative** ➔ tell the computer **how** to compute, step by step. Its native model is [[Von Neumann Architecture and Programs|von Neumann]]/Turing: an instruction pointer walking a sequence of state mutations.
- **Declarative** ➔ describe **what** you want, not how to get it. Its native model is the **lambda calculus**: expressions reduced to values, no instruction pointer, no store.
- **Where JavaScript sits** ➔ basically an **imperative** language with C/Java-like syntax, except that it is **interpreted** and **functions are objects** assignable to variables — which is why heavy functional style is available in it at all.

### 2. Purity and referential transparency
- **Pure expression** ➔ has **no effects outside the expression**. No mutation, no I/O, nothing observable but its value.
- **Referential transparency** ➔ *follows from* purity: any expression may be replaced by its value without changing the program's meaning. This is what makes equational reasoning (and later, `Functor`/`Monad` laws) possible.
- **Declarative ⟹ closer to the definition** ➔ `sumTo n = n + sumTo(n-1)` is the **inductive definition** of the sum, not a recipe for computing it; the code **states the loop invariant** instead of maintaining it.
- **The caveat, stated honestly** ➔ too many levels of recursion causes a **stack overflow**. Declarativeness is not free.

### 3. Why the unit distrusts hand-coded loops
- **`for ([init]; [cond]; [final]) statement` has four independent failure surfaces** ➔ the **init** can start at the wrong value (`n` instead of `n-1`, `1` instead of `0`) or initialise the wrong variable; the **condition** can use `=` for `==`/`===`, `<=` for `<`, or test the wrong variable; the **final-expression** can increment the wrong variable; the **body** can mutate the very variable the termination test reads, because it is in scope.
- **`while`, `goto` and recursive loops carry risks too** ➔ the slides' conclusion is not "prefer `while`" — it is *stop hand-coding iteration*.
- **The replacement** ➔ built-in [[Higher-Order Function|higher-order]] Array methods (`forEach`/`map`/`filter`/`reduce`), which encode the traversal once and correctly ➔ [[JavaScript Functions as Values]].
- **Composition, two ways** ➔ programs can be composed through **higher-order functions** (behaviour as a parameter) or through **objects** (behaviour bundled with state) — the unit contrasts these deliberately rather than ranking them.

## 🧬 Evaluation Model
One computation — sum the numbers up to $n$ — climbing from imperative to functional. Every version returns the same value; only the model changes.

```javascript
// 1. IMPERATIVE, truthiness guard: two mutations per step
function sumTo(n) {
  let sum = 0;
  while (n) { sum += n--; }        // Boolean(0) === false ends the loop
  return sum;
}

// 2. IMPERATIVE, counted loop: the four failure surfaces above live here
function sumTo(n) {
  let sum = 0;
  for (let i = 1; i <= n; i++) { sum += i; }
  return sum;
}

// 3. DECLARATIVE, recursive: no mutable variables, every expression pure
function sumTo(n) {
  if (n === 0) return 0;           // base case
  return n + sumTo(n - 1);         // inductive step
}

// 4. DECLARATIVE, condensed + generalised by a HOF parameter
function sumTo(n, f) { return n ? f(n) + sumTo(n - 1, f) : 0; }
sumTo(10, x => x * x);             // 385  -- behaviour is now an argument
```

- **Desugaring** ➔ `n ? a : b` ⟹ `if (n) { return a } else { return b }`; `x => x * x` ⟹ `function(x) { return x * x }`.
- **Type signature** ➔ version 4 is $\text{sumTo} : \mathbb{N} \to (\mathbb{N} \to \mathbb{N}) \to \mathbb{N}$ — taking a function is what makes it higher-order.
- **What changed between 2 and 3** ➔ `let` disappears. No binding is ever reassigned, so no expression's value depends on *when* it is evaluated.

## ⚖️ Core Decision Matrix
| Paradigm | You write | Model of computation | Buys you | Costs you |
| :--- | :--- | :--- | :--- | :--- |
| **Imperative** | statements mutating state | von Neumann / Turing | direct match to hardware; bounded memory | four loop failure surfaces; no referential transparency |
| **Declarative** | expressions describing the result | reduction of expressions | states the invariant; safe to reason about equationally | indirection from the machine |
| **Functional** | pure functions + [[Higher-Order Function|HOFs]] | lambda calculus | composability; behaviour as a parameter | **stack overflow** on deep recursion |
| **Object oriented** | objects bundling state + behaviour | message passing over encapsulated state | composition via interfaces; locality of state | state is mutable *by design* ➔ harder to reason about |

> [!NOTE] **When It Flips:** prefer the imperative loop only when recursion depth is unbounded or the mutation *is* the point (in-place algorithms). Otherwise the built-in Array HOFs win: they remove all four hand-coded-loop failure surfaces at once, and they compose (`map(…).reduce(…)`) where loops do not.

## 🧠 Active Recall
> [!FAQ]- The recursive `sumTo` is called "more declarative" than the `for`-loop version. Justify that with three specific properties, then name what it costs.
> - **Hint:** Mutation, effects, and what the code *says*.
> > [!SUCCESS]- Answer
> > - **Short answer:** No mutable variables; every expression is pure; the code states the loop **invariant** rather than a procedure for maintaining it — so it has **referential transparency**. Cost: a **stack overflow** at depth.
> > - **Why:** **Closer to the inductive definition** ➔ `n + sumTo(n-1)` *is* the mathematical definition of the sum, whereas the loop is a recipe. Purity means no expression has effects outside itself, which is precisely the condition under which an expression may be substituted for its value.

> [!FAQ]- Name the four independent failure surfaces of a hand-coded `for` loop, and say why built-in Array methods remove all of them.
> > [!SUCCESS]- Answer
> > - **Short answer:** Wrong **initial** value or variable; wrong **condition** (`=` vs `===`, `<=` vs `<`, wrong variable); wrong variable in the **final-expression**; a **body** that mutates the variable the termination test reads.
> > - **Why:** **Traversal encoded once** ➔ `map`/`filter`/`reduce` own the iteration, so there is no index for you to get wrong — you supply only the per-element behaviour. This is why the unit's advice is "avoid hand-coded loops", extended even to `while` and recursion.

> [!FAQ]- JavaScript is described as "basically an imperative language". Why is functional programming nonetheless idiomatic in it?
> > [!SUCCESS]- Answer
> > - **Short answer:** Functions are **objects** — assignable to variables, storable, passable, returnable — so functions-as-values has been available since the language's inception.
> > - **Why:** **First-class functions are the enabling condition** ➔ they make [[Higher-Order Function|HOFs]] and closures expressible without any language change, which is why server- and client-side JS in the wild leans on FP patterns (jQuery, React, D3, RxJS, Mocha) for flexibility and robustness.
