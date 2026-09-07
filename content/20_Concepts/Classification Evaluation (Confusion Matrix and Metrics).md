---
unit: [FIT1043, FIT2086]
domain: E
week: 7
source: [lecture]
parent: "[[Predictive Models]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Confusion Matrix, Accuracy, Classification Accuracy, Precision, Recall, Sensitivity, Specificity, TPR, TNR, True Positive Rate, True Negative Rate]
---
# [[Classification Evaluation (Confusion Matrix and Metrics)]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · how good is a [[Predictive Models|classifier]]? · counts outcomes in a confusion matrix · the right metric **depends on the cost of each error** · scores the output of [[Logistic Regression]] · sweep the threshold instead of fixing it ➔ [[ROC and AUC]] · score the probabilities instead of the labels ➔ [[Logarithmic Loss]]

> [!abstract] Quick Revision
> - **🎯 Objective:** score a classifier ➔ build a confusion matrix (TP/FP/FN/TN), then compute the metric that matches the task.
> - **📦 Core Components:** accuracy | sensitivity/recall | specificity | precision | false-positive rate.
> - **⚡ Key Constraint:** accuracy alone misleads — choose the metric by **which error is worse** (a missed fraud vs a blocked good email), and check it against the **class frequencies**, not against $\tfrac12$.

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

### 4. The FIT2086 Layer — Notation, Decision Rule and Baseline
- **Where the labels come from** ➔ a probabilistic model gives $\mathbb{P}(Y'_i=y\mid \mathbf{x}'_i)$; the predicted class is $\hat y'_i=\arg\max_{y\in\{0,1\}}\mathbb{P}(Y'_i=y\mid\mathbf{x}'_i)$ ➔ equivalently a threshold of $T=\tfrac12$ ([[ROC and AUC]]).
- **Classification accuracy as an indicator sum** ➔ over $n'$ **new** test individuals:
$$
\text{CA}=\frac{1}{n'}\sum_{i=1}^{n'}I\left(y'_i=\hat y'_i\right)
$$
where $I(\cdot)$ is $1$ when the condition holds and $0$ otherwise ⟹ the proportion of correct guesses on data the model was **not** fitted to.
- **Names used in FIT2086** ➔ sensitivity is the **true positive rate** $\text{TPR}=\frac{TP}{TP+FN}$; specificity is the **true negative rate** $\text{TNR}=\frac{TN}{TN+FP}$ — same quantities as above, exam-facing names.
- **Range** ➔ $\text{CA}\in[0,1]$: $0$ perfectly incorrect, $1$ perfectly correct.
- **The baseline is not always $\tfrac12$** ➔ for **balanced** binary classes, $\tfrac12$ is the accuracy of random guessing; for **imbalanced** classes a trivial majority-class classifier already scores above $\tfrac12$ ⟹ the relevant baseline is set by the **class frequencies**.
- **Orientation warning** ➔ the lecture draws the matrix both ways (predicted as rows on one slide, actual as rows on the next) ⟹ read the axis **labels**, never the cell positions.

## ⚖️ Core Decision Matrix
| Metric | Question it answers | Formula |
| :--- | :--- | :--- |
| **Accuracy** | overall how often correct? | $(TP{+}TN)/\text{all}$ |
| **Recall (sensitivity, TPR)** | of actual +, how many found? | $TP/(TP{+}FN)$ |
| **Specificity (TNR)** | of actual −, how many correct? | $TN/(TN{+}FP)$ |
| **Precision** | of predicted +, how many right? | $TP/(TP{+}FP)$ |

> [!NOTE] **When It Flips:** recall and precision pull apart — flagging **everything** positive gives perfect recall but poor precision; flagging **only sure** cases gives high precision but poor recall. The task's error costs pick which to favour.

## 📊 Exam Execution Trace

### Applied Exercise 1
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

### Applied Exercise 2 — a decent accuracy hiding a broken classifier
**Problem:** $n'=192$ test individuals give $TN=118$, $FP=12$, $FN=47$, $TP=15$. Report CA, sensitivity and specificity, and judge the classifier.
$$
\begin{aligned}
\text{CA} &= \frac{15+118}{15+118+12+47}=\frac{133}{192}=0.6927 \\
\text{TPR} &= \frac{15}{15+47}=\frac{15}{62}=0.2419 \\
\text{TNR} &= \frac{118}{118+12}=\frac{118}{130}=0.9077
\end{aligned}
$$
**Final Extracted Output:** $69\%$ accurate looks respectable, but it catches only $24\%$ of the positives while getting $91\%$ of the negatives right ⟹ the accuracy is carried almost entirely by the **majority negative class**. With $130/192=68\%$ negatives, predicting "always $0$" would already score $\text{CA}=0.68$ — this model beats that baseline by less than one point.

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
> > - **Why:** **Imbalance** ➔ inspect recall/precision on the positive class, not overall accuracy; the honest baseline is the **majority-class frequency**, not $\tfrac12$.

> [!FAQ]- Classification accuracy is computed on new data, not the training data. What would go wrong otherwise?
> > [!SUCCESS]- Answer
> > - **Short answer:** Training accuracy rewards **memorisation** — a model complex enough to fit every training label scores near $1$ and still fails on anything new.
> > - **Why:** **Same generalisation problem as regression** ➔ in-sample fit improves monotonically with complexity ([[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]), so honest scoring needs held-out data, exactly as for the held-out NLL in [[Plug-in Prediction and Held-Out Evaluation]].
