---
unit: FIT2014
week: 3
parent: "[[Kleene's Theorem]]"
tags: [Math/Theory, CS/Computation, CS/Languages, Monash/CS_DS]
type: pattern
aliases: [subset construction, powerset construction, determinisation, NFA to FA, epsilon closure, endStates]
---
# [[NFA to DFA (Subset Construction)]]

**Context:** [[FIT2014_MOC]] · leg 2 of the [[Kleene's Theorem]] cycle · turns a convenient [[Finite Automata (DFA and NFA)|NFA]] into a deterministic machine · **Assignment 1 hand skill**
**Problem it solves:** given an NFA (possibly with $\varepsilon$-transitions), build a DFA recognising the same language.

> [!abstract] Quick Revision
> - **🎯 Trigger:** an NFA to determinise ➔ make each **set of NFA states** into a **single DFA state**, and fill a table until no new sets appear.
> - **⚡ Key Constraint:** whenever a state joins a set you must also add **everything reachable from it along $\varepsilon$-transitions** ($\varepsilon$-closure) — forgetting this is the standard error.

## 📐 The idea
- **In a DFA** ➔ a string $w$ traces a **unique** path to a single $\mathrm{endState}(w)$; accepted iff that state is Final; $\mathrm{endState}(\varepsilon)=$ Start State.
- **In an NFA** ➔ a string traces a **set of paths** ending in a **set** of states, $\mathrm{endStates}(w)$, which may have **zero, one or many** members; accepted iff $\mathrm{endStates}(w)$ **contains** a Final state.
- **The construction** ➔ $$\text{sets of states in the NFA}\;\longrightarrow\;\text{states in the DFA}$$
- **Step relation** (no $\varepsilon$-transitions) ➔
$$\mathrm{endStates}(wx)=\{q : \text{for some } p\in\mathrm{endStates}(w),\ \text{there is a transition } p\xrightarrow{\ x\ }q\}$$

## ⚙️ The procedure
1. **Start set** ➔ $\{\text{Start State of the NFA}\}$; then **add the $\varepsilon$-closure** (every state reachable from a member along $\varepsilon$-transitions). This set is the DFA's Start state.
2. **Take the first incomplete row** of the DFA table; call its set $X$.
3. **For each letter $x$** of the alphabet: compute $\{q:\ \exists p\in X \text{ with } p\xrightarrow{x}q\}$, then **add the $\varepsilon$-closure** of that set. Write it in row $X$, column $x$.
4. **If the resulting set is new**, add it as a new (incomplete) row.
5. **Repeat** until every row is complete — no new sets appear.
6. **Final states** ➔ any DFA state whose **set contains an NFA Final state** is labelled Final.

## 📊 Worked trace (no $\varepsilon$-transitions)
NFA: state 1 is Start with self-loops on $\mathtt{a},\mathtt{b}$ and $1\xrightarrow{\mathtt{b}}2$; $2\xrightarrow{\mathtt{a},\mathtt{b}}3$; state 3 Final.

| DFA state (set) | $\mathtt{a}$ | $\mathtt{b}$ | Final? |
| :--- | :--- | :--- | :--- |
| **Start** $\{1\}$ | $\{1\}$ | $\{1,2\}$ | — |
| $\{1,2\}$ | $\{1,3\}$ | $\{1,2,3\}$ | — |
| $\{1,3\}$ | $\{1\}$ | $\{1,2\}$ | ✓ (contains 3) |
| $\{1,2,3\}$ | $\{1,3\}$ | $\{1,2,3\}$ | ✓ (contains 3) |

- **Reading it** ➔ $\mathrm{endStates}(\mathtt{ab})=\{1,2\}$ and $\mathrm{endStates}(\mathtt{aba})=\{1,3\}$, which contains the Final state 3 — so $\mathtt{aba}$ is accepted.

## 📊 Worked trace (with $\varepsilon$-transitions)
NFA: $1$ Start with self-loop $\mathtt{a}$; $1\xrightarrow{\varepsilon}2$; $2$ self-loop $\mathtt{b}$; $2\xrightarrow{\varepsilon}3$; $3$ Final.

| DFA state (set) | $\mathtt{a}$ | $\mathtt{b}$ | Final? |
| :--- | :--- | :--- | :--- |
| **Start** $\{1,2,3\}$ | $\{1,2,3\}$ | $\{2,3\}$ | ✓ |
| $\{2,3\}$ | $\emptyset$ | $\{2,3\}$ | ✓ |
| $\emptyset$ | $\emptyset$ | $\emptyset$ | — |

- **Start set** ➔ $\{1\}$ closes under $\varepsilon$ to $\{1,2,3\}$ — the machine is "already" in states 2 and 3 before reading anything.
- **$\emptyset$ is a real state** ➔ it is the **dead/sink** state: once there, every letter keeps you there and it is never Final.

## ✍️ Practice 
> [!QUESTION]- Practice: An NFA has Start $1$ with $1\xrightarrow{\mathtt{a}}1$, $1\xrightarrow{\mathtt{a}}2$, and $2$ Final with no outgoing transitions. Determinise it.
> > [!SUCCESS]- Reference solution
> > | DFA state | $\mathtt{a}$ | $\mathtt{b}$ | Final? |
> > | :--- | :--- | :--- | :--- |
> > | **Start** $\{1\}$ | $\{1,2\}$ | $\emptyset$ | — |
> > | $\{1,2\}$ | $\{1,2\}$ | $\emptyset$ | ✓ |
> > | $\emptyset$ | $\emptyset$ | $\emptyset$ | — |
> > - **Key move:** the nondeterministic choice at $1$ on $\mathtt{a}$ becomes the **single** set $\{1,2\}$; the missing $\mathtt{b}$-transition becomes an explicit edge to $\emptyset$, making the DFA total. Language: one or more $\mathtt{a}$s.

## ⚠️ Common Mistakes
- 💡 **Forgetting the $\varepsilon$-closure** ➔ it must be applied to the **Start set** *and* after **every** letter step; omitting it produces a DFA that rejects strings the NFA accepts.
- 💡 **$\emptyset$ is a legitimate DFA state** ➔ don't leave the cell blank; the DFA must be **total**, and $\emptyset$ is the sink.
- 💡 **Final = *contains* an NFA Final state** ➔ the whole set need not consist of Final states; one member suffices (matching the NFA's "some path accepts" rule).
- 💡 **Sets, not sequences** ➔ $\{1,2\}$ and $\{2,1\}$ are the same DFA state; normalise the order so you don't create duplicate rows.

## 🧠 Active Recall
> [!FAQ]- Why does making each *set* of NFA states a single DFA state give the right language?
> > [!SUCCESS]- Answer
> > - **Short answer:** after reading $w$, the NFA could be in **any** state of $\mathrm{endStates}(w)$. Tracking that whole set deterministically records exactly the information needed, and the NFA accepts iff the set contains a Final state — which is precisely how the DFA's Final states are defined.
> > - **Why:** **Determinising the uncertainty** ➔ the nondeterministic "which path?" question is replaced by the deterministic "which set of states am I in?", and the step relation $\mathrm{endStates}(wx)$ makes that set a function of the previous set and the letter.

> [!FAQ]- How many states can the resulting DFA have, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** up to $2^{n}$ for an $n$-state NFA — the DFA's states are **subsets** of the NFA's state set, and in the worst case every subset is reachable.
> > - **Why:** **Powerset blow-up** ➔ this exponential cost is the price of determinism, and it is why NFAs remain the practical design notation even though the two models are equivalent by [[Kleene's Theorem]].
