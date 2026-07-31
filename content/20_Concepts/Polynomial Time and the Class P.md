---
unit: FIT2014
week: 10
source: [lecture]
domain: D
parent: "[[Decidability and Decision Problems]]"
tags: [Math/Theory, CS/Computation]
aliases: [P, class P, polynomial time, time complexity of a Turing machine, polynomial slowdown, Cobham-Edmonds thesis]
---
# [[Polynomial Time and the Class P]]

**Context:** [[FIT2014_MOC]] · **decidability is not enough** — [[Decidability and Decision Problems|decidable]] says a computer *can* answer, this note asks whether it can answer *before the sun dies*; refines the tier regular ⊊ context-free ⊊ decidable by inserting $\mathrm{P}$

> [!abstract] Quick Revision
> - **🎯 Objective:** $t_M(n):=\max\{t_M(x):|x|=n\}$ ➔ $M$ is **polynomial time** iff $t_M(n)=O(n^k)$ for some **fixed** $k$ ➔ $\mathrm{P}:=\{L : L$ decided by some polynomial-time TM$\}$, the first formal definition of "efficiently solvable".
> - **📦 Core Components:** [[Big-O Notation|time complexity]] $t_M(n)$ ➔ worst case over inputs of length $n$ | **polynomial slowdown** ➔ why $\mathrm{P}$ is model-independent | **membership** ➔ exhibit an algorithm and bound its steps.
> - **⚡ Key Constraint:** $k$ is **fixed and input-independent** — $O(n^{\log n})$ and $O(n^{n})$ are *not* polynomial; and $t_M(n)$ is **undefined unless $M$ is a decider**, so a recogniser that loops has no time complexity at all.

## 📝 How It Works
### 1. Time complexity of a Turing machine
- **Per-input cost** ➔ $t_M(x):=$ the number of steps [[Turing Machines|M]] takes on input $x$ **until it halts** — one step $=$ one transition, not one "operation".
- **The complexity function** ➔ $t_M(n):=\max\{t_M(x):\lvert x\rvert=n\}$, a function of $n$ ➔ **worst case**, never average, and maximised over the finitely many inputs of each length.
- **Definedness precondition** ➔ the max exists only if $M$ halts on **every** input, i.e. $M$ is a **decider** ($\text{Loop}(M)=\emptyset$).
- **Lecture's three calibration examples** ➔ $\{$strings ending in $\mathtt{b}\}$ ➔ $n+1$ (sweep right to the blank, step back once) | $\{$palindromes$\}$ ➔ $\approx\tfrac12(n+1)(n+2)=O(n^2)$ (match-and-erase from both ends) | $\{\varepsilon\}$ ➔ $1$.
- **Every regular language is in $\mathrm{P}$** ➔ the [[Turing Machines|FA to TM]] construction of Lecture 18 reads each letter once and never returns ⟹ $t_M(n)=O(n)$.

### 2. The model dependence — and why it evaporates
- **Details that move the constant** ➔ number of tape symbols · tape infinite in one or both directions · number of tapes · dimensionality of the tape (1-D, 2-D, …) · whether "stay still" is a legal move.
- **Why a fixed threshold fails** ➔ declaring "efficient $:=$ at most $3n^{5}$ steps" is arbitrary, ties the definition to one machine model, and **decays as hardware improves** ⟹ the class must be closed under the differences above, and only the *polynomial* family is.
- **Continuity with FIT1008/FIT1045** ➔ the complexity you already compute for programs also assumed a machine model, usually implicitly; $\mathrm{P}$ is the version that stops depending on it (see [[Algorithmic Complexity]]).

### 3. Polynomial vs exponential — the growth gap
| $n$ | $n^2$ | $n^3$ | $2^n$ | $10^n$ |
| :--- | :--- | :--- | :--- | :--- |
| $10$ | $100$ | $1000$ | $1024$ | $10^{10}$ |
| $40$ | $1600$ | $64000$ | $\approx 1.1\times10^{12}$ | $10^{40}$ |
| $100$ | $10^{4}$ | $10^{6}$ | $\approx 10^{30}$ | $10^{100}$ |
| $1000$ | $10^{6}$ | $10^{9}$ | $\approx 10^{300}$ | $10^{1000}$ |

