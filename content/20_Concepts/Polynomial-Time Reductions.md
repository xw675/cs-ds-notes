---
unit: FIT2014
week: 10
source: [lecture]
domain: D
parent: "[[Mapping Reductions]]"
tags: [Math/Theory, CS/Computation]
aliases: ["<=P", Karp reduction, polynomial transformation, polynomial-time many-one reduction, polynomial-time mapping reduction]
---
# [[Polynomial-Time Reductions]]

**Context:** [[FIT2014_MOC]] · [[Mapping Reductions|$\le_m$]] with a **clock attached** — the same translator discipline, now used to transport *tractability* instead of decidability, and the tool that will define NP-completeness

> [!abstract] Quick Revision
> - **🎯 Objective:** a **polynomial-time computable** $f:\Sigma^{*}\to\Sigma^{*}$ with $x\in K\iff f(x)\in L$ for **every** $x$ ➔ written $K\le_{P}L$, read "**$K$ is no harder than $L$, up to polynomial cost**".
> - **📦 Core Components:** the **function** $f$ | the **iff chain** certifying it | the **time bound** on computing it — all three are marked, and the third is the one added since Lecture 21.
> - **⚡ Key Constraint:** every $\le_{P}$ **is** a $\le_{m}$, but **not conversely** — $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$ passes through the [[NFA to DFA (Subset Construction)|subset construction]] and is exponential. Adding the clock genuinely shrinks the relation.

## 📝 Core
> [!IMPORTANT] A **polynomial-time reduction** from $K$ to $L$ is a polynomial-time **mapping reduction**: a function $f:\Sigma^{*}\to\Sigma^{*}$, computable in time $O(n^{k})$ for fixed $k$, such that for all $x\in\Sigma^{*}$, $\;x\in K\iff f(x)\in L$. Notation: $K\le_{P}L$.

- **Aliases, all one thing** ➔ polynomial-time **mapping** reduction · polynomial-time **many-one** reduction · **polynomial transformation** · **Karp reduction**.
- **What changed from Lecture 21** ➔ nothing about the *logic*; $f$ is still a total translator that preserves the Yes/No answer and never decides anything. Only the **cost of computing $f$** is now constrained.
- **The output-length lemma** ➔ a TM can emit at most **one symbol per step**, so $f$ computable in time $O(n^{k})$ forces $\lvert f(x)\rvert=O(n^{k})$. This is the hinge of both proofs below — a reduction cannot hand the next machine a super-polynomially large instance.

## 🔧 Worked reductions
Each is stated as **the function**, then the **iff chain**, then the **cost**. All three parts are marked; a bare function earns nothing.

- **$\text{INDEPENDENT SET}\le_{P}\text{CLIQUE}$** ➔ $f(G,k):=(\overline{G},k)$, the **complement graph** (edges $\leftrightarrow$ non-edges), $k$ untouched.
$$(G,k)\in\text{INDEPENDENT SET}\iff G\text{ has an independent set of size}\ge k\iff \overline{G}\text{ has a clique of size}\ge k\iff(\overline{G},k)\in\text{CLIQUE}$$
  - **Cost** ➔ complementing is one pass over the $\binom{n}{2}$ vertex pairs ⟹ $O(n^{2})$.
- **$\text{VERTEX COVER}\le_{P}\text{INDEPENDENT SET}$** ➔ $f(G,k):=(G,n-k)$ where $n=\lvert V(G)\rvert$; the **graph is unchanged**, only the parameter moves.
$$X\text{ is a vertex cover of }G\iff V(G)\setminus X\text{ is independent}\ \ \Longrightarrow\ \ (G,k)\in\text{VERTEX COVER}\iff(G,n-k)\in\text{INDEPENDENT SET}$$
  - **Why the arithmetic** ➔ complementing the *set* complements the *size*: a cover of size $\le k$ leaves an independent set of size $\ge n-k$, which is why the $\le$/$\ge$ bounds in [[Standard NP Problems and Certificates]] flip together with $k$.
  - **Cost** ➔ one subtraction ⟹ $O(n)$ including copying the graph.
- **$2\text{-SAT}\le_{P}3\text{-SAT}$** ➔ pad each clause with a **fresh** variable used nowhere else: replace the $i$-th clause $x\vee y$ by
$$(x\vee y\vee w_i)\wedge(x\vee y\vee\neg w_i)$$
  - **Why it preserves satisfiability** ➔ whatever $w_i$ is set to, one of the two clauses loses its padding literal and reduces to $x\vee y$ ⟹ the pair is satisfiable **iff** $x\vee y$ is, and freshness stops $w_i$ interfering with any other clause.
  - **Cost** ➔ one new variable and one extra clause per clause ⟹ **linear**.
- **$\text{PARTITION}\le_{P}\text{SUBSET SUM}$** ➔ $f(s_1,\dots,s_n):=\left(s_1,\dots,s_n,\tfrac{1}{2}\textstyle\sum_{i=1}^{n}s_i\right)$ — supply the half-total as the target $t$.
  - **Why** ➔ a subset summing to half the total leaves its complement summing to the same amount, which is the definition of a partition. **Cost** ➔ one addition pass, $O(n)$.
