---
unit: FIT1043
domain: E
week: 4
parent: "[[Python for Data Science]]"
tags: [DataScience/Wrangling, Tool/Pandas]
type: pattern
aliases: [groupby, agg, Split-Apply-Combine]
---
# [[Groupby-Aggregate Pipeline (Pandas)]]

**Context:** [[FIT1043_MOC]] · per-group summaries in pandas · the SQL [[SQL Aggregate Functions and GROUP BY|GROUP BY]] of Python · often feeds a [[Plotting with Matplotlib (Pandas)|plot]] · lab: `30_Projects/FIT1043_Labs/Week3-Aggregation-Solution.pdf`
**Problem it solves:** collapse rows into per-group statistics via split → apply → combine.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "for each group, compute…" ➔ df.groupby(key)[col].func(), or .agg({...}) for several at once.
> - **⚡ Key Constraint:** groupby is **split → apply → combine**; the result is indexed by the group key, one row per group.

## 🔧 Minimal Working Example
```python
# (N, D) rows → group by 'gender' → mean of 'age' → (G, 1) one row per group
df.groupby('gender')['age'].mean()
```
**Expected output:** a Series indexed by `gender` (e.g. Female → 30, Male → 25); shape `(N, D) → groupby → (G, k)`.

- **Split** ➔ `groupby('gender')` partitions rows by key.
- **Apply** ➔ `['age'].mean()` runs the aggregator on each group.
- **Combine** ➔ results reassembled, indexed by the group key.
- **Multiple aggregations** ➔ `df.groupby('class').agg({'who':'count', 'age':'mean'})` — a dict maps column → function.

## 🔀 Variations
- **Custom aggregator (lambda)** ➔ count ages over 50 per class:
```python
fun = {'age': ['nunique', lambda x: sum(e > 50 for e in x)]}
df.groupby('class').agg(fun)
```
- **Single column, named function** ➔ `df.groupby('class')['who'].agg('count')` ≡ `.count()` on that column.
- **Flatten a multi-level result** ➔ several functions on one column give **two-level columns**; flatten them:
```python
g = titanic.groupby('class').agg({'who':'count', 'age':{'mean','max','min'}})
g = g.reset_index()                       # 'class' back to a column
g.columns = g.columns.droplevel(0)        # drop the top ('age') level
g.rename(columns={'count':'passengers','mean':'avg age'}, inplace=True)
```

## ✍️ Practice
> [!QUESTION]- Practice 1: For each `class` in `titanic`, return the passenger **count** (`who`) and **mean** `age` in one call.
> > [!SUCCESS]- Reference solution
> > ```python
> > fun = {'who': 'count', 'age': 'mean'}
> > titanic.groupby('class').agg(fun)
> > ```
> > - **Key move:** `.agg({col: func})` runs several aggregations at once, one row per class.

## ⚠️ Common Mistakes
- 💡 **Result is indexed by the group key** ➔ `(G, k)` not `(N, D)`; use `.reset_index()` if you need the key back as a column (e.g. before plotting).
- 💡 **`lambda x:` defines an anonymous function** ➔ `x` is each group's Series; use it for custom aggregators `agg()` doesn't provide by name.
- 💡 **Multi-function agg makes 2-level columns** ➔ `reset_index()` + `droplevel(0)` + `rename()` to flatten before further use or plotting; flattening loses the key's name, so rename `''` → the key.