| If you… | $n^{c}$ time | exponential time |
| :--- | :--- | :--- |
| grow input by a fixed **amount** ($n\to n+k$) | time grows by an **additive** $O(n^{c-1})$ | time grows by a **fixed multiplicative factor** |
| grow input by a fixed **factor** ($n\to kn$) | time $\times\,k^{c}$ | time **raised to the power** $k$ |
| **double the machine's speed** | feasible input size $\times$ fixed factor | feasible input size $+$ fixed **amount** |
| need inputs **twice** today's size | wait $2c$ years for hardware | wait $\propto$ **your current input size** |

> [!NOTE] **When It Flips:** the last two rows are the real argument — under Moore's Law a polynomial algorithm **inherits** hardware progress ($c$ doublings $=2c$ years buys a doubling of $n$), an exponential one converts the whole of it into $+1$ on the input size. Faster machines rescue polynomials, never exponentials.

### 4. The class $\mathrm{P}$
> [!IMPORTANT] A language is **polynomial-time decidable** if some polynomial-time TM decides it. $\mathrm{P}$ is the class of all such languages — historically the first, and still the default, formalisation of *tractable*.

- **The power is fixed, the machine is not** ➔ different members of $\mathrm{P}$ have wildly different $k$; what matters is only that **some** fixed $k$ bounds the given machine.
- **History** ➔ Alan Cobham (1965), Jack Edmonds (1965), Michael Rabin (1966).
- **Proving membership** ➔ give an algorithm **and** bound its step count by a polynomial; the bound may be loose, since only the *existence* of some $O(n^k)$ matters.

## 🧮 Proof Blueprint — $\mathrm{P}$ is model-independent
> [!IMPORTANT] **Theorem.** If $M_2$ can simulate $M_1$ with **polynomial slowdown** (a computation of $M_1$ taking time $t$ costs $M_2$ at most $c\,t^{k}$), and $M_1$ is polynomial time, then $M_2$ simulates $M_1$ in polynomial time. **Hence** $L$ decidable in polynomial time on $M_1$ $\Rightarrow$ $L$ decidable in polynomial time on $M_2$.

**Strategy** ➔ *compose the two polynomial bounds and read off that a polynomial of a polynomial is a polynomial*.

