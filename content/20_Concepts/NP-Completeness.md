---
unit: FIT2014
week: 11
source: [lecture]
domain: D
parent: "[[Verifiers, Certificates and the Class NP]]"
tags: [Math/Theory, CS/Computation]
aliases: [NP-complete, NPC, Cook-Levin Theorem statement, co-NP, NP-hard]
---
# [[NP-Completeness]]

**Context:** [[FIT2014_MOC]] · the **hardest** languages in $\mathrm{NP}$ — [[Polynomial-Time Reductions|$\le_{P}$]] finally used to name a *summit* rather than compare two problems, collapsing the whole $\mathrm{P}$-vs-$\mathrm{NP}$ question onto any single one of them

> [!abstract] Quick Revision
> - **🎯 Objective:** $L$ is **NP-complete** iff **(a)** $L\in\mathrm{NP}$ **and (b)** $\forall K\in\mathrm{NP}:K\le_{P}L$ ➔ so a polynomial-time decider for **one** NP-complete language would give one for **every** language in $\mathrm{NP}$.
> - **📦 Core Components:** condition **(a)** membership ➔ a verifier | condition **(b)** hardness ➔ universal reducibility | the **master theorem** ➔ $L$ has a poly decider $\iff\mathrm{P}=\mathrm{NP}$.
> - **⚡ Key Constraint:** **(b) alone is not NP-completeness.** A language everything reduces to but which sits *outside* $\mathrm{NP}$ (e.g. an undecidable one) is **NP-hard, not NP-complete** — both conditions are marked separately.

## 📝 How It Works
### 1. The definition, and the two ways to fail it
> [!IMPORTANT] **Definition.** A language $L$ is **NP-complete** if **(a)** $L\in\mathrm{NP}$, and **(b)** every language in $\mathrm{NP}$ is polynomial-time reducible to $L$: $\;\forall K\in\mathrm{NP}:K\le_{P}L$.

- **(a) fails** ➔ $L$ lies outside $\mathrm{NP}$. It does **not matter** that everything in $\mathrm{NP}$ reduces to it — such an $L$ is only **NP-hard**, and cannot be the summit *of* $\mathrm{NP}$ because it is not in the set.
- **(b) fails** ➔ $L\in\mathrm{NP}$ but some $K\in\mathrm{NP}$ has $K\not\le_{P}L$. $L$ is then a member, not a maximum — every language in $\mathrm{P}$ is like this (given $\mathrm{P}\neq\mathrm{NP}$).
- **Quantifier discipline** ➔ (b) ranges over **all** of $\mathrm{NP}$, an infinite set. That is why establishing the *first* NP-complete language ([[Cook-Levin Theorem]]) is hard and every one after it is [[Proving NP-Completeness by Reduction|one reduction away]].

### 2. Why one language decides the whole question
- **The collapse** ➔ condition (b) makes $L$ a **universal solver**: an efficient algorithm for $L$ is, via the reduction, an efficient algorithm for everything in $\mathrm{NP}$.
- **Consequence for practice** ➔ proving your problem NP-complete is proving it **at least as hard as SATISFIABILITY, HAMILTONIAN CIRCUIT, and 3-COLOURABILITY simultaneously** — which is why nobody expects you to then find a fast exact algorithm.
- **What it does not settle** ➔ NP-completeness is a statement about $L$'s **position**, not its difficulty in absolute terms. Whether that position is inside $\mathrm{P}$ is the open question itself.

### 3. The landscape — two possible worlds
| Region | If $\mathrm{P}\neq\mathrm{NP}$ | If $\mathrm{P}=\mathrm{NP}$ |
| :--- | :--- | :--- |
| **In $\mathrm{P}$** | 2-SAT, EULERIAN CIRCUIT, 2-COLOURABILITY, CONNECTED GRAPHS, SHORTEST PATH, PRIMES, invertible matrices, **all regular and all context-free languages** | everything below, merged |
| **NP-complete** | SATISFIABILITY, 3-SAT, HAMILTONIAN CIRCUIT, 3-COLOURABILITY, VERTEX COVER, INDEPENDENT SET | the whole picture is **one blob** — $\mathrm{P}=\mathrm{NP}=\mathrm{NPC}$ |
| **In $\mathrm{NP}$, in neither** | GRAPH ISOMORPHISM, INTEGER FACTORISATION — not known in $\mathrm{P}$, not known NP-complete | region vanishes |

