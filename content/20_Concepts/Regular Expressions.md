---
unit: FIT2014
week: 2
parent: "[[Formal Languages (Alphabets, Words, Languages)]]"
tags: [Math/Theory, CS/Computation, CS/Languages]
aliases: [regular expression, regex, regular language, Kleene star, concatenation, alternation, matched]
---
# [[Regular Expressions]]

**Context:** [[FIT2014_MOC]] · a finite notation for (often infinite) **languages** over $\Sigma$ · builds on [[Formal Languages (Alphabets, Words, Languages)]] · **Assignment 1 material** (regex + finite automata)
**Companion:** [[Finding Regular Expressions]] — the description $\to$ expression skill.

> [!abstract] Quick Revision
> - **🎯 Objective:** define languages by **pattern** rather than by listing ➔ built inductively from $\emptyset$, $\varepsilon$ and letters using **concatenation**, **union** $\cup$ and **Kleene star** $^{*}$.
> - **⚡ Key Constraint:** $^{*}$ binds tightest — $\mathtt{ab}^{*}\neq(\mathtt{ab})^{*}$: the first is $\mathtt{a}$ followed by any number of $\mathtt{b}$s, the second repeats the block $\mathtt{ab}$.

## 📝 Why they exist
- **Pattern matching** ➔ find URLs in logs, valid variable names, dates, numbers in mixed text.
- **Everywhere in tools** ➔ editors (vi, emacs), filters (grep, sed, awk), lexical-analyser generators (lex, flex, JFlex), compiler generators (yacc, bison), and languages (Python `re`, Perl, Java `java.util.regex`). *(applied hands-on: [[Text Processing with sed and tr]], Lab 0)*

## 🧱 Inductive definition — the expressions
1. $\emptyset$ and $\varepsilon$ are regular expressions.
2. Every **letter** of the alphabet is a regular expression.
3. If $R$ and $S$ are regular expressions, then so are: $(R)$ · $RS$ · $R\cup S$ · $R^{*}$.

## 🧭 Inductive definition — what they *mean*
| Expression | Language represented |
| :--- | :--- |
| $\emptyset$ | the **empty language** $\emptyset$ |
| $\varepsilon$ | $\{\varepsilon\}$ — just the empty word |
| $w$ (a word) | $\{w\}$ — exactly that one word |
| $(R)$ | same language as $R$ (grouping only) |
| $RS$ | $\{vw : v\in K,\ w\in L\}$ — **concatenation** |
| $R\cup S$ | $K\cup L$ — **union / alternatives** |
| $R^{*}$ | $\{\varepsilon\}\cup\{w_1w_2\cdots w_k : k\in\mathbb{N},\ \text{each } w_i\in K\}$ |

*(writing $K$ for the language of $R$ and $L$ for the language of $S$)*

- **Regular language** ➔ any language describable by a regular expression.
- **Matched** ➔ a word is *matched* by $R$ if it belongs to $R$'s language.

## ⭐ The three operations
- **Concatenation** ➔ if $x$ matches $R$ and $y$ matches $S$, then $xy$ matches $RS$.
- **Union (alternatives)** ➔ $\mathtt{1}\cup\mathtt{2}\cup\dots\cup\mathtt{9}$ describes $\{1,2,\dots,9\}$.
- **Grouping** ➔ $(\mathtt{ab}\cup\mathtt{ba})(\mathtt{e}\cup\mathtt{g})$ describes $\{\mathtt{abe},\mathtt{abg},\mathtt{bae},\mathtt{bag}\}$.
- **Kleene star** ➔ *zero or more* repetitions:
$$\mathtt{a}^{*}=\{\varepsilon,\mathtt{a},\mathtt{aa},\mathtt{aaa},\dots\},\qquad (\mathtt{ab})^{*}=\{\varepsilon,\mathtt{ab},\mathtt{abab},\dots\},\qquad \mathtt{ab}^{*}=\{\mathtt{a},\mathtt{ab},\mathtt{abb},\dots\}$$
- **Star unfolds as a union of powers** ➔
$$(\mathtt{aa}\cup\mathtt{bb})^{*}=(\mathtt{aa}\cup\mathtt{bb})^{0}\cup(\mathtt{aa}\cup\mathtt{bb})^{1}\cup(\mathtt{aa}\cup\mathtt{bb})^{2}\cup\cdots=\{\varepsilon,\mathtt{aa},\mathtt{bb},\mathtt{aaaa},\mathtt{aabb},\mathtt{bbaa},\dots\}$$

