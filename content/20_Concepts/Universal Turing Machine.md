---
unit: FIT2014
domain: D
week: 7
source: [lecture]
parent: "[[Turing Machines]]"
tags: [Math/Theory, CS/Computation]
aliases: [UTM, universal Turing machine, stored program, interpreter]
---
# [[Universal Turing Machine]]

**Context:** [[FIT2014_MOC]] · one [[Turing Machines|Turing machine]] that runs **all** the others, by reading them as data via [[Encoding Turing Machines (Code Words)]] · the theoretical ancestor of the stored-program computer

> [!abstract] Quick Revision
> - **🎯 Objective:** a **single fixed** TM $U$ taking $\langle M\rangle\,\$\,x$ ➔ simulates $M$ on $x$ step for step, accepting iff $M$ accepts $x$.
> - **⚠️ Key Constraint:** $U$ has a **finite** state set but must simulate machines with arbitrarily many states — so the simulated state is held **on the tape**, and only the *current letter* is carried in $U$'s own states.

## 📝 Definition and input format
> [!IMPORTANT] A **Universal Turing Machine** is a Turing Machine that takes as input (i) an **encoding of some Turing Machine $M$** and (ii) a **string $x$** to be used as input to $M$, and **simulates the execution of $M$ on $x$**.

$$\underbrace{\texttt{abaaabaaaabababababbaaabaabaaaab}}_{\langle M\rangle\ \text{— the encoded TM}}\ \underbrace{\texttt{\$}}_{\text{separator}}\ \underbrace{\texttt{bbbaa}}_{x\ \text{— input to } M}\ \Delta\Delta\Delta\dots$$

- **The $\texttt{\$}$** ➔ marks the **end of the TM encoding and the start of its input**; without it the head cannot tell program from data on a single tape.
- **Worked input** ➔ for $M$ with $1\xrightarrow{\texttt{b}\to R}1$, $1\xrightarrow{\texttt{a}\to R}3$, $3\xrightarrow{\texttt{a}\to R}2$ and $x=\texttt{bbbaa}$:
  - TM: `abaaabaaaabababababbaaabaabaaaab`
  - Data: `bbbaa`
- **Both regions are re-read constantly** ➔ $U$ shuttles between them once per simulated step, which is where its slowdown comes from.

## ⚙️ The simulation algorithm
1. **Move right** to the first letter of the encoded TM's input. Read it, **mark** it so the position can be found again ($\texttt{a}\mapsto\texttt{A}$, $\texttt{b}\mapsto\texttt{B}$), and **remember** it in $U$'s choice of state.
2. **Move left** to the first instruction of $\langle M\rangle$.
3. **Scan the instructions** for the one matching (current simulated state, remembered letter). Then:
   - **If** its To-state is the **Accept** state $2$: read off what to write and which way to move, remember them in $U$'s state, move right to the marked position, write the required letter, move in the required direction, and **Accept**.
   - **Else**: read off what to write and the direction, remember them, move right to the marked position, write the letter and move; then **read and mark** the new current letter, remember it, and move **left** to locate the next instruction.

- **What lives where** ➔ the **simulated state number** is located positionally within $\langle M\rangle$ (which instruction block $U$ is standing in); the **simulated tape** is the data region; the **one remembered letter plus the pending write/direction** are all $U$ keeps in its own finite control.
- **Why marking is essential** ➔ $U$ leaves the data region on every step; $\texttt{A}/\texttt{B}$ is the bookmark that lets it return to the exact simulated head position.

