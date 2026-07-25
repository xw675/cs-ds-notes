---
unit: FIT2014
domain: D
week: 1
parent: "[[Conjunctive Normal Form]]"
tags: [Math/Logic, Math/Theory, CS/Computation]
type: pattern
aliases: [encoding, propositional encoding, modelling in logic, seating problem, truth assignment, SAT encoding]
---
# [[Encoding Problems in Propositional Logic]]

**Context:** [[FIT2014_MOC]] · turning a **real-world problem** into a logical formula · the clause recipes live in [[CNF Encoding Patterns (At Least, At Most, Exactly)]]
**Problem it solves:** given an English scenario, define propositions and write a CNF formula whose satisfying assignments are exactly the valid solutions.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "write a Boolean expression representing …" ➔ run the four-step pipeline: **choose propositions → state constraints in English → formalise each → convert to CNF**.
> - **⚡ Key Constraint:** you **cannot assume physical common sense** — with $v$ propositions all $2^{v}$ assignments are candidates, so every "obvious" impossibility (one person in two seats) must be **explicitly forbidden** by a clause.

## 🔧 The four-step pipeline
1. **Choose propositions** ➔ strip extraneous detail; index by the things that matter. *Seating example:* $P_{F,s}$ = "friend $F$ is seated in seat $s$" for $F\in\{A,B,C\}$, $s\in\{13,14,15,16\}$ ⟹ $3\times 4=12$ propositions, hence $2^{12}$ truth assignments.
2. **State constraints in English** ➔ list rules that *exactly* characterise a valid solution:
   - (1) Each friend gets a seat.
   - (2) No friend occupies more than one seat.
   - (3) No seat is occupied by more than one friend.
3. **Formalise each rule** ➔ translate one rule at a time (below).
4. **Convert to CNF** ➔ push negations inward with De Morgan ([[Boolean Algebra Laws]]).

## 📐 Worked encoding (seating)
**Rule 1 — each friend $F$ gets a seat** (already a clause, hence already CNF):
$$P_{F,13}\vee P_{F,14}\vee P_{F,15}\vee P_{F,16}$$

**Rule 2 — no friend $F$ takes two seats** (forbid every *pair* of seats):
$$\neg(P_{F,13}\wedge P_{F,14})\wedge\neg(P_{F,13}\wedge P_{F,15})\wedge\dots\wedge\neg(P_{F,15}\wedge P_{F,16})$$
De Morgan on each conjunct $\big(\neg(p\wedge q)\equiv\neg p\vee\neg q\big)$ gives CNF:
$$(\neg P_{F,13}\vee\neg P_{F,14})\wedge(\neg P_{F,13}\vee\neg P_{F,15})\wedge\dots\wedge(\neg P_{F,15}\vee\neg P_{F,16})$$

**Rule 3 — no seat $s$ holds two friends** (same shape, over friend pairs):
$$(\neg P_{A,s}\vee\neg P_{B,s})\wedge(\neg P_{A,s}\vee\neg P_{C,s})\wedge(\neg P_{B,s}\vee\neg P_{C,s})$$

- **Recognise the shapes** ➔ Rule 1 is "**at least one**"; Rules 2–3 are "**at most one**" (pairwise negated clauses) — exactly the templates in [[CNF Encoding Patterns (At Least, At Most, Exactly)]].
- **Why CNF** ➔ a uniform encoding makes problems comparable and machine-checkable; this is the standard input shape used later in **complexity theory** and SAT.

## 🔀 Translating common English forms
| English | Formula | CNF form |
| :--- | :--- | :--- |
| at least one of $S$ | $\bigvee_{s\in S}s$ | already CNF |
| $P$ **only if** $Q$ | $P\Rightarrow Q$ | $(\neg P\vee Q)$ |
| **none or both** of $P,Q$ | $P\Leftrightarrow Q$ | $(\neg P\vee Q)\wedge(P\vee\neg Q)$ |
| **no more than one** of $P,Q,R$ | pairwise not-both | $(\neg P\vee\neg Q)\wedge(\neg P\vee\neg R)\wedge(\neg Q\vee\neg R)$ |

## ✍️ Practice
> [!QUESTION]- Practice: A guest list must include at least one of $\{H,R,He,G\}$; may include Hagrid only if it includes Norberta; includes none or both of Fred and George; and no more than one of $\{V,B,D\}$. Write the whole thing in CNF.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > &(H\vee R\vee He\vee G)\\
> > \wedge\ &(\neg\text{Hagrid}\vee\text{Norberta})\\
> > \wedge\ &(\neg\text{Fred}\vee\text{George})\wedge(\text{Fred}\vee\neg\text{George})\\
> > \wedge\ &(\neg V\vee\neg B)\wedge(\neg V\vee\neg D)\wedge(\neg B\vee\neg D)
> > \end{aligned}
> > $$
> > - **Key move:** rewrite $\Rightarrow$ and $\Leftrightarrow$ into clauses **before** claiming CNF; "no more than one" expands **pairwise**, never as one big negated clause.

## ⚠️ Common Mistakes
- 💡 **Nothing is implied by physics** ➔ $P_{A,13}\wedge P_{A,14}$ (Alice in two seats) is a perfectly legal truth assignment unless a clause forbids it; enumerate the impossibilities.
- 💡 **$\Rightarrow$ and $\Leftrightarrow$ are not CNF** ➔ a formula containing them is not yet in CNF; rewrite as $(\neg P\vee Q)$ and $(\neg P\vee Q)\wedge(P\vee\neg Q)$.
- 💡 **"No more than one" $\neq$ one negated clause** ➔ $(\neg V\vee\neg B\vee\neg D)$ merely forbids all three together; the correct encoding is **pairwise**.
- 💡 **Encoding is not unique** ➔ many equivalent encodings exist; aim for one that follows **directly from the English rules**, which is easier to check and less error-prone.

## 🧠 Active Recall
> [!FAQ]- Why must an encoding explicitly forbid "Alice sits in seats 13 and 14", when that is physically impossible?
> > [!SUCCESS]- Answer
> > - **Short answer:** the formula's meaning is fixed entirely by its **truth assignments** — all $2^{12}$ of them are candidates, and many assign True to both $P_{A,13}$ and $P_{A,14}$. Logic imports no physical knowledge.
> > - **Why:** **Constraints define validity** ➔ only clauses distinguish valid seatings from nonsense, so every real-world impossibility must appear as an explicit "at most one" clause set.
