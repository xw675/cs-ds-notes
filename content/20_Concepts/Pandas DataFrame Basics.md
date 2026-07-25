---
unit: FIT1043
parent: "[[Python for Data Science]]"
tags: [DataScience/Tools, Tool/Pandas]
type: pattern
aliases: [Pandas DataFrame, Boolean Filtering, read_fwf, loc]
---
# [[Pandas DataFrame Basics]]

**Context:** [[FIT1043_MOC]] · create/select/filter a [[Python for Data Science|pandas]] table · precedes [[Data Auditing in Pandas|auditing]] and [[Groupby-Aggregate Pipeline (Pandas)|groupby]] · labs: `30_Projects/FIT1043_Labs/Week2-Pandas-Solution.pdf`, `Week4-Wrangling-Viz-Solution.pdf`
**Problem it solves:** build a DataFrame, select rows/columns, filter by a boolean mask, and add/fix values.

> [!abstract] Quick Revision
> - **🎯 Trigger:** tabular data in Python ➔ build with pd.DataFrame; filter with a boolean mask df[mask]; add a column by assignment.
> - **⚡ Key Constraint:** compound masks need **parentheses** — `(a) & (b)`; and to *edit* selected cells use **df.loc[mask, col] = val** (not chained indexing).

## 🔧 Minimal Working Example
```python
import pandas as pd
df = pd.DataFrame({'Name':['Steven','Alex','Bill'], 'Math':[100,90,40], 'English':[60,70,80]})

df['Name'] == 'Alex'          # boolean Series
df[df['Name'] == 'Alex']      # filter rows where True
df['Total'] = df['Math'] + df['English']   # add a computed column
```
**Expected output:** the mask (F/T/F); one matching row; a new `Total` column (160/160/120).

- **Create** ➔ `pd.DataFrame({col: list, ...})`; optional `index=[...]` for row labels.
- **Select** ➔ column `df['Name']`; row by label `df.loc[0]`; sample `df.sample(3)`.
- **Boolean filter** ➔ a condition makes a boolean Series; `df[mask]` keeps the True rows.
- **Compound filter** ➔ `filt = (df['Name'] != 'Bob') & (df['Math'] > 50); df[filt]` — each condition **in parentheses**.
- **Add column** ➔ `df['Total'] = df['Math'] + df['English']` (element-wise).

## 🔀 Variations
- **Read a fixed-width file** ➔ `pd.read_fwf('data/Patients.txt', widths=[3,1,10,3,3,3,3,1], header=None)`; then name columns `df.columns = ['ID','Gender',...]`.
- **Fix inconsistent values (conditional assign)** ➔ `df.loc[df['Gender']=='f', 'Gender'] = 'F'` — the correct, copy-safe way to edit selected cells.
- **Stack DataFrames** ➔ `pd.concat([df1, df2]).reset_index()` (renumber the combined index).

## ✍️ Practice 
> [!QUESTION]- Practice 1: From patient `df`, keep rows with `SBP` ≤ 370 **and** `HR` ≥ 30, then report the shape.
> > [!SUCCESS]- Reference solution
> > ```python
> > newDf = df[df['SBP'] <= 370]
> > df2 = newDf[newDf['HR'] >= 30]
> > df2.shape
> > ```
> > - **Key move:** chain two boolean filters (or combine with `&` and parentheses).

## ⚠️ Common Mistakes
- 💡 **Parenthesise compound masks** ➔ `df['a']>0 & df['b']<9` misparses; write `(df['a']>0) & (df['b']<9)`.
- 💡 **Edit with `df.loc[mask, col] = …`** ➔ `df[mask][col] = …` sets on a copy (SettingWithCopyWarning) and silently fails; `.loc` writes in place.
