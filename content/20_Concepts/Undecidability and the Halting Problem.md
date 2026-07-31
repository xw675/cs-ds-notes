---
unit: FIT2014
week: 9
source: [lecture]
domain: D
parent: "[[Decidability and Decision Problems]]"
tags: [Math/Theory, CS/Computation]
aliases: [Halting Problem, Entscheidungsproblem, undecidable, Diagonal Halting Problem, HALT, DIAGONAL HALTING PROBLEM]
---
# [[Undecidability and the Halting Problem]]

**Context:** [[FIT2014_MOC]] · names the $\boxed{?}$ ring left open by [[Decidability and Decision Problems]] — the first **explicitly undecidable** language, and the seed every later undecidability proof reduces from ([[Proving Undecidability by Reduction]])

> [!abstract] Quick Revision
> - **🎯 Objective:** $\text{HaltingProblem} := \{\langle P,x\rangle : P \text{ eventually halts when run on } x\}$ is **undecidable** ➔ assume a decider $D$, build $E$ that **does the opposite of what $D$ predicts about $E$**, read off the contradiction.
> - **📦 Core Components:** counting ➔ *some* language is undecidable | diagonalisation ➔ *this* language is undecidable | $\text{DIAGONAL HALTING PROBLEM}$ ➔ the one-argument version the proof actually kills.
> - **⚠️ Key Constraint:** undecidable ≠ unanswerable. Every individual $\langle P,x\rangle$ has a Yes/No answer; what cannot exist is **one machine that halts with the right answer on every instance**.

## 📝 How It Works

### 1. Undecidable languages exist (the counting argument)
- **Deciders are countable** ➔ $\{\text{CWL-encodings of deciders}\}\subseteq\text{CWL}\subseteq\Sigma^{*}$ ([[Encoding Turing Machines (Code Words)]]), and $\Sigma^{*}$ is countable ⟹ **at most countably many decidable languages**.
- **Languages are uncountable** ➔ Cantor diagonalisation on $\mathcal{P}(\Sigma^{*})$ ([[Countability and Cantor Diagonalisation]]).
- **Conclusion** ➔ $\aleph_{0} < 2^{\aleph_{0}}$ forces **undecidable languages to exist** — but this is a **pure existence proof**: it exhibits none, which is exactly why the Halting Problem is needed.

### 2. The problem itself
> [!IMPORTANT] **Halting Problem.** *Input:* a Turing machine $P$ and an input $x$. *Question:* if $P$ is run on $x$, does it eventually halt?

- **As a language** ➔ $\text{HaltingProblem}=\{\langle P,x\rangle : P \text{ halts on } x\}$, via the problem ⟷ language bridge of [[Decidability and Decision Problems]].
- **Halting, not accepting** ➔ the question is whether $P$ **stops in any state**; Accept and Reject both count as halting, only $\text{Loop}$ is the No-answer.
- **Historical name** ➔ Hilbert's **Entscheidungsproblem**; killed independently by **Church (1936, $\lambda$-calculus)** and **Turing (1936–37, Turing machines)**.
- **Diagonal Halting Problem** ➔ *Input:* a TM $P$. *Question:* does $P$ halt on input $P$? The **one-argument** restriction — and the version the proof below actually refutes, hence the version every reduction starts from.

### 3. Why self-application is legal
- **Programs are strings** ➔ $\langle P\rangle$ is a word over $\Sigma$ ([[Encoding Turing Machines (Code Words)]]), so it is a perfectly legal *input* to a machine — the [[Universal Turing Machine|stored-program idea]] is what makes "run $P$ on $P$" meaningful rather than a category error.
- **Proof ingredients** ➔ **contradiction** $+$ **diagonalisation** $+$ a machine version of the **Liar Paradox** ("this sentence is false").

## 🧮 Proof Blueprint — the Halting Problem is undecidable
> [!IMPORTANT] **Theorem.** The Halting Problem is undecidable. Equivalently, no decider settles $\{\langle P\rangle : P \text{ halts on } P\}$.

**Strategy** ➔ *assume the decider, use it to build a machine whose behaviour must contradict the decider's own verdict on that machine.*

> [!SUCCESS]- Derivation
> $$
> \begin{aligned}
> &\textbf{1. Assume } D \text{ decides the Halting Problem} &&\text{so } D \text{ halts on every } \langle P,x\rangle\\
> &\textbf{2. Specialise } x:=P &&D \text{ can settle "does } P \text{ halt on } P\text{?"}\\
> &\textbf{3. Build } E \text{ on input } P: \text{ ask } D \text{ about } \langle P,P\rangle &&\text{legal: } D \text{ is a total subroutine}\\
> &\qquad D \text{ says HALTS} \;\Longrightarrow\; E \text{ loops forever} &&\\
> &\qquad D \text{ says LOOPS} \;\Longrightarrow\; E \text{ halts} &&\\
> &\textbf{4. Feed } E \text{ to itself} &&\\
> &\qquad E \text{ halts on } E &\iff\ &D \text{ says } E \text{ halts on } E \iff E \text{ loops on } E\\
> &\qquad E \text{ loops on } E &\iff\ &D \text{ says } E \text{ loops on } E \iff E \text{ halts on } E
> \end{aligned}
> $$
> Both branches are self-contradictory, and every step after **1** is a legitimate construction, so the fault lies in **1**. Therefore no such $D$ exists. $\blacksquare$
> - **Key move:** $E$'s row of the behaviour table is the **flipped diagonal**, so $E$ differs from *every* machine in the list at its own index — including itself, which is the impossibility.
> - **What is actually refuted:** step **2** only ever uses $D$ on $\langle P,P\rangle$, so the proof kills the **DIAGONAL HALTING PROBLEM** first; the general Halting Problem is undecidable *a fortiori* (a decider for it would restrict to one for the diagonal version).

