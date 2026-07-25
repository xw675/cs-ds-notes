---
unit: [FIT1043, FIT2086]
domain: G
week: [0, 4]
parent: "[[Measures of Centrality]]"
tags: [DataScience/Statistics, DataScience/Visualisation]
aliases: [Measures of Spread, Range, Variance, Standard Deviation, Boxplot, Five-Number Summary]
---
# [[Measures of Spread and Boxplots]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · how far samples differ from the [[Measures of Centrality|centre]] · percentiles feed the IQR and the boxplot · outlier rule shared with [[Data Quality Problems]]
**FIT2086 framing:** sample **variance** $v(\mathbf{y})=s^2(\mathbf{y})$ where $s(\mathbf{y})=\sqrt{\frac1n\sum_j (y_j-\bar y)^2}$ (same unit as the data); the **percentile** $Q(\mathbf{y},p)$ generalises the median $Q(\mathbf{y},50)$, with quartiles $Q(\mathbf{y},25),Q(\mathbf{y},75)$ — the population analogue is the [[Random Variables and Probability Distributions (FIT2086)|quantile function]].

> [!abstract] Quick Revision
> - **🎯 Objective:** quantify dispersion ➔ range, variance/standard deviation, and the IQR from percentiles.
> - **📦 Core Components:** range (max−min) | variance $v=s^2$ / SD $s$ | IQR $=Q_3-Q_1$ | boxplot = five-number summary.
> - **⚡ Key Constraint:** range and SD are **outlier-sensitive**; the IQR (middle 50%) is robust and drives the boxplot outlier rule.

## 📝 How It Works
### 1. Range, Variance, Standard Deviation
- **Range** ➔ $\operatorname{rng}(y)=\max\{y\}-\min\{y\}$; simplest, but only two values.
- **Variance** ➔ $v(y)=s^2(y)$ = mean of **squared deviations** from the sample mean; easier to work with algebraically.
- **Standard deviation** ➔ $s(y)=\sqrt{v(y)}$; in the data's units, sensitive to changes like the mean.

### 2. Percentiles & Quartiles
- **$p$-th percentile** ➔ $Q(y,p)$ = value with $p\%$ of the sample below it.
- **Median** ➔ $Q(y,50)$; **quartiles** ➔ $Q_1=Q(y,25)$, $Q_3=Q(y,75)$.
- **IQR** ➔ $\text{IQR}=Q_3-Q_1$ = spread of the middle 50% (robust to outliers).

### 3. Boxplot (five-number summary)
- **Five numbers** ➔ min, $Q_1$, median, $Q_3$, max ➔ captures **centrality, spread, and skew** in one plot.
- **Outlier rule** ➔ suspected outliers are $> Q_3 + 1.5\,\text{IQR}$ or $< Q_1 - 1.5\,\text{IQR}$.

## ⚖️ Core Decision Matrix
| Measure | Formula | Robust to outliers? |
| :--- | :--- | :--- |
| **Range** | $\max-\min$ | ❌ (extremes only) |
| **Standard deviation** | $\sqrt{v(y)}$ | ❌ (uses all values) |
| **IQR** | $Q_3-Q_1$ | ✅ (middle 50%) |

> [!NOTE] **When It Flips:** a wider spread ($s$ from $0.5 \to 1.5$) fattens the distribution and lengthens the range; the boxplot shows the same story visually — a taller box = larger IQR.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** $Q_1 = 400$, $Q_3 = 600$. Give the IQR and the upper outlier threshold.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{IQR} &= Q_3 - Q_1 = 600 - 400 = 200 \\
\text{upper} &= Q_3 + 1.5\,\text{IQR} = 600 + 300 = 900
\end{aligned}
$$
**Final Extracted Output:** IQR $=200$; any value $> 900$ (or $< Q_1-300 = 100$) is a suspected outlier.

## 🧠 Active Recall
> [!FAQ]- What five numbers make a boxplot, and what three properties does it show at once?
> - **Hint:** Five-number summary.
> > [!SUCCESS]- Answer
> > - **Short answer:** min, $Q_1$, median, $Q_3$, max; it displays centrality (median), spread (box/whiskers), and skew (asymmetry) together.
> > - **Why:** **Quartile geometry** ➔ box = IQR, line = median, whiskers/points = spread and outliers.

> [!FAQ]- Why prefer the IQR over the range or SD when outliers are present?
> - **Hint:** Middle-50% robustness.
> > [!SUCCESS]- Answer
> > - **Short answer:** The IQR uses only the middle 50% ($Q_3-Q_1$), so extreme values don't distort it; range uses the extremes and SD uses every value.
> > - **Why:** **Resistance** ➔ like the median, quartile-based measures ignore the tails.
