---
unit: FIT2014
domain: D
week: 6
source: [lecture]
parent: "[[Chomsky Normal Form]]"
tags: [Math/Theory, CS/Computation, CS/Languages]
aliases: [CYK, CKY, Cocke-Younger-Kasami, CYK algorithm, CYK table, dynamic programming parsing, membership problem for CFLs]
---
# [[CYK Algorithm]]

**Context:** [[FIT2014_MOC]] · the **decision procedure** for CFL membership — a bottom-up [[Parsing and Shift-Reduce Parsers|parser]] that runs in **polynomial time** on *any* [[Context-Free Grammars (CFG)|CFG]], ambiguous or not
**Parent Framework:** [[Chomsky Normal Form]]

> [!abstract] Quick Revision
> - **🎯 Objective:** given a CFG and a string $s$, **decide** whether the grammar generates $s$ ➔ build up, by substring **length**, the set of nonterminals deriving each substring; **Accept** iff $S$ derives the whole string.
> - **📦 Core Components:** **CNF grammar** ➔ every split is binary | **length-ordered table** ➔ answers for length $\ell$ reuse all shorter answers.
> - **⚡ Key Constraint:** the grammar **must be in [[Chomsky Normal Form]]** first, and $s=\varepsilon$ must be sent to the **nullability** algorithm instead — CNF cannot generate $\varepsilon$.