## 📊 Manual Execution Trace — the diagonalisation table
Rows are TMs (by code word), columns are inputs; ✓ $=$ halts, ✗ $=$ loops forever. $E$ is defined to **flip the shaded diagonal**.

| TM $\downarrow$ / input $\rightarrow$ | $\varepsilon$ | $\mathtt{a}$ | $\mathtt{b}$ | $\mathtt{aa}$ | $\dots$ |
| :--- | :---: | :---: | :---: | :---: | :---: |
| $\varepsilon$ | **✓** | ✗ | ✗ | ✓ | $\dots$ |
| $\mathtt{a}$ | ✗ | **✗** | ✓ | ✓ | $\dots$ |
| $\mathtt{b}$ | ✓ | ✓ | **✗** | ✗ | $\dots$ |
| $\mathtt{aa}$ | ✓ | ✗ | ✓ | **✓** | $\dots$ |
| $\vdots$ | | | | | $\ddots$ |
| $E$ | ✗ | ✓ | ✓ | ✗ | $\dots$ |

- **Reading the flip** ➔ $E$'s entry in column $P$ is the **negation** of the diagonal entry $(P,P)$ ⟹ $E$ disagrees with machine $P$ on input $P$, for every $P$.
- **The kill** ➔ $E$ is itself a machine, so it owns a row; at its own column it must **disagree with itself**. The table therefore cannot exist, and $D$ — which is what made $E$ constructible — cannot either.

## ⚠️ Common Mistakes
- 💡 **"Undecidable means we don't know the answer"** ➔ wrong on both counts. Each instance has a definite answer, and infinitely many are easy; undecidability denies a **uniform total algorithm**, nothing more.
- 💡 **Confusing halting with accepting** ➔ a machine that halts in Reject is a **Yes**-instance of the Halting Problem. Only $\text{Loop}(P)$ contributes No-instances.
- 💡 **"Just simulate $P$ on $x$"** ➔ simulation ([[Universal Turing Machine]]) **recognises** halting but never certifies looping — it gives $\text{Accept}(M)=\text{HALT}$ with $\text{Loop}(M)=\overline{\text{HALT}}$, i.e. r.e. but not decidable ([[Recursively Enumerable Languages]]). Timeouts do not fix it: no computable bound on running time exists.
- 💡 **Objecting that "$P$ run on $P$" is nonsense** ➔ it is not; $\langle P\rangle$ is just a string, and compilers compiling themselves is the everyday instance.
- 💡 **Claiming the counting argument proves the theorem** ➔ counting yields **existence only**. Without diagonalisation you cannot name a single undecidable language, and reductions need a *named* one to start from.

## 🧠 Active Recall
> [!FAQ]- The counting argument already shows undecidable languages exist. Why spend a whole lecture constructing the Halting Problem?
> > [!SUCCESS]- Answer
> > - **Short answer:** counting is **non-constructive** — it proves the set of undecidable languages is non-empty without producing an inhabitant, and [[Mapping Reductions|reductions]] need a **named, concrete** source language to transport undecidability from.
> > - **Why:** **Cardinality vs. exhibition** ➔ $\lvert\{\text{deciders}\}\rvert\le\lvert\Sigma^{*}\rvert=\aleph_{0}$ while $\lvert\{\text{languages}\}\rvert=2^{\aleph_{0}}$ settles existence; the Halting Problem is additionally **natural and universal**, so every later result ($\text{HALT FOR INPUT ZERO}$, $\text{ALWAYS HALTS}$, Hilbert's tenth problem) is one reduction away.

> [!FAQ]- Exactly which assumption does the contradiction refute — why can't $E$ be the faulty step?
> > [!SUCCESS]- Answer
> > - **Short answer:** $E$'s construction is **unconditionally legal given $D$** — it is a finite program that calls a total subroutine and then branches — so the only defeasible hypothesis in the chain is the existence of $D$.
> > - **Why:** **$D$ was assumed to be a decider, hence total** ➔ every call $D(\langle P,P\rangle)$ returns, so $E$ is well defined on all inputs and $E$ has a code word like any other machine. If instead $D$ were merely a *recogniser*, the branch "$D$ says LOOPS" might never fire, $E$ would simply loop, and **no contradiction arises** — which is precisely why $\text{HALT}$ is r.e. yet undecidable.
