---
unit: FIT2014
week: 2
parent: "[[Regular Expressions]]"
tags: [Math/Theory, CS/Computation, CS/Languages, Monash/CS_DS]
type: pattern
aliases: [writing regular expressions, description to regex, regex recipes, contains substring, starts with, ends with]
---
# [[Finding Regular Expressions]]

**Context:** [[FIT2014_MOC]] · going **from a description of a language to a regular expression for it** · the assessable half of [[Regular Expressions]] (**Assignment 1**)
**Problem it solves:** given English like "all strings that start and end with $\mathtt{a}$", produce a correct regular expression.

> [!abstract] Quick Revision
> - **🎯 Trigger:** an English description of a string set ➔ identify the **shape** (contains / starts / ends / order / count), then assemble from the recipe table.
> - **⚡ Key Constraint:** **check the smallest strings** — especially $\varepsilon$ and single letters. Most wrong answers fail on the shortest cases, not the long ones.

## 📐 Recipe table (over $\Sigma=\{\mathtt{a},\mathtt{b}\}$)
| Language description | Regular expression |
| :--- | :--- |
| all strings (universal language) | $(\mathtt{a}\cup\mathtt{b})^{*}$ |
| **contains** the substring $\mathtt{abba}$ | $(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{abba}(\mathtt{a}\cup\mathtt{b})^{*}$ |
| **starts with** $\mathtt{abba}$ | $\mathtt{abba}(\mathtt{a}\cup\mathtt{b})^{*}$ |
| **ends with** $\mathtt{abba}$ | $(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{abba}$ |
| $\mathtt{abba}$ **starting at the third letter** | $(\mathtt{a}\cup\mathtt{b})(\mathtt{a}\cup\mathtt{b})\mathtt{abba}(\mathtt{a}\cup\mathtt{b})^{*}$ |
| starts with $\mathtt{a}$ **and** ends with $\mathtt{b}$ | $\mathtt{a}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{b}$ |
| **starts and ends with $\mathtt{a}$** | $\mathtt{a}\cup\mathtt{a}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{a}$ ⚠ |
| two **different adjacent** letters (contains $\mathtt{ab}$ or $\mathtt{ba}$) | $(\mathtt{a}\cup\mathtt{b})^{*}(\mathtt{ab}\cup\mathtt{ba})(\mathtt{a}\cup\mathtt{b})^{*}$ |
| any number of $\mathtt{a}$s **followed by** any number of $\mathtt{b}$s | $\mathtt{a}^{*}\mathtt{b}^{*}$ |

- **The starred trap** ➔ $\mathtt{a}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{a}$ alone is **wrong**: it needs **two** $\mathtt{a}$s, so it misses the single-letter string $\mathtt{a}$, which does start and end with $\mathtt{a}$. Hence the extra alternative $\mathtt{a}\cup\dots$.

## 🧠 Five tips (from the lecture)
- **Look for interactions** ➔ between the patterns used to define the language; conditions can overlap or conflict.
- **Check the very smallest strings** ➔ especially $\varepsilon$, $\mathtt{a}$, $\mathtt{b}$.
- **Read the description carefully** ➔ be sure what each part means *in terms of strings*.
- **Watch the ordering** ➔ for multiple patterns, check whether the wording constrains their order.
- **Ask how strings are built up** ➔ this reveals which operation was applied **last**, which is the top of the parse tree.

## ✍️ Practice 
> [!QUESTION]- Practice 1: EVEN-EVEN — all strings where $\mathtt{a}$ and $\mathtt{b}$ each occur an **even** number of times.
> > [!SUCCESS]- Reference solution
> > $$\big(\mathtt{aa}\cup\mathtt{bb}\cup(\mathtt{ab}\cup\mathtt{ba})(\mathtt{aa}\cup\mathtt{bb})^{*}(\mathtt{ab}\cup\mathtt{ba})\big)^{*}$$
> > - **Key move:** either add a *pair of the same letter* ($\mathtt{aa}$/$\mathtt{bb}$, keeping both parities), or two *mixed* blocks that each flip both parities, with same-letter pairs allowed between them. The outer $^{*}$ (including zero copies) supplies $\varepsilon$.

> [!QUESTION]- Practice 2: Build a regular expression for a **floating-point number** — one or more digits, optionally signed with $-$, optionally containing a decimal point.
> > [!SUCCESS]- Reference solution
> > Build it up in named layers:
> > $$
> > \begin{aligned}
> > D &= (\mathtt{0}\cup\mathtt{1}\cup\mathtt{2}\cup\mathtt{3}\cup\mathtt{4}\cup\mathtt{5}\cup\mathtt{6}\cup\mathtt{7}\cup\mathtt{8}\cup\mathtt{9}) && \text{one digit}\\
> > N &= DD^{*} && \text{nonneg. integer (one or more digits)}\\
> > Z &= N\cup(-N) && \text{integer}\\
> > F &= Z\cup(Z\mathtt{.})\cup(\mathtt{.}N)\cup(-\mathtt{.}N)\cup(Z\mathtt{.}N) && \text{floating point}
> > \end{aligned}
> > $$
> > - **Key move:** **name intermediate expressions** ($D$, $N$, $Z$) and compose. $DD^{*}$ (not $D^{*}$) enforces "one or more". Enumerate where the point may sit.

> [!QUESTION]- Practice 3: All strings that **start and end with $\mathtt{abba}$**.
> > [!SUCCESS]- Reference solution
> > $$\mathtt{abba}\cup\mathtt{abba}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{abba}$$
> > - **Key move:** the same edge case as "starts and ends with $\mathtt{a}$" — the string $\mathtt{abba}$ itself satisfies both conditions with a **single** occurrence, so it needs its own alternative.

## ⚠️ Common Mistakes
- 💡 **Overlapping start/end conditions** ➔ "starts and ends with $x$" is satisfied by $x$ alone; a naive $x(\dots)^{*}x$ demands two copies. Add the $x\cup$ alternative.
- 💡 **$R^{*}$ silently admits $\varepsilon$** ➔ if the description says "one or more", use $RR^{*}$.
- 💡 **"Followed by" means concatenation, not union** ➔ $\mathtt{a}^{*}\mathtt{b}^{*}$ is ordered; it does **not** describe strings with equal counts, nor arbitrary interleavings.
- 💡 **Fixed positions need explicit letters** ➔ "$\mathtt{abba}$ starting at the third letter" needs two explicit $(\mathtt{a}\cup\mathtt{b})$ placeholders, not a star.

## 🧠 Active Recall
> [!FAQ]- Why is $\mathtt{a}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{a}$ wrong for "strings that start and end with $\mathtt{a}$"?
> > [!SUCCESS]- Answer
> > - **Short answer:** it forces **two distinct** $\mathtt{a}$s (one at each end), so it excludes the one-letter string $\mathtt{a}$ — which does start with $\mathtt{a}$ and end with $\mathtt{a}$. Correct: $\mathtt{a}\cup\mathtt{a}(\mathtt{a}\cup\mathtt{b})^{*}\mathtt{a}$.
> > - **Why:** **Check the smallest strings** ➔ when two positional conditions can be met by the *same* symbol, the minimal case needs its own alternative — the single most common source of lost marks.
