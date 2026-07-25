---
unit: FIT1043
domain: E
week: 3
parent: "[[Data Wrangling]]"
tags: [DataScience/Wrangling, Tool/Pandas]
type: pattern
aliases: [Data Auditing, df.describe, df.info, df.corr]
---
# [[Data Auditing in Pandas]]

**Context:** [[FIT1043_MOC]] · first pass over a new dataset · surfaces [[Data Quality Problems]] before [[Data Wrangling|wrangling]] · pandas on a DataFrame `df`
**Problem it solves:** given a freshly loaded DataFrame, profile its shape, types, distributions, and relationships to spot quality issues.

> [!abstract] Quick Revision
> - **🎯 Trigger:** just read data into a DataFrame ➔ run the audit sequence: shape → head/tail → info → describe → corr.
> - **⚡ Key Constraint:** `describe()` defaults to **numeric** columns only; audit object/categorical columns separately, and remember `df.shape` is an **attribute** (no parentheses).

## 🔧 Minimal Working Example
```python
df.shape            # (N, D) — rows, columns   (attribute, NOT df.shape())
df.head(); df.tail()  # eyeball first / last rows
df.info()           # dtypes, non-null counts (spot nulls), memory
df.describe()       # numeric summary: count, mean, std, min, quartiles, max
```
**Expected output:** `(N, D)` dimensions; a per-column dtype/null table from `info()`; numeric statistics from `describe()`.

- **Shape** ➔ `df.shape` → `(N, D)`; row count and column count in one attribute.
- **Peek** ➔ `head()` / `tail()` to see real values and obvious formatting issues.
- **Types & nulls** ➔ `info()` reveals dtypes and non-null counts (which columns have missing data).
- **Distributions** ➔ `describe()` for numeric (ranges expose outliers); `describe(include=['O'])` for object columns (count, unique, **top** = most common, **freq** = its frequency).
- **Relationships** ➔ `df.corr()` = pairwise **Pearson** correlation (feeds regression-based imputation).

## 🔀 Variations
- **Categorical audit** ➔ `df.describe(include=['O'])`; per-column `df["suburb"].unique()` and `df["suburb"].value_counts()` to find inconsistent/misspelled values.
- **Numeric vs categorical split** ➔ use `info()` dtypes to decide which columns get `describe()` vs `describe(include=['O'])`.

## ✍️ Practice 
> [!QUESTION]- Practice 1: You've loaded a housing dataset into `df`. Write the initial audit that would reveal its size, dtypes/nulls, numeric ranges, and the distinct values of the `suburb` column.
> > [!SUCCESS]- Reference solution
> > ```python
> > df.shape                       # (N, D)
> > df.info()                      # dtypes + non-null counts (nulls)
> > df.describe()                  # numeric ranges → outliers
> > df["suburb"].value_counts()    # categorical consistency / misspellings
> > ```
> > - **Key move:** `info()` for nulls/types, `describe()` for numeric ranges, `value_counts()` for categorical cleanliness.

## ⚠️ Common Mistakes
- 💡 **`df.shape` has no parentheses** ➔ it is an attribute; `df.shape()` raises `TypeError`.
- 💡 **`describe()` hides text columns** ➔ by default it profiles numeric only; add `include=['O']` to audit object/categorical columns.
- 💡 **View-vs-copy / chained indexing** ➔ fixing values via `df[df.a>0]["b"] = x` may hit a `SettingWithCopyWarning` and silently fail; assign with a single `df.loc[mask, "b"] = x`.
