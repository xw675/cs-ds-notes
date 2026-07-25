---
unit: FIT1043
week: 3
parent: "[[Data Wrangling]]"
tags: [DataScience/Wrangling, DataScience/DataQuality]
aliases: [Data Quality, Missing Values, Outliers, Duplicates, IQR]
---
# [[Data Quality Problems]]

**Context:** [[FIT1043_MOC]] · the defects [[Data Wrangling|wrangling]] must fix · found by [[Data Auditing in Pandas|auditing]] · each has a **detect → fix** strategy

> [!abstract] Quick Revision
> - **🎯 Objective:** recognise the common data-quality issues and pair each with a detection and a fix.
> - **📦 Core Components:** interpretability · format · inconsistency/misspelling · irregularities · integrity violations · missing · outliers · duplicates.
> - **⚡ Key Constraint:** fixing is **judgement + justification** — imputation vs removal, or keeping an outlier, depends on domain context, not a rule.

## 📝 How It Works
### 1. The Issue Types (causes)
- **Interpretability** ➔ no documentation / **data dictionary** ➔ can't reliably use the fields; obtain the dictionary.
- **Data format** ➔ sources differ (**JSON** vs **XML**, etc.) ➔ hard to integrate; convert to a common format.
- **Inconsistent / faulty** ➔ mistyped, inconsistent entry, extraneous data.
- **Missing / incomplete**, **Outliers**, **Duplicates** ➔ see detection/fixing below.

### 2. Detect & Fix (worked cases)
- **Inconsistency & misspelling** ➔ *detect* `unique()`, `value_counts()`; *fix* standardise case / representation (e.g. `0`↔`No`), replace infrequent values with the best-matching frequent one.
- **Irregularities** (invalid dates, domain-invalid like negative passengers) ➔ *detect* `unique()`, value ranges, **type-casting** (parse to datetime, catch exceptions); *fix* consult docs, replace, or remove.
- **Integrity-constraint violations** (land < building size; one field = sum of others) ➔ *detect* domain rules; *fix* swap or remove.
- **Missing values** ➔ *detect* `unique()`, value range, domain analysis (may be coded, e.g. `?` or `*`); *fix* **imputation** (mean/mode, regression via `df.corr()`, dummy value) or removal — **justify** the choice.
- **Outliers** ➔ *detect* `df.describe()` range, **boxplot (IQR rule)**, **3σ rule**; *fix* as for missing values.
- **Duplicates** ➔ *detect* pick candidate **keys** (fix other issues first, try different keys); *fix* merge/combine or remove.

## ⚖️ Core Decision Matrix
| Problem | Detect with | Fix with |
| :--- | :--- | :--- |
| **Inconsistency/misspelling** | `unique()`, `value_counts()` | standardise; replace infrequent → best match |
| **Irregularities** | ranges; type-cast + catch errors | docs / replace / remove |
| **Integrity violation** | domain rules (context) | swap / remove |
| **Missing values** | `unique()`, ranges, domain analysis | impute (mean/mode/regression/dummy) or remove |
| **Outliers** | `describe()`, boxplot, 3σ | impute or remove (justify) |
| **Duplicates** | candidate keys | merge / remove |

> [!NOTE] **When It Flips:** missing values and outliers share the **same fix menu** (impute vs remove) — the differentiator is detection, and every removal/imputation needs a domain justification.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** A price column has $Q_1 = 400{,}000$ and $Q_3 = 900{,}000$. Which values are outliers by the IQR rule?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{IQR} &= Q_3 - Q_1 = 900{,}000 - 400{,}000 = 500{,}000 \\
\text{lower} &= Q_1 - 1.5\,\text{IQR} = 400{,}000 - 750{,}000 = -350{,}000 \\
\text{upper} &= Q_3 + 1.5\,\text{IQR} = 900{,}000 + 750{,}000 = 1{,}650{,}000
\end{aligned}
$$
**Final Extracted Output:** anything $< -350{,}000$ or $> 1{,}650{,}000$ is an outlier (so a $\$2{,}000{,}000$ listing flags).

## 🧠 Active Recall
> [!FAQ]- State the IQR outlier rule, and why you shouldn't auto-delete detected outliers.
> - **Hint:** IQR bounds + judgement.
> > [!SUCCESS]- Answer
> > - **Short answer:** Outliers fall below $Q_1 - 1.5\,\text{IQR}$ or above $Q_3 + 1.5\,\text{IQR}$ (IQR $= Q_3-Q_1$); don't auto-remove because a "far" value may be genuine — fixing needs domain justification.
> > - **Why:** **Detect ≠ fix** ➔ boxplot/3σ flag candidates; removal vs imputation is a context decision (compare detectors first).

> [!FAQ]- How do you detect and fix misspelling/inconsistency in a categorical column?
> - **Hint:** unique + frequency matching.
> > [!SUCCESS]- Answer
> > - **Short answer:** Inspect `unique()` values and `value_counts()`; standardise case/representation and replace infrequent variants with the best-matching frequent value.
> > - **Why:** **Frequency as truth** ➔ common spellings are likely correct; rare near-matches are likely typos to merge.
