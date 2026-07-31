---
unit: FIT2014
week: 8
source: [lecture]
domain: D
parent: "[[Decidability and Decision Problems]]"
tags: [Math/Theory, CS/Computation]
aliases: [mapping reduction, many-one reduction, reducibility, "<=m", reduces to]
---
# [[Mapping Reductions]]

**Context:** [[FIT2014_MOC]] · the machinery for **transporting decidability between languages** — the tool that turns one hard-won result ([[Deciding Properties of FAs and CFGs|FA-Empty is decidable]]) into many, and later turns one undecidable language into a whole family

> [!abstract] Quick Revision
> - **🎯 Objective:** a **computable** $f:\Sigma^{*}\to\Sigma^{*}$ with $x\in K \iff f(x)\in L$ for **every** $x$ ➔ written $K\le_{m}L$, read "**$K$ is no harder than $L$**".
> - **⚠️ Key Constraint:** **direction is everything.** To prove $L$ **decidable**, reduce $L$ **to** a known-decidable language. To prove $L$ **undecidable**, reduce a known-undecidable language **to** $L$. Reversing the arrow proves nothing at all.

## 📝 Core
> [!IMPORTANT] A **mapping reduction** from language $K$ to language $L$ is a **computable function** $f:\Sigma^{*}\to\Sigma^{*}$ such that, for every $x\in\Sigma^{*}$, $\;x\in K \iff f(x)\in L$.

- **Notation** ➔ $K\le_{m}L$ means *there exists* a mapping reduction from $K$ to $L$; the function itself is usually left anonymous once exhibited.
- **What $f$ does and does not do** ➔ $f$ is a **translator**, never a decider: it answers nothing, it only rewrites an instance of one problem as an instance of another **preserving the Yes/No answer**.
- **Where the outputs land** ➔ $f$ maps $K$ **into** $L$ and $\Sigma^{*}\setminus K$ **into** $\Sigma^{*}\setminus L$. *Into*, not *onto* — $f$ need not be injective, surjective, or invertible, and may miss most of $L$ entirely.
- **Reflexivity** ➔ $\forall L:\ L\le_{m}L$ via the identity function, which is trivially computable.
- **Totality is mandatory** ➔ $f$ must be defined and **halt** on every $x\in\Sigma^{*}$, including junk inputs; a partial "reduction" that loops on malformed input is not computable and the transfer theorem collapses.

## 🧮 Proof Blueprint — the transfer theorem
> [!IMPORTANT] **Theorem.** $(K\le_{m}L)\wedge(L\text{ decidable})\Longrightarrow(K\text{ decidable})$.
> **Corollary.** $(K\le_{m}L)\wedge(K\text{ undecidable})\Longrightarrow(L\text{ undecidable})$.

**Strategy** ➔ *exhibit a decider for $K$ built from $f$ and the decider for $L$*; the corollary is then the **contrapositive**, obtained for free.

> [!SUCCESS]- Derivation
> **Decider for $K$**, on input $x$:
> $$
> \begin{aligned}
> &\text{1. Compute } f(x) &&\text{halts, since } f \text{ is computable and total}\\
> &\text{2. Run the decider for } L \text{ on } f(x) &&\text{halts, since } L \text{ is decidable}\\
> &\text{3. Echo its answer} &&\text{correct, since } x\in K \iff f(x)\in L
> \end{aligned}
> $$
> Both steps halt, so the composite halts on **every** input ⟹ it is a decider, and it Accepts exactly $K$. $\blacksquare$
> **Transitivity.** $K\le_{m}L\le_{m}M\Rightarrow K\le_{m}M$: take $g\circ f$, computable as a composition of computable functions, and
> $$
> \begin{aligned}
> w\in K &\iff f(w)\in L &&(f \text{ reduces } K \text{ to } L)\\
> &\iff g(f(w))\in M &&(g \text{ reduces } L \text{ to } M)\\
> &\iff (g\circ f)(w)\in M &&\text{(definition of composition)}.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** the theorem spends only **halting**, so it transports *decidability* backwards along $\le_{m}$ and *undecidability* forwards. Fix which of $K,L$ is the known one **before** choosing the direction of $f$.

## 🔧 Worked reductions
Each is stated as: the function, then the **iff chain** that certifies it. The chain is the marked part of the answer — a bare function earns nothing.

- **$\text{EQUAL}\le_{m}\text{HALF-AND-HALF}$** ➔ $f(w) := $ **sort $w$**.
$$w\in\text{EQUAL} \iff \#\mathtt{a}(w)=\#\mathtt{b}(w) \iff \#\mathtt{a}(f(w))=\#\mathtt{b}(f(w)) \iff f(w)=\mathtt{a}^{n}\mathtt{b}^{n} \iff f(w)\in\text{HALF-AND-HALF}$$
  - **Why it works** ➔ sorting **preserves letter frequencies** and forces the canonical $\mathtt{a}$s-then-$\mathtt{b}$s shape, so the counting property survives and the ordering property is manufactured.
- **$\text{HALF-AND-HALF}\le_{m}\text{PARENTHESES}$** ➔ scan $w$ left to right; if the previous letter was $\mathtt{b}$ and the current is $\mathtt{a}$ (i.e. the substring $\mathtt{ba}$, impossible in HALF-AND-HALF) **output the single string** `)` and stop; otherwise replace $\mathtt{a}\mapsto\texttt{(}$ and $\mathtt{b}\mapsto\texttt{)}$.
  - **Two failure routes, one target** ➔ wrong *order* is caught by the $\mathtt{ba}$ guard, which emits a lone unmatched `)`; wrong *counts* survive to $\texttt{(}^{i}\texttt{)}^{j}$ with $i\neq j$. Both land outside PARENTHESES, and $\mathtt{a}^{n}\mathtt{b}^{n}\mapsto\texttt{(}^{n}\texttt{)}^{n}$, which is balanced (see [[Writing a CFG]]).