- **Instance stock** ➔ the named problems and their certificates are catalogued in [[Standard NP Problems and Certificates]]; this table only places them.
- **The $\mathrm{P}=\mathrm{NP}$ picture is degenerate** ➔ under $\mathrm{P}=\mathrm{NP}$ the three regions cannot be distinguished, which is itself the revision exercise the slides pose *(see Active Recall)*.

### 4. co-NP and the remaining open questions
- **co-NP** ➔ the complements of $\mathrm{NP}$ languages; **co-NPC** the complements of the NP-complete ones. $\mathrm{P}$ sits inside $\mathrm{NP}\cap\text{co-}\mathrm{NP}$.
- **Second open question** ➔ **does $\mathrm{P}=\mathrm{NP}\cap\text{co-}\mathrm{NP}$?** Open, and the lecture's remark is that *in practice there does not seem to be much difference*.
- **Standing assumption for the picture** ➔ the two-lobe diagram is drawn under $\mathrm{P}\neq\mathrm{NP}$ **and** $\mathrm{NP}\neq\text{co-}\mathrm{NP}$; neither is proved.

### 5. Living with NP-completeness
> [!WARNING] Proving a language NP-complete **does not make it go away** — you may still need to ship an algorithm for it. NP-completeness is *evidence* that no single algorithm is **efficient, deterministic, all-cases, and exact** at once. So drop exactly one of the four:

| Drop | What you build | What you give up |
| :--- | :--- | :--- |
| efficient | exponential-time exact algorithm | speed |
| deterministic | randomised algorithm | a guaranteed run |
| all cases | algorithm for a special case | generality |
| exact | approximation algorithm | optimality |

- **Not a fifth option** ➔ the slides raise quantum computers only as a *maybe in future*, not as a known escape.

## 🧮 Proof Blueprint — the master theorem
> [!IMPORTANT] **Theorem.** Let $L$ be any NP-complete language. There is a polynomial-time **decider** for $L$ **if and only if** $\mathrm{P}=\mathrm{NP}$.

**Strategy** ➔ *each direction uses exactly one half of the definition — ($\Leftarrow$) uses membership (a), ($\Rightarrow$) uses hardness (b) plus the [[Polynomial-Time Reductions|$\le_P$ transfer theorem]]. Naming which half you are spending is the marked move.*

> [!SUCCESS]- Derivation — ($\Leftarrow$) assume $\mathrm{P}=\mathrm{NP}$
> $$
> \begin{aligned}
> \mathrm{P}=\mathrm{NP} &\Longrightarrow \text{every } K\in\mathrm{NP}\text{ has a polynomial-time decider}\\
> L\text{ NP-complete} &\Longrightarrow L\in\mathrm{NP} &&\text{(condition (a))}\\
> &\Longrightarrow L\text{ has a polynomial-time decider.}\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** condition **(a)** is doing all the work — without it $L$ need not be in $\mathrm{NP}$ at all and the hypothesis says nothing about it.

> [!SUCCESS]- Derivation — ($\Rightarrow$) assume $L\in\mathrm{P}$
> $\mathrm{P}\subseteq\mathrm{NP}$ is already known, so it suffices to show $\mathrm{NP}\subseteq\mathrm{P}$. Let $K\in\mathrm{NP}$ be arbitrary.
> $$
> \begin{aligned}
> L\text{ NP-complete} &\Longrightarrow K\le_{P}L &&\text{(condition (b), applied to this }K)\\
> K\le_{P}L\ \wedge\ L\in\mathrm{P} &\Longrightarrow K\in\mathrm{P} &&\text{(transfer theorem, Lecture 26)}\\
> K\text{ arbitrary} &\Longrightarrow \mathrm{NP}\subseteq\mathrm{P}\ \Longrightarrow\ \mathrm{P}=\mathrm{NP}.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** $K$ must be introduced as **arbitrary** before (b) fires — that is what upgrades one reduction into the set inclusion $\mathrm{NP}\subseteq\mathrm{P}$.

