---
unit: FIT1043
week: 5
parent: "[[Machine Learning]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Learning Theory, Loss Function, Error, Loss, Gain]
---
# [[Learning Theory and Loss Functions]]

**Context:** [[FIT1043_MOC]] · how we judge a learnt [[Predictive Models|model]]'s quality · turns prediction **error** into a **loss** · the objective [[Linear and Polynomial Regression|regression]] minimises

> [!abstract] Quick Revision
> - **🎯 Objective:** measure how good a prediction is ➔ convert error into quality via a **loss function**.
> - **📦 Core Components:** error (the miss) → loss (bad = positive) / gain (good = positive).
> - **⚡ Key Constraint:** **error is not quality** — it's a distance; quality is a *function of* error, and the loss function decides how a given error is penalised.

## 📝 How It Works
### 1. Learning Theory & Truth
- **Learning theory** ➔ the subfield of AI studying the **design and analysis** of machine learning.
- **The "truth"** ➔ for a single case (e.g. one heart-disease patient) truth is measurable, but the **true model** would need **infinite data** and is a **dynamic** (moving) target — so it's never fully known.

### 2. Quality, Loss, Gain, Error
- **Quality/value** ➔ the consequence of an action (a prediction is an action); measured on a positive or negative scale (William Tell's apple shot: value varies with where the arrow strikes).
- **Loss** ➔ **positive when things are bad**, negative/zero when good.
- **Gain** ➔ positive when good, negative when bad.
- **Error** ➔ a measure of **"miss"** (often a distance); $0$ = exactly right. **Not** itself a measure of quality.

### 3. Loss Functions (error → quality)
$$
\begin{aligned}
\text{absolute-error}(x) &= |x| \\
\text{square-error}(x) &= x \cdot x = x^{2} \\
\text{hinge-error}(x) &= \begin{cases} |x| & \text{if } |x| \le 1 \\ 1 & \text{otherwise} \end{cases}
\end{aligned}
$$

## ⚖️ Core Decision Matrix
| Term | Sign convention | Meaning |
| :--- | :--- | :--- |
| **Loss** | + when bad | penalty for a poor outcome |
| **Gain** | + when good | reward for a good outcome |
| **Error** | 0 = perfect | distance of prediction from actual (not quality) |

> [!NOTE] **When It Flips:** the **choice of loss function** shapes the model — square-error punishes large misses much harder than absolute-error (it squares them), so it's more outlier-sensitive; hinge-error caps the penalty at 1.

## 🧠 Active Recall
> [!FAQ]- Why is "error" not the same as "quality", and how does a loss function bridge them?
> > [!SUCCESS]- Answer
> > - **Short answer:** Error just measures the miss (distance, $0$ = perfect); quality is a *function of* error produced by a loss function (e.g. absolute, square, hinge) that assigns a penalty to each error size.
> > - **Why:** **Penalty shape** ➔ square-error weights big misses ∝ $x^2$ (outlier-sensitive); absolute-error weights them ∝ $|x|$; hinge caps at 1.

> [!FAQ]- Why can't we simply measure the "true model" directly?
> > [!SUCCESS]- Answer
> > - **Short answer:** A single instance's truth is measurable, but the true model would require infinite data and the problem is dynamic (changes over time), so it can only ever be approximated.
> > - **Why:** **Finite, shifting data** ➔ learning estimates the truth from samples and re-estimates as it changes.
