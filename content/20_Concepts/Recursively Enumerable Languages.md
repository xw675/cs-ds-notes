---
unit: FIT2014
week: 9
source: [lecture]
domain: D
parent: "[[Decidability and Decision Problems]]"
tags: [Math/Theory, CS/Computation]
aliases: [r.e., recursively enumerable, computably enumerable, Turing recognisable, partially decidable, type 0, co-r.e.]
---
# [[Recursively Enumerable Languages]]

**Context:** [[FIT2014_MOC]] · the class **one tier above decidable** — accept the members, but you are allowed to loop forever on the non-members · the home of $\text{HALT}$ ([[Undecidability and the Halting Problem]]) and the setting in which "undecidable" finally splits into two different kinds of bad

> [!abstract] Quick Revision
> - **🎯 Objective:** $L$ is **r.e.** iff $\exists$ TM $T$ with $\text{Accept}(T)=L$ ➔ **only the accepting side is constrained**; $\overline{L}$ may be split arbitrarily between $\text{Reject}(T)$ and $\text{Loop}(T)$.
> - **📦 Core Components:** decidable ➔ $\text{Loop}(T)=\emptyset$ | r.e. ➔ $\text{Loop}(T)$ unrestricted | **decidable $\iff$ $L$ and $\overline{L}$ both r.e.** ➔ the bridge theorem.
> - **⚠️ Key Constraint:** r.e. is **not closed under complement**. $\text{HALT}$ is r.e., $\overline{\text{HALT}}$ is **not even r.e.** — asserting closure here is the fastest way to lose the proof.

## 📝 How It Works

### 1. Definition and the contrast with decidable
> [!IMPORTANT] $L$ is **recursively enumerable** iff there is a TM $T$ with $\text{Accept}(T)=L$. Strings outside $L$ may be **rejected or may loop forever**.

| Class | $\text{Accept}(T)$ | $\text{Reject}(T)$ | $\text{Loop}(T)$ | Guarantee you get |
| :--- | :--- | :--- | :--- | :--- |
| **decidable** | $L$ | $\overline{L}$ | $\emptyset$ | a **Yes or No** answer, always |
| **r.e.** | $L$ | anything $\subseteq\overline{L}$ | anything $\subseteq\overline{L}$ | a **Yes** eventually, if the answer is Yes |

- **Every decidable language is r.e.** ➔ a decider is a machine with $\text{Accept}(T)=L$ that happens also to have $\text{Loop}(T)=\emptyset$; the r.e. definition simply drops that clause.
- **Semi-decision** ➔ this is why "partially decidable" is a synonym: a Yes-answer arrives in finite time, a No-answer may never arrive **and you cannot tell which case you are in** while waiting.

### 2. Synonyms *(all name the same class — expect any of them in a question)*
$$\text{recursively enumerable (r.e.)} = \text{computably enumerable} = \text{partially decidable} = \text{Turing recognisable} = \text{type 0}$$
- **Turing recognisable** ➔ Sipser's term (the unit's reference text).
- **Type 0** ➔ the outermost level of the **Chomsky hierarchy**, above [[Context-Free Grammars (CFG)|context-free]] and [[Regular Grammars and the CFL Hierarchy|regular]].
- **⚠️ "computable"** ➔ also used for r.e. (justified by [[Enumerators and Dovetailing]]) *and* for **decidable** ([[Decidability and Decision Problems]]) — ambiguous, so never write it in an answer where the distinction is the point.

### 3. $\text{HALT}$ separates the two classes
- **The language** ➔ $\text{HALT}=\{T : T \text{ halts when its input is } T\}$, i.e. the DIAGONAL HALTING PROBLEM's YES-language; **not decidable** ([[Undecidability and the Halting Problem]]).
- **The recogniser $M$** ➔ obtained by modifying a [[Universal Turing Machine|UTM]]: on input $T$, **simulate $T$ running on $T$**; if the simulation ever stops in **any** state, Accept.
$$\text{Accept}(M)=\text{HALT},\qquad \text{Reject}(M)=\emptyset,\qquad \text{Loop}(M)=\overline{\text{HALT}}$$
- **Read-off** ➔ $\text{HALT}$ is r.e. and undecidable ⟹ **the inclusion decidable $\subsetneq$ r.e. is strict.** Simulation buys recognition; it never buys a decision, because the non-halting case is exactly the case the simulator cannot report.

