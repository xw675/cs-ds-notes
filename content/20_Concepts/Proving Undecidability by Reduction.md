---
unit: FIT2014
week: 9
source: [lecture]
domain: D
parent: "[[Mapping Reductions]]"
tags: [Math/Theory, CS/Computation]
aliases: [HALT FOR INPUT ZERO, ALWAYS HALTS, SOMETIMES HALTS, NEVER HALTS, undecidability proof, Post Correspondence Problem]
---
# [[Proving Undecidability by Reduction]]

**Context:** [[FIT2014_MOC]] · the **exam hand skill** of Week 9 — take the one language known undecidable ([[Undecidability and the Halting Problem|DIAGONAL HALTING PROBLEM]]) and mass-produce more with the transfer corollary of [[Mapping Reductions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** to prove $L$ undecidable, exhibit a **computable** $M\mapsto M'$ with $M\in\text{DIAG-HALT}\iff \langle M'\rangle\in L$ ➔ $\text{DIAG-HALT}\le_{m}L$ and the corollary fires.
> - **📦 Core Components:** the **universal gadget** $M'$ = *"ignore your input; run $M$ on $M$"* ➔ settles $\text{HALT FOR INPUT ZERO}$, $\text{ALWAYS HALTS}$, $\text{SOMETIMES HALTS}$ with **one construction** | the **complement swap** ➔ settles $\text{NEVER HALTS}$.
> - **⚠️ Key Constraint:** reduce **from** the known-undecidable language **to** the new one. $L\le_{m}\text{DIAG-HALT}$ is the wrong arrow and proves **nothing**.

## 📝 How It Works

### 1. The proof skeleton (four lines, always the same)
- **Line 1 — fix the source** ➔ *"Let $M$ be any program, regarded as an input to the DIAGONAL HALTING PROBLEM."*
- **Line 2 — define the image** ➔ construct $M'$ from $M$; the definition may **mention $M$ freely** but must never run a decider for anything.
- **Line 3 — computability** ➔ *"The construction $M\mapsto M'$ is computable"* — $M'$ is assembled by textual surgery on $\langle M\rangle$, so a TM builds it and **halts** ([[Mapping Reductions|totality is mandatory]]).
- **Line 4 — the iff** ➔ *"$M$ halts on input $M$ **if and only if** $M'$ has property $\Pi$"*, then conclude $\text{DIAG-HALT}\le_{m}L_{\Pi}$, therefore $L_{\Pi}$ is undecidable.

### 2. The universal gadget
> [!IMPORTANT] $M'$: *Input:* $x$. *Body:* **run $M$ on input $M$.**

- **$x$ is discarded** ➔ $M'$ never reads its own input, so its behaviour is **the same on every input** — either it halts on all of them, or on none.
- **Consequence** ➔ *halts on $0$*, *halts on $42$*, *always halts*, and *halts for some input* all **collapse into the single event** "$M$ halts on $M$". One gadget, one iff, four theorems.
- **⚡ Key Constraint:** $M'$ is **built, not run** — the reduction outputs the *string* $\langle M'\rangle$. Nothing simulates $M$ at reduction time, which is why $f$ halts even though $M$ may not.

### 3. Reading off the family
| Target problem $L$ | Question asked of $P$ | The iff the gadget certifies | Verdict |
| :--- | :--- | :--- | :--- |
| $\text{HALT FOR INPUT ZERO}$ | halts on input $0$? | $M$ halts on $M$ $\iff$ $M'$ halts on $0$ | undecidable |
| $\text{HALT FOR INPUT 42}$ | halts on input $42$? | $M$ halts on $M$ $\iff$ $M'$ halts on $42$ | undecidable |
| $\text{ALWAYS HALTS}$ | halts on **every** input? | $M$ halts on $M$ $\iff$ $M'$ always halts | undecidable |
| $\text{SOMETIMES HALTS}$ | halts on **some** input? | $M$ halts on $M$ $\iff$ $M'$ halts for some input | undecidable |
| $\text{NEVER HALTS}$ | loops on **every** input? | complement of $\text{SOMETIMES HALTS}$ | undecidable |

- **Nothing special about $0$** ➔ the constant is a free parameter, so the gadget generates an **infinite family** of undecidable problems at zero extra cost.
- **Why $\forall$ and $\exists$ both work** ➔ because $M'$ is **input-blind**, the quantifier over inputs is vacuous — "for all $x$" and "for some $x$" agree, and both equal the single fact about $M$ on $M$.

### 4. The complement route — $\text{NEVER HALTS}$
- **Not a mapping reduction** ➔ the lecture calls it *"a more general type of reduction"*: a decider $D$ for $\text{NEVER HALTS}$ becomes a decider for $\text{SOMETIMES HALTS}$ by **swapping Accept and Reject**.
- **What it spends** ➔ exactly the closure of decidable languages under complement ([[Decidability and Decision Problems]]) — legal only because a **decider** always halts, so swapping its two halting states is well defined.
- **Chain** ➔ $\text{DIAG-HALT}\le_{m}\text{SOMETIMES HALTS}$, and $\text{NEVER HALTS}=\overline{\text{SOMETIMES HALTS}}$ decidable would make $\text{SOMETIMES HALTS}$ decidable. Contradiction.
- 💡 **Do not try the swap on a recogniser** ➔ swapping Accept/Reject on a machine with $\text{Loop}\neq\emptyset$ loses the looping inputs entirely; this is the asymmetry that makes $\overline{\text{HALT}}$ **not even r.e.** ([[Recursively Enumerable Languages]]).

## 📚 Catalogue of undecidable problems *(lecture list — quotable without proof)*
- **About one TM** ➔ does $P$ on input `"What's the answer?"` output `"42"`? · is $\text{Accept}(P)$ **regular** (is $P$ equivalent to a [[Finite Automata (DFA and NFA)|finite automaton]])?
- **About two TMs** ➔ $\forall x:\; P \text{ halts on } x \iff Q \text{ halts on } x$ (do they always both halt or both loop)?
- **About grammars** ➔ is the language of a [[Context-Free Grammars (CFG)|CFG]] **regular**? · does a CFG **fail to generate** some string over its alphabet? · do **two CFGs** define the same language? *(contrast [[Deciding Properties of FAs and CFGs]]: CFG-**Empty** IS decidable, and RegExp**Equiv** IS decidable — equivalence survives for automata, dies for grammars.)*
- **Outside computation** ➔ does a multivariate **polynomial have an integer root**? (Hilbert's tenth problem; **Matiyasevich, 1970**) · the **Post Correspondence Problem** (string matching; Sipser §5.2, Emil Post).
- **The pattern** ➔ once a **non-trivial semantic property** of a machine's language is asked, undecidability is the default; syntactic properties (state count, tape alphabet) stay decidable.

## ✍️ Practice
*(the lecture's "Decidable or Undecidable?" slide, posed without answers — write your verdict cold, then expand.)*

> [!QUESTION]- Practice 1: *Input:* TM $P$, input $x$. *Question:* does $P$ **accept** $x$?
> > [!SUCCESS]- Reference solution
> > - **Verdict:** **undecidable.**
> > - **Key move:** the gadget again — send $M\mapsto M''$ where $M''$ ignores $x$, runs $M$ on $M$, and **Accepts** if that halts. Then $M$ halts on $M$ $\iff$ $M''$ accepts (any fixed) $x$, so $\text{DIAG-HALT}\le_{m}\text{ACCEPTANCE}$.

> [!QUESTION]- Practice 2: *Input:* TM $P$, input $x$, positive integer $t$. *Question:* does $P$ halt on $x$ in $\le t$ steps?
> > [!SUCCESS]- Reference solution
> > - **Verdict:** **decidable.**
> > - **Key move:** **the bound is part of the input.** Simulate $P$ on $x$ for at most $t$ steps with a [[Universal Turing Machine|UTM]] and answer; the simulation cannot run away, so $\text{Loop}=\emptyset$. Undecidability of halting comes entirely from the **absence of a computable time bound**.

> [!QUESTION]- Practice 3: *Input:* TM $P$, positive integer $s$. *Question:* does $P$ have $\le s$ states?
> > [!SUCCESS]- Reference solution
> > - **Verdict:** **decidable.**
> > - **Key move:** this is a **syntactic** question about $\langle P\rangle$, not a semantic one about $\text{Accept}(P)$ — count the state blocks in the [[Encoding Turing Machines (Code Words)|code word]] and compare. No execution is involved, so nothing can loop.

> [!QUESTION]- Practice 4: *Input:* TM $P$, positive integer $k$. *Question:* does $P$ halt for **some** input of length $\le k$?
> > [!SUCCESS]- Reference solution
> > - **Verdict:** **undecidable.**
> > - **Key move:** finitely many candidate inputs does **not** rescue you — each individual test is still a halting question. The input-blind gadget gives $M$ halts on $M$ $\iff$ $M'$ halts on **every** input, in particular on $\varepsilon$, whose length is $\le k$ for all $k\ge 0$.

## ⚠️ Common Mistakes
- 💡 **Arrow reversed** ➔ writing $L\le_{m}\text{DIAG-HALT}$ proves only that $L$ is *no harder* than something hard — compatible with $L$ being trivially decidable. The corollary needs the **known-undecidable language as the source**.
- 💡 **Running $M$ inside the reduction** ➔ if $f$ simulates $M$ to decide what to output, $f$ is **not total** and the transfer theorem collapses. The reduction only ever **writes down** $\langle M'\rangle$.
- 💡 **Proving one implication** ➔ "$M$ halts on $M$ $\Rightarrow$ $M'$ halts on $0$" is half a reduction; the converse is what forbids a No-instance from mapping to a Yes-instance.
- 💡 **Skipping the computability line** ➔ markers award a mark for stating $M\mapsto M'$ is computable. It is one sentence and it is never free.
- 💡 **Reusing the Accept/Reject swap on r.e. sets** ➔ complementation is a property of **deciders**, not recognisers; using it on a merely-r.e. language is the single most common invalid step in this material.

## 🧠 Active Recall
> [!FAQ]- Why does the same machine $M'$ — "ignore $x$, run $M$ on $M$" — settle both $\text{ALWAYS HALTS}$ ($\forall$) and $\text{SOMETIMES HALTS}$ ($\exists$)?
> > [!SUCCESS]- Answer
> > - **Short answer:** $M'$ is **input-blind**, so its halting behaviour is a **constant function of the input** — the $\forall$ and $\exists$ quantifiers range over a set on which the predicate is constant, hence they coincide.
> > - **Why:** **Both reduce to one bit** ➔ if $M$ halts on $M$ then $M'$ halts on *every* $x$ (so it is in both $\text{ALWAYS}$ and $\text{SOMETIMES}$ $\text{HALTS}$); if not, $M'$ halts on *no* $x$ (so it is in neither). The iff chain $M\in\text{DIAG-HALT}\iff\langle M'\rangle\in L$ is therefore valid for either target with the same construction.

> [!FAQ]- "Halt in $\le t$ steps" is decidable but "halt" is undecidable. Where exactly does the difference live?
> > [!SUCCESS]- Answer
> > - **Short answer:** in **who supplies the bound**. When $t$ arrives as input, the simulation is guaranteed to terminate; when it does not, no computable function of $\langle P,x\rangle$ can supply one — such a function would decide halting.
> > - **Why:** **Decidability is about guaranteed termination, not about difficulty** ➔ the bounded version has $\text{Loop}=\emptyset$ by construction, so it is a decider. Any attempted timeout for the unbounded version must either cut off a machine that would have halted later (unsound) or run forever (not a decider) — this is also why simulation makes $\text{HALT}$ only **r.e.** ([[Recursively Enumerable Languages]]).