- **$\text{GRAPH ISOMORPHISM}\le_{P}\text{SUBGRAPH ISOMORPHISM}$** ➔ case split on sizes: output $(G,H)$ unchanged when $\lvert V(G)\rvert\ge\lvert V(H)\rvert$; otherwise output the fixed pair the slide gives **as a diagram**. Comparing two vertex counts is $O(n)$, so either branch is polynomial. *(The second branch is a picture in the handout — construction not verifiable from the provided material; the slide then asks whether the reduction runs **the other way round**.)*

> [!QUESTION]- Slide 5 exercise: which Lecture-21 mapping reductions are **also** polynomial-time? *(the slide leaves the Yes/No column blank — reasoning worked here)*
> > [!SUCCESS]- Worked answer
> > | Lecture-21 reduction | Poly-time? | Reason |
> > | :--- | :--- | :--- |
> > | $\text{EQUAL}\to\text{HALF-AND-HALF}$ | **Yes** | $f=$ sort the word; $O(n\log n)$, output length $=n$ |
> > | $\text{HALF-AND-HALF}\to\text{PARENTHESES}$ | **Yes** | single left-to-right scan with a $\mathtt{ba}$ guard; $O(n)$ |
> > | $\text{FA-Empty}\to\text{No-Digraph-Path}$ | **Yes** | one pass over states and transitions plus a new sink $t$; linear in $\lvert\langle A\rangle\rvert$ |
> > | $\text{RegExpEquiv}\to\text{FA-Empty}$ | **No** | needs complementation, hence [[NFA to DFA (Subset Construction)\|subset construction]] — $2^{q}$ states in the worst case |
> > - **Key move:** the last row is the whole lesson — **decidability transferred, tractability did not**. Every construction that determinises or complements an NFA must be checked for blow-up before the word *polynomial* is used.

- **Further reductions set as exercises** *(slide 12 — statements only, no constructions given)* ➔ $3\text{-COLOURABILITY}\le_{P}\text{GRAPH COLOURING}$ · $2\text{-COL}\le_{P}3\text{-COL}$ · $\text{HAMILTONIAN CIRCUIT}\le_{P}\text{HAMILTONIAN PATH}$ · $2\text{-COL}\le_{P}2\text{-SAT}$ · $\text{SATISFIABILITY}\le_{P}3\text{-SAT}$ · $3\text{-COL}\le_{P}\text{SATISFIABILITY}$ · $\text{SUBSET SUM}\le_{P}\text{PARTITION}$.

## 🧮 Proof Blueprint — the properties of $\le_{P}$
> [!IMPORTANT] **Reflexive.** $L\le_{P}L$ (identity). **Transitive.** $K\le_{P}L\wedge L\le_{P}M\Rightarrow K\le_{P}M$. **Transfer.** $K\le_{P}L\wedge L\in\mathrm{P}\Rightarrow K\in\mathrm{P}$. **Corollary.** $K\le_{P}L\wedge K\notin\mathrm{P}\Rightarrow L\notin\mathrm{P}$.

**Strategy** ➔ *both theorems compose two polynomial bounds; the only non-obvious ingredient is that the intermediate string $f(x)$ is itself only polynomially long.*

> [!SUCCESS]- Derivation — transitivity
> $g\circ f$ is a mapping reduction from $K$ to $M$ (Lecture 21); only the timing is new. Say $f(x)$ costs $\le c\lvert x\rvert^{k}$ and $g(y)$ costs $\le d\lvert y\rvert^{\ell}$ for large inputs. The output-length lemma gives $\lvert f(x)\rvert\le c\lvert x\rvert^{k}$, so
> $$
> \begin{aligned}
> \text{cost of } g\text{ on } f(x) &\le d\,\lvert f(x)\rvert^{\ell} \le d\,(c\lvert x\rvert^{k})^{\ell} = d\,c^{\ell}\lvert x\rvert^{k\ell}\\
> \text{total} &\le c\lvert x\rvert^{k}+d\,c^{\ell}\lvert x\rvert^{k\ell} \le c'\lvert x\rvert^{m}\quad\text{for constants } c',m.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** without the bound on $\lvert f(x)\rvert$ the second stage is measured in the wrong variable and the proof collapses — $g$ polynomial **in its own input** says nothing until that input is known to be small.