## 🧮 Proof Blueprint — the bridge theorem
> [!IMPORTANT] **Theorem.** $L$ is decidable $\iff$ **both** $L$ and $\overline{L}$ are r.e.

**Strategy** ➔ $(\Rightarrow)$ quote closure of decidable under complement; $(\Leftarrow)$ **interleave** the two recognisers so that neither one's looping can stall the other.

> [!SUCCESS]- Derivation
> **($\Rightarrow$)**
> $$
> \begin{aligned}
> L \text{ decidable} &\Longrightarrow L \text{ r.e.} &&\text{(a decider is a recogniser)}\\
> L \text{ decidable} &\Longrightarrow \overline{L} \text{ decidable} &&\text{(closure under complement)}\\
> &\Longrightarrow \overline{L} \text{ r.e.} &&\blacksquare
> \end{aligned}
> $$
> **($\Leftarrow$)** Let $\text{Accept}(M_{1})=L$ and $\text{Accept}(M_{2})=\overline{L}$; **either may loop** on inputs it does not accept. Build $M'$:
> $$
> \begin{aligned}
> &\textbf{Input } x. \textbf{ Repeatedly:} &&\\
> &\quad \text{do ONE step of } M_{1} \text{ on } x;\ \text{if it accepts} \Rightarrow \textbf{Accept} &&\\
> &\quad \text{do ONE step of } M_{2} \text{ on } x;\ \text{if it accepts} \Rightarrow \textbf{Reject} &&
> \end{aligned}
> $$
> - **$M'$ halts on every $x$** ➔ every string lies in $L$ or in $\overline{L}$, hence is accepted by $M_{1}$ or by $M_{2}$ after finitely many steps; the round-robin reaches that step. So $\text{Loop}(M')=\emptyset$.
> - **$M'$ is correct** ➔ $M'$ accepts $x$ iff $M_{1}$ accepts $x$ iff $x\in L$.
> - Therefore $M'$ decides $L$. $\blacksquare$
> - **Key move:** **one step at a time, alternating.** Running $M_{1}$ to completion first would hang forever on any $x\in\overline{L}$ — the interleaving is the entire proof, not a presentational detail.

## 🚫 A non-r.e. language
> [!IMPORTANT] **Theorem.** $\overline{\text{HALT}}=\{T : T \text{ loops forever when its input is } T\}$ is **not r.e.**

$$
\begin{aligned}
\text{Suppose } \overline{\text{HALT}} \text{ is r.e.} &&\text{(for contradiction)}\\
\text{We know } \text{HALT} \text{ is r.e.} &&\text{(the modified UTM above)}\\
\Longrightarrow \text{HALT and } \overline{\text{HALT}} \text{ are both r.e.} &&\\
\Longrightarrow \text{HALT is decidable} &&\text{(bridge theorem)}\\
\Longrightarrow \Rightarrow\!\Leftarrow &&\text{(the diagonalisation proof)}
\end{aligned}
$$
- **The contradiction cited** ➔ $\text{HALT}$ is not decidable ([[Undecidability and the Halting Problem]]), so the supposition dies. $\blacksquare$
- **What it buys** ➔ the first language **outside r.e. altogether**, so "undecidable" splits: $\text{HALT}$ is undecidable-but-recognisable, $\overline{\text{HALT}}$ is not even that.
- **co-r.e.** ➔ $\{L : \overline{L} \text{ is r.e.}\}$; the bridge theorem restates as $\textbf{decidable} = \textbf{r.e.} \cap \textbf{co-r.e.}$ — the lens where the r.e. and co-r.e. rings overlap, with $\text{HALT}$ and $\overline{\text{HALT}}$ sitting symmetrically outside it.

## 🗺️ The final hierarchy
$$\text{regular}\ \subsetneq\ \text{context-free}\ \subsetneq\ \text{decidable}\ \subsetneq\ \text{r.e.}\ \subsetneq\ \{\text{all languages}\}$$

| Ring | Membership certificate | Witness that the containment is proper |
| :--- | :--- | :--- |
| regular | [[Finite Automata (DFA and NFA)\|DFA]] run | HALF-AND-HALF ([[Proving a Language Non-Regular]]) |
| context-free | [[Pushdown Automata (PDA)\|PDA]] / [[CYK Algorithm\|CYK]] | $\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$ ([[Proving a Language Non-Context-Free]]) |
| decidable | a **decider** halts either way | $\text{HALT}$ |
| r.e. | acceptance in finite time | $\overline{\text{HALT}}$ |

