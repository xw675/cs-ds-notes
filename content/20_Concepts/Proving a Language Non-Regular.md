---
unit: FIT2014
week: [4, 5]
parent: "[[Pumping Lemma for Regular Languages]]"
tags: [Math/Theory, Math/Proof, CS/Computation, CS/Languages]
type: pattern
aliases: [non-regular, HALF-AND-HALF, EQUAL, PALINDROME, a^n b^n, pumping lemma proof, closure argument]
---
# [[Proving a Language Non-Regular]]

**Context:** [[FIT2014_MOC]] · the exam-standard use of the [[Pumping Lemma for Regular Languages|Pumping Lemma]] · two routes: **pump a well-chosen word**, or **derive a contradiction from [[Closure Properties of Regular Languages|closure]]**
**Problem it solves:** given a language, prove it is **not** regular.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a language that seems to need **counting** or **matching** unboundedly ➔ assume regular, get $N$, choose a word, pump, contradict.
> - **⚡ Key Constraint:** **choose $w$ so that $|x|+|y|\le N$ leaves only ONE case.** A lazy choice forces a three-case slog; a good choice makes the proof four lines.

## 📐 Route 1 — the Pumping Lemma recipe
1. **Assume** $L$ is regular. By [[Kleene's Theorem]] it is recognised by some FA; let $N$ be its number of states.
2. **Choose a suitable word** $w\in L$ with $|w|\ge N$ — *you* get this choice, so choose to make step 4 easy.
3. **Consider any** $x,y,z$ with $w=xyz$, $y\neq\varepsilon$ and $|x|+|y|\le N$. *(You must handle **every** such decomposition.)*
4. **Exhibit an $i\ge 0$** with $xy^{i}z\notin L$ (usually $i=2$, sometimes $i=0$).
5. **Contradiction** with the Pumping Lemma ⟹ $L$ is **not** regular. $\blacksquare$

## 🥇 Worked example — HALF-AND-HALF $=\{\mathtt{a}^{n}\mathtt{b}^{n}: n\ge 0\}$
**The naive choice** $w=\mathtt{a}^{\lceil N/2\rceil}\mathtt{b}^{\lceil N/2\rceil}$ forces **three cases**:

| Case | $y$ is… | Why $xy^{2}z\notin L$ |
| :--- | :--- | :--- |
| 1 | all $\mathtt{a}$s | more $\mathtt{a}$s than $\mathtt{b}$s (since $y\neq\varepsilon$) |
| 2 | all $\mathtt{b}$s | more $\mathtt{b}$s than $\mathtt{a}$s |
| 3 | contains an $\mathtt{ab}$ | $xy^{2}z$ has **two** occurrences of $\mathtt{ab}$, impossible in $\mathtt{a}^{n}\mathtt{b}^{n}$ |

**The good choice** $w=\mathtt{a}^{N}\mathtt{b}^{N}$ leaves **one case**:
$$
\begin{aligned}
|x|+|y|\le N &\Rightarrow xy \text{ lies entirely within the first } N \text{ letters} \\
&\Rightarrow y \text{ consists only of } \mathtt{a}\text{s},\ y\neq\varepsilon \\
\Rightarrow xy^{2}z &\text{ has more } \mathtt{a}\text{s than } \mathtt{b}\text{s} \ \Rightarrow\ xy^{2}z\notin L \quad\text{Contradiction.}
\end{aligned}
$$
- **The lesson** ➔ the naive proof never **used** $|x|+|y|\le N$. Exploiting it is what collapses three cases into one.

## 🥈 Worked example — PALINDROME
- **Choose** $w=\mathtt{a}^{N}\mathtt{b}\mathtt{a}^{N}$ (a palindrome, and $|w|\ge N$).
- **Constraint bites** ➔ $|x|+|y|\le N$ forces $y$ to sit inside the **first** block of $\mathtt{a}$s, so $y$ is all $\mathtt{a}$s with $y\neq\varepsilon$.
- **Pump** ➔ $xy^{2}z$ has $N+|y|$ leading $\mathtt{a}$s but still $N$ trailing $\mathtt{a}$s, so the solitary $\mathtt{b}$ now sits **more than half-way along** ⟹ not a palindrome ⟹ $xy^{2}z\notin L$. Contradiction. $\blacksquare$

## 📐 Route 2 — the closure argument (often much faster)
If $L$ combined with a **known regular** language via a **closure-preserving** operation yields a **known non-regular** language, then $L$ cannot be regular.

**Worked example — EQUAL $=\{$words with equally many $\mathtt{a}$s and $\mathtt{b}$s$\}$:**
$$
\begin{aligned}
\text{Observe } \text{HALF-AND-HALF} &= \text{EQUAL}\cap \mathtt{a}^{*}\mathtt{b}^{*} \\
\text{Suppose EQUAL were regular} &\Rightarrow \text{since } \mathtt{a}^{*}\mathtt{b}^{*} \text{ is regular and regular languages are} \\
&\quad\ \textbf{closed under intersection},\ \text{HALF-AND-HALF would be regular} \\
&\Rightarrow \text{contradiction (proved non-regular above)} \\
\Rightarrow \text{EQUAL is \textbf{not} regular.} &\qquad\blacksquare
\end{aligned}
$$
- **When to reach for it** ➔ when the language is "close to" a known non-regular one; intersecting with a simple regex like $\mathtt{a}^{*}\mathtt{b}^{*}$ often strips away the noise.

## ✍️ Practice 
> [!QUESTION]- Practice: Prove $L=\{\mathtt{a}^{n}\mathtt{b}^{m}: n>m\ge 0\}$ is not regular.
> > [!SUCCESS]- Reference solution
> > 1. Assume regular; let $N$ be the number of states of an accepting FA.
> > 2. **Choose** $w=\mathtt{a}^{N+1}\mathtt{b}^{N}\in L$ (indeed $N+1>N$), and $|w|\ge N$.
> > 3. Any $x,y,z$ with $|x|+|y|\le N$ puts $y$ **inside the leading $\mathtt{a}$s**, with $y\neq\varepsilon$.
> > 4. **Pump down** with $i=0$: $xz$ has $N+1-|y|\le N$ leading $\mathtt{a}$s but still $N$ trailing $\mathtt{b}$s, so the $\mathtt{a}$-count is no longer strictly greater ⟹ $xz\notin L$.
> > 5. Contradiction ⟹ $L$ is not regular. $\blacksquare$
> > - **Key move:** here **$i=0$** (deleting the loop) is the natural choice — pumping *down* breaks a strict inequality more cleanly than pumping up.

## ⚠️ Common Mistakes
- 💡 **You choose $w$; you do NOT choose $x,y,z$** ➔ the lemma says *there exist* $x,y,z$; to contradict it you must defeat **every** valid decomposition. Picking a convenient $y$ yourself is the most common invalid proof.
- 💡 **Always use $|x|+|y|\le N$** ➔ it is what pins $y$ inside the first $N$ letters. A proof that ignores it needs far more cases (and often stalls).
- 💡 **$i=2$ is a habit, not a rule** ➔ for strict-inequality languages, **pumping down to $i=0$** is usually the shorter kill.
- 💡 **You cannot prove regularity this way** ➔ to show a language *is* regular, build a regex or FA instead ([[Pumping Lemma for Regular Languages]] is a one-way tool).

## 🧠 Active Recall
> [!FAQ]- Why does choosing $w=\mathtt{a}^{N}\mathtt{b}^{N}$ beat $w=\mathtt{a}^{\lceil N/2\rceil}\mathtt{b}^{\lceil N/2\rceil}$ for HALF-AND-HALF?
> > [!SUCCESS]- Answer
> > - **Short answer:** with $\mathtt{a}^{N}\mathtt{b}^{N}$, the condition $|x|+|y|\le N$ confines $xy$ to the first $N$ letters — **all $\mathtt{a}$s** — so only **one case** survives ($y$ is a non-empty block of $\mathtt{a}$s) and $xy^{2}z$ immediately has too many $\mathtt{a}$s.
> > - **Why:** **Exploit the length constraint** ➔ the shorter word lets $y$ straddle the $\mathtt{a}$/$\mathtt{b}$ boundary, forcing three separate cases. Choosing $w$ so that the first $N$ letters are homogeneous is the general trick.

> [!FAQ]- Give the closure-based proof that EQUAL is non-regular, and say why it avoids pumping.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\text{EQUAL}\cap\mathtt{a}^{*}\mathtt{b}^{*}=\text{HALF-AND-HALF}$. Regular languages are **closed under intersection** and $\mathtt{a}^{*}\mathtt{b}^{*}$ is regular, so if EQUAL were regular then HALF-AND-HALF would be — contradicting its known non-regularity.
> > - **Why:** **Reduction to a known result** ➔ the pumping work is done **once** (on HALF-AND-HALF) and then reused; intersecting with a regular language filters EQUAL down to the already-settled case, which is far quicker than a fresh case analysis.
