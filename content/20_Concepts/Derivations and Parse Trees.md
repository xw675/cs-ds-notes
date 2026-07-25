---
unit: FIT2014
domain: D
week: 5
parent: "[[Context-Free Grammars (CFG)]]"
tags: [Math/Theory, CS/Computation, CS/Languages]
aliases: [derivation, parse tree, leftmost derivation, rightmost derivation, derivation step, prefix property, syntax tree]
---
# [[Derivations and Parse Trees]]

**Context:** [[FIT2014_MOC]] · *how* a [[Context-Free Grammars (CFG)|CFG]] produces a string — the step-by-step rewrite and its tree · the bridge to the [[Pushdown Automata (PDA)|PDA]] construction

> [!abstract] Quick Revision
> - **🎯 Objective:** a **derivation** applies production rules one at a time, $S\Rightarrow\cdots\Rightarrow w$; a **parse tree** records the *structure* of that derivation, hiding the order.
> - **⚡ Key Constraint:** many derivations share **one** parse tree — the tree captures structure (and hence meaning); the order of rewrites is what distinguishes **leftmost** vs **rightmost**.

## 📝 Derivations
- **A derivation** ➔ a sequence $S\Rightarrow\alpha_1\Rightarrow\alpha_2\Rightarrow\cdots\Rightarrow w$ where each $\Rightarrow$ replaces **one nonterminal** using a production, ending at a **terminal string** $w$.
- **Example** (grammar $S\to \mathtt{a}S\mid S\mathtt{a}\mid\varepsilon$, deriving $\mathtt{aaaa}$):
$$S\Rightarrow S\mathtt{a}\Rightarrow \mathtt{a}S\mathtt{a}\Rightarrow \mathtt{aa}S\mathtt{aa}\Rightarrow \mathtt{aa}\varepsilon\mathtt{aa}=\mathtt{aaaa}$$

## 🌳 Parse trees
- **Structure, not order** ➔ the **root** is $S$; each internal node is a nonterminal whose children are the symbols on the **right side** of the rule applied to it; the **leaves read left-to-right** spell $w$.
- **Why they matter** ➔ the tree encodes **grouping/precedence** — e.g. for arithmetic it shows that $*$ binds tighter than $+$.

## ↔️ Leftmost vs rightmost
- **Leftmost derivation** ➔ always rewrite the **leftmost** nonterminal first.
- **Rightmost derivation** ➔ always rewrite the **rightmost** nonterminal first.
- **Same tree, different sequence** ➔ for `4 + 2*3` with a precedence grammar, the leftmost and rightmost derivations differ step-by-step but yield the **same parse tree** (and the same grouping $4+(2*3)$):

| | Leftmost | Rightmost |
| :--- | :--- | :--- |
| rewrite order | leftmost nonterminal each step | rightmost nonterminal each step |
| step 1 | $S\Rightarrow E\Rightarrow T+E$ | $S\Rightarrow E\Rightarrow T+E$ |
| middle | expands $T\ (=4)$ before $E$ | expands $E\ (=2*3)$ before $T$ |
| result | $4+2*3$ | $4+2*3$ |

- **Theorem** ➔ *whenever a string has a derivation, it has a **leftmost** derivation of the **same length**.* (Proof: reorder rule applications; the tree is unchanged.)

## 🔑 The prefix property (of leftmost derivations)
- **Observation** ➔ at any stage of **any** derivation, the string **to the left of the first nonterminal is a prefix of the final derived string**.
- **Leftmost sharpening** ➔ when a leftmost derivation applies a rule $X\to(\text{terminals})(\text{nonterminal})(\text{rest})$, those leading terminals are **appended to the confirmed prefix**, growing it.
- **Why it is the key idea** ➔ this "grow a correct prefix, defer the rest" behaviour is exactly what the [[Pushdown Automata (PDA)|PDA]] simulates — confirmed terminals are read off the input, the deferred suffix (including nonterminals) lives on the **stack**.

## ⚠️ Common Mistakes
- 💡 **Derivation ≠ parse tree** ➔ a string can have many derivations (leftmost, rightmost, and mixtures) but they may all share **one** parse tree; the tree is the canonical object.
- 💡 **$\Rightarrow$ is one step; $\Rightarrow^{*}$ is many** ➔ a single $\Rightarrow$ rewrites exactly one nonterminal.
- 💡 **Leftmost/rightmost is about *order*, not *result*** ➔ both derive the same string via the same tree; they differ only in which nonterminal is expanded next.
- 💡 **Ambiguity is a separate issue** ➔ a grammar is *ambiguous* if some string has **two different parse trees** — distinct from having two derivations of the same tree.

## 🧠 Active Recall
> [!FAQ]- A string has both a leftmost and a rightmost derivation. What do they share and how do they differ?
> > [!SUCCESS]- Answer
> > - **Short answer:** they produce the **same string** via the **same parse tree** (same grouping), and — by the theorem — have the **same length**. They differ only in the **order** nonterminals are expanded: leftmost always takes the left-most nonterminal, rightmost the right-most.
> > - **Why:** **The tree fixes the rules, the order is free** ➔ a parse tree determines exactly which productions are used and how they nest; traversing it left-to-right gives the leftmost derivation, right-to-left the rightmost, so both are just linearisations of one structure.

> [!FAQ]- Why is the "prefix property" of leftmost derivations the crucial idea for simulating a CFG with a machine?
> > [!SUCCESS]- Answer
> > - **Short answer:** in a leftmost derivation the material **left of the first nonterminal is always a confirmed prefix** of the target string, so a machine can **read that prefix off the input** and keep only the **unresolved suffix** (terminals not yet matched plus nonterminals) on a **stack**.
> > - **Why:** **Grow-prefix / stack-the-rest** ➔ this is precisely the [[Pushdown Automata (PDA)|PDA]] simulation of a grammar: expand the top nonterminal on the stack by a production, and pop-match terminals against the input as they surface — the leftmost strategy guarantees the input is consumed in order.