- **The two named inhabitants** ➔ $\text{HALT}\in\text{r.e.}\setminus\text{decidable}$ and $\overline{\text{HALT}}\in\text{co-r.e.}\setminus\text{r.e.}$ sit symmetrically about the decidable core.

## 🔭 Beyond the lecture *(stated as exercises on the slides, no proofs given)*
- **Verifier characterisation** ➔ $L$ is r.e. $\iff$ there is a **decidable two-argument predicate** $P$ with $x\in L\iff\exists y:P(x,y)$. The $y$ is a **certificate**: given it, membership is checkable; **finding** it may be hard — the shape that returns as $\mathbf{NP}$ later in the unit.
- **Reductions preserve r.e.** ➔ if $K\le_{m}L$ and $L$ is r.e., then $K$ is r.e. (run $f$, then the recogniser for $L$ — the [[Mapping Reductions|transfer theorem]] with "halts" weakened to "accepts").
- **Which W22 problems are r.e.?** ➔ the lecture leaves this open; the $\exists$-shaped ones ($\text{SOMETIMES HALTS}$, $\text{HALT FOR INPUT ZERO}$) are recognisable by dovetailed simulation, the $\forall$-shaped ones ($\text{ALWAYS HALTS}$, $\text{NEVER HALTS}$) are not.

## ⚠️ Common Mistakes
- 💡 **Assuming r.e. is closed under complement** ➔ it is closed under $\cup$, $\cap$ and concatenation but **not** complement; $\text{HALT}$ vs $\overline{\text{HALT}}$ is the standing counterexample, and the bridge theorem says closure would collapse r.e. onto decidable.
- 💡 **"Reject $=$ not accept"** ➔ for a recogniser, $\overline{\text{Accept}(T)}=\text{Reject}(T)\cup\text{Loop}(T)$. Writing $\text{Reject}(T)=\overline{L}$ silently assumes a decider and destroys the proof.
- 💡 **Running $M_{1}$ to completion before starting $M_{2}$** ➔ the interleaving is load-bearing; sequential execution hangs on precisely the inputs the second machine was there to catch.
- 💡 **Calling r.e. languages "computable" in an answer** ➔ the word is genuinely ambiguous in this literature. Write **r.e.** or **decidable** and the marker cannot dock you.
- 💡 **Confusing $\text{HALT}$ (a language) with the Halting Problem (a problem)** ➔ they are the same content in two vocabularies; be explicit which one a theorem is quantifying over.

## 🧠 Active Recall
> [!FAQ]- Why does the interleaved machine $M'$ halt on every input, when both $M_{1}$ and $M_{2}$ may loop forever?
> > [!SUCCESS]- Answer
> > - **Short answer:** because $L\cup\overline{L}=\Sigma^{*}$, **every** $x$ is accepted by one of them after some finite number of steps $n$; the round-robin schedule reaches step $n$ of that machine after $\approx 2n$ of its own steps, so $M'$ terminates.
> > - **Why:** **Only one of the two can loop on a given $x$** ➔ looping is never simultaneous, and the interleaving guarantees the *non*-looping computation is never starved. This is the same scheduling idea as the dovetailing in [[Enumerators and Dovetailing]] — finite progress on infinitely patient computations.

> [!FAQ]- $\text{HALT}$ and $\overline{\text{HALT}}$ are both undecidable, yet the lecture treats them very differently. What is the asymmetry?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\text{HALT}$ is **r.e.** — simulation gives $\text{Accept}(M)=\text{HALT}$, $\text{Loop}(M)=\overline{\text{HALT}}$ — while $\overline{\text{HALT}}$ is **not r.e. at all**, so no machine even recognises it.
> > - **Why:** **Halting is a finitely witnessable event; non-halting is not** ➔ if $T$ halts on $T$, the simulator sees it in finite time and can Accept. "$T$ runs forever" has no finite witness, so nothing can announce it. Formally, r.e. $\cap$ co-r.e. $=$ decidable, so $\overline{\text{HALT}}$ being r.e. would make $\text{HALT}$ decidable.
