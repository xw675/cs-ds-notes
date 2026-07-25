---
unit: [FIT1043, FIT2086]
week: [0, 4]
parent: "[[Types of Data (Numeric and Categorical)]]"
tags: [DataScience/Statistics, Monash/CS_DS]
aliases: [Descriptive Statistics, Mean, Median, Mode, Skewness]
---
# [[Measures of Centrality]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · the "typical value" of a sample · the first of the [[Measures of Spread and Boxplots|descriptive statistics]] · numerically interpreting [[Types of Data (Numeric and Categorical)|numeric data]]
**FIT2086 framing:** a **statistic** is *any* function $s(\mathbf{y})$ of a sample; the mean $\bar y=\frac1n\sum_j y_j$, median $\mathrm{med}(\mathbf{y})$ and mode are the simplest — later reused as **estimators** of population parameters (see [[Statistical Modelling and Inference]]).

> [!abstract] Quick Revision
> - **🎯 Objective:** summarise a sample's centre ➔ mean, median, mode.
> - **📦 Core Components:** mean (all values) | median (middle value) | mode (most frequent).
> - **⚡ Key Constraint:** the **mean is sensitive** to every value (outliers drag it); the **median is resistant** — their gap reveals skew.

## 📝 How It Works
### 1. What is a Statistic?
- **Descriptive statistics** ➔ numerically interpret key features of a dataset; usually **lose information** but gain comprehension (contrast **inferential** statistics).
- **Statistic** ➔ for a sample $y=(y_1,\dots,y_n)$, any function $s(y)$ of the data.

### 2. The Three Measures
- **Mean** ➔ arithmetic average $\bar y = \frac1n\sum_{i=1}^n y_i$; uses **all** values.
- **Median** ➔ $\operatorname{med}(y)$ = value with 50% of samples below it; sort and take the middle.
- **Mode** ➔ the most frequently occurring value.

### 3. Mean vs Median (robustness)
- **Mean** ➔ any change to any value changes it; one huge value can move it arbitrarily.
- **Median** ➔ uses at most **two** middle values ➔ resistant to changes away from the middle.
- **Worked** ➔ $y=(1,2,3,4,5)\Rightarrow \bar y=3,\ \operatorname{med}=3$; $y=(1,2,3,4,50)\Rightarrow \bar y=12,\ \operatorname{med}=3$.

## ⚖️ Core Decision Matrix
| Distribution | Mean vs Median | Tail |
| :--- | :--- | :--- |
| **Symmetric** | mean $\approx$ median | balanced |
| **Positively skewed** | mean $>$ median | long right tail |
| **Negatively skewed** | mean $<$ median | long left tail |

> [!NOTE] **When It Flips:** the **sign of (mean − median)** diagnoses skew — the mean chases the long tail while the median stays put; equal ⇒ symmetric.

## 🧠 Active Recall
> [!FAQ]- Why does changing one value from 5 to 50 move the mean from 3 to 12 but leave the median at 3?
> - **Hint:** All-values vs middle-value.
> > [!SUCCESS]- Answer
> > - **Short answer:** The mean sums all values, so a large outlier inflates it; the median depends only on the middle position, unchanged when a non-middle value grows.
> > - **Why:** **Resistance** ➔ median uses at most two central values, so it's robust to outliers; the mean is not.

> [!FAQ]- How do you read skew from the mean and median?
> - **Hint:** Mean chases the tail.
> > [!SUCCESS]- Answer
> > - **Short answer:** mean > median ⇒ positively skewed (right tail); mean < median ⇒ negatively skewed (left tail); mean ≈ median ⇒ symmetric.
> > - **Why:** **Tail pull** ➔ extreme values in the tail drag the mean toward that tail.
