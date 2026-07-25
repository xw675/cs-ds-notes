---
unit: FIT1043
parent: "[[Data Wrangling]]"
tags: [DS/Pandas, DS/Wrangling]
type: cheatsheet
aliases: [Pandas Cheatsheet, Python Aggregation]
---
# [[Pandas Toolkit (Cheatsheet)]]

**Context:** [[FIT1043_MOC]] · Weeks 1–5 pandas in one place — create → audit → clean → groupby/agg → plot → fit · depth in [[Python Basics (Syntax, Types, Control Flow)]], [[Pandas DataFrame Basics]], [[Data Auditing in Pandas]], [[Groupby-Aggregate Pipeline (Pandas)]], [[Plotting with Matplotlib (Pandas)]]
**Read protocol:** scan tables → attempt the practice blank → follow links only where you failed. Shapes annotated as $(N,D)$. Lab code: `30_Projects/FIT1043_Labs/`.

> [!abstract] Quick Revision
> - **🎯 Objective:** raw CSV ➔ audited df ➔ cleaned ➔ **split–apply–combine** ➔ chart, in one chain.
> - **⚡ Key Constraint:** groupby mechanics: `groupby('g')` splits $(N,D)$ into $G$ sub-frames ➔ apply (e.g. `.mean()`) collapses each ➔ combine into $(G,k)$.

## 🧱 Create & Build — [[Pandas DataFrame Basics]]
| Task | Micro-syntax | Note |
| :-- | :-- | :-- |
| from dict | `pd.DataFrame({'A':[1,2], 'B':['x','y']})` | one list per column; `index=[...]` sets row labels |
| fixed-width file | `pd.read_fwf('f.txt', widths=[3,1,10], header=None)` | then `df.columns = ['ID','Gender',…]` |
| row by label | `df.loc[0]` · sample `df.sample(3)` | `.loc` = label-based |
| boolean filter | `df[df['A'] > 50]` · compound `df[(a) & (b)]` | **parenthesise** each condition |
| edit selected cells | `df.loc[mask, 'col'] = 'F'` | copy-safe — never `df[mask]['col'] = …` |
| new column | `df['Total'] = df['Math'] + df['English']` | vectorised |
| stack frames | `pd.concat([df1, df2]).reset_index()` | renumber combined index |

## 🔍 Load & Audit — [[Data Auditing in Pandas]]
| Task | Micro-syntax | Reads as |
| :-- | :-- | :-- |
| load | `df = pd.read_csv('file.csv')` | $(N,D)$ |
| peek | `df.head()` / `df.tail(3)` | first/last rows |
| size | `df.shape` · `len(df)` | $(N,D)$ tuple |
| schema | `df.info()` · `df.dtypes` | column types + non-null counts |
| stats | `df.describe()` | numeric five-number summary |
| categories | `df['col'].unique()` · `.nunique()` · `.value_counts()` | level inventory / frequency |
| missing map | `df.isnull().sum()` | NULL count per column |
| duplicates | `df.duplicated().sum()` | audit before dropping |

## 🧹 Clean & Transform — [[Data Wrangling]] · [[Data Quality Problems]]
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| select rows | `df[df['age'] > 50]` | boolean mask keeps TRUE rows |
| select safely | `df.loc[mask, ['col1','col2']]` | label-based; **avoid chained `df[a][b]` writes** |
| drop missing | `df.dropna(subset=['age'])` | row-wise by default |
| fill missing | `df['age'].fillna(df['age'].mean())` | impute = a modelling choice — note it |
| drop dupes | `df.drop_duplicates()` | after auditing count |
| retype | `df['d'] = pd.to_datetime(df['d'])` · `.astype(int)` | wrong dtype breaks aggregation |
| new column | `df['ratio'] = df['a'] / df['b']` | vectorised, no loop |
| rename | `df.rename(columns={'old':'new'})` | returns a copy — assign it |

## 📦 Groupby / Aggregate (split–apply–combine) — [[Groupby-Aggregate Pipeline (Pandas)]]
```python
df.groupby('gender')['age'].mean()                    # (N,D) → G groups → (G,) one stat
fun = {'who': 'count', 'age': 'mean'}                 # per-column different stats
df.groupby('class').agg(fun)                          # → (G, 2)
fun = {'age': {'nunique', lambda x: sum(e > 50 for e in x)}}   # custom aggregator (lambda)
df.groupby('class').agg(fun)                          # named + anonymous functions mixed
df.groupby('class')['who'].agg('count')               # string form ≡ .count()

g = df.groupby('class').agg({'who':'count','age':{'mean','max','min'}})  # 2-level columns
g = g.reset_index()                                   # 'class' back to a column
g.columns = g.columns.droplevel(0)                    # flatten: drop top ('age') level
g.rename(columns={'count':'passengers'}, inplace=True)
```
- **Split** ➔ `groupby('g')` partitions rows by value of `g`; **Apply** ➔ one stat per sub-frame; **Combine** ➔ result indexed by group.
- **Flatten multi-agg** ➔ several functions on one column give 2-level columns; `reset_index()` + `droplevel(0)` + `rename()` before plotting/further use.
- **`agg` accepts** ➔ a string (`'count'`), a dict (column→stat), a set of functions, or `lambda x: …` where $x$ is the group's column values.
- **Two-key groups** ➔ `groupby(['class','gender'])` — one row per key *combination* (SQL `GROUP BY a, b` analogue).

## 📊 Plot Entry Points — [[Plotting with Matplotlib (Pandas)]] · [[Data Visualisation (Chart Types)]]
| Question | Chart ➔ call |
| :-- | :-- |
| category comparison | `df.groupby('g')['v'].mean().plot(kind='bar')` |
| distribution of one numeric | `df['v'].plot(kind='hist')` / `.plot(kind='box')` |
| two numerics related? | `df.plot(kind='scatter', x='a', y='b')` |
| trend over time | `df.plot(x='date', y='v')` (line default) |
Always label: `plt.xlabel/ylabel/title` then `plt.show()`. Encode a 3rd var: `plt.scatter(x, y, c=df['g'], s=40, cmap='hot')`.
- **Fit a trend line** ➔ FIT1043 uses `scipy.stats.linregress(x, y)` → `slope, intercept, r, p, std_err`; see [[Linear Regression in Python (scipy)]].

## ✍️ Practice 
> [!QUESTION]- Titanic-style df `(891, 12)`: audit missing values; drop rows lacking `age`; then per `class` report passenger count, mean age, and the number of passengers older than 50; plot mean age per class as a bar chart.
> > [!SUCCESS]- Reference solution
> > ```python
> > df.isnull().sum()
> > df = df.dropna(subset=['age'])                       # (891,12) → (714,12)
> > fun = {'who': 'count', 'age': ['mean', lambda x: sum(e > 50 for e in x)]}
> > out = df.groupby('class').agg(fun)                   # → (3, 3)
> > out[('age','mean')].plot(kind='bar'); plt.ylabel('mean age'); plt.show()
> > ```
> > - **Key moves:** dict-form `agg` mixing string + lambda; shape tracking at each step.

## ⚠️ Common Mistakes
- 💡 **Chained indexing writes** ➔ `df[df.a>5]['b'] = 0` silently edits a copy (SettingWithCopy) — write via `df.loc[mask, 'b'] = 0`.
- 💡 **Aggregating wrong dtype** ➔ numbers stored as strings make `.mean()` fail/garbage — `df.info()` first, always.
- 💡 **`count` vs `size`** ➔ `count` skips NaN, `size` doesn't — mirrors SQL `COUNT(col)` vs `COUNT(*)` ([[SQL Aggregate Functions and GROUP BY]]).
