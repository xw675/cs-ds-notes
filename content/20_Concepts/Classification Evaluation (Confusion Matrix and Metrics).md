---
unit: FIT1043
week: 7
parent: "[[Predictive Models]]"
tags: [DataScience/Modelling, ML/Classification, Monash/CS_DS]
aliases: [Confusion Matrix, Accuracy, Precision, Recall, Sensitivity, Specificity]
---
# [[Classification Evaluation (Confusion Matrix and Metrics)]]

**Context:** [[FIT1043_MOC]] · how good is a [[Predictive Models|classifier]]? · counts outcomes in a confusion matrix · the right metric **depends on the cost of each error**

> [!abstract] Quick Revision
> - **🎯 Objective:** score a classifier ➔ build a confusion matrix (TP/FP/FN/TN), then compute the metric that matches the task.
> - **📦 Core Components:** accuracy | sensitivity/recall | specificity | precision | false-positive rate.
> - **⚡ Key Constraint:** accuracy alone misleads — choose the metric by **which error is worse** (a missed fraud vs a blocked good email).

## 📝 How It Works
### 1. The Confusion Matrix
|  | **Predicted Positive** | **Predicted Negative** |
| :--- | :--- | :--- |
| **Actual Positive** | TP (true positive) | FN (false negative) |
| **Actual Negative** | FP (false positive) | TN (true negative) |

### 2. The Five Metrics
- **Accuracy** ➔ overall correct: $\dfrac{TP+TN}{TP+TN+FP+FN}$.
- **Sensitivity / Recall** ➔ of actual **positives**, how many caught: $\dfrac{TP}{TP+FN}$.
- **Specificity** ➔ of actual **negatives**, how many correct: $\dfrac{TN}{TN+FP}$.
- **False Positive Rate** ➔ of actual negatives, how many wrongly flagged: $\dfrac{FP}{TN+FP} = 1-\text{specificity}$.
- **Precision** ➔ of predicted **positives**, how many correct: $\dfrac{TP}{TP+FP}$.

### 3. Which Metric When (it depends)
- **Spam filter** ➔ optimise **precision / specificity** — a FN (spam in inbox) is tolerable; a FP (good mail blocked) is costly.
- **Fraud detector** ➔ optimise **sensitivity/recall** — a FP (normal flagged) is tolerable; a FN (missed fraud) is costly.
- **Covid test** ➔ balance sensitivity (catch the sick) vs specificity (don't alarm the healthy).

## ⚖️ Core Decision Matrix
| Metric | Question it answers | Formula |
| :--- | :--- | :--- |
| **Accuracy** | overall how often correct? | $(TP{+}TN)/\text{all}$ |
| **Recall (sensitivity)** | of actual +, how many found? | $TP/(TP{+}FN)$ |
| **Specificity** | of actual −, how many correct? | $TN/(TN{+}FP)$ |
| **Precision** | of predicted +, how many right? | $TP/(TP{+}FP)$ |

> [!NOTE] **When It Flips:** recall and precision pull apart — flagging **everything** positive gives perfect recall but poor precision; flagging **only sure** cases gives high precision but poor recall. The task's error costs pick which to favour.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** $TP=40$, $FN=10$, $FP=20$, $TN=30$. Compute accuracy, recall, precision.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{accuracy} &= \frac{40+30}{100} = 0.70 \\
\text{recall} &= \frac{40}{40+10} = 0.80 \\
\text{precision} &= \frac{40}{40+20} \approx 0.67
\end{aligned}
$$
**Final Extracted Output:** 70% accurate; catches 80% of positives (recall) but only 67% of its positive calls are right (precision).

## 🧠 Active Recall
> [!FAQ]- For a fraud detector, which metric matters most and why — precision or recall?
> - **Hint:** Cost of a false negative.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Recall (sensitivity)** — a missed fraud (false negative) is far costlier than a false alarm (false positive), so you maximise the fraction of actual frauds caught.
> > - **Why:** **Error asymmetry** ➔ recall $=TP/(TP+FN)$ penalises misses; the tolerable error (FP) is what precision would protect.

> [!FAQ]- Why can a 95%-accurate classifier still be useless?
> - **Hint:** Class imbalance.
> > [!SUCCESS]- Answer
> > - **Short answer:** If 95% of cases are negative, always predicting "negative" scores 95% accuracy yet catches **zero** positives (recall 0); accuracy hides this.
> > - **Why:** **Imbalance** ➔ inspect recall/precision on the positive class, not overall accuracy.
