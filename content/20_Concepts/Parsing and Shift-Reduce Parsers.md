---
unit: FIT2014
domain: D
week: 6
source: [lecture]
parent: "[[Derivations and Parse Trees]]"
tags: [Math/Theory, CS/Computation, CS/Languages]
aliases: [parsing, parser, top-down parser, bottom-up parser, LR parser, shift-reduce, shift, reduce, shift-reduce conflict, reduce-reduce conflict, DCFL]
---
# [[Parsing and Shift-Reduce Parsers]]

**Context:** [[FIT2014_MOC]] · the **recognition** problem for a [[Context-Free Grammars (CFG)|CFG]] — run [[Derivations and Parse Trees|derivation]] machinery *backwards* from a string · **Assignment 2 material** (lexical analysis, parsing, computability)
**Parent Framework:** [[Derivations and Parse Trees]]

> [!abstract] Quick Revision
> - **🎯 Objective:** given a CFG and a string, decide **membership** and — if a member — recover a **parse tree / derivation**. A **parser** is a program that does this.
> - **📦 Core Components:** **top-down** ➔ expand $S$ toward the string | **bottom-up** ➔ reduce the string back to $S$ | **shift-reduce** ➔ the LR parser drilled here.
> - **⚡ Key Constraint:** **not every CFG has an LR parser** — $\text{DCFL}\subsetneq\text{CFL}$, and an **ambiguous** grammar guarantees conflicts.

## 📝 How It Works
### 1. The parsing problem
- **Two questions at once** ➔ (a) is $w$ a word of $L(G)$? (b) if so, exhibit a **parse tree** or a **derivation** for it.
- **Top-down** ➔ start at $S$ and apply productions **forwards**, trying to reach $w$.
- **Bottom-up** ➔ start at $w$ and apply productions **in reverse**, trying to reduce it to $S$.

### 2. LR parsers
- **The acronym is the spec** ➔ scans input **L**eft to right · constructs a **R**ightmost derivation **in reverse** · bottom-up.
- **Machine model** ➔ implemented by a **Deterministic PDA** ([[Pushdown Automata (PDA)|DPDA]]), not a general nondeterministic one.
- **⚡ Key Constraint:** ➔ deterministic PDAs are strictly weaker, so $\text{DCFL}\neq\text{CFL}$ — **some CFGs admit no LR parser**.

### 3. Shift-reduce parser (the LR type examined here)
- **State = stack + buffer** ➔ **stack** holds terminals and nonterminals processed so far (initially **empty**); **buffer** holds the unread suffix (initially the **whole** input).
- **Two moves only** ➔ **Shift** the next input letter onto the stack, or **Reduce** when a block of top-most stack symbols equals the **right-hand side** of a rule — replace it by that rule's left-hand side.
- **Accept condition** ➔ stack contains **only the start symbol** *and* the buffer is **empty**.
- **Reduce = rule in reverse** ➔ this is what makes the run a rightmost derivation read backwards.

### 4. Ambiguity is what breaks the parser
- **[[Context-Free Grammars (CFG)|Grammar]] Plus-Times-A** $\;S\to E,\; E\to E+E \mid E*E \mid \mathtt{i}$ ➔ **ambiguous**: $\mathtt{i+i*i}$ has **two** parse trees, one grouping $(\mathtt{i+i})*\mathtt{i}$, the other $\mathtt{i}+(\mathtt{i*i})$.
- **Grammar Plus-Times-B** $\;S\to E,\; E\to T+E \mid T,\; T\to F*T \mid F,\; F\to \mathtt{i}$ ➔ the **layered** rewrite ($E$ above $T$ above $F$) forces $*$ to bind tighter, giving **one** tree.
- **Design lesson** ➔ fix ambiguity in the **grammar** (stratify by precedence), not in the parser.

---
## ⚖️ Core Decision Matrix
| Conflict | Trigger on the stack | What is ambiguous | Yacc's default resolution |
| :--- | :--- | :--- | :--- |
| **Shift-reduce** | top symbols match a rule's RHS **and** the next buffer letter could legally be shifted | *when* to reduce ➔ changes the grouping | **shift** |
| **Reduce-reduce** | top symbols match the RHS of **more than one** rule | *which* rule to reverse | use the rule **listed first** |

> [!NOTE] **When It Flips:** the conflict is a symptom, not the disease — an unambiguous, stratified grammar (Plus-Times-B) produces **neither** conflict, so the defaults never fire.

---
## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
**Grammar** $\mathtt{a}^*\mathtt{ba}^*\mathtt{b}$: (1) $S\to BB$ · (2) $B\to \mathtt{a}B$ · (3) $B\to \mathtt{b}$ **· Input** $\mathtt{abb}$

