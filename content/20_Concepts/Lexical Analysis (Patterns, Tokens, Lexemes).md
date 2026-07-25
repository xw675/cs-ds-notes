---
unit: FIT2014
week: 4
parent: "[[Finite Automata (DFA and NFA)]]"
tags: [Math/Theory, CS/Computation, CS/Languages, Monash/CS_DS]
aliases: [lexical analysis, lexer, tokeniser, token, lexeme, pattern, maximal munch, longest match, scanner]
---
# [[Lexical Analysis (Patterns, Tokens, Lexemes)]]

**Context:** [[FIT2014_MOC]] · the headline **application** of finite automata — splitting text into meaningful pieces · **Assignment 2 material** (lexical analysis, parsing, computability)

> [!abstract] Quick Revision
> - **🎯 Objective:** read input **one character at a time** and split it into **lexemes** tagged with their **tokens** ➔ output a token sequence. Implemented as a **finite automaton**.
> - **⚡ Key Constraint:** splits are usually **ambiguous**, so two conventions decide: take the **longest possible lexeme** (maximal munch), and on ties take the **first-listed** token.

## 📖 The three terms
| Term | Definition | Example |
| :--- | :--- | :--- |
| **Pattern** | a **regular expression** specifying a form | $N=DD^{*}$, where $D=(\mathtt{0}\cup\mathtt{1}\cup\dots\cup\mathtt{9})$ |
| **Token** | the **name** of a pattern (may carry an attribute value) | "non-negative integer" |
| **Lexeme** | an actual **sequence of characters** matching the pattern for a token | $1957$, $8$, $31$, $024$, $0002014$ |

- **The relationship** ➔ a **pattern describes the form that the lexemes of a token may take**.
- **Where it appears** ➔ calculators (`exp(sqrt(-1)*3.14159265)+1`), programming languages (identifiers, keywords, operators, literals), even structured records (names, dates, addresses).

## ⚙️ What a lexical analyser does
- **Reads** the input **one character at a time**.
- **Splits** it into lexemes with their associated tokens, where **each token corresponds to a regular language**.
- **Outputs** a sequence of tokens, together with any attribute values.
- **Is implemented using a finite automaton** — which is why the whole regex→NFA→DFA→minimise pipeline matters.

### Recognising several patterns at once
- **Construction** ➔ build an NFA per pattern, join them from a common Start state with $\varepsilon$-transitions, then determinise ([[NFA to DFA (Subset Construction)]]).
- **Labelling** ➔ each Final state of the resulting DFA records **which pattern** it accepts, so the machine reports not just *a* match but *which token* matched.
- **Worked shape** ➔ for the patterns $\mathtt{a}$, $\mathtt{abb}$, $\mathtt{a}^{*}\mathtt{bb}^{*}$, the determinised table has Final states individually tagged "Final $\mathtt{a}$", "Final $\mathtt{abb}$", "Final $\mathtt{a}^{*}\mathtt{bb}^{*}$".

## 📏 The two disambiguation conventions
- **1. Maximal munch (longest match)** ➔ *match the largest possible lexeme at each stage.*
  - Example: `abbbb` could split as `a`+`bb`+`bb` or as one long lexeme; the convention takes the **longest** available match.
- **2. First-listed wins on ties** ➔ *if candidate lexemes are the **same length**, choose the **first token listed**.*
  - Example: `abb` matches both the pattern $\mathtt{abb}$ and the pattern $\mathtt{a}^{*}\mathtt{bb}^{*}$ with the same length ⟹ whichever is declared first wins.
- **Why order matters in practice** ➔ this is exactly why keywords are listed **before** the general identifier pattern in real lexer specifications.

## ⚠️ Common Mistakes
- 💡 **Token ≠ lexeme** ➔ the **token** is the *name/class* ("non-negative integer"); the **lexeme** is the *actual text* (`0002014`). One token has many lexemes.
- 💡 **Pattern is a regex, token is a label** ➔ the pattern is the machinery; the token is what the parser downstream consumes.
- 💡 **Ambiguity is the norm, not the exception** ➔ without maximal munch a lexer would fragment `abbbb` arbitrarily; without the first-listed rule, equal-length matches would be undecided.
- 💡 **Order of declaration is semantically significant** ➔ listing a general pattern before a specific one silently swallows the specific one on ties.

## 🧠 Active Recall
> [!FAQ]- Distinguish pattern, token and lexeme, and state how they relate.
> > [!SUCCESS]- Answer
> > - **Short answer:** a **pattern** is a **regular expression** specifying a form; a **token** is the **name** of that pattern (optionally with an attribute); a **lexeme** is a **concrete character sequence** matching the pattern. So a pattern **describes the form that the lexemes of a token may take**.
> > - **Why:** **One token, many lexemes** ➔ e.g. the token "non-negative integer" has pattern $DD^{*}$ and lexemes $1957$, $8$, $024$, …; the lexer emits the *token* (plus attribute) while the *lexeme* is the text consumed.

> [!FAQ]- Why does a lexical analyser need both disambiguation conventions rather than just one?
> > [!SUCCESS]- Answer
> > - **Short answer:** **maximal munch** resolves *how far to read* — `abbbb` should become one long lexeme rather than several short ones. But it cannot settle cases where **two different patterns match the same length**, e.g. `abb` matching both $\mathtt{abb}$ and $\mathtt{a}^{*}\mathtt{bb}^{*}$; the **first-listed** rule breaks those ties.
> > - **Why:** **Two orthogonal ambiguities** ➔ one is about **length** of the match, the other about **which token** claims a match of that length; a deterministic lexer must resolve both, which is why declaration order carries meaning.
