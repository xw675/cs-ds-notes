---
unit: FIT2014
domain: D
week: 6
source: [lecture]
parent: "[[Pumping Lemma for Context-Free Languages]]"
tags: [Math/Theory, Math/Proof, CS/Computation, CS/Languages]
type: pattern
aliases: [non-context-free, not context-free, a^n b^n a^n, a^n b^n c^n, CFL pumping proof, uvxyz proof]
---
# [[Proving a Language Non-Context-Free]]

**Context:** [[FIT2014_MOC]] · the exam-standard use of the [[Pumping Lemma for Context-Free Languages|CFL pumping lemma]] · the outer-ring twin of [[Proving a Language Non-Regular]]
**Problem it solves:** given a language, prove it is **not** context-free — i.e. no [[Context-Free Grammars (CFG)|CFG]] and no [[Pushdown Automata (PDA)|PDA]] can handle it.

> [!abstract] Quick Revision
> - **🎯 Trigger:** the language needs **three or more** unboundedly-coupled counts (or two interleaved copies) ➔ two pumping blocks cannot keep them all in step.
> - **⚠️ Key Constraint:** you choose $w$; you must then defeat **every** decomposition $w=uvxyz$ with $vy\neq\varepsilon$ and $|vxy|\le 2^{k}$ — so the case split must be **exhaustive**, not illustrative.

## 📐 The recipe
1. **Assume** $L$ is context-free ⟹ it has a CFG ⟹ it has one in [[Chomsky Normal Form|CNF]] generating $L\setminus\{\varepsilon\}$.
2. **Let $k$** = number of nonterminals in that CNF grammar. *(You never see the grammar; $k$ is just a number the lemma hands you.)*
3. **Choose a suitable $w\in L$** with $|w|>2^{k-1}$ — parameterise it so the length condition is satisfiable, e.g. take $N>2^{k-1}/3$ and $w=\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{a}^{N}$.
4. **Consider any** $u,v,x,y,z$ with $w=uvxyz$, $vy\neq\varepsilon$, $|vxy|\le 2^{k}$.
5. **Exhibit an $i\ge 0$** with $uv^{i}xy^{i}z\notin L$ — in **every** case.
6. **Contradiction** with the lemma ⟹ $L$ is **not** context-free. $\blacksquare$

- **⚡ The case split writes itself** ➔ partition on **where $v$ and $y$ sit**: (1) each inside a single homogeneous stretch, (2) one of them **straddles a boundary**. Straddling cases die instantly, because pumping creates a **second occurrence of a boundary pattern**.

## 🥇 Worked example — $L=\{\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}: n\ge 0\}=\{\varepsilon,\mathtt{aba},\mathtt{aabbaa},\dots\}$
**Theorem.** $L$ is not context-free.
**Proof (by contradiction).** Assume it is. Take its CNF grammar, let $k$ = #nonterminals, take $N>2^{k-1}/3$ so that $|w|=3N>2^{k-1}$, and choose $w=\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{a}^{N}$. Consider any $u,v,x,y,z$ with $w=uvxyz$, $vy\neq\varepsilon$, $|vxy|\le 2^{k}$.

| Case | Where $v,y$ sit | Pumped word | Why it leaves $L$ |
| :--- | :--- | :--- | :--- |
| **1** | $v$ and $y$ are each **all $\mathtt{a}$s, all $\mathtt{b}$s, or empty** | $uv^{2}xy^{2}z$ | each of $v,y$ lies **inside one** of the **three** stretches, so **≥1 stretch is unaltered**; since $vy\neq\varepsilon$, **≥1 other stretch grows** ⟹ the three lengths can no longer be equal |
| **2** | $v$ **or** $y$ contains $\mathtt{ab}$ | $uv^{2}xy^{2}z$ | the word now has **two occurrences of $\mathtt{ab}$**; every word of $L$ has **at most one** |
| **3** | $v$ **or** $y$ contains $\mathtt{ba}$ | $uv^{2}xy^{2}z$ | same argument — **two occurrences of $\mathtt{ba}$**, impossible in $L$ |

In every case some $i$ (here $i=2$) gives $uv^{i}xy^{i}z\notin L$, violating the lemma. Contradiction ⟹ $L$ is **not context-free**. $\blacksquare$

- **🔑 The counting principle** ➔ **two** pumping blocks can keep **two** counts in step ($\mathtt{a}^{n}\mathtt{b}^{n}$ is context-free: pump $v=\mathtt{a},\,y=\mathtt{b}$). **Three** coupled counts exhaust them — that is precisely the CFL frontier.
- **Note the unused hypothesis** ➔ this proof never needs $|vxy|\le 2^{k}$; the three-stretch pigeonhole alone does the work. Practice 2 is where that bound earns its keep.

