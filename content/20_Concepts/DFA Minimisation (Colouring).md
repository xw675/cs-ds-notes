---
unit: FIT2014
week: 4
parent: "[[Finite Automata (DFA and NFA)]]"
tags: [Math/Theory, CS/Computation, CS/Languages, Monash/CS_DS]
type: pattern
aliases: [DFA minimisation, minimum DFA, state minimisation, colouring algorithm, partition refinement, simplifying finite automata]
---
# [[DFA Minimisation (Colouring)]]

**Context:** [[FIT2014_MOC]] · step 3 of the pipeline **regex → NFA → DFA → simplify** · shrinks the [[NFA to DFA (Subset Construction)|subset-construction]] blow-up back down
**Problem it solves:** given a DFA, produce an equivalent DFA with the **fewest possible states**.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a DFA (usually one that came out of the subset construction with redundant states) ➔ **colour** states, then repeatedly **split** colours whose rows disagree.
> - **⚡ Key Constraint:** **different colours ⟹ definitely different states; same colour ⟹ only *possibly* mergeable.** Sameness is provisional and must survive every refinement round.

## 🎨 The colouring principle
- **Seed** ➔ a Final state and a non-Final state are **fundamentally different** and can never be combined. Give all Final states **one colour** and all non-Final states **a different colour**.
- **Different colours** $\Rightarrow$ different states — they **cannot** be combined.
- **Same colour** $\not\Rightarrow$ same states — they **may or may not** be combinable; you have merely not yet ruled it out.
- **Refinement rule** ➔ if two states share a colour but their transition rows lead to **different colour patterns**, they are distinguishable, so the colour must **split**.

## ⚙️ The algorithm
1. **Colour** all Final states one colour; all non-Final states another.
2. **Repeat:**
   - For each colour used so far, consider all states of that colour.
   - Rewrite each state's row in terms of the **colours** its transitions lead to.
   - **If those rows do not all share the same colour pattern**, split: give each distinct row-pattern a **new colour** (states with the same row pattern keep a common colour).
3. **Until** no new colour is added in a full pass.
4. **Number** the colours and read off the transition table — each colour is one state of the minimal DFA.

## 📊 Worked trace
Starting DFA from the subset construction for $(\mathtt{a}\cup\mathtt{bb}\cup\mathtt{baa}^{*}\mathtt{b})^{*}\mathtt{baa}^{*}$:

| | State | $\mathtt{a}$ | $\mathtt{b}$ |
| :--- | :--- | :--- | :--- |
| **Start** | $\{1,2,8\}$ | $\{2,8\}$ | $\{3,4,9\}$ |
| | $\{2,8\}$ | $\{2,8\}$ | $\{3,4,9\}$ |
| | $\{3,4,9\}$ | $\{5,6,7,10,11,12\}$ | $\{2,8\}$ |
| **Final** | $\{5,6,7,10,11,12\}$ | $\{6,7,11,12\}$ | $\{2,8\}$ |
| **Final** | $\{6,7,11,12\}$ | $\{6,7,11,12\}$ | $\{2,8\}$ |

**Round 1** ➔ colour Finals **blue**, non-Finals **red**. Rows become:

| State | colour | $\mathtt{a}$ → | $\mathtt{b}$ → |
| :--- | :--- | :--- | :--- |
| $\{1,2,8\}$ | red | red | red |
| $\{2,8\}$ | red | red | red |
| $\{3,4,9\}$ | red | **blue** | red |
| $\{5,6,7,10,11,12\}$ | blue | blue | red |
| $\{6,7,11,12\}$ | blue | blue | red |

**Round 2** ➔ among the reds, $\{3,4,9\}$ has row (blue, red) while the other two have (red, red) ⟹ **split**: $\{3,4,9\}$ becomes **green**. The blues agree, so they stay merged.

**Result** ➔ three colours ⟹ a **3-state** minimal DFA (down from 5):

| | State | $\mathtt{a}$ | $\mathtt{b}$ |
| :--- | :--- | :--- | :--- |
| **Start** | 1 (red) | 1 | 2 |
| | 2 (green) | 3 | 1 |
| **Final** | 3 (blue) | 3 | 1 |

## 🖥️ Implementing a finite automaton
Once minimised, the machine is trivial to run from its table:
- **Keep** a `currentState` variable, initialised to the Start state.
- **Loop** while input letters remain: read the next letter and set `currentState` to the table entry for (current state, that letter).
- **Finish** by reporting a **match** if `currentState` is a Final state, otherwise no match.
- **Note** ➔ better algorithms exist: some build a **minimum-state DFA directly from a regular expression** without an intermediate NFA, and there are more compact table encodings than the plain two-dimensional array.

## ✍️ Practice
> [!QUESTION]- Practice: A 4-state DFA has Start $A$; $A\xrightarrow{\mathtt{a}}B$, $A\xrightarrow{\mathtt{b}}A$; $B\xrightarrow{\mathtt{a}}B$, $B\xrightarrow{\mathtt{b}}C$; $C$ Final with $C\xrightarrow{\mathtt{a}}B$, $C\xrightarrow{\mathtt{b}}A$; $D$ Final, unreachable, with $D\xrightarrow{\mathtt{a}}B$, $D\xrightarrow{\mathtt{b}}A$. Minimise.
> > [!SUCCESS]- Reference solution
> > 1. **Colour** ➔ Finals $\{C,D\}$ blue; non-Finals $\{A,B\}$ red.
> > 2. **Rows by colour** ➔ $A$: (red, red) · $B$: (red, **blue**) · $C$: (red, red) · $D$: (red, red).
> > 3. **Split the reds** ➔ $A$ is (red, red) but $B$ is (red, blue) ⟹ $B$ gets its own colour. The blues $C,D$ agree ⟹ stay merged.
> > 4. **Result** ➔ 3 states: $\{A\}$, $\{B\}$, $\{C,D\}$.
> > - **Key move:** $C$ and $D$ have identical rows *and* the same Final status, so they merge — this is exactly how unreachable or duplicated states are absorbed.

## ⚠️ Common Mistakes
- 💡 **Compare colour patterns, not destination names** ➔ two rows count as matching when they lead to the **same colours**, even if the named target states differ. This is what lets distinct states merge.
- 💡 **Never merge a Final with a non-Final** ➔ that distinction is the seed of the whole algorithm and is preserved by every refinement.
- 💡 **Re-examine every colour each round** ➔ a split can make a previously-agreeing colour disagree; keep iterating until a **full pass** adds nothing.
- 💡 **Same colour is provisional** ➔ states sharing a colour are only "not yet shown different"; only the **final** partition licenses merging.

## 🧠 Active Recall
> [!FAQ]- Why does the algorithm start by separating Final from non-Final states?
> > [!SUCCESS]- Answer
> > - **Short answer:** they are **behaviourally distinguishable by the empty string**: from a Final state $\varepsilon$ is accepted, from a non-Final state it is not. Merging them would change the language, so they must carry different colours from the outset.
> > - **Why:** **Seeding the partition** ➔ every later split is derived from this one: if two states send some letter into differently-coloured states, they too are distinguishable, and refinement propagates that difference backwards until the partition stabilises.

> [!FAQ]- Two states have the same colour after the algorithm terminates. What does that license, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** they can be **merged into a single state** of the minimal DFA — the algorithm has stabilised, so **no string** distinguishes them: every input drives them through identically-coloured states and they agree on acceptance.
> > - **Why:** **Fixpoint = indistinguishability** ➔ termination means no row-pattern disagreement remains, so the colours are exactly the equivalence classes of the "same behaviour on all inputs" relation, and merging each class yields the fewest possible states.