> [!SUCCESS]- Derivation
> Let $t(n)$ be the time complexity of $M_1$, so $t(n)\le c_1 n^{K}$ for some fixed $c_1,K$ and all sufficiently large $n$. Then the time $M_2$ needs to simulate $M_1$ on an input of size $n$ is
> $$
> \begin{aligned}
> &\le c\,t(n)^{k} &&\text{(polynomial slowdown)}\\
> &\le c\,(c_1 n^{K})^{k} &&\text{(bound on } t(n)\text{, large } n)\\
> &= c\,c_1^{k}\,n^{Kk} &&\text{(index laws)}\\
> &= c'\,n^{k'} &&\text{where } c'=c\,c_1^{k},\ k'=Kk \text{ are constants}\\
> &= O(n^{k'}). &&\blacksquare
> \end{aligned}
> $$
> - **Key move:** $K$ and $k$ are **constants**, so their product is a constant. The argument dies instantly if either exponent is allowed to depend on $n$ — which is exactly why "polynomial" must mean *fixed* power.
> - **Why it settles the definition:** virtually any two "reasonable" computers simulate each other with at most polynomial slowdown, so **$\mathrm{P}$ is the same class whether defined over a one-tape TM, a laptop, or a supercomputer**. This mirrors [[Computable Functions and the Church-Turing Thesis|the history of decidability]]: many models, one class.

## 📚 Members of $\mathrm{P}$
| Family | Languages in $\mathrm{P}$ | Certifying algorithm |
| :--- | :--- | :--- |
| Words | strings ending in $\mathtt{b}$ · palindromes · $\{\varepsilon\}$ · pairs in lexicographic order · matching parentheses | single or double sweep of the tape |
| Language classes | **every [[Kleene's Theorem\|regular language]]** · **every [[Context-Free Grammars (CFG)\|context-free language]]** · $\{\mathtt{a}^n\mathtt{b}^n\mathtt{c}^n\}$ | FA $\to$ TM sweep; [[CYK Algorithm\|CYK]] at $O(n^3)$ |
| Numbers | coprime pairs · square numbers · **PRIMES** (Agrawal–Kayal–Saxena, *Annals of Mathematics*, 2004) · invertible matrices | [[Euclidean Algorithm]]; AKS; Gaussian elimination |
| Graphs | trees · balanced binary trees · $\{(G,s,t,k): G$ has an $s$–$t$ path of length $\le k\}$ · regular graphs · **2-colourable** graphs · [[Euler Tour\|Eulerian]] graphs · planar graphs *(advanced)* | search / degree counting / [[Bipartite Graph\|bipartiteness]] test |
| Logic | **2-SAT** — satisfiable [[Conjunctive Normal Form\|CNF]] with **exactly two literals per clause** | *(slide's challenge; algorithm not given)* |

- **Where the tiers now sit** ➔ regular $\subsetneq$ context-free $\subsetneq \mathrm{P} \subsetneq$ decidable, each containment **proper** with a named witness: $\{\mathtt{a}^n\mathtt{b}^n\}$ separates the first, $\{\mathtt{a}^n\mathtt{b}^n\mathtt{c}^n\}$ and 2-SAT the second, and the **time-bounded Halting Problem**, **RegExp equivalence**, generalised Chess and generalised Go the third.
- **2-SAT vocabulary** ➔ a **truth assignment** is a function $f:\{\text{variables}\}\to\{\text{True},\text{False}\}$; an expression is **satisfiable** iff *some* assignment makes it True. For $(\neg x\vee\neg y)\wedge(x\vee\neg z)\wedge(y\vee z)\wedge(y\vee\neg y)$, $f(x)=f(y)=\text{F},f(z)=\text{T}$ gives False, but $g(x)=\text{T},g(y)=\text{F},g(z)=\text{T}$ gives True ⟹ **satisfiable**. One bad assignment proves nothing.

## ⚠️ Common Mistakes
- 💡 **Letting the exponent float** ➔ "$O(n^{k})$ for some $k$" quantifies $k$ **once per machine**, before the input is seen. $O(n^{\log n})$ has a growing exponent and is not polynomial.
- 💡 **Computing $t_M$ for a non-decider** ➔ no halting guarantee, no maximum, no time complexity. Establish "decider" *before* quoting a bound.
- 💡 **Confusing "in $\mathrm{P}$" with "fast"** ➔ $n^{100}$ is in $\mathrm{P}$ and useless in practice; $\mathrm{P}$ is a robustness-driven abstraction, not a performance promise.
- 💡 **Testing one truth assignment** ➔ satisfiability is an $\exists$ claim ([[Quantifiers (Existential and Universal)]]). One assignment giving False refutes nothing; one giving True settles it.
- 💡 **Quoting the model** ➔ never write "in $\mathrm{P}$ *on a two-tape TM*" — the slowdown theorem is precisely what makes the qualifier meaningless.

## 🧠 Active Recall
> [!FAQ]- Why is the class $\mathrm{P}$ defined by *polynomial* time rather than by an explicit threshold such as $3n^{5}$?
> > [!SUCCESS]- Answer
> > - **Short answer:** because the polynomials are the **smallest natural family closed under the differences between machine models** — an explicit threshold would make "efficient" depend on tape count, alphabet size, and the calendar.
> > - **Why:** **Polynomial slowdown composes** ➔ if $M_2$ simulates $M_1$ in $c\,t^{k}$ and $t(n)\le c_1n^{K}$ then the total is $c\,c_1^{k}n^{Kk}=O(n^{Kk})$, still polynomial because $Kk$ is a constant. Every reasonable model simulates every other with at most polynomial slowdown ⟹ $\mathrm{P}$ is invariant, exactly as the class of decidable languages is invariant across models.

> [!FAQ]- A colleague claims $\{$palindromes$\}$ shows time complexity is a property of the *language*. Where is the error?
> > [!SUCCESS]- Answer
> > - **Short answer:** $t_M(n)$ is a property of a **machine**, not a language; $\tfrac12(n+1)(n+2)$ is what *that* TM costs. A language's standing is the **existential** claim "*some* decider runs in $O(n^{k})$".
> > - **Why:** **Different deciders, different bounds** ➔ a two-tape machine decides palindromes in $O(n)$, the one-tape machine in $O(n^2)$; both put the language in $\mathrm{P}$. Membership of $\mathrm{P}$ therefore needs only **one** witnessing machine, and a slow decider never proves a language is *outside* $\mathrm{P}$.
