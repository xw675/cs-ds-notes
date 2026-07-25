---
unit: FIT2094
week: 6
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
aliases: [CHAR, VARCHAR2, NUMBER, DATE]
---
# [[Oracle Data Types]]

**Context:** [[FIT2094_MOC]] · the four column types allowed in this unit · chosen per attribute in a [[DDL Table Creation|CREATE TABLE]] · the physical realisation of a [[Domain (Relational Model)|domain]]

> [!abstract] Quick Revision
> - **🎯 Objective:** pick one of $\{\text{CHAR},\text{VARCHAR2},\text{NUMBER},\text{DATE}\}$ per column ➔ fix storage + valid values.
> - **⚡ Key Constraint:** $\text{CHAR}(n)$ is **fixed-width, space-padded**; $\text{VARCHAR2}(n)$ is variable — wrong choice wastes space or mis-compares.

## 📝 Core
- **$\text{CHAR}(n)$** ➔ fixed $n$-char text, **padded with spaces**; `'Apple'` in $\text{CHAR}(10)$ stored as `'apple     '`. Use for known-length codes.
- **$\text{VARCHAR2}(n)$** ➔ up to $n$ chars, stored **as-is** (no padding); `'Apple'` stays `'apple'`. Default for names/free text.
- **$\text{NUMBER}(p,s)$** ➔ $p$ = total digits (precision), $s$ = decimal digits (scale, optional); before-point digits $= p-s$.
- **$\text{DATE}$** ➔ date **+ time to the second** (Gregorian), e.g. `10-Mar-2026 14:32:18`; stored numerically ➔ two dates subtract to a day count.

**NUMBER examples:**

| Declaration | Range / form | Example |
| :--- | :--- | :--- |
| $\text{NUMBER}(5)$ | $-99999\ldots99999$ (= $(5,0)$) | $15250$ |
| $\text{NUMBER}(7,2)$ | 5 digits before point, 2 after | $15250.25$ |
| $\text{NUMBER}(4,1)$ | 3 digits before point, 1 after | $950.1$ |

## ⚠️ Common Mistakes
- 💡 **$\text{CHAR}$ padding breaks equality/joins** ➔ a padded `'apple     '` may not match an unpadded `'apple'`; reserve $\text{CHAR}$ for genuinely fixed-length codes.
- 💡 **Scale eats precision** ➔ in $\text{NUMBER}(p,s)$ the integer part holds only $p-s$ digits, so $\text{NUMBER}(4,1)$ maxes at $999.9$, not $9999.9$.

## 🧠 Active Recall
> [!FAQ]- When do you choose CHAR over VARCHAR2, and what does NUMBER(7,2) actually permit?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\text{CHAR}$ for fixed-length codes (all values same width); $\text{VARCHAR2}$ for variable text. $\text{NUMBER}(7,2)$ = 5 integer + 2 fractional digits (max $99999.99$).
> > - **Why:** **Padding vs precision** ➔ $\text{CHAR}$ space-pads to width; in $\text{NUMBER}(p,s)$ integer digits $=p-s$.
