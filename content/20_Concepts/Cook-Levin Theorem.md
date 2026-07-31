---
unit: FIT2014
week: 11
source: [lecture]
domain: D
parent: "[[NP-Completeness]]"
tags: [Math/Theory, CS/Computation]
aliases: [Cook's Theorem, SATISFIABILITY is NP-complete, Cook-Levin]
---
# [[Cook-Levin Theorem]]

**Context:** [[FIT2014_MOC]] · the **first** NP-complete language — pays condition (b) of [[NP-Completeness]] once, generically, so every later proof is [[Proving NP-Completeness by Reduction|one reduction]] instead of an argument about all of $\mathrm{NP}$

> [!WARNING] **The proof (Lecture 29) is explicitly NON-EXAMINABLE.** Learn the **statement**, the **two obligations**, and the **architecture** below — it is the payoff for [[Encoding Problems in Propositional Logic|CNF encoding]] and [[Turing Machines|TM configurations]]. Do not spend SWOTVAC time reproducing the clause algebra.

> [!abstract] Quick Revision
> - **🎯 Objective:** $\text{SATISFIABILITY}:=\{$satisfiable Boolean expressions in **CNF**$\}$ is **NP-complete** (S. Cook 1971, L. Levin 1972).
> - **⚡ Key Constraint:** part (a) — SAT $\in\mathrm{NP}$ — is **easy and examinable**; part (b) is the hard generic construction and is not.

## 📝 Core
- **The two obligations** ➔ **(a)** $\text{SAT}\in\mathrm{NP}$; **(b)** $\forall L\in\mathrm{NP}:L\le_{P}\text{SAT}$.
- **(a) in full** *(the examinable half — the standard 4-part [[Verifiers, Certificates and the Class NP|membership proof]])* ➔ **certificate** = a truth assignment to the variables of $\phi$; **verifier** = check each clause has a true literal; **iff** = $\phi$ satisfiable $\iff$ some assignment passes; **time** = one pass over $\phi$, polynomial in $\lvert\phi\rvert$.
- **Why (b) is hard** ➔ it quantifies over an **infinite** set of languages, so no fixed gadget works. The only handle every $L\in\mathrm{NP}$ shares is that it *has a polynomial-time verifier* — so the reduction must encode **an arbitrary machine's run**, not the problem's combinatorics.
- **The generic idea** ➔ given $L\in\mathrm{NP}$ with polynomial-time verifier $V$ on tape $x\#y$ ($x$ the input, $y$ the certificate), build a CNF $\phi_{x}$ such that
$$\exists y: V(x,y)\text{ accepts}\quad\iff\quad \exists\text{ truth assignment}:\phi_{x}\text{ is True}$$
- **The polynomial clock** ➔ with $t_V(x,y)\le c\lvert x\rvert^{k}$, set $T(n):=\lfloor c\,n^{k}\rfloor$ — an integer bound on the number of timesteps, which is what makes the variable set **finite and polynomially large**.

## 🧬 Proof architecture *(non-examinable — read once for the shape)*
**Variables** — one Boolean for every possibility of every part of $V$ at every timestep, with $1\le t\le T(n)$:

| Variable | Meaning at time $t$ | Range |
| :--- | :--- | :--- |
| $Q_{t,q}$ | the machine is in state $q$ | $1\le q\le p$ (states) |
| $S_{t,s,\ell}$ | tape cell $s$ contains letter $\ell$ | $1\le s\le T(n)$, $\ell\in\{\mathtt{a},\mathtt{b},\Delta,\#\}$ |
| $H_{t,s}$ | the tape head is scanning cell $s$ | $1\le s\le T(n)$ |

- **Why polynomially many** ➔ the counts are $T(n)p$, $4T(n)^{2}$ and $T(n)^{2}$ — all polynomial in $n$ because $T$ is.

**Clauses** — left unconstrained, the variables describe nonsense (machine in several states at once, head in two places, a cell holding two letters). Two families rule that out:

| Family | Condition | Clause form |
| :--- | :--- | :--- |
| **Static — sanity**, every $t$ | exactly one state | at least: $Q_{t,1}\vee\dots\vee Q_{t,p}$ · at most: $\neg Q_{t,q}\vee\neg Q_{t,r}$ per pair |
| | exactly one head position | at least: $H_{t,1}\vee\dots\vee H_{t,T(n)}$ · at most: $\neg H_{t,s_1}\vee\neg H_{t,s_2}$ per pair |
| | exactly one letter per cell $s$ | at least: $S_{t,s,\mathtt{a}}\vee S_{t,s,\mathtt{b}}\vee S_{t,s,\#}\vee S_{t,s,\Delta}$ · at most: $\neg S_{t,s,\ell}\vee\neg S_{t,s,m}$ per pair |
| **Static — boundary** | correct start, $t=0$ | $(Q_{0,1})\wedge(H_{0,1})\wedge\bigwedge_{i=1}^{n}(S_{0,i,x_i})\wedge(S_{0,n+1,\#})$ |
| | accepted, $t=T(n)$ | $(Q_{T(n),2})$ — state $2$ is Accept |
| **Dynamic — inertia** | cells away from the head do not change | $H_{t,s}\vee\neg S_{t,s,\ell}\vee S_{t+1,s,\ell}$, one per letter $\ell$ |
| **Dynamic — transition** | for $q\xrightarrow{\ell\to m,\,d}u$ with $\sigma=+1$ if $d=$ Right, $-1$ if Left | $\neg Q_{t,q}\vee\neg S_{t,s,\ell}\vee\neg H_{t,s}\vee Q_{t+1,u}$ · $\dots\vee S_{t+1,s,m}$ · $\dots\vee H_{t+1,s+\sigma}$ |

- **Reading the dynamic clauses** ➔ each is an implication $(Q_{t,q}\wedge S_{t,s,\ell}\wedge H_{t,s})\Rightarrow(\text{consequence})$ pushed into CNF by $A\Rightarrow B\equiv\neg A\vee B$ and De Morgan — the [[Boolean Algebra Laws|W1 rewriting]], applied mechanically.
- **Conclusion** ➔ $\phi_{x}$ is the conjunction of everything above; $x\mapsto\phi_{x}$ is computable in polynomial time (*lengthy but routine*), and $x\in L\iff\phi_{x}\in\text{SATISFIABILITY}$. $\blacksquare$
- **The omitted detail** *(posed as an open exercise on the revision slide — no answer given in the handout)* ➔ the construction assumes acceptance happens **exactly at** $T(n)$; extra clauses are needed for a TM that accepts **earlier**. *(A natural fix is to make the Accept state absorbing so an early accept persists to time $T(n)$ — not stated in the slides.)*

## ⚠️ Common Mistakes
- 💡 **Attempting the proof under exam pressure** ➔ it is non-examinable. What *is* examinable is the **statement**, part (a), and the consequence that one reduction now suffices.
- 💡 **Forgetting the sanity clauses** ➔ without "exactly one" per component the variables describe an impossible machine, and $\phi_{x}$ becomes satisfiable for inputs $V$ rejects.
- 💡 **Confusing the two normal forms** ➔ this is [[Conjunctive Normal Form]] (logic), never [[Chomsky Normal Form]] (grammars).
- 💡 **Saying Cook-Levin proves $\mathrm{P}\neq\mathrm{NP}$** ➔ it proves SAT is a **hardest** problem in $\mathrm{NP}$. Which side of the frontier that summit sits on is still open.

## 🧠 Active Recall
> [!FAQ]- Why must the reduction encode *time* explicitly, with a variable per timestep?
> > [!SUCCESS]- Answer
> > - **Short answer:** a Boolean formula is **static** — it has no notion of sequence — so a whole computation must be flattened into one assignment by indexing every component with $t$.
> > - **Why:** **the polynomial bound $T(n)=\lfloor cn^{k}\rfloor$ makes the flattening finite** ➔ the run is at most $T(n)$ steps on at most $T(n)$ cells, so $O(T(n)^{2})$ variables suffice. A verifier without a polynomial time bound would need infinitely many variables, which is exactly why this works for $\mathrm{NP}$ and not for r.e. languages *(see [[Recursively Enumerable Languages]])*.

> [!FAQ]- What does Cook-Levin buy that the [[Reducing to SATISFIABILITY|PARTITION INTO TRIANGLES]] reduction does not?
> > [!SUCCESS]- Answer
> > - **Short answer:** **universality**. One worked reduction shows one language is $\le_{P}\text{SAT}$; Cook-Levin shows **every** language in $\mathrm{NP}$ is, which is condition (b) of NP-completeness.
> > - **Why:** **the handmade reductions encode a problem's rules, the generic one encodes a machine** ➔ the only property shared by all of $\mathrm{NP}$ is the existence of a polynomial-time verifier, so that is the object the construction must talk about. Karp's follow-up then makes the effort a one-off: every later NP-completeness proof reduces **from** SAT rather than repeating this.