| Step | Stack | Buffer | Action |
| :--- | :--- | :--- | :--- |
| 0 | $\varepsilon$ | $\mathtt{abb}$ | shift |
| 1 | $\mathtt{a}$ | $\mathtt{bb}$ | shift |
| 2 | $\mathtt{ab}$ | $\mathtt{b}$ | reduce (3) |
| 3 | $\mathtt{a}B$ | $\mathtt{b}$ | reduce (2) |
| 4 | $B$ | $\mathtt{b}$ | shift |
| 5 | $B\mathtt{b}$ | $\varepsilon$ | reduce (3) |
| 6 | $BB$ | $\varepsilon$ | reduce (1) |
| 7 | $S$ | $\varepsilon$ | **ACCEPT** |

### Applied Exercise
**Problem:** parse $\mathtt{i+i*i}$ with Plus-Times-A: (1) $S\to E$ · (2) $E\to E+E$ · (3) $E\to E*E$ · (4) $E\to \mathtt{i}$.

| Step | Stack | Buffer | Action |
| :--- | :--- | :--- | :--- |
| 0 | $\varepsilon$ | $\mathtt{i+i*i}$ | shift |
| 1 | $\mathtt{i}$ | $\mathtt{+i*i}$ | reduce (4) |
| 2 | $E$ | $\mathtt{+i*i}$ | shift |
| 3 | $E\mathtt{+}$ | $\mathtt{i*i}$ | shift |
| 4 | $E\mathtt{+i}$ | $\mathtt{*i}$ | reduce (4) |
| 5 | $E\mathtt{+}E$ | $\mathtt{*i}$ | **⚠ conflict** — reduce by (2), or shift $\mathtt{*}$? |
| 6 | $E\mathtt{+}E\mathtt{*}$ | $\mathtt{i}$ | *(shift branch)* shift |
| 7 | $E\mathtt{+}E\mathtt{*i}$ | $\varepsilon$ | reduce (4) |
| 8 | $E\mathtt{+}E\mathtt{*}E$ | $\varepsilon$ | reduce (3) |
| 9 | $E\mathtt{+}E$ | $\varepsilon$ | reduce (2) |
| 10 | $E$ | $\varepsilon$ | reduce (1) |
| 11 | $S$ | $\varepsilon$ | **ACCEPT** |

**Final Extracted Output:** the shift branch groups $\mathtt{i}+(\mathtt{i}*\mathtt{i})$. Taking the **reduce** branch at step 5 also reaches ACCEPT, but groups $(\mathtt{i}+\mathtt{i})*\mathtt{i}$ — **two accepting runs, two trees ⟹ the grammar is ambiguous.**

---
## ⚠️ Common Mistakes
- 💡 **A reduce needs the *whole* RHS on top** ➔ the matching symbols must be the **top-most** contiguous block of the stack, in order; a partial match is not a legal reduce.
- 💡 **"Both branches accept" is not a bug in the trace** ➔ it is the *evidence* of ambiguity. Don't discard one branch to make the answer tidy.
- 💡 **Bottom-up ⟹ rightmost derivation *in reverse*** ➔ reading the reduce steps backwards gives a **rightmost** derivation, not a leftmost one (contrast the leftmost/prefix behaviour driving the [[Pushdown Automata (PDA)|PDA]]).
- 💡 **$\text{DCFL}\subsetneq\text{CFL}$** ➔ "it's context-free" does **not** entitle you to an LR parser.

## 🧠 Active Recall
> [!FAQ]- At $E\mathtt{+}E$ with $\mathtt{*i}$ still buffered, why is either move legal — and what does each one mean?
> > [!SUCCESS]- Answer
> > - **Short answer:** the stack top $E\mathtt{+}E$ matches the RHS of rule (2), so a **reduce** is legal; the buffer's next letter $\mathtt{*}$ can also be **shifted**. Reducing commits to $(\mathtt{i+i})*\mathtt{i}$; shifting defers and yields $\mathtt{i}+(\mathtt{i*i})$.
> > - **Why:** **Shift-reduce conflict** ➔ Plus-Times-A gives $+$ and $*$ the **same** nonterminal $E$, so the grammar itself never fixes precedence. Yacc breaks the tie by **shifting**; the real fix is Plus-Times-B's stratified $E/T/F$.

> [!FAQ]- Why can't every context-free grammar be given a shift-reduce parser?
> > [!SUCCESS]- Answer
> > - **Short answer:** an LR parser is a **deterministic** PDA, and deterministic PDAs recognise only the **deterministic** context-free languages — a **proper** subset, $\text{DCFL}\subsetneq\text{CFL}$.
> > - **Why:** **No backtracking, no guessing** ➔ at each step the parser must choose shift-or-reduce (and which rule) from bounded lookahead alone. A general [[Pushdown Automata (PDA)|PDA]] may explore *all* branches nondeterministically; a DPDA cannot, so grammars needing that search — every ambiguous grammar among them — fall outside its reach.
