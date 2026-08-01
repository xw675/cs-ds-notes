---
unit: FIT2102
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2102: Programming Paradigms

> [!INFO] Map of Content
> Index for **FIT2102 Programming Paradigms** — programming languages as *different abstractions of computation*. The whole unit turns on one distinction: [[Syntax versus Semantics]]. Arc: abstraction ladder → paradigms → JavaScript/TypeScript → Haskell (type classes → Functor/Applicative → Foldable/Traversable → Monad/IO → parser combinators) → lambda calculus → MiniZinc. **No exam** — the assessable act is defending your own code in an interview, so every note must make the WHY sayable out loud.

## 📊 Assessment Map
- **Tutorials + Quizzes (40%)** ➔ completed **individually**, assessed via **in-class interviews**. Marked on *correct and timely completion* (submitted via Moodle) **and demonstrated understanding in the interview**.
- **Assignment 1 (30%)** ➔ set W4, **due W7**. Individual; interviews check understanding; standard plagiarism checks.
- **Assignment 2 (30%)** ➔ set W8, **due W12**. Same conditions.
- **Workload calibration** ➔ most tutorial tasks are a few lines; **no single problem should exceed ~30 minutes**. Stuck? Write the question as a code comment, split it into sub-questions, bring it to the lab. This is deliberate — the pedagogy is **productive failure + active learning**.
- **Out of scope** ➔ not a full "Programming Languages" course: you will **not** build a compiler or design a language, though both are discussed.

## 📅 Knowledge Index

### Week 1 — Syntax vs Semantics, Abstraction, JavaScript
- [[Syntax versus Semantics]] -> Parent Framework: [[Programming Paradigms]] *(the distinction that makes every concept transferable)*
- [[Levels of Abstraction (Machine to High-Level)]] -> Parent Framework: [[Von Neumann Architecture and Programs]] *(shared with FIT1047 — the assembly/x86 tables are flagged **not examinable**)*
- [[Programming Paradigms]] -> Parent Framework: [[FIT2102_MOC]] *(**the unit's spine** — imperative vs declarative, purity, referential transparency, the four-surface loop critique)*
- [[JavaScript Basics (Syntax, Types, Control Flow)]] -> Parent Framework: [[Programming Paradigms]] *(`const`/`let`, `===`, truthiness, operators)*
- [[JavaScript Functions as Values]] -> Parent Framework: [[Higher-Order Function]] *(arrow functions, closures, `forEach`/`map`/`filter`/`reduce` — **the W1 hand skill**)*
- [[Higher-Order Function]] *(Smart Merged: dual-unit — FIT1008 Python forms + the FIT2102 JavaScript/arrow forms)*
- [[Von Neumann Architecture and Programs]] *(Smart Merged: FIT2102 adds the imperative-model framing that lambda calculus later replaces)*

## 🧭 Suggested Reading Order
- **W1 — from the machine to functions-as-values:** [[Levels of Abstraction (Machine to High-Level)]] → **[[Syntax versus Semantics]]** → **[[Programming Paradigms]]** *(the spine)* → [[JavaScript Basics (Syntax, Types, Control Flow)]] → **[[JavaScript Functions as Values]]** *(W1 hand skill)*

## 🎯 Learning Outcomes
- **W1** ➔ 
	- justify the need for abstraction from machine instructions to high-level languages 
	- distinguish **syntax** from **semantics** 
	- write JS with immutable bindings, functions, loops and conditionals 
	- contrast composition via **higher-order functions** vs **objects** 
	- desugar arrow functions to `function` form 
	- define a **closure** as an anonymous function capturing its enclosing scope 
	- use the built-in Array HOFs instead of hand-coded loops