## ✍️ Practice
> [!QUESTION]- Practice 1: prove $L=\{\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{c}^{n}: n\ge 0\}$ is not context-free.
> > [!SUCCESS]- Reference solution
> > 1. Assume context-free; take a CNF grammar with $k$ nonterminals; take $N>2^{k-1}/3$ and $w=\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{c}^{N}\in L$, so $|w|=3N>2^{k-1}$.
> > 2. Take any $u,v,x,y,z$ with $w=uvxyz$, $vy\neq\varepsilon$, $|vxy|\le 2^{k}$.
> > 3. **Case A — $v,y$ each within one letter-block.** They occupy at most **two** of the three blocks, so **one block is untouched** while $vy\neq\varepsilon$ grows another ⟹ $uv^{2}xy^{2}z$ has unequal counts ⟹ $\notin L$.
> > 4. **Case B — $v$ or $y$ straddles a boundary** (contains $\mathtt{ab}$ or $\mathtt{bc}$). Then $uv^{2}xy^{2}z$ has letters **out of order** (e.g. an $\mathtt{a}$ after a $\mathtt{b}$), and every word of $L$ is sorted $\mathtt{a}$s-then-$\mathtt{b}$s-then-$\mathtt{c}$s ⟹ $\notin L$.
> > 5. Contradiction ⟹ $L$ is not context-free. $\blacksquare$
> > - **Key move:** identical skeleton to $\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$ — **three blocks, two pumping sites**. Only the "why it leaves $L$" reason changes (order violation instead of a repeated $\mathtt{ab}$).

> [!QUESTION]- Practice 2 *(harder — this one genuinely needs $|vxy|\le 2^{k}$)*: prove $L=\{\mathtt{a}^{i}\mathtt{b}^{j}\mathtt{c}^{m}: 0\le i\le j\le m\}$ is not context-free.
> > [!SUCCESS]- Reference solution
> > 1. Assume context-free; CNF grammar with $k$ nonterminals; choose $N>2^{k}$ **and** $3N>2^{k-1}$, and $w=\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{c}^{N}\in L$ (since $N\le N\le N$).
> > 2. Take any valid $u,v,x,y,z$. Because $|vxy|\le 2^{k}<N$ and the $\mathtt{b}$-block has length $N$, the window $vxy$ **cannot contain both an $\mathtt{a}$ and a $\mathtt{c}$**.
> > 3. **Case A — $vxy$ contains no $\mathtt{c}$.** **Pump up** ($i=2$): the $\mathtt{c}$-count stays $N$ while $\#\mathtt{a}+\#\mathtt{b}=2N+|vy|>2N$. But $i\le j\le m=N$ forces $i+j\le 2N$ ⟹ $\notin L$.
> > 4. **Case B — $vxy$ contains no $\mathtt{a}$.** **Pump down** ($i=0$): the $\mathtt{a}$-count stays $N$. If $vy$ contains a $\mathtt{b}$ then $j<N=i$, breaking $i\le j$; otherwise $vy$ is all $\mathtt{c}$s so $m<N=j$, breaking $j\le m$ ⟹ $\notin L$.
> > 5. Contradiction ⟹ $L$ is not context-free. $\blacksquare$
> > - **Key move:** the **locality bound** $|vxy|\le 2^{k}$ is what forces the two-case split — it is the CFL analogue of the regular lemma's $|x|+|y|\le N$, and picking $N>2^{k}$ is what makes it bite.

## ⚠️ Common Mistakes
- 💡 **You choose $w$; you do NOT choose $u,v,x,y,z$** ➔ the lemma says such a decomposition **exists**; to contradict it you must defeat **every** one. Picking a convenient $v,y$ yourself is the most common invalid proof.
- 💡 **Forgetting that $v$ or $y$ may be empty** ➔ only $vy\neq\varepsilon$ is guaranteed. Case analyses that assume both are non-empty miss decompositions.
- 💡 **Forgetting the straddling cases** ➔ a proof that only handles "$v,y$ inside single blocks" is **incomplete** and loses marks even though those cases are the easy ones.
- 💡 **Reusing the regular lemma's shape** ➔ there is no $|uv|\le N$ prefix bound here; the constraint is $|vxy|\le 2^{k}$ and it pins a **window**, not a prefix.
- 💡 **This never proves context-freeness** ➔ to show $L$ **is** a CFL, build a [[Context-Free Grammars (CFG)|CFG]] or a [[Pushdown Automata (PDA)|PDA]].

## 🧠 Active Recall
> [!FAQ]- Why is $\mathtt{a}^{n}\mathtt{b}^{n}$ context-free while $\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$ is not?
> > [!SUCCESS]- Answer
> > - **Short answer:** the CFL lemma gives **two** pumping blocks, $v$ and $y$, incremented **in lockstep**. Two blocks can maintain **two** coupled counts ($v=\mathtt{a}$, $y=\mathtt{b}$ keeps them equal), but with **three** stretches at least one is always left behind ⟹ equality breaks.
> > - **Why:** **Blocks vs counts** ➔ the same accounting explains the whole hierarchy: the [[Pumping Lemma for Regular Languages|regular]] lemma pumps **one** block, so it already fails at $\mathtt{a}^{n}\mathtt{b}^{n}$; a [[Pushdown Automata (PDA)|PDA]]'s single stack can match **one** pair of counts, not two nested pairs.
