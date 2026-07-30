---
unit: FIT2014
domain: D
week: 6
source: [lecture]
parent: "[[Context-Free Grammars (CFG)]]"
tags: [Math/Theory, Math/Proof, CS/Computation, CS/Languages]
aliases: [CFL pumping lemma, pumping lemma for CFLs, uvxyz, uvxyz decomposition, repeated nonterminal, non-context-free]
---
# [[Pumping Lemma for Context-Free Languages]]

**Context:** [[FIT2014_MOC]] · the property **every** CFL must have ➔ the tool that proves some languages are **not context-free**, closing the outer ring after [[Pumping Lemma for Regular Languages]] closed the inner one · applied in [[Proving a Language Non-Context-Free]]
**Parent Framework:** [[Context-Free Grammars (CFG)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** in a [[Chomsky Normal Form|CNF]] grammar with $k$ nonterminals, any generated word longer than $2^{k-1}$ forces a **repeated nonterminal on a root-to-leaf path** ➔ the subtree between the two copies can be **re-inserted or deleted**, pumping **two** substrings at once.
> - **📦 Core Components:** $w=uvxyz$ ➔ $v,y$ pump | $x$ = inner subtree's yield | $u,z$ = untouched flanks.
> - **⚡ Key Constraint:** **necessary, not sufficient** — it proves non-context-freeness only. And unlike the regular case you must pump **two** blocks *simultaneously*, which is what the case analysis has to defeat.

## 🌳 Why a long word forces a repeated nonterminal
- **Path length = non-leaf nodes** ➔ in a parse tree, each non-leaf node carries a **nonterminal** symbol.
- **Naive bound** ➔ if some root-to-leaf path is longer than the number of nonterminals in the grammar, **some nonterminal appears twice** on it (pigeonhole).
- **The gap** ➔ nothing yet guarantees a **long word** produces a **long path** — a wide flat tree would defeat it. **CNF closes the gap:**
$$2^{\,\text{max path length}-1}\;\ge\;\#\text{leaves}\;=\;|w|$$
- **Consequence** ➔ if $|w|>2^{k-1}$ then $2^{\text{max path}-1}>2^{k-1}$, so $\text{max path length}>k$ ⟹ **a nonterminal repeats** on that path. *(This is exactly what CNF's binary shape is for.)*

## 📜 The lemma
**Theorem (Pumping Lemma for CFLs).** Let $L$ be a context-free language with a CNF grammar having $k$ nonterminal symbols. Then for **every** $w\in L$ with $|w|>2^{k-1}$ there **exist** strings $u,v,x,y,z$ with $vy\neq\varepsilon$ (i.e. $v,y$ **not both** empty) such that:
1. $w=uvxyz$
2. $|vxy|\le 2^{k}$
3. for **all** $i\ge 0$: $uv^{i}xy^{i}z\in L$ — i.e. $uxz,\;uvxyz,\;uvvxyyz,\;\dots\in L$

**Symbolically:**
$$\forall w\in L:\ |w|>2^{k-1}\Rightarrow\Big(\exists u,v,x,y,z:\ (w=uvxyz)\wedge(vy\neq\varepsilon)\wedge(|vxy|\le 2^{k})\wedge(\forall i\ge 0:\ uv^{i}xy^{i}z\in L)\Big)$$

## 🧮 Proof Blueprint
**Theorem.** As stated above.

**Strategy.** Pigeonhole a repeated nonterminal onto a root-to-leaf path of a **CNF** parse tree, then splice the subtree between the two copies.

**Derivation.**
$$
\begin{aligned}
\text{Take } w\in L,\ |w|>2^{k-1} &\Rightarrow \text{some root-to-leaf path } P \text{ repeats a nonterminal (above)} \\
\text{Choose } q \text{ above } r \text{ on } P,\ \text{same nonterminal,} &\ q \textbf{ as far down } P \textbf{ as possible} \\
 &\Rightarrow \text{all nonterminals below } q \text{ on } P \text{ are distinct} \\
u,z &= \text{letters left / right of the subtree } T_q \\
v,y &= \text{leaves of } T_q \text{ left / right of the subtree } T_r \\
x &= \text{leaves of } T_r \\
\Rightarrow w &= uvxyz \quad\text{(by construction)} \\
vy\neq\varepsilon:\ \text{CNF} \Rightarrow q \text{ has \textbf{two} children}&,\ \text{only one above } r,\ \text{so } T_q \text{ has leaves outside } T_r \\
|vxy|\le 2^{k}:\ \text{subpath } q\!\downarrow \text{ has} \le k+2 \text{ nodes}&\ (q,\ \le k \text{ distinct nonterminals},\ \text{leaf}) \\
 &\Rightarrow \text{its length} \le k+1 \Rightarrow T_q \text{ has} \le 2^{k}\text{ leaves} = vxy \\
\text{Replace } T_q \text{ by } T_r &\Rightarrow \text{a parse tree for } uxz \quad (i=0) \\
\text{Replace } T_r \text{ by } T_q &\Rightarrow \text{a parse tree for } uvvxyyz \quad (i=2) \\
\text{The new } T_q \text{ contains a fresh copy of } T_r&,\ \text{so the splice repeats} \Rightarrow uv^{i}xy^{i}z\in L\ \forall i\ge 0
\end{aligned}
$$
**Q.E.D.** $\blacksquare$ *(The final step is formalised by induction on $i$.)*

---
## ⚖️ A Tale of Two Pumping Lemmas
| | [[Pumping Lemma for Regular Languages|Regular]] | **Context-free** |
| :--- | :--- | :--- |
| Object with the bound | **FA** with $N$ states | **CNF grammar** with $k$ nonterminals |
| "Sufficiently long" | $\vert w\vert\ge N$ | $\vert w\vert>2^{k-1}$ |
| What repeats | a **state** on the accepting **path** | a **nonterminal** on a **root-to-leaf path** |
| Decomposition | $w=xyz$ | $w=uvxyz$ |
| Blocks pumped | **one** ($y$) | **two, in lockstep** ($v$ and $y$) |
| Non-emptiness | $y\neq\varepsilon$ | $vy\neq\varepsilon$ *(either may be empty, not both)* |
| Locality bound | $\vert x\vert+\vert y\vert\le N$ | $\vert vxy\vert\le 2^{k}$ |
| Conclusion | $xy^{i}z\in L\ \forall i\ge 0$ | $uv^{i}xy^{i}z\in L\ \forall i\ge 0$ |

> [!NOTE] **When It Flips:** a language that **survives** the regular lemma's failure is often context-free by pumping two blocks — $\mathtt{a}^{n}\mathtt{b}^{n}$ pumps $v=\mathtt{a},y=\mathtt{b}$ together. Three coupled blocks ($\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$) is where **two** pumping sites run out, and that is the CFL frontier.

---
## ⚠️ Common Mistakes
- 💡 **$vy\neq\varepsilon$, not $v\neq\varepsilon\wedge y\neq\varepsilon$** ➔ **one** of them may be empty; only the pair must be non-empty. A proof that assumes both are non-empty is incomplete.
- 💡 **The bound is on $|vxy|$, not $|uv|$** ➔ the regular lemma bounds a **prefix**; here the bound confines the pumped material **plus the gap between the two blocks**, and it can sit anywhere in $w$.
- 💡 **Necessary, not sufficient** ➔ satisfying the lemma never proves a language **is** context-free; build a [[Context-Free Grammars (CFG)|CFG]] or [[Pushdown Automata (PDA)|PDA]] for that.
- 💡 **$k$ counts nonterminals in the CNF grammar** ➔ not states, not terminals, not rules — and the grammar must be in [[Chomsky Normal Form]] for the $2^{k-1}$ bound to hold at all.
- 💡 **$i=0$ is legal** ➔ $uxz$ (delete both blocks) is as valid a pumped word as $uv^2xy^2z$.

## 🧠 Active Recall
> [!FAQ]- Where exactly does [[Chomsky Normal Form]] enter the proof, and what breaks without it?
> > [!SUCCESS]- Answer
> > - **Short answer:** twice. **(1)** Binary trees give $2^{\text{max path}-1}\ge|w|$, converting "long word" into "long path" and hence a **repeated nonterminal** — without it a flat wide tree gives a long word with a short path. **(2)** Binariness forces node $q$ to have **two** children with only one above $r$, which is what guarantees $vy\neq\varepsilon$.
> > - **Why:** **Ban shrinking and renaming** ➔ CNF has no $\varepsilon$-rules and no unit rules, so no derivation step wastes tree height; every level genuinely doubles the maximum yield, making both the $2^{k-1}$ threshold and the $2^{k}$ locality bound exact.

> [!FAQ]- Why must $q$ be chosen **as far down** the path as possible?
> > [!SUCCESS]- Answer
> > - **Short answer:** it guarantees every nonterminal **below $q$** on the path is **distinct**, so that subpath has at most $k+2$ nodes ⟹ length $\le k+1$ ⟹ $T_q$ has at most $2^{k}$ leaves ⟹ $|vxy|\le 2^{k}$.
> > - **Why:** **The locality bound is bought by the choice** ➔ any repeated pair would give conditions 1 and 3, but only the **lowest** repetition bounds the subtree's height, and it is that bound which later confines $v$ and $y$ to a short window of $w$ — the leverage used in [[Proving a Language Non-Context-Free]].
