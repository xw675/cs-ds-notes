---
unit: FIT2014
week: 10
source: [lecture]
domain: D
parent: "[[Polynomial Time and the Class P]]"
tags: [Math/Theory, CS/Computation]
aliases: [NP, class NP, verifier, certificate, nondeterministic Turing machine, NDTM, P versus NP]
---
# [[Verifiers, Certificates and the Class NP]]

**Context:** [[FIT2014_MOC]] · swaps **deciding** for **verifying** — the same move that separates *sitting the exam* from *showing the degree certificate*; the problem catalogue lives in [[Standard NP Problems and Certificates]] and the comparison machinery in [[Polynomial-Time Reductions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a **verifier** for $L$ is a TM on **two** inputs $(x,y)$ that always halts, with $x\in L\iff\exists y$ the TM accepts $(x,y)$, and $x\notin L\Rightarrow$ **every** $y$ is rejected ➔ $\mathrm{NP}:=\{L: L$ has a verifier of time complexity $O(n^{k})$, $n=\lvert x\rvert\}$.
> - **📦 Core Components:** **certificate** $y$ ➔ the guessed evidence | **verifier** ➔ the polynomial-time check | **NDTM** ➔ the equivalent machine model that supplies the letter **N**.
> - **⚡ Key Constraint:** the polynomial is in $\lvert x\rvert$ **only** — never in $\lvert y\rvert$. That single bound silently caps the useful certificate length at $O(n^{k})$ symbols and is what makes $\mathrm{NP}\subseteq\mathrm{EXP}$ provable.

## 📝 How It Works
### 1. Deciding versus verifying
- **The distinction** ➔ *deciding* answers "is $x\in L$?" **either way**; *verifying* only confirms a **Yes**, and only when handed suitable evidence.
- **Lecture's two analogies** ➔ $\{$people who can kick a football$\}$ ➔ hand them a ball ⟹ that procedure is a **decider**, settling Yes and No alike. $\{$university graduates$\}$ ➔ no efficient decider exists, but a **degree certificate** verifies membership instantly — and **non**-membership stays hard to verify.
- **Asymmetry is the point** ➔ $\mathrm{NP}$ is a class of languages whose **Yes**-instances have short, checkable evidence; nothing is claimed about the No-instances (that is $\mathrm{co}\text{-}\mathrm{NP}$).

### 2. Verifier, certificate, $\mathrm{NP}$
> [!IMPORTANT] A **verifier** for $L$ is a TM taking two strings $x,y$ that (i) **always halts**; (ii) if $x\in L$, **there exists** $y$ making it accept; (iii) if $x\notin L$, **every** $y$ makes it reject. The string $y$ is a **certificate**. A **polynomial-time verifier** has time complexity $O(n^{k})$ where $n=\lvert x\rvert$.

- **Acceptance restated** ➔ $x$ is accepted **iff it has a certificate that the verifier passes** — so designing a certificate *is* designing the proof of membership.
- **$\mathrm{NP}$** ➔ the class of languages possessing a polynomial-time verifier; the name is **N**ondeterministic **P**olynomial time, justified in §5 — it does **not** stand for "non-polynomial".
- **The four obligations of a membership proof** ➔ ① specify the **certificate**; ② give the **verifier** as an algorithm; ③ prove it **is** a verifier (the iff chain); ④ prove it runs in **polynomial time**. Skipping ③ or ④ is where the marks go.

### 3. Worked membership proof — $\{3\text{-colourable graphs}\}\in\mathrm{NP}$
- **Certificate** ➔ a function $f:V(G)\to\{\text{Red},\text{White},\text{Black}\}$, stored as a list of $n$ colours indexed by vertex.
- **Verifier** ➔ for each edge $uv\in E(G)$: look up $f(u)$ and $f(v)$; if $f(u)=f(v)$ **Reject and halt**; if the loop completes with no violation, **Accept and halt**.

> [!SUCCESS]- Claim 1 — it is a verifier
> $$
> \begin{aligned}
> G\in\{3\text{-colourable}\} &\iff \exists f:V(G)\to\{\text{R},\text{W},\text{B}\}\ \text{with}\ f(u)\neq f(v)\ \text{for every edge } uv\\
> &\iff \exists\,\text{certificate on which the verifier accepts } G.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** the definition of 3-colourability is **already** an $\exists$-statement over exactly the object used as the certificate — so the chain is one line. Choose the certificate to *be* the witness the definition quantifies.

> [!SUCCESS]- Claim 2 — it is polynomial time
> $$
> \begin{aligned}
> \text{iterations} &= m := \lvert E(G)\rvert\\
> \text{cost per iteration} &= \underbrace{O(n)}_{\text{look up } f(u),f(v)\text{ in a length-}n\text{ list}} + \underbrace{O(1)}_{f(u)\neq f(v)?}\\
> \text{total} &\le m\cdot n\cdot\text{const} = O(mn).\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** $O(mn)$ is a **deliberately loose** bound — array lookup is faster than $O(n)$ — and looseness costs nothing, because membership of $\mathrm{NP}$ needs only *some* polynomial. Do not optimise; bound and move on.

### 4. $\mathrm{P}\subseteq\mathrm{NP}$, and the exponential ceiling
> [!IMPORTANT] **Theorem.** $\mathrm{P}\subseteq\mathrm{NP}$. **Theorem.** Every $L\in\mathrm{NP}$ is decidable in time $O\!\left(2^{n^{K}}\right)$ for some constant $K$.

> [!SUCCESS]- Derivation — both directions of the sandwich $\mathrm{P}\subseteq\mathrm{NP}\subseteq\mathrm{EXP}$
> **$\mathrm{P}\subseteq\mathrm{NP}$** ➔ take a polynomial-time decider for $L$ and make it a verifier that **ignores the certificate**: on $(x,y)$ run the decider on $x$ and echo its answer. If $x\in L$ *every* $y$ works (so one exists); if $x\notin L$ *every* $y$ fails. Time is unchanged, hence polynomial. $\blacksquare$
> **$\mathrm{NP}\subseteq\mathrm{EXP}$** ➔ let $V$ verify $L$ in time $\le c\,n^{k}$. Decider for $L$ on input $x$: for each certificate $y$, run $V(x,y)$; Accept on the first success, Reject after exhausting them. It accepts iff **some** $y$ works and rejects iff **every** $y$ fails, which is the definition of a verifier ⟹ it decides $L$.
> $$
> \begin{aligned}
> \text{certificate symbols readable in } c n^{k} \text{ steps} &\le c\,n^{k} &&\text{(one symbol per step)}\\
> \#\text{certificates worth testing over } \{\mathtt{a},\mathtt{b}\} &\le 2^{c n^{k}}\\
> \text{total time} &= O\!\left(2^{cn^{k}}\,n^{k}\right) = O\!\left(2^{n^{K}}\right) &&\text{for } K \text{ slightly above } k.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** the certificate space looks infinite, but **a TM reads at most one symbol per step**, so anything past position $c\,n^{k}$ is invisible to $V$ and need never be enumerated. The same one-symbol-per-step lemma reappears in [[Polynomial-Time Reductions]].

### 5. Nondeterministic TMs — where the "N" comes from
- **NDTM** ➔ a [[Turing Machines|Turing machine]] whose transition function may offer **more than one** action for a given (state, symbol) pair ⟹ one input spawns many possible computations. Every deterministic TM **is** an NDTM (the degenerate case).
- **Acceptance** ➔ $M$ accepts $x$ iff **some** computation path reaches Accept — exactly the [[Finite Automata (DFA and NFA)|NFA]] convention lifted to tapes.
- **Nondeterministic decider** ➔ $M$ halts on **all** inputs and the accepted language is $L$. **Polynomial-time NDTM** ➔ time complexity $O(n^{k})$, the maximum taken over all inputs of length $n$ **and all computation paths** for each.

> [!IMPORTANT] **Theorem.** $L\in\mathrm{NP}$ $\iff$ some polynomial-time NDTM is a nondeterministic decider for $L$.

> [!SUCCESS]- Derivation (outline, both directions)
> $(\Rightarrow)$ Given a verifier of time $\le c\,n^{k}$, build $M$ that **nondeterministically writes** a string $y$ of length $c\,n^{k}$ and then runs the verifier on $(x,y)$ deterministically. Guessing costs $O(n^{k})$, checking costs $O(n^{k})$.
> $(\Leftarrow)$ Given a polynomial-time NDTM deciding $L$, fix an encoding of the **sequence of choices** made at each nondeterministic step and use that string as the certificate; the verifier replays the choices deterministically.
> - **Key move:** *guess-then-check* $=$ *certificate-plus-verifier*. The certificate **is** the record of the lucky path.
> - **⚡ Key Constraint:** contrast [[Kleene's Theorem|DFA vs NFA]], where nondeterminism costs nothing in expressive power. Here determinising an NDTM is only known to cost **exponential** time — which is precisely the open problem below.

### 6. The $\mathrm{P}$-versus-$\mathrm{NP}$ problem
- **Conjecture** ➔ $\mathrm{P}\neq\mathrm{NP}$: the biggest open problem in computer science and one of the biggest in mathematics, carrying a Clay Institute **Millennium Prize** of US$1 million. Many false solutions appear and continue to appear.
- **The disputed middle** ➔ in $\mathrm{NP}$ but **not known** to be in $\mathrm{P}$: SATISFIABILITY, 3-SAT, HAMILTONIAN CIRCUIT, 3-COLOURABILITY, VERTEX COVER, INDEPENDENT SET, GRAPH ISOMORPHISM, INTEGER FACTORISATION — see [[Standard NP Problems and Certificates]].
- **Known inside $\mathrm{P}$** ➔ 2-SAT, EULERIAN CIRCUIT, 2-COLOURABILITY, CONNECTED GRAPHS, SHORTEST PATH, PRIMES, invertible matrices, **all context-free and all regular languages** ⟹ if $\mathrm{P}=\mathrm{NP}$ the two pictures collapse into one.

## ⚠️ Common Mistakes
- 💡 **Bounding the verifier in $\lvert y\rvert$** ➔ the definition fixes $n=\lvert x\rvert$. Bounding by the certificate's length would let an exponentially long certificate smuggle in exponential time.
- 💡 **Proving only the Yes direction** ➔ condition (iii) — *every* $y$ rejected when $x\notin L$ — is what forbids a certificate that fakes membership. A "verifier" that accepts some $(x,y)$ with $x\notin L$ verifies nothing.
- 💡 **Reading NP as "not polynomial"** ➔ it abbreviates **N**ondeterministic **P**olynomial, and $\mathrm{P}\subseteq\mathrm{NP}$ is a theorem, so the reading is not merely wrong but self-contradictory.
- 💡 **Claiming $\mathrm{NP}$ means "unsolvable"** ➔ every $\mathrm{NP}$ language is **decidable**, in $O(2^{n^{K}})$ by brute-force certificate search. $\mathrm{NP}$ is a tractability question, not a computability one ([[Undecidability and the Halting Problem]]).
- 💡 **Over-tightening the time bound** ➔ marks come from exhibiting *a* polynomial. Optimising $O(mn)$ to $O(m)$ earns nothing and wastes exam minutes.

## 🧠 Active Recall
> [!FAQ]- You must show a language is in $\mathrm{NP}$. What exactly do you have to produce, and which of the four parts do students omit?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **certificate**, the **verifier as an algorithm**, the **iff proof** that it is a verifier, and the **polynomial time bound**. The two proofs are the parts that get dropped.
> > - **Why:** **The certificate should be the object the definition already quantifies** ➔ for 3-colourability the definition reads $\exists f:V\to\{\text{R},\text{W},\text{B}\}$, so taking $f$ as the certificate makes Claim 1 a one-line chain, and Claim 2 need only reach *some* bound — $O(mn)$ for the edge loop with $O(n)$ lookups is fine and deliberately loose.

> [!FAQ]- If $\mathrm{NP}$ is defined by verifiers, why is it named after nondeterminism?
> > [!SUCCESS]- Answer
> > - **Short answer:** because $L\in\mathrm{NP}$ **iff** a polynomial-time **NDTM** decides $L$ — *guess-then-check* and *certificate-plus-verifier* are two descriptions of one class.
> > - **Why:** **The certificate encodes the choice sequence** ➔ from a verifier, build an NDTM that nondeterministically writes $y$ of length $c\,n^{k}$ then verifies; from a poly-time NDTM, record its nondeterministic choices as the certificate and replay them. Note the contrast with [[Finite Automata (DFA and NFA)|DFA vs NFA]], where nondeterminism is free — for TMs the known cost is exponential, and whether it truly is is the $\mathrm{P}$ vs $\mathrm{NP}$ question.

> [!FAQ]- Why does exhaustive search over certificates terminate, given there are infinitely many strings $y$?
> > [!SUCCESS]- Answer
> > - **Short answer:** a TM running in $\le c\,n^{k}$ steps **reads at most $c\,n^{k}$ symbols**, so all certificates agreeing on that prefix behave identically — only $\le 2^{cn^{k}}$ distinct prefixes need testing.
> > - **Why:** **One symbol per step is the lemma that bounds everything** ➔ it converts an infinite search into a finite one and yields the decider's $O\!\left(2^{cn^{k}}n^{k}\right)=O\!\left(2^{n^{K}}\right)$ bound, placing $\mathrm{NP}$ inside exponential time. The same lemma bounds $\lvert f(x)\rvert$ in [[Polynomial-Time Reductions]].
