---
unit: FIT2014
domain: D
week: 1
parent: "[[Conjunctive Normal Form]]"
tags: [Math/Logic, Math/Theory, CS/Computation]
type: pattern
aliases: [at least k, at most k, exactly k, cardinality constraints, CNF recipe, pick at least, pick at most, pick exactly]
---
# [[CNF Encoding Patterns (At Least, At Most, Exactly)]]

**Context:** [[FIT2014_MOC]] · turning a **counting condition** into [[Conjunctive Normal Form|CNF]] mechanically · the reusable half of [[Encoding Problems in Propositional Logic]]
**Problem it solves:** given $n$ options, write CNF for "**pick at least / at most / exactly $k$** of them".

> [!abstract] Quick Revision
> - **🎯 Trigger:** any phrase reducible to "at least $x$ / at most $y$ / exactly $z$ from $n$ options" ➔ apply the clause-size formula, then enumerate combinations.
> - **⚡ Key Constraint:** the formula is on **clause size**, not clause count — for *at least $x$ from $n$*, every clause has $m=n-x+1$ literals, and you write **all** $\binom{n}{m}$ of them.

## 📐 The master formula
- **At least $x$ from $n$** ➔ literals per clause $m=n-(x-1)=n-x+1$; clauses = **all combinations** of size $m$, i.e. $\binom{n}{m}$ clauses; literals **unnegated**.
- **Sanity check** ➔ *at least $1$* gives $m=n$: one clause with everything, $(a\vee b\vee\dots)$. *At least $n$* gives $m=1$: $n$ singleton clauses $(a)\wedge(b)\wedge\dots$.
- **Visual trick** ➔ write $n$ symbols, circle the first $k$, draw a box from the **last** symbol back until it encloses **exactly one circled** symbol; the **box size is the clause size**.

## 🔧 Worked patterns
**At least $2$ from $\{a,b,c\}$** ➔ $m=3-2+1=2$, so all $\binom{3}{2}=3$ pairs:
$$(a\vee b)\wedge(a\vee c)\wedge(b\vee c)$$

**At least $3$ from $\{a,b,c,d,e\}$** ➔ $m=5-3+1=3$, so all $\binom{5}{3}=10$ triples:
$$
\begin{aligned}
&(a\vee b\vee c)\wedge(a\vee b\vee d)\wedge(a\vee b\vee e)\wedge(a\vee c\vee d)\wedge(a\vee c\vee e)\\
\wedge\ &(a\vee d\vee e)\wedge(b\vee c\vee d)\wedge(b\vee c\vee e)\wedge(b\vee d\vee e)\wedge(c\vee d\vee e)
\end{aligned}
$$

**At most $y$ from $n$** ➔ equivalent to "**do not pick at least $n-y$**" ⟹ use the same formula on the **negated** literals with $x=n-y$:
$$m=n-\big((n-y)-1\big)=y+1$$
*At most $3$ from $\{a,b,c,d,e\}$* ➔ $m=4$, all $\binom{5}{4}=5$ clauses of negated literals:
$$(\neg a\vee\neg b\vee\neg c\vee\neg d)\wedge(\neg a\vee\neg b\vee\neg c\vee\neg e)\wedge(\neg a\vee\neg b\vee\neg d\vee\neg e)\wedge(\neg a\vee\neg c\vee\neg d\vee\neg e)\wedge(\neg b\vee\neg c\vee\neg d\vee\neg e)$$

**Exactly $z$ from $n$** ➔ simply **conjoin** the two:
$$\text{exactly } z \;=\; (\text{at least } z)\ \wedge\ (\text{at most } z)$$

## 🔀 Common special cases
| Condition | CNF shape | Note |
| :--- | :--- | :--- |
| at least one of $S$ | one clause $\bigvee_{s\in S}s$ | already CNF |
| at most one of $S$ | pairwise $(\neg s_i\vee\neg s_j)$ for all $i<j$ | $\binom{n}{2}$ clauses |
| exactly one of $S$ | $\big(\bigvee s\big)\wedge\bigwedge_{i<j}(\neg s_i\vee\neg s_j)$ | the workhorse |
| $P\Rightarrow Q$ | $(\neg P\vee Q)$ | rewrite implication |
| $P\Leftrightarrow Q$ | $(\neg P\vee Q)\wedge(P\vee\neg Q)$ | two clauses |

## ✍️ Practice
> [!QUESTION]- Practice 1: A mouse is on the clock, the floor, or the bread, and can be in only one place at once. Write this in CNF.
> > [!SUCCESS]- Reference solution
> > This is "**exactly one** of three options" with $S=\{C,F,B\}$:
> > $$(C\vee F\vee B)\wedge(\neg C\vee\neg F)\wedge(\neg C\vee\neg B)\wedge(\neg F\vee\neg B)$$
> > - **Key move:** *exactly one* $=$ *at least one* (single clause) $\wedge$ *at most one* (all pairwise negated pairs).

> [!QUESTION]- Practice 2: Write "at least two of $\{a,b,c,d\}$" in CNF, and state the clause count before writing it.
> > [!SUCCESS]- Reference solution
> > $m=n-x+1=4-2+1=3$ literals per clause; $\binom{4}{3}=4$ clauses:
> > $$(a\vee b\vee c)\wedge(a\vee b\vee d)\wedge(a\vee c\vee d)\wedge(b\vee c\vee d)$$
> > - **Key move:** compute $m$ **first**, then mechanically enumerate every size-$m$ subset in alphabetical order so none is missed.

## ⚠️ Common Mistakes
- 💡 **The formula sizes the clause, not the count** ➔ $m=n-x+1$ is **literals per clause**; the number of clauses is then $\binom{n}{m}$. Swapping these is the standard error.
- 💡 **"At most" needs negated literals** ➔ it is *at least $n-y$ of the **complements***; forgetting to negate produces a formula asserting the opposite.
- 💡 **A single big negated clause is wrong for "at most one"** ➔ $(\neg V\vee\neg B\vee\neg D)$ only forbids *all three*; "no more than one" needs **pairwise** clauses.
- 💡 **Enumerate systematically** ➔ write clauses in alphabetical order (new leading variable ⟹ new line) so no combination is skipped under time pressure.

## 🧠 Active Recall
> [!FAQ]- For "at least $x$ of $n$", why does each clause have $n-x+1$ literals?
> > [!SUCCESS]- Answer
> > - **Short answer:** a clause of size $m$ says "**not all $m$ of these are false**". If we omitted $x-1$ options, $n-(x-1)$ remain; forcing at least one of *every* such subset to be true makes it impossible to leave $x-1$ or fewer chosen.
> > - **Why:** **Blocking the shortfall** ➔ suppose only $x-1$ were picked; then some size-$(n-x+1)$ subset would be entirely unpicked, violating its clause. Requiring **all** $\binom{n}{n-x+1}$ such clauses therefore forces at least $x$ picks.