> [!SUCCESS]- Derivation — the transfer theorem
> Let $f$ reduce $K$ to $L$ and let $D$ be a polynomial-time decider for $L$, say $O(n^{k'})$. **Decider for $K$** on input $x$: compute $f(x)$; run $D$ on $f(x)$; echo the answer — correct because $x\in K\iff f(x)\in L$. With $f$ of time $O(n^{k})$ and hence $\lvert f(x)\rvert=O(n^{k})$,
> $$
> \begin{aligned}
> \text{total time} &= \underbrace{O(n^{k})}_{\text{compute } f(x)} + \underbrace{O\!\left(\lvert f(x)\rvert^{k'}\right)}_{\text{run } D}\\
> &= O(n^{k}) + O\!\left(n^{kk'}\right)\\
> &= O\!\left(n^{kk'}\right)\ \Longrightarrow\ K\in\mathrm{P}.\ \blacksquare
> \end{aligned}
> $$
> - **Corollary (contrapositive, free):** $(K\le_{P}L)\wedge(K\notin\mathrm{P})\Rightarrow(L\notin\mathrm{P})$ — the form used to spread *in*tractability, exactly as $\le_{m}$ spreads undecidability.
> - **Same shape, harder currency:** the $\le_{m}$ transfer theorem spent only **halting**; this one spends **halting within a polynomial**, so the exponents multiply and must both be constants.

- **The two set exercises** ➔ ① if $K\in\mathrm{P}$ then $K\le_{P}L$ for any $L$ — the caveats are the same trivial cases as for $\le_m$: $L=\emptyset$ and $L=\Sigma^{*}$ are excluded, since a constant-valued $f$ needs both a Yes-target and a No-target in $L$. ② $K\le_{P}L\wedge L\in\mathrm{NP}\Rightarrow K\in\mathrm{NP}$ — same proof with "decider" replaced by "verifier", the certificate passed straight through.

## ⚠️ Common Mistakes
- 💡 **Forgetting to bound $\lvert f(x)\rvert$** ➔ the single technical step examiners look for. "$f$ is polynomial and $D$ is polynomial, so the composite is" is **incomplete** until the intermediate instance is shown to be polynomially small.
- 💡 **Reducing the wrong way** ➔ $K\le_{P}L$ pushes **hardness up** and **easiness down**: it licenses "$L\in\mathrm{P}\Rightarrow K\in\mathrm{P}$" and "$K\notin\mathrm{P}\Rightarrow L\notin\mathrm{P}$", never the reverse.
- 💡 **Reusing an $\le_{m}$ construction without re-timing it** ➔ $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$ is a valid mapping reduction and **not** a polynomial one. Recheck every determinisation and complementation.
- 💡 **Proving one direction of the iff** ➔ $x\in K\Rightarrow f(x)\in L$ leaves the reduction free to map a No-instance onto a Yes-instance, and the composite decider then accepts too much.
- 💡 **Treating $\le_{P}$ as symmetric** ➔ it is **reflexive and transitive** (a preorder). $\text{GRAPH ISOMORPHISM}\le_{P}\text{SUBGRAPH ISOMORPHISM}$ says nothing about the converse — which the slide poses as an open question precisely because it does not follow.
- 💡 **Padding with a re-used variable** ➔ in $2\text{-SAT}\le_{P}3\text{-SAT}$ each clause needs its **own fresh** $w_i$; sharing one variable couples clauses and breaks the iff.

## 🧠 Active Recall
> [!FAQ]- Why does the transfer theorem need the lemma "a TM outputs at most one symbol per step"?
> > [!SUCCESS]- Answer
> > - **Short answer:** because $D$'s running time is polynomial **in the length of its own input**, which is $f(x)$ — not $x$. The lemma converts $f$'s *time* bound $O(n^{k})$ into a *length* bound $\lvert f(x)\rvert=O(n^{k})$, so $D$ costs $O\!\left(n^{kk'}\right)$.
> > - **Why:** **A reduction could otherwise hand over an exponentially large instance** ➔ then even a linear-time $D$ would take exponential time overall and $K\in\mathrm{P}$ would fail. The identical lemma bounds the certificate search in [[Verifiers, Certificates and the Class NP]].

> [!FAQ]- $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$ was a legitimate mapping reduction. Why is it not a polynomial-time reduction, and what does that show about $\le_{P}$ versus $\le_{m}$?
> > [!SUCCESS]- Answer
> > - **Short answer:** it builds an FA for the symmetric difference $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$, and complementation requires a **deterministic** automaton — the [[NFA to DFA (Subset Construction)|subset construction]] can blow $q$ states up to $2^{q}$.
> > - **Why:** **$\le_{P}$ is strictly finer than $\le_{m}$** ➔ every polynomial-time reduction is a mapping reduction, but the clock rejects constructions that are merely computable. That is exactly what is needed to separate *decidable* languages by difficulty, something $\le_{m}$ is far too coarse to do.

> [!FAQ]- Prove $\text{VERTEX COVER}\le_{P}\text{INDEPENDENT SET}$, stating what is marked.
> > [!SUCCESS]- Answer
> > - **Short answer:** $f(G,k):=(G,n-k)$ with $n=\lvert V(G)\rvert$; computable in $O(n)$; and $(G,k)\in\text{VERTEX COVER}\iff(G,n-k)\in\text{INDEPENDENT SET}$.
> > - **Why:** **$X$ is a vertex cover $\iff V\setminus X$ is independent** ➔ "every edge meets $X$" and "no edge lies inside $V\setminus X$" are the same sentence. So a cover of size $\le k$ exists iff an independent set of size $\ge n-k$ does; the **function, the iff chain, and the $O(n)$ cost** are the three marked components.
