---
unit: FIT2014
week: 8
source: [lecture]
domain: D
parent: "[[Turing Machines]]"
tags: [Math/Theory, CS/Computation]
aliases: [decidable, recursive, solvable, decider, decision problem, YES-input]
---
# [[Decidability and Decision Problems]]

**Context:** [[FIT2014_MOC]] · the class of languages a [[Turing Machines|Turing machine]] settles **with a guaranteed halt** · sits one tier above [[Regular Grammars and the CFL Hierarchy|regular ⊊ context-free]] and is the launchpad for reductions ([[Mapping Reductions]])

> [!abstract] Quick Revision
> - **🎯 Objective:** a **decider** halts on every input ➔ $L$ is **decidable** iff $L=\text{Accept}(M)$ for some decider $M$; a Yes/No problem is decidable iff its YES-input language is.
> - **⚠️ Key Constraint:** decidable ≠ merely accepted. Acceptance tolerates $\text{Loop}(M)\neq\emptyset$; **decidable demands $\text{Loop}(M)=\emptyset$** — halting on the No-instances is the entire content of the word.

## 📝 Core
- **Decider** ➔ a TM that **halts for every input**, so $\Sigma^{*}$ splits into exactly two parts, $\text{Accept}(M)$ and $\text{Reject}(M)$, with $\text{Loop}(M)=\emptyset$ (partition from [[Turing Machines]]).
- **Decidable language** ➔ $L$ is decidable iff $L=\text{Accept}(M)$ for some **decider** $M$ — in which case $\overline{L}=\text{Reject}(M)$ **for free**: one machine settles both sides.
- **Synonyms** ➔ **decidable $=$ recursive $=$ solvable**, and often **computable** — but "computable" has carried other meanings too, so *decidable* is the safe word in an answer.
- **Decision problem** ➔ a problem where, for each input, the answer is **Yes** or **No**. A decider **solves** it iff it **Accepts** every Yes-input and **Rejects** every No-input.
- **Known decidable** ➔ every regular language, every context-free language, and $\{\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n} : n\ge 0\}$ (built in [[Building Turing Machines]]) — the last is **not** context-free, so this tier strictly exceeds the CFLs.

## 🔁 Problem ⟷ language
- **Problem $\to$ language** ➔ collect the YES-instances: $L := \{\text{YES-inputs}\}$, each encoded as a string.
- **Language $\to$ problem** ➔ *Input:* a string $x$ (usually representing some object). *Question:* is $x\in L$?
- **The bridge** ➔ a decider solves a decision problem **iff** it is a decider for the corresponding language ⟹ "decidable problem" and "decidable language" are one statement in two vocabularies, and either may be quoted in a proof.
- **Encoding $\langle\cdot\rangle$** ➔ a TM's input and output are **always strings**, so an object $O$ enters as $\langle O\rangle$ and a tuple as $\langle O_{1},\dots,O_{n}\rangle$ — this is the device that lets a graph, an automaton or a grammar *be* an input at all (see [[Encoding Turing Machines (Code Words)]] for a concrete encoding).

## 🗺️ Where decidable sits
$$\text{regular}\ \subsetneq\ \text{context-free}\ \subsetneq\ \text{decidable}\ \subsetneq\ \boxed{?}$$
- **Every containment is proper** ➔ HALF-AND-HALF separates regular from context-free ([[Proving a Language Non-Regular]]); $\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$ separates context-free from decidable ([[Proving a Language Non-Context-Free]]).
- **The outer ring is left unlabelled in the lecture** ➔ that *something* lives outside is already forced by counting — TM code words are countable, languages are not ([[Countability and Cantor Diagonalisation]]) — but naming an explicit inhabitant is the undecidability material still to come.

## 🧮 Proof Blueprint — closure of the decidable languages
> [!IMPORTANT] **Theorem.** If $L$ is decidable then so is $\overline{L}$. If $L_{1}$ and $L_{2}$ are decidable then so are $L_{1}\cup L_{2}$, $L_{1}\cap L_{2}$, and $L_{1}L_{2}$.