## 📝 How It Works
### 1. Setup
- **Input** ➔ $s=t_1t_2\dots t_n$ with each $t_i$ a letter, $n\ge 0$.
- **Empty string** ➔ if $s=\varepsilon$, run **nullability** ([[Chomsky Normal Form#🕳️ Nullability — the case CNF cannot cover|see there]]) and stop.
- **Otherwise** ➔ convert to [[Chomsky Normal Form]] for the non-empty words, then fill the table.

### 2. Base row — single letters
- For each $t_k$, collect every nonterminal $X$ with a **dead production** $X\to t_k$.

### 3. Inductive rows — every longer substring
- **Pairs** $t_it_{i+1}$ ➔ for each $X$ deriving $t_i$ and $Y$ deriving $t_{i+1}$, add every $W$ with a rule $W\to XY$.
- **Triples** $t_it_{i+1}t_{i+2}$ ➔ **consider both binary splits**, $1{+}2$ and $2{+}1$: for each $X\Rightarrow^{*}$ left part and $Y\Rightarrow^{*}$ right part, add every $W$ with $W\to XY$.
- **Length $\ell$** ➔ there are $\ell-1$ split points; take the union over all of them.
- **Rules That Always Hold:** ➔ CNF guarantees **exactly two** children, so only binary splits ever need checking; a substring of length $\ell$ only ever consults substrings of length $<\ell$.

### 4. Decide
- **Accept** iff the **start symbol $S$** appears in the cell for the whole string $t_1\dots t_n$; otherwise **Reject**.

---
## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
**Grammar** $S\to \mathtt{a}S\mathtt{a}\mid \mathtt{b}$, in **CNF**: $\;S\to TA\mid \mathtt{b}$, $\;T\to AS$, $\;A\to \mathtt{a}$ **· Input** $\mathtt{aabaa}$ ($n=5$).

*Cell $(\ell, i)$ = nonterminals deriving the substring of length $\ell$ starting at position $i$.*

| $\ell$ | $i=1$ | $i=2$ | $i=3$ | $i=4$ | $i=5$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | $\mathtt{a}$: $\{A\}$ | $\mathtt{a}$: $\{A\}$ | $\mathtt{b}$: $\{S\}$ | $\mathtt{a}$: $\{A\}$ | $\mathtt{a}$: $\{A\}$ |
| **2** | $\mathtt{aa}$: $\varnothing$ | $\mathtt{ab}$: $\{T\}$ | $\mathtt{ba}$: $\varnothing$ | $\mathtt{aa}$: $\varnothing$ | |
| **3** | $\mathtt{aab}$: $\varnothing$ | $\mathtt{aba}$: $\{S\}$ | $\mathtt{baa}$: $\varnothing$ | | |
| **4** | $\mathtt{aaba}$: $\{T\}$ | $\mathtt{abaa}$: $\varnothing$ | | | |
| **5** | $\mathtt{aabaa}$: $\boxed{\{S\}}$ | | | | |

**Justifications for the non-empty cells:**

| Cell | Split used | Pair | Rule fired |
| :--- | :--- | :--- | :--- |
| $(2,2)=\mathtt{ab}$ | $\mathtt{a}\mid\mathtt{b}$ | $A\,S$ | $T\to AS$ |
| $(3,2)=\mathtt{aba}$ | $\mathtt{ab}\mid\mathtt{a}$ | $T\,A$ | $S\to TA$ |
| $(4,1)=\mathtt{aaba}$ | $\mathtt{a}\mid\mathtt{aba}$ | $A\,S$ | $T\to AS$ |
| $(5,1)=\mathtt{aabaa}$ | $\mathtt{aaba}\mid\mathtt{a}$ | $T\,A$ | $S\to TA$ |

**Final Extracted Output:** $S\in(5,1)$ ⟹ the grammar **generates** $\mathtt{aabaa}$ — **ACCEPT**. *(Sanity check: $\mathtt{aabaa}=\mathtt{a}\,\mathtt{aba}\,\mathtt{a}$ and $\mathtt{aba}=\mathtt{a}\,\mathtt{b}\,\mathtt{a}$, exactly $S\to\mathtt{a}S\mathtt{a}$ applied twice.)*

### Applied Exercise
**Problem:** the lecture sets three exercises — write the algorithm formally, prove it correct by induction, and give its complexity. The complexity argument:
$$
\begin{aligned}
\text{substrings of } s &= \tbinom{n+1}{2} = O(n^{2}) \\
\text{binary splits per substring} &\le n-1 = O(n) \\
\text{rule lookups per split} &= O(|G|) \\
\Rightarrow \text{total} &= O(n^{3}\,|G|)
\end{aligned}
$$
**Final Extracted Output:** $O(n^{3})$ in the string length for a fixed grammar — **polynomial**, which is the whole point of the algorithm. *(Correctness is by induction on substring length: the base row is exact by the dead productions, and the inductive step is exact because CNF forces a **binary** root split, so every derivation of a length-$\ell$ substring is caught by one of the $\ell-1$ splits.)*

---
## ⚠️ Common Mistakes
- 💡 **Forgetting a split point** ➔ length $\ell$ needs **all** $\ell-1$ splits, not just $1{+}(\ell-1)$. A missed split turns an Accept into a wrong Reject.
- 💡 **Running CYK on a non-CNF grammar** ➔ a rule like $A\to\mathtt{a}B$ or $A\to BCD$ breaks the "one binary split" invariant the whole table rests on.
- 💡 **Order matters in $W\to XY$** ➔ $X$ must derive the **left** part and $Y$ the **right**. $S\to TA$ never fires on an $A,T$ pair.
- 💡 **Handing $\varepsilon$ to CYK** ➔ CNF has no $\varepsilon$-rule, so the table is meaningless; use **nullability**.
- 💡 **An empty cell is not an error** ➔ most cells are empty; only the top cell's contents decide the answer.

## 🧠 Active Recall
> [!FAQ]- Why does CYK work on **ambiguous** grammars when a [[Parsing and Shift-Reduce Parsers|shift-reduce parser]] chokes on them?
> > [!SUCCESS]- Answer
> > - **Short answer:** CYK stores a **set** of nonterminals per substring and unions over **all** splits — it never has to choose. A shift-reduce parser is a **deterministic** PDA that must commit to one move, so ambiguity surfaces as a **shift-reduce or reduce-reduce conflict**.
> > - **Why:** **Exhaustive vs deterministic** ➔ CYK explores every parse simultaneously in $O(n^3)$, paying polynomial time for completeness; the LR parser pays only linear time but is confined to $\text{DCFL}\subsetneq\text{CFL}$.

> [!FAQ]- Why is the table filled in order of increasing substring **length** rather than left-to-right?
> > [!SUCCESS]- Answer
> > - **Short answer:** a cell of length $\ell$ is computed from **two strictly shorter** substrings, so all shorter lengths must already be complete. Length is the induction variable; position is not.
> > - **Why:** **Bottom-up dynamic programming** ➔ CNF forces the parse tree's root to split its yield into two non-empty halves. Ordering by length guarantees both halves are resolved before the parent is asked, which is exactly the induction that proves the algorithm correct.
