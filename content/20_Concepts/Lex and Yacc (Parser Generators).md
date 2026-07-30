---
unit: FIT2014
domain: D
week: 6
source: [lecture]
parent: "[[Parsing and Shift-Reduce Parsers]]"
tags: [CS/Computation, CS/Languages, Tool/Lex, Tool/Yacc]
type: pattern
aliases: [Lex, Yacc, flex, bison, lex.yy.c, y.tab.c, yylex, yyparse, parser generator, compiler-compiler]
---
# [[Lex and Yacc (Parser Generators)]]

**Context:** [[FIT2014_MOC]] · the Unix/Linux toolchain that turns the theory into a running parser — **Lex** builds the [[Lexical Analysis (Patterns, Tokens, Lexemes)|lexer]] from [[Regular Expressions|regexes]], **Yacc** builds the [[Parsing and Shift-Reduce Parsers|LR parser]] from a [[Context-Free Grammars (CFG)|CFG]] · **Assignment 2**
**Problem it solves:** you have a token spec and a grammar; you want an executable that recognises (and evaluates) the language without hand-coding a DPDA.

> [!abstract] Quick Revision
> - **🎯 Trigger:** regexes per token ➔ **Lex**; production rules ➔ **Yacc**; compile both, link, get a parser.
> - **⚠️ Key Constraint:** **Yacc silently resolves conflicts** — shift-reduce ➔ **shift**, reduce-reduce ➔ **rule listed first**. A grammar that "works" may still be ambiguous.

## 🔧 The two-file pipeline
| Tool | Full name | Input | Output file | Entry function |
| :--- | :--- | :--- | :--- | :--- |
| **Lex** | Lexical Analyser | a **regular expression** per token | `lex.yy.c` | `yylex()` |
| **Yacc** | **Y**et **A**nother **C**ompiler-**C**ompiler | a **context-free grammar** | `y.tab.c` | `yyparse()` |

- **How they couple** ➔ `yyparse()` repeatedly **calls `yylex()`** to pull the next token; Lex handles the [[Regular Expressions|regular]] layer, Yacc the [[Context-Free Grammars (CFG)|context-free]] layer.
- **Build** ➔ compile `y.tab.c` and `lex.yy.c` with a C compiler (`cc`) ➔ a single **executable parser**, which can **evaluate as it parses** — the code attached to each rule runs as that rule fires.

## 🧩 File anatomy (both use the same three-section shape, split by `%%`)
```
filename.l                        filename.y
    definitions ...                   declarations (incl. token names) ...
%%                                %%
    regexps + code, per token         grammar: production rules ...
%%                                %%
    C code ...                        C code ...
```
- **Section 1** ➔ definitions / declarations. Yacc's is where **token names** are declared, so Lex and Yacc agree on the vocabulary.
- **Section 2** ➔ the **rules**: Lex pairs each regex with an action; Yacc pairs each production with an action.
- **Section 3** ➔ plain C (e.g. `main`, helper functions).

## ⚠️ Common Mistakes
- 💡 **Chomsky vs Conjunctive Normal Form** ➔ Yacc grammars need no normal form at all; [[Chomsky Normal Form]] is a *proof/algorithm* device ([[CYK Algorithm]]), not an input format.
- 💡 **Treating a silent build as a correct grammar** ➔ Yacc resolves conflicts by default rather than failing; check the conflict report, then **stratify the grammar** (Plus-Times-B style) rather than relying on the default.
- 💡 **Token spec split across the two files** ➔ a token named in the Yacc declarations but never returned by a Lex rule (or vice versa) links cleanly and then never matches.

## 🧠 Active Recall
> [!FAQ]- Why does the toolchain split into two tools rather than one?
> > [!SUCCESS]- Answer
> > - **Short answer:** the two layers need **different machines**. Tokens are a **regular** problem, recognised by a finite automaton generated from regexes (Lex); nesting and structure are **context-free**, needing a stack machine generated from a CFG (Yacc).
> > - **Why:** **Match the machine to the language class** ➔ by the [[Pumping Lemma for Regular Languages|pumping lemma]] no FA can match nested brackets, and running a full [[Pushdown Automata (PDA)|PDA]] over raw characters would be needlessly costly. Splitting keeps the cheap regular scan cheap and hands only the token stream to the parser — which is why `yyparse()` calls `yylex()`.