> [!QUESTION]- Slide 12 exercises: two characterisations of $\mathrm{NP}$ and of NP-completeness via a fixed NP-complete $L$.
> > [!SUCCESS]- Worked answers
> > **Theorem 1.** For NP-complete $L$ and any $K$: $\;K\in\mathrm{NP}\iff K\le_{P}L$.
> > - ($\Rightarrow$) is condition **(b)** of $L$'s NP-completeness, applied to $K$.
> > - ($\Leftarrow$) is the closure exercise from [[Polynomial-Time Reductions]]: $K\le_{P}L$ and $L\in\mathrm{NP}$ give $K\in\mathrm{NP}$ — run $L$'s verifier on $f(x)$ and pass the certificate through.
> >
> > **Theorem 2.** For NP-complete $L$ and any $K$: $\;K$ is NP-complete $\iff K\le_{P}L$ **and** $L\le_{P}K$.
> > - ($\Rightarrow$) $K\le_{P}L$ by $L$'s condition (b); $L\le_{P}K$ by $K$'s condition (b) — each language's hardness clause supplies one direction.
> > - ($\Leftarrow$) $K\le_{P}L$ with $L\in\mathrm{NP}$ gives $K\in\mathrm{NP}$ (condition (a)); $L\le_{P}K$ with $L$ NP-complete gives condition (b) by [[Proving NP-Completeness by Reduction|the inheritance theorem]].
> > - **Key move:** NP-complete languages are exactly the $\le_{P}$-**equivalence class** at the top of $\mathrm{NP}$ — mutual reducibility, not a one-way bound.

## ⚠️ Common Mistakes
- 💡 **Proving only hardness** ➔ (b) without (a) is **NP-hard**. The HALTING PROBLEM is NP-hard and undecidable; calling it NP-complete is a straight error.
- 💡 **Reducing in the wrong direction** ➔ NP-completeness of $L$ needs $K\le_{P}L$ for *arbitrary* $K\in\mathrm{NP}$ — reducing $L$ to a known-hard problem shows $L$ is **easy** enough, which is the opposite claim.
- 💡 **Saying "NP-complete means no algorithm exists"** ➔ every NP-complete language is **decidable** (it is in $\mathrm{NP}\subseteq\mathrm{EXP}$). What is doubted is a *polynomial-time* algorithm, and even that is conditional on $\mathrm{P}\neq\mathrm{NP}$.
- 💡 **Writing "NP" for "not polynomial"** ➔ $\mathrm{NP}$ is **nondeterministic polynomial**; $\mathrm{P}\subseteq\mathrm{NP}$, so every easy language is in $\mathrm{NP}$ too.
- 💡 **Treating the two-lobe diagram as fact** ➔ it depicts the *conjectured* world $\mathrm{P}\neq\mathrm{NP}$. State the assumption when you draw it.

## 🧠 Active Recall
> [!FAQ]- If $\mathrm{P}=\mathrm{NP}$ turned out to be true, which languages would be NP-complete?
> > [!SUCCESS]- Answer
> > - **Short answer:** every language in $\mathrm{NP}$ **except $\emptyset$ and $\Sigma^{*}$**.
> > - **Why:** **the definition survives but stops discriminating** ➔ under $\mathrm{P}=\mathrm{NP}$ every $K\in\mathrm{NP}$ is in $\mathrm{P}$, and a language in $\mathrm{P}$ reduces to any $L$ with at least one Yes-instance and one No-instance — decide $x$ outright, then output a fixed member or non-member of $L$. The two trivial languages are excluded exactly as in [[Polynomial-Time Reductions]], because a constant-valued $f$ needs both targets to exist.
> > - **Reading:** the three-region picture collapses to one blob, so "NP-complete" would carry no information about difficulty.

> [!FAQ]- Your problem is proved NP-complete the week before shipping. What actually changes about your engineering plan?
> > [!SUCCESS]- Answer
> > - **Short answer:** you stop searching for the fast exact algorithm and **choose which of the four properties to abandon** — efficient, deterministic, all-cases, exact.
> > - **Why:** **NP-completeness is evidence, not a prohibition** ➔ it says the target algorithm would also solve SAT, and no such algorithm is known. The problem still needs solving, so you ship an exponential exact solver, a randomised solver, a special-case solver, or an approximation — and you can also route the instance through a **SAT solver**, since your problem is $\le_{P}\text{SAT}$ by definition *(see [[Reducing to SATISFIABILITY]])*.

> [!FAQ]- Why is establishing the *first* NP-complete language qualitatively harder than the hundredth?
> > [!SUCCESS]- Answer
> > - **Short answer:** condition (b) quantifies over **all** of $\mathrm{NP}$, so with no NP-complete language in hand there is nothing to reduce *from* and the argument must be generic over machines.
> > - **Why:** **the [[Cook-Levin Theorem]] pays that cost once** ➔ it reduces an arbitrary polynomial-time verifier's computation to a CNF formula. Afterwards [[Proving NP-Completeness by Reduction|transitivity of $\le_{P}$]] means a single reduction from a known NP-complete language suffices — Karp's 1972 move.
