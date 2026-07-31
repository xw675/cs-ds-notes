---
unit: FIT2014
week: 9
source: [lecture]
domain: D
parent: "[[Recursively Enumerable Languages]]"
tags: [Math/Theory, CS/Computation]
aliases: [enumerator, dovetailing, enumerated language, computably enumerable]
---
# [[Enumerators and Dovetailing]]

**Context:** [[FIT2014_MOC]] · the **generative** characterisation of [[Recursively Enumerable Languages|r.e.]] — a machine that *prints* a language instead of *testing* it — and the reason the class is called "recursively **enumerable**" at all

> [!abstract] Quick Revision
> - **🎯 Objective:** $L$ is **r.e.** $\iff$ $L$ is **enumerated by some enumerator** ➔ recogniser $\to$ enumerator by **dovetailing**, enumerator $\to$ recogniser by **scan-and-compare**.
> - **⚠️ Key Constraint:** naive "simulate all inputs in parallel" is **not a machine** — infinitely many simulations, finite time. The $k$-then-$i$ nested schedule is the whole content of the $(\Rightarrow)$ direction.

## 📝 Core
> [!IMPORTANT] An **enumerator** is a Turing machine that **outputs a sequence of strings**. $L$ is **enumerated by** $M$ iff $L=\{\text{all strings in the sequence }M\text{ outputs}\}$.

- **It never accepts or rejects** ➔ an enumerator has **no verdict states** in play; it just keeps emitting. If the sequence is infinite it **never halts**, and that is not a defect.
- **Finite languages** ➔ the enumerator **may** stop once it has finished printing; **the state it stops in is irrelevant** — nothing is being decided.
- **Order and repetition are free** ➔ members may appear in **any order**, and **repeats are allowed**. Only the *set* of emitted strings is specified, so "enumerable" carries no sorting or de-duplication obligation.
- **Contrast with a recogniser** ➔ a recogniser is asked *"is this $x$ in $L$?"*; an enumerator is asked *"name the members"*. The theorem below says these are the **same power**.

## 🧮 Proof Blueprint — enumerable $\iff$ r.e.
> [!IMPORTANT] **Theorem.** A language is recursively enumerable **if and only if** it is enumerated by some enumerator.

**Strategy** ➔ $(\Leftarrow)$ turn printing into testing by comparing against each printed string; $(\Rightarrow)$ turn testing into printing by **dovetailing** all inputs so no computation starves.

> [!SUCCESS]- Derivation — ($\Leftarrow$) enumerator $\Rightarrow$ r.e.
> Let $M$ enumerate $L$. Build $M'$:
> $$
> \begin{aligned}
> &\textbf{Input } x.\ \text{Simulate } M;\ \text{for each string } y \text{ it generates:}\\
> &\qquad \text{if } x=y \Rightarrow \textbf{Accept};\quad\text{otherwise continue.}
> \end{aligned}
> $$
> $M'$ accepts $x$ iff $x$ appears in $M$'s output iff $x\in L$, so $\text{Accept}(M')=L$ and $L$ is r.e. $\blacksquare$
> - **Note what happens for $x\notin L$** ➔ $M'$ **loops forever**, which the r.e. definition permits. This direction cannot give a decider, and that is exactly the gap between r.e. and decidable.

> [!SUCCESS]- Derivation — ($\Rightarrow$) r.e. $\Rightarrow$ enumerator
> Let $\text{Accept}(M)=L$ and list $\Sigma^{*}$ in shortlex order $x_{1},x_{2},x_{3},\dots$ $\;(\varepsilon,\mathtt{a},\mathtt{b},\mathtt{aa},\mathtt{ab},\mathtt{ba},\mathtt{bb},\mathtt{aaa},\dots)$.
> **The hazard:** simulating $M$ on *all* $x_{i}$ "in parallel" is infinitely many computations in finite time — not implementable. **The fix is the schedule:**
> $$
> \begin{aligned}
> &\textbf{for } k = 1,2,3,\dots\\
> &\quad \textbf{for } i = 1,\dots,k:\\
> &\qquad \text{simulate the NEXT step of } M \text{ on } x_{i}\quad\text{(if that run has not already stopped)}\\
> &\qquad \text{if it makes } M \textbf{ accept} \Rightarrow \text{output } x_{i},\ \text{skip } i \text{ forever after}\\
> &\qquad \text{if it makes } M \textbf{ reject} \Rightarrow \text{output nothing},\ \text{skip } i \text{ forever after}
> \end{aligned}
> $$
> - **Each round is finite** ➔ round $k$ performs exactly $k$ (or fewer) simulation steps, so a TM implements it.
> - **Nothing starves** ➔ if $M$ accepts $x_{i}$ after $n$ steps, that acceptance occurs by round $k=\max(i,n)$, so $x_{i}$ **is eventually printed**.
> - **Nothing spurious** ➔ only accepted strings are printed, so the emitted set is exactly $L$. $\blacksquare$
> - **Key move:** **bound the work per round, then let the bound grow.** A looping run on some $x_{j}$ consumes one step per round and can never block the others.

## ⚠️ Common Mistakes
- 💡 **Running $M$ on $x_{1}$ to completion first** ➔ if $x_{1}\notin L$ and $M$ loops on it, the enumerator prints nothing ever. **Depth-first is fatal; dovetailing is the point.**
- 💡 **Demanding sorted or duplicate-free output** ➔ neither is required, and imposing sorted order would be strictly stronger (that stronger version characterises *decidable* infinite languages, not r.e.).
- 💡 **"It never halts, so it's broken"** ➔ non-termination is the **normal** behaviour for an infinite language. An enumerator is judged by its output stream, not its final state.
- 💡 **Treating the enumerator as a decider** ➔ seeing $x$ printed proves $x\in L$; **not** seeing it printed yet proves nothing, because you cannot know whether it is still coming.

## 🧠 Active Recall
> [!FAQ]- Why must the $(\Rightarrow)$ construction dovetail, rather than simply "simulate all inputs in parallel"?
> > [!SUCCESS]- Answer
> > - **Short answer:** a Turing machine performs **one step at a time**, so "in parallel" over an **infinite** input list is not a computation. The $k$-then-$i$ schedule keeps every round **finite** ($\le k$ steps) while giving each $x_{i}$ unboundedly many steps as $k$ grows.
> > - **Why:** **Finite work per round, unbounded work in the limit** ➔ acceptance of $x_{i}$ after $n$ steps surfaces by round $\max(i,n)$, so every member is printed in finite time; meanwhile a non-halting run on some $x_{j}$ costs only one step per round and **cannot block** the rest. This is the same anti-starvation trick as the interleaved decider in [[Recursively Enumerable Languages]].

> [!FAQ]- Enumerators explain why r.e. languages are sometimes called "computable". Why is that name dangerous?
> > [!SUCCESS]- Answer
> > - **Short answer:** it is defensible — a machine **computes** (generates) every member — but **"computable" is also used for decidable**, and the two classes are provably different ($\text{HALT}$ is r.e., not decidable).
> > - **Why:** **Generating all members $\neq$ answering all membership questions** ➔ the enumerator confirms $x\in L$ by eventually printing $x$, but supplies **no finite signal** for $x\notin L$. Write **r.e.**/**Turing recognisable** for this class and **decidable**/**recursive** for the other; the ambiguity is a mark-loss vector, not a stylistic choice.