## ⏱️ Cost of simulation
> [!QUESTION]- **Exercise** *(set in the lecture, not solved there)*: $U$ is a UTM, $T$ a TM, $x$ an input with $|x|=n$. Running $T$ on $x$ takes time $t$ and visits at most $s$ tape cells. Bound the time for $U$ to simulate it, in terms of $t$, $s$, $n$.
> > [!SUCCESS]- Worked bound *(derivation, not lecture-given)*
> > Let $m=|\langle T\rangle|$, a **constant** once $T$ is fixed. Per simulated step $U$ must:
> > $$
> > \begin{aligned}
> > \text{walk left to the instruction block} &\le m+s \text{ cells}\\
> > \text{scan instructions for the match} &\le m \text{ cells}\\
> > \text{walk right to the marked cell} &\le m+s \text{ cells}
> > \end{aligned}
> > $$
> > so one simulated step costs $O(m+s)$, and $t$ steps cost
> > $$O\!\big(t\,(m+s)\big)\ =\ O(t\,s)\quad\text{for fixed } T,$$
> > using $s\ge n$ (the head at least covers the input). **The slowdown is polynomial** — a constant times $s$ per step, never exponential.
> > - **Key move:** identify what is constant ($m$, hence $|Q_T|$ and the alphabet) and what scales ($t$, $s$). The bound is what later justifies treating "TM time" and "algorithm time" as the same up to polynomial factors when defining complexity classes.

## 🧭 Why UTMs matter
- **One machine simulating another** ➔ the first formal model of *interpretation*: a program is an input, not a wiring diagram.
- **Stored-program computer** ➔ program and data share one memory, exactly as $\langle M\rangle$ and $x$ share one tape.
- **[[Von Neumann Architecture and Programs|von Neumann architecture]]** ➔ the engineering realisation of that idea; the UTM is its mathematical precursor.
- **Existence, not just definition** ➔ $U$ exists because the decoding pass of [[Encoding Turing Machines (Code Words)]] is a **finite, mechanical, left-to-right procedure**, and by the [[Computable Functions and the Church-Turing Thesis|Church–Turing thesis]] any such procedure is itself implementable as a TM.

## ⚠️ Common Mistakes
- 💡 **$U$ is one fixed machine** ➔ it is not "a machine per $M$". Universality means a **single finite program** handles all encodings, which is the whole claim.
- 💡 **The simulated state is not a state of $U$** ➔ $U$'s finite control cannot hold an unbounded state number; it holds only the **current letter** and the pending write/direction, and finds the state **positionally** in the encoding.
- 💡 **Don't skip the $\texttt{\$}$** ➔ program and data must be separable on one tape; a missing separator is a common lost mark when asked to lay out the UTM's input.
- 💡 **Simulation costs time, not power** ➔ $U$ is slower by a factor $O(m+s)$, but accepts **exactly** the strings $M$ accepts, loops exactly where $M$ loops.

## 🧠 Active Recall
> [!FAQ]- A UTM has a fixed, finite set of states, yet must simulate machines with arbitrarily many states. How is that not a contradiction?
> > [!SUCCESS]- Answer
> > - **Short answer:** the simulated machine's state is **never stored in $U$'s control** — it is stored **on the tape**, as $U$'s position within the encoded instruction list. $U$'s own states only have to remember one tape letter plus a pending (write, direction) pair, and that is a **bounded** amount of information.
> > - **Why:** **Unbounded data goes on the tape, bounded control in the states** ➔ this is the general design rule for TMs, and here it is what makes universality possible: the number of *kinds* of thing $U$ must do is finite even though the number of machines it can run is infinite.

> [!FAQ]- What does the existence of a UTM tell us that the definition of a Turing machine alone does not?
> > [!SUCCESS]- Answer
> > - **Short answer:** that **programs are data**. Machines can be encoded as strings, and there is a machine that reads such strings and *runs* them — so the set of TMs can be enumerated, fed to other TMs, and reasoned about **inside** the model rather than only about it.
> > - **Why:** **Self-reference becomes available** ➔ combined with the countability of code words (each $\langle M\rangle\in$ CWL $\subseteq\{\texttt{a},\texttt{b}\}^*$, which is countable, while the set of languages is not — see [[Countability and Cantor Diagonalisation]]), this is the machinery every undecidability proof is built from. Practically, it is also the reason a computer needs no rewiring per program: the [[Von Neumann Architecture and Programs|stored-program]] idea in its original form.
