---
unit: FIT2102
week: 1
source: [lecture]
domain: H
parent: "[[Programming Paradigms]]"
tags: [CS/Languages]
aliases: [Syntax, Semantics, Syntax vs Semantics]
---
# [[Syntax versus Semantics]]

**Context:** [[FIT2102_MOC]] · the distinction that makes the whole unit transferable — [[Programming Paradigms]] are differences of *semantics*, and language choice is mostly *syntax* · the ladder those semantics sit on is [[Levels of Abstraction (Machine to High-Level)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** **syntax** = which symbol combinations are *well-formed*; **semantics** = what the machine *does* when it runs them ➔ two programs can differ entirely in syntax and be identical in semantics.
> - **⚡ Key Constraint:** learn the **semantics**; the syntax is the disposable part. FIT2102 studies few languages on purpose — concepts transfer, keywords do not.

## 📝 Core
- **Syntax** ➔ the set of rules defining which combinations of symbols count as correctly structured **statements or expressions** in a language. A syntax error means the text was never a program.
- **Semantics** ➔ the processes a computer follows when **executing** a program in a given language. A semantic difference means the machine *does something else*.
- **Same semantics, different syntax** ➔ `sumTo` in Python (`while i < n:`, indentation-delimited) and in JavaScript (`for(let i = 0; i < n; i++)`, brace-delimited) compute the identical result: the syntax is unrecognisably different, the semantics are the same.
- **Same semantics, different syntax — *within* one language** ➔ `while` vs `for`, `if/else` vs the ternary `x >= y ? x : y`. Choosing between them is a readability decision, not a behavioural one.
- **Why this pays** ➔ a concept learned as semantics is portable to any language that offers the abstraction; a concept learned as syntax dies with the language.

## 🧬 Evaluation Model
The same computation, three surfaces — all three reduce to *"accumulate $0+1+\dots+(n-1)$"*:

| Surface | Code | Semantics |
| :-- | :-- | :-- |
| Python `while` | `sum = 0; i = 0` · `while i < n: sum += i; i += 1` | mutate two variables until the guard fails |
| Python `for` | `for i in range(0,n): sum = sum + i` | same mutation, loop variable managed for you |
| JavaScript `for` | `let sum = 0;` · `for(let i = 0; i < n; i++) { sum += i; }` | same mutation, different delimiters |

- **Desugaring** ➔ `x >= y ? x : y` ⟹ `if (x >= y) { return x } else { return y }`; the ternary is an **expression** (it *has* a value), the `if` is a **statement** (it *does* something). That is a real semantic difference hiding inside apparent sugar.

## ⚠️ Common Mistakes
- 💡 **Calling a semantic difference "just syntax"** ➔ a statement and an expression are not interchangeable: only the expression form can be passed, returned, or composed.
- 💡 **Assuming `range(0,n)` and `i < n` agree by luck** ➔ both exclude $n$, which is why the two `sumTo` versions match. Change either bound and the semantics diverge while the syntax looks fine.

## 🧠 Active Recall
> [!FAQ]- Two programs in different languages produce identical output for every input. Are they syntactically or semantically equivalent — and why does FIT2102 care?
> - **Hint:** One of the two is what the machine actually does.
> > [!SUCCESS]- Answer
> > - **Short answer:** Semantically equivalent; syntactically unrelated.
> > - **Why:** **Transfer** ➔ semantics is the layer of *processes the computer follows*, so it is what generalises across languages. The unit studies few languages deliberately: master the semantics of an abstraction once and it reappears in JavaScript, TypeScript, Haskell and MiniZinc under different spellings.