- **$\text{EQUAL}\le_{m}\text{PARENTHESES}$** ➔ **compose** the two above; justified by transitivity, no new construction needed.
- **$\text{FA-Empty}\le_{m}\text{No-Digraph-Path}$** ➔ given $\langle A\rangle$: vertices $:=$ states of $A$; every transition $v\xrightarrow{x}w$ becomes a directed edge $(v,w)$; add a **new vertex $t$** and an edge $(v,t)$ from **every** Final State $v$; set $s :=$ the Start State's vertex; output $\langle G,s,t\rangle$.
$$\langle A\rangle\in\text{FA-Empty} \iff \text{no transition sequence Start}\to\text{Final} \iff \text{no } s\text{–}t \text{ path in } G \iff \langle G,s,t\rangle\in\text{No-Digraph-Path}$$
  - **What the new sink buys** ➔ collapsing *many* Final States into the **single** target $t$ converts "reaches **some** Final State" into the standard single-pair reachability question ([[Walks, Trails, and Paths]]); letters are discarded because emptiness ignores which word is read.
- **$\text{RegExpEquiv}\le_{m}\text{FA-Empty}$** ➔ $f(\langle A,B\rangle) := $ the FA $C$ for $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$; the symmetric difference is empty iff the languages agree. **This is the [[Deciding Properties of FAs and CFGs|Lecture-20 decidability proof]] re-read as a reduction** — same construction, now named.

## 🚫 Reducing *from* a decidable language is worthless
> [!IMPORTANT] **Theorem.** If $L_{1}$ is decidable and $L_{2}$ is any language except $\emptyset$ and $\Sigma^{*}$, then $L_{1}\le_{m}L_{2}$.

- **Construction** ➔ let $D$ decide $L_{1}$; pick a fixed $x^{(\text{yes})}\in L_{2}$ and a fixed $x^{(\text{no})}\notin L_{2}$ (both exist precisely because $L_{2}\neq\emptyset,\Sigma^{*}$). Define $f(w) := x^{(\text{yes})}$ if $D$ accepts $w$, else $x^{(\text{no})}$.
- **The lecture's joke instance** ➔ $\text{EnglishPalindromes}\le_{m}\text{YearsOfTransitsOfVenus}$ by outputting $2012$ on a palindrome and $2021$ otherwise.
- **⚡ Key Constraint:** the reduction has **already decided $L_{1}$ inside $f$** — so it transfers nothing and proves nothing. **Reductions are only informative when the source language is *not* known to be decidable**, which is why every serious use runs *from* an undecidable language.
- **Where the two excluded cases go** ➔ $L_{2}=\emptyset$ has no $x^{(\text{yes})}$ and $L_{2}=\Sigma^{*}$ has no $x^{(\text{no})}$, so a constant-valued $f$ cannot separate the two answers.

## ⚠️ Common Mistakes
- 💡 **Reducing the wrong way** ➔ the single biggest mark-killer. $K\le_{m}L$ pushes **hardness up** and **easiness down**: it lets you conclude "$L$ decidable $\Rightarrow K$ decidable" and "$K$ undecidable $\Rightarrow L$ undecidable" — never the reverse of either.
- 💡 **Proving only one direction** ➔ $x\in K\Rightarrow f(x)\in L$ is **half** a reduction. The converse forbids $f$ from mapping a No-instance onto a Yes-instance; without it the composite decider accepts too much.
- 💡 **Treating $f$ as a decider** ➔ $f$ outputs a **string**, not a verdict, and is not allowed to consult an oracle for $K$. If your $f$ needs to know whether $x\in K$, you have assumed what you are proving.
- 💡 **Forgetting $f$ must handle malformed input** ➔ every $x\in\Sigma^{*}$ needs an image, including strings that encode no object; map them to any fixed non-member of $L$.
- 💡 **Assuming $\le_{m}$ is symmetric** ➔ it is **reflexive and transitive** (a preorder), not an equivalence. $K\le_{m}L$ says nothing about $L\le_{m}K$.

## 🧠 Active Recall
> [!FAQ]- You want to prove that a new language $L$ is undecidable. Which language do you reduce, and in which direction — and why does the other direction fail?
> > [!SUCCESS]- Answer
> > - **Short answer:** reduce a **known-undecidable** $K$ **to** $L$, i.e. build $f$ with $x\in K\iff f(x)\in L$, giving $K\le_{m}L$; the corollary then forces $L$ undecidable.
> > - **Why:** **A decider for $L$ would manufacture one for $K$** ➔ compute $f(x)$, run it, echo. Since none exists for $K$, none can exist for $L$. The reverse direction $L\le_{m}K$ would only say "$L$ is no harder than something hard" — compatible with $L$ being trivially decidable, so it carries no information.

> [!FAQ]- Why does the theorem "every decidable $L_1$ reduces to every non-trivial $L_2$" not make reducibility useless?
> > [!SUCCESS]- Answer
> > - **Short answer:** because that reduction **smuggles a decider for $L_{1}$ inside $f$**. It is only available when $L_{1}$ was already decidable, so it transports no information — the transfer theorem still holds, it just tells you something you knew.
> > - **Why:** **The content of $K\le_{m}L$ lies in what $K$ is** ➔ reductions become informative exactly when the source is *not* known to be decidable, so the conclusion "$L$ is undecidable" is genuinely new. It also shows $\le_{m}$ is far too coarse to compare *decidable* languages — separating those needs a resource bound, which is the complexity material still to come.