## 🌳 Structure (parse tree)
- **Expressions have structure** ➔ $(\mathtt{a}\cup\varepsilon)\mathtt{b}^{*}$ parses as a concatenation of $(\mathtt{a}\cup\varepsilon)$ and $\mathtt{b}^{*}$, each decomposing further.
- **Why it matters** ➔ identifying the **last operation used** to build the expression is the key to both reading and writing regexes.

## ✍️ Alternative notations (tool-dependent)
| This unit | Common alternative | Meaning |
| :--- | :--- | :--- |
| $R\cup S$ | $R\ \vert\ S$ | alternatives |
| $\mathtt{0}\cup\mathtt{1}\cup\dots\cup\mathtt{9}$ | `[0-9]` | character class |
| letters $\mathtt{a}$ to $\mathtt{z}$ | `[a-z]` | range |
| $RR^{*}$ | $R^{+}$ | **one** or more |
| $\varepsilon\cup R$ | $R?$ | optional |

- **⚠ Tools differ** ➔ in whether $+$ and $?$ carry these meanings, how parentheses/vertical bars are escaped, whether `.` means "any non-newline character", and how newlines are handled. The unit's notation is the mathematical one.

## ⚠️ Common Mistakes
- 💡 **$\mathtt{ab}^{*}\neq(\mathtt{ab})^{*}$** ➔ the star applies to the **immediately preceding** expression; group explicitly when you mean the block.
- 💡 **$^{*}$ includes zero copies** ➔ $R^{*}$ always contains $\varepsilon$; if you need at least one, write $RR^{*}$ (i.e. $R^{+}$).
- 💡 **$\emptyset$ vs $\varepsilon$** ➔ $\emptyset$ represents the language with **no** words; $\varepsilon$ represents $\{\varepsilon\}$, which has **one**. *(same trap as in [[Formal Languages (Alphabets, Words, Languages)]])*
- 💡 **Not every language is regular** ➔ **PALINDROME is now settled: it is *not* regular**, proved by the [[Pumping Lemma for Regular Languages|pumping lemma]] (see [[Proving a Language Non-Regular]]). DOUBLEWORD is likewise non-regular, though the unit has not yet proved it.

## 🧠 Active Recall
> [!FAQ]- Distinguish the languages of $\mathtt{ab}^{*}$, $(\mathtt{ab})^{*}$ and $\mathtt{a}^{*}\mathtt{b}^{*}$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathtt{ab}^{*}=\{\mathtt{a},\mathtt{ab},\mathtt{abb},\dots\}$ (one $\mathtt{a}$, then any number of $\mathtt{b}$s); $(\mathtt{ab})^{*}=\{\varepsilon,\mathtt{ab},\mathtt{abab},\dots\}$ (repeats of the block); $\mathtt{a}^{*}\mathtt{b}^{*}=\{\varepsilon,\mathtt{a},\mathtt{b},\mathtt{ab},\mathtt{aab},\mathtt{abb},\dots\}$ (any number of $\mathtt{a}$s **then** any number of $\mathtt{b}$s).
> > - **Why:** **Scope of the star** ➔ $^{*}$ binds to the immediately preceding expression, so grouping decides whether a block or a single letter repeats; concatenating two starred expressions gives an ordered pair of runs.

> [!FAQ]- What does it mean for a language to be *regular*, and why is the inductive definition needed?
> > [!SUCCESS]- Answer
> > - **Short answer:** a language is **regular** iff some regular expression describes it; the word is **matched** if it lies in that language.
> > - **Why:** **Finite description of infinite sets** ➔ the inductive rules (base cases $\emptyset,\varepsilon$, letters; closure under concatenation, $\cup$, $^{*}$) generate every regular expression from finitely many rules, and the parallel inductive semantics assigns each one a language — so infinite languages get finite descriptions.
