---
unit: FIT1043
parent: "[[Linear and Polynomial Regression]]"
tags: [DataScience/Tools, DataScience/ML, Tool/Pandas]
type: pattern
aliases: [linregress, scipy linregress, Linear Regression Python]
---
# [[Linear Regression in Python (scipy)]]

**Context:** [[FIT1043_MOC]] · the applied form of [[Linear and Polynomial Regression|linear regression]] · fit a line with **scipy** · lab: `30_Projects/FIT1043_Labs/Week5-Regression-Solution.pdf`
**Problem it solves:** fit $\hat y = a_0 + a_1 x$ to two numeric columns, read the slope/intercept/$r$, and plot the line.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a linear trend between two numeric variables ➔ linregress(x, y) returns slope, intercept, r, p, std_err.
> - **⚡ Key Constraint:** `linregress` unpacks **five** values in order; build predictions with a comprehension `slope*xi + intercept`.

## 🔧 Minimal Working Example
```python
from scipy.stats import linregress
import matplotlib.pyplot as plt

slope, intercept, r_value, p_value, std_err = linregress(df['Age'], df['Income'])
line = [slope*xi + intercept for xi in df['Age']]     # predicted y for each x

plt.scatter(df['Age'], df['Income'])
plt.plot(df['Age'], line, 'r-')
plt.show()
```
**Expected output:** the fitted line over the scatter; `slope`/`intercept` define it, `r_value` its correlation strength.

- **Fit** ➔ `slope, intercept, r_value, p_value, std_err = linregress(x, y)` (x = independent, y = dependent).
- **Predict / draw** ➔ `line = [slope*xi + intercept for xi in x]`, then `plt.plot(x, line)`.
- **Read $r$** ➔ `r_value` is Pearson correlation ($-1..1$); its sign matches the slope's (e.g. Age↑ vs Runs↓ gives negative slope and $r$).

## 🔀 Variations
- **Report the fit** ➔ `print('slope %f intercept %f' % (slope, intercept)); print('r %f' % r_value)`.
- **Predict one point** ➔ `slope*70 + intercept` — but only trust it where the relationship is actually linear.

## ✍️ Practice
> [!QUESTION]- Practice 1: Fit Age → Runs for a players DataFrame, print the slope and r-value, and plot the line over the data.
> > [!SUCCESS]- Reference solution
> > ```python
> > slope, intercept, r_value, p_value, std_err = linregress(df['Age'], df['Runs'])
> > print('slope: %f  r: %f' % (slope, r_value))
> > line = [slope*xi + intercept for xi in df['Age']]
> > plt.plot(df['Age'], line, 'r-'); plt.scatter(df['Age'], df['Runs']); plt.show()
> > ```
> > - **Key move:** unpack all five returns; the comprehension turns slope/intercept into a plottable line.

## ⚠️ Common Mistakes
- 💡 **Don't extrapolate past the linear range** ➔ a model fit on ages 18–40 can't predict income at 70 if the true relation bends — linear regression **assumes** linearity.
- 💡 **Order of returns matters** ➔ `linregress` gives (slope, intercept, r, p, std_err); mis-unpacking silently mislabels them.
