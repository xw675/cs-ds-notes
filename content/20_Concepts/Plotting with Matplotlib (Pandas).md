---
unit: FIT1043
domain: G
week: 4
parent: "[[Data Visualisation (Chart Types)]]"
tags: [DataScience/Visualisation, Tool/Matplotlib]
type: pattern
aliases: [Matplotlib, plt, df.plot, hist, boxplot]
---
# [[Plotting with Matplotlib (Pandas)]]

**Context:** [[FIT1043_MOC]] · render the [[Data Visualisation (Chart Types)|chart types]] in Python · matplotlib + pandas `.plot` · often after a [[Groupby-Aggregate Pipeline (Pandas)|groupby]] · lab: `30_Projects/FIT1043_Labs/Week4-Wrangling-Viz-Solution.pdf`
**Problem it solves:** turn a DataFrame column (or two) into the chart appropriate for its data type.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need a chart ➔ import matplotlib.pyplot as plt; call plt.<kind> or df.plot.<kind> matched to the data type.
> - **⚡ Key Constraint:** match plot to [[Types of Data (Numeric and Categorical)|type]] — `bar`/`pie` for categorical, `hist`/`boxplot`/`scatter` for numeric.

## 🔧 Minimal Working Example
```python
import matplotlib.pyplot as plt
df = pd.DataFrame({'Class': ['First','Second','Third'], 'Passengers': [194,177,450]})
plt.bar(df['Class'], df['Passengers'])   # categorical → bar chart
plt.show()
```
**Expected output:** a bar chart of passengers per class.

- **Bar (categorical)** ➔ `plt.bar(df['Class'], df['Passengers'])`.
- **Pie (categorical proportions)** ➔ `df.plot.pie(y='Average Age', labels=df['Class'])`.
- **Line (trend)** ➔ `plt.plot(df['Y'])`.
- **Scatter (cont × cont)** ➔ `plt.scatter(df['X'], df['Y'])`.
- **Histogram (continuous)** ➔ `df.col_name.hist(bins=4)`.
- **Boxplot (continuous)** ➔ `df.boxplot(column='col_name')`.

## 🔀 Variations
- **Set the pie index** ➔ build the DataFrame with `index=['First','Second','Third']` so `df.plot.pie(y='Average Age')` labels sectors automatically.
- **Control histogram detail** ➔ raise/lower `bins=` (few = coarse shape, many = ragged).
- **Encode a 3rd/4th variable on a scatter** ➔ colour by a column and size the points: `plt.scatter(df['HR'], df['SBP'], c=df['DBP'], s=40, cmap='hot')` — `c=` colours, `cmap=` the palette, `s=` the marker size.

## ✍️ Practice 
> [!QUESTION]- Practice 1: For numeric column `price`, draw a histogram with 20 bins and a boxplot to inspect its spread/outliers.
> > [!SUCCESS]- Reference solution
> > ```python
> > df['price'].hist(bins=20)          # distribution shape
> > df.boxplot(column='price')         # spread + outliers (IQR rule)
> > ```
> > - **Key move:** histogram + boxplot are the numeric-continuous pair; both need a numeric column.

## ⚠️ Common Mistakes
- 💡 **Wrong chart for the type** ➔ a bar chart is for categorical counts; use a histogram for *continuous* data (it bins the values).
- 💡 **`plt.show()` renders it** ➔ in scripts the figure won't display until `plt.show()` (notebooks may auto-render).