**Strategy** ➔ build a **new decider that runs the old ones as subroutines**. Every subroutine call is guaranteed to return, so the composite halts — *this guaranteed return is the only property being spent, and it is exactly what "decider" buys.*

> [!SUCCESS]- Derivation *(the lecture states these and sets "formulate and prove more" as an exercise)*
> Let $M_{1},M_{2}$ decide $L_{1},L_{2}$.
> $$
> \begin{aligned}
> \overline{L_{1}} &: \text{run } M_{1} \text{ on } x,\ \textbf{swap} \text{ its answer} &&\text{halts since } M_{1} \text{ halts}\\
> L_{1}\cup L_{2} &: \text{run } M_{1}, \text{ then } M_{2};\ \text{Accept iff \textbf{either} accepted} &&\text{two halting runs}\\
> L_{1}\cap L_{2} &: \text{same, Accept iff \textbf{both} accepted} &&\text{two halting runs}\\
> L_{1}L_{2} &: \text{for each of the } |x|+1 \text{ splits } x=uv,\ \text{run } M_{1}(u), M_{2}(v) &&\text{finitely many halting runs}
> \end{aligned}
> $$
> Each construction is a finite mechanical procedure, hence itself a TM by the [[Computable Functions and the Church-Turing Thesis|Church–Turing thesis]]. $\blacksquare$
> - **Key move:** the concatenation case is the only one needing search — bound the search **first** ($|x|+1$ splits), because an unbounded search would destroy the halting guarantee.

## ⚠️ Common Mistakes
- 💡 **"It accepts $L$" is weaker than "it decides $L$"** ➔ a machine may accept exactly $L$ yet **loop forever** on some non-member. Only $\text{Loop}(M)=\emptyset$ earns the word *decidable*.
- 💡 **Complement is free only for deciders** ➔ $\overline{L}=\text{Reject}(M)$ needs $M$ to halt on every input; without that, $\Sigma^{*}\setminus\text{Accept}(M)$ contains the loopers and no machine has been exhibited for it.
- 💡 **Don't skip $\langle\cdot\rangle$** ➔ writing $\text{FA-Empty}:=\{A : \dots\}$ instead of $\{\langle A\rangle : \dots\}$ loses the point that the *object* must be serialised before a TM can touch it.
- 💡 **Yes/No, not output** ➔ a decision problem returns a verdict, never a constructed object; "find the shortest path" is not a decision problem, "is there a path?" is.

## 🧠 Active Recall
> [!FAQ]- Why is decidability defined through a machine that halts, rather than simply through a machine that accepts exactly the right strings?
> > [!SUCCESS]- Answer
> > - **Short answer:** because a Yes/No **problem** demands an answer on the No-instances too. A machine that accepts exactly $L$ but loops on some $x\notin L$ never delivers "No" — you can wait forever without learning anything, so nothing has been *solved*.
> > - **Why:** **Halting is what makes the answer usable** ➔ with $\text{Loop}(M)=\emptyset$ the three-way partition of [[Turing Machines]] collapses to two, giving $\overline{L}=\text{Reject}(M)$ and making the decidable class **closed under complement** — the property every closure and reduction argument then spends.

> [!FAQ]- A decision problem and a language are different kinds of object. What exactly is the correspondence, and why is it needed?
> > [!SUCCESS]- Answer
> > - **Short answer:** a problem becomes the language of its **YES-inputs**; a language becomes the problem "is $x$ in it?". A decider solves the problem **iff** it decides that language, so the two notions are interchangeable in any proof.
> > - **Why:** **A TM only reads strings** ➔ graphs, automata and grammars must arrive as $\langle O\rangle$, and once every problem is a set of strings the whole apparatus built for languages — closure properties, [[Mapping Reductions|reductions]], the [[Regular Grammars and the CFL Hierarchy|containment hierarchy]] — applies to problems unchanged.
