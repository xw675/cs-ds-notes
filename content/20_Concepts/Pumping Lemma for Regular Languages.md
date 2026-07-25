---
unit: FIT2014
domain: D
week: 4
parent: "[[Finite Automata (DFA and NFA)]]"
tags: [Math/Theory, Math/Proof, CS/Computation, CS/Languages]
aliases: [pumping lemma, pumping, circuit in FA, non-regular, xyz decomposition, pumping length]
---
# [[Pumping Lemma for Regular Languages]]

**Context:** [[FIT2014_MOC]] · the property **every** infinite regular language must have ➔ the tool that finally proves some languages are **not** regular · applied in [[Proving a Language Non-Regular]]

> [!abstract] Quick Revision
> - **🎯 Objective:** in an FA with $N$ states, any accepted word of length $\ge N$ must **repeat a state**, so its path contains a **circuit** ➔ the looping segment can be repeated ("**pumped**") any number of times and the word stays in the language.
> - **⚡ Key Constraint:** the lemma is a **necessary, not sufficient** condition — it can prove a language **non**-regular, but satisfying it never proves a language **is** regular.

## 🔁 Circuits in finite automata
- **Circuit** ➔ a directed path that **starts and ends at the same state**; its **length** is the number of edges.
- **Observation (pigeonhole)** ➔ take any FA and any string $w$ with **at least as many letters as the FA has states**. The path for $w$ must **revisit a state**, so it **contains a circuit**.
- **Natural split** ➔ $w=xyz$ where
  - $x$ = the part **before** the circuit,
  - $y$ = the part that **goes around** the circuit,
  - $z$ = the part **after** the circuit.

## 📜 The lemma
**Theorem (Pumping Lemma).** Let $L$ be an **infinite regular language**, accepted by an FA with $N$ states. Then for **all** words $w\in L$ with $|w|\ge N$, there **exist** strings $x,y,z$ with $y\neq\varepsilon$ such that:
1. $w=xyz$
2. $|x|+|y|\le N$
3. for **all** $i\ge 0$: $xy^{i}z\in L$ — i.e. $xz,\ xyz,\ xyyz,\ xyyyz,\ \dots\in L$

**Symbolically:**
$$\forall w\in L:\ |w|\ge N\ \Rightarrow\ \big(\exists x,y,z:\ (w=xyz)\wedge(y\neq\varepsilon)\wedge(|x|+|y|\le N)\wedge(\forall i\ge 0:\ xy^{i}z\in L)\big)$$

- **⚠ $y\neq\varepsilon$** ➔ the pumped segment **cannot be empty**, otherwise the statement would be vacuous.
- **$i=0$ is allowed** ➔ "pumping down" to $xz$ (deleting the loop) is just as legitimate as pumping up.

## 🧮 Formal Proof Blueprint
**Theorem.** As stated above.

**Strategy.** Pigeonhole on states, then exploit that a circuit returns to the same state.

**Derivation.**
$$
\begin{aligned}
\text{Take } w\in L,\ |w|\ge N &\Rightarrow \text{the path for } w \text{ revisits a state, so it contains a circuit} \\
\text{Let } x &= \text{letters of } w \text{ up to the first circuit} \\
y &= \text{letters corresponding to the circuit} \\
z &= \text{the remaining letters} \\
\Rightarrow w &= xyz \quad\text{(by construction)} \\
y &\neq\varepsilon \quad\text{(a circuit has}\ge 1\text{ edge)} \\
|x|+|y| &\le N \quad\text{(the FA reads } xy \text{ without repeating a state until the circuit closes)} \\
\text{Since } y \text{ starts and ends at } \mathrm{endState}(x)&,\ \text{it may be traversed any number of times;} \\
z \text{ then leads to the same Final state} &\Rightarrow xy^{i}z\in L \text{ for all } i\ge 0
\end{aligned}
$$
**Q.E.D.** $\blacksquare$

## ⚠️ Common Mistakes
- 💡 **Necessary, not sufficient** ➔ every infinite regular language satisfies the lemma, but **some non-regular languages satisfy it too**. Passing the pumping test proves nothing positive.
- 💡 **The quantifiers are the whole game** ➔ $\forall w$ (long enough), $\exists x,y,z$, $\forall i$. To *use* it for a contradiction you pick $w$ (you may choose it cleverly) but must handle **every** valid decomposition $x,y,z$.
- 💡 **$y\neq\varepsilon$ is mandatory** ➔ without it, taking $y=\varepsilon$ would satisfy the conclusion trivially for any language.
- 💡 **$|x|+|y|\le N$ is a gift, not decoration** ➔ it confines the loop to the **first $N$ letters** of $w$, which is exactly what collapses the case analysis in real proofs.
- 💡 **The lemma is stated for *infinite* regular languages** ➔ finite languages have no words long enough to force a circuit.

## 🧠 Active Recall
> [!FAQ]- Why must a sufficiently long accepted word give rise to a circuit in the automaton?
> > [!SUCCESS]- Answer
> > - **Short answer:** an FA with $N$ states reading a word of length $\ge N$ visits **at least $N+1$ states** (counting the start), so by the **pigeonhole principle** some state is visited twice — and the path between those two visits is a **circuit**.
> > - **Why:** **Finite memory** ➔ the automaton has no way to distinguish the two visits to that state, so whatever follows works identically from either; the loop can therefore be traversed $0,1,2,\dots$ times, giving $xy^{i}z\in L$.

> [!FAQ]- Why can the Pumping Lemma never be used to prove a language *is* regular?
> > [!SUCCESS]- Answer
> > - **Short answer:** it states a property that regularity **implies** (regular $\Rightarrow$ pumpable). Confirming the consequent does not establish the antecedent — that is the fallacy of affirming the consequent.
> > - **Why:** **One-way implication** ➔ it is only usable **contrapositively**: exhibit a word that cannot be pumped $\Rightarrow$ the language is **not** regular. To prove regularity you must instead *construct* a regular expression or finite automaton ([[Kleene's Theorem]]).
