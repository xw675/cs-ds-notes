---
unit: FIT2014
week: 5
parent: "[[Context-Free Grammars (CFG)]]"
tags: [Math/Theory, CS/Computation, CS/Languages, Monash/CS_DS]
type: pattern
aliases: [writing a grammar, CFG construction, Dyck language, PARENTHESES grammar, palindrome grammar, balanced brackets, a^n b^n grammar]
---
# [[Writing a CFG]]

**Context:** [[FIT2014_MOC]] · turning a language description into a [[Context-Free Grammars (CFG)|grammar]] · the assessable counterpart to [[Finding Regular Expressions]], one tier up
**Problem it solves:** given a language, write production rules that generate exactly it.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a language with **nesting** or **matching** or a **running count** ➔ find an **inductive definition** ("a string is either $\varepsilon$, or … built from smaller strings") and transcribe each case into a rule.
> - **⚡ Key Constraint:** the recursion must be **structural** — every rule should shrink toward the base case $\varepsilon$, and the nonterminals should capture the **invariant** that defines membership.

## 📐 The recipe
1. **Find an inductive definition** of the language: a base case plus ways to build bigger members from smaller ones.
2. **One rule per case.** The base case becomes $S\to\varepsilon$ (or a terminal); each recursive case becomes a rule whose right side contains nonterminal(s) for the smaller pieces.
3. **Introduce a nonterminal per "type"** of string when membership depends on a running property (imbalance, parity, phase).
4. **Check the extremes** — does the grammar produce $\varepsilon$ and the shortest non-empty members? Does it *avoid* non-members?

## 🧱 Worked example — PARENTHESES (the Dyck language)
**Language** ➔ all strings of **correctly matched** parentheses: $\varepsilon,\ \mathtt{()},\ \mathtt{()()},\ \mathtt{(())},\ \mathtt{(()())},\dots$ (non-members: $\mathtt{)(}$, $\mathtt{(((())}$).

**Inductive definition** ➔ a string of parentheses $S$ is one of:
- the empty string $\varepsilon$;
- $(S')$ where $S'$ is a string of parentheses;
- $S_1S_2$ where $S_1,S_2$ are strings of parentheses.

**Grammar** (transcribe the three cases):
$$S\to\varepsilon \mid (S) \mid SS$$

- **Where does the matching go?** ➔ any non-empty balanced string starts with $($; its partner $)$ is either **at the very end** (rule $(S)$) or **before the end** (rule $SS$) — exactly the two recursive cases.

## ✍️ Practice 
> [!QUESTION]- Practice 1: A grammar for HALF-AND-HALF $=\{\mathtt{a}^{n}\mathtt{b}^{n}: n\ge 0\}$.
> > [!SUCCESS]- Reference solution
> > $$S\to \mathtt{a}S\mathtt{b}\mid\varepsilon$$
> > - **Key move:** add **one $\mathtt{a}$ on the left and one $\mathtt{b}$ on the right per step** — the matched pair keeps the counts equal and correctly ordered. This is the language the [[Pumping Lemma for Regular Languages|pumping lemma]] proved **non-regular**, yet a two-rule CFG generates it.

> [!QUESTION]- Practice 2: A grammar for PALINDROME over $\{\mathtt{a},\mathtt{b}\}$.
> > [!SUCCESS]- Reference solution
> > $$S\to \mathtt{a}S\mathtt{a}\mid \mathtt{b}S\mathtt{b}\mid \mathtt{a}\mid \mathtt{b}\mid\varepsilon$$
> > - **Key move:** wrap the **same letter on both ends** each step; the odd-length middle needs the single-letter cases $\mathtt{a}$ and $\mathtt{b}$, the even-length core needs $\varepsilon$.

> [!QUESTION]- Practice 3: A grammar for balanced strings over **two** bracket types, round $()$ and square $[\,]$.
> > [!SUCCESS]- Reference solution
> > $$S\to\varepsilon \mid (S) \mid [S] \mid SS$$
> > - **Key move:** the Dyck idea generalises — one "wrap" rule **per bracket pair**, plus concatenation. A round open must be closed by a round close, so $(S)$ and $[S]$ stay separate.

## ⚠️ Common Mistakes
- 💡 **Concatenation needs its own rule** ➔ $S\to SS$ (or similar) is what lets members sit side by side; without it $\mathtt{()()}$ is underivable.
- 💡 **Don't over-generate** ➔ a sloppy grammar like $S\to (\mid )\mid SS\mid\varepsilon$ would produce $\mathtt{)(}$; the **wrap** rule $(S)$ is what enforces matching.
- 💡 **Track the invariant with nonterminals** ➔ for counting languages (EQUAL), one nonterminal per imbalance class; for phase languages, one per phase.
- 💡 **Always allow the base case** ➔ forgetting $S\to\varepsilon$ silently excludes the empty word (and can break recursion that bottoms out at $\varepsilon$).

## 🧠 Active Recall
> [!FAQ]- Derive the CFG $S\to\varepsilon\mid(S)\mid SS$ for balanced parentheses from an inductive definition.
> > [!SUCCESS]- Answer
> > - **Short answer:** a balanced string is **either** empty ($\Rightarrow S\to\varepsilon$), **or** a smaller balanced string **wrapped** in a pair ($\Rightarrow S\to(S)$), **or** two balanced strings **concatenated** ($\Rightarrow S\to SS$). Each clause of the definition becomes one production.
> > - **Why:** **Matching partner is at or before the end** ➔ every non-empty balanced string begins with $($ whose partner $)$ is either final (giving $(S)$) or internal (giving $SS$); the two recursive rules cover exactly these, and both shrink toward $\varepsilon$.

> [!FAQ]- Why can a CFG generate $\mathtt{a}^{n}\mathtt{b}^{n}$ when no regular expression can?
> > [!SUCCESS]- Answer
> > - **Short answer:** the rule $S\to\mathtt{a}S\mathtt{b}$ adds a matched $\mathtt{a}$…$\mathtt{b}$ pair **around** the recursive call, so the two counts are kept equal **by construction** for arbitrarily large $n$.
> > - **Why:** **Recursion = unbounded matched memory** ➔ each expansion remembers one outstanding $\mathtt{b}$ obligation through the grammar's nesting, whereas a finite automaton has only finitely many states and cannot count $n$ without bound (the pumping-lemma obstruction).
