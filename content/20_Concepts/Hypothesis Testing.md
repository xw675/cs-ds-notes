---
unit: FIT2086
week: 5
source: [lecture]
domain: D
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [hypothesis test, null hypothesis, alternative hypothesis, H0, HA, p-value, Neyman-Pearson, test statistic, statistical significance, significance level, one-sided test, two-sided test, type I error]
---
# [[Hypothesis Testing]]

**Context:** [[FIT2086_MOC]] · the **third** inference task, after the point estimation of [[Maximum Likelihood Estimation]] and the interval estimation of [[Confidence Intervals]] · same [[Sampling Distribution of an Estimator|sampling-distribution]] machinery, run **backwards**: fix $\theta$ at the null and ask how improbable the observed $\hat\theta$ was · the concrete tests live in [[Tests for Normal Means (z-test and t-test)]] and [[Tests for Bernoulli Populations]]

> [!abstract] Quick Revision
> - **🎯 Objective:** assume $H_0$ true ➔ derive the sampling distribution of a **test statistic** ➔ report the tail probability $p$ of a discrepancy **as extreme or more extreme** than the observed one ➔ small $p$ = strong evidence **against** $H_0$.
> - **📦 Core Components:** $H_0$ (default position) vs $H_A$ · test statistic ($z$, $t$) · null distribution ($N(0,1)$, $T(n-1)$) · $p$-value · optional threshold $\alpha$.
> - **⚡ Key Constraint:** a $p$-value measures evidence **against** the null **only** — a large $p$ never proves $H_0$, it only fails to falsify it.

## 📝 Core
- **Two question shapes** ➔ virtually every test asks either *"are the parameters of a model equal to some specific value?"* or *"does one model fit the data better than another?"*; this week answers the first.
- **$H_0$ is the default position** ➔ the hypothesis held unless the data carries enough evidence to dismiss it; $H_A$ is what remains if it is dismissed. Framing example: $H_0:\mu=\mu_0$ vs $H_A:\mu\neq\mu_0$.
- **Neyman–Pearson logic** ➔ *"how likely would it be to see our sample $\mathbf{y}$ by chance if $H_0$ were true?"* — compute that probability **under the null**, and let its smallness be the evidence.
- **Estimates never hit the null exactly** ➔ $\hat\mu\neq\mu_0$ even when $\mu=\mu_0$, purely from sampling randomness ➔ the question is never *"is there a difference?"* but *"is a difference this large plausible by chance?"*.
- **Test statistic** ➔ the quantity whose null distribution is known and from which $p$ is computed; standardising the raw discrepancy by its **standard error** makes it scale-free — $z_{\hat\mu}$ counts **how many standard errors** $\hat\mu$ sits from $\mu_0$.
- **$p$-value** ➔ $P(\text{a discrepancy at least as extreme as the observed one}\mid H_0)$, tail(s) chosen by $H_A$. Smaller $p$ ⟹ the observed sample is more improbable under $H_0$ ⟹ stronger evidence against it.
- **Evidence grading (report this, not a verdict)** ➔ $p>0.05$ weak/no evidence · $0.01<p<0.05$ **moderate** evidence · $p<0.01$ **strong** evidence against $H_0$.
- **Two-sided ignores the sign** ➔ a large discrepancy in *either* direction contradicts $H_0:\mu=\mu_0$, so the two tails are added; symmetry of $N(0,1)$ collapses this to $2P(Z<-\lvert z\rvert)$.
- **The grey zone** ➔ $p\in(0.05,0.2)$ with a **large estimated difference** and a **small $n$** is **inconclusive**, not negative: small $n$ ⟹ large standard error ⟹ small $\lvert z\rvert$ ⟹ weak evidence purely from lack of data.
- **Sensitivity of $z$ and $p$ to $\sigma^2$** ➔ $\mathrm{se}=\sigma/\sqrt n$ sits in the denominator, so $\sigma^2\uparrow\Rightarrow\lvert z\rvert\downarrow\Rightarrow p\uparrow$ — **weaker** evidence from the *same* $\hat\mu$. The statistic grades a difference **relative to the variability expected in a fresh sample**, so a noisier population makes the same gap less surprising.

## 🧮 Proof Blueprint
**Theorem.** For $Y_1,\dots,Y_n\sim N(\mu,\sigma^2)$ with $\sigma^2$ known, testing $H_0:\mu=\mu_0$, the statistic $z_{\hat\mu}=\dfrac{\hat\mu-\mu_0}{\sigma/\sqrt n}$ satisfies $z_{\hat\mu}\sim N(0,1)$ under $H_0$, so $p=2P(Z<-\lvert z_{\hat\mu}\rvert)$.
**Strategy:** impose the null on the population, propagate it to the sampling distribution of $\hat\mu$, standardise, then read the tail mass beyond the observed value.
$$
\begin{aligned}
Y_1,\dots,Y_n &\sim N(\mu_0,\sigma^2) && \text{(null imposed on the population)}\\
\hat\mu\equiv\bar Y &\sim N\!\left(\mu_0,\frac{\sigma^2}{n}\right) && \text{(sampling distribution of the ML estimate)}\\
z_{\hat\mu}=\frac{\hat\mu-\mu_0}{\sigma/\sqrt n} &\sim N(0,1) && \text{(self-similarity; } \sigma/\sqrt n=\mathrm{se})\\
p=1-P\!\left(-\lvert z_{\hat\mu}\rvert<Z<\lvert z_{\hat\mu}\rvert\right) &= P(Z<-\lvert z_{\hat\mu}\rvert)+P(Z>\lvert z_{\hat\mu}\rvert) && \text{(both tails: sign-blind alternative)}\\
&= 2P(Z<-\lvert z_{\hat\mu}\rvert) && \text{(symmetry of } N(0,1))
\end{aligned}
$$
**Q.E.D.** ➔ the whole apparatus is [[Confidence Intervals|the CI derivation]] with the roles swapped: there $\mu$ was unknown and bracketed, here $\mu$ is **fixed at $\mu_0$** and the estimate is placed in the null's tail.

## ⚖️ Which Tail Fires
| Test | $H_0$ vs $H_A$ | Counts as evidence | $p$-value |
| :--- | :--- | :--- | :--- |
| **Two-sided** | $\mu=\mu_0$ vs $\mu\neq\mu_0$ | large $\lvert z_{\hat\mu}\rvert$, either sign | $2P(Z<-\lvert z_{\hat\mu}\rvert)$ |
| **One-sided upper** | $\mu\le\mu_0$ vs $\mu>\mu_0$ | large **positive** $z_{\hat\mu}$ | $1-P(Z<z_{\hat\mu})$ |
| **One-sided lower** | $\mu\ge\mu_0$ vs $\mu<\mu_0$ | large **negative** $z_{\hat\mu}$ | $P(Z<z_{\hat\mu})$ |

> [!NOTE] **When It Flips:** the one-sided forms drop the absolute value **and** the factor of $2$ — same $z$, half the $p$. Choosing the side *after* seeing the data manufactures significance; $H_A$ is fixed by the research question **before** the sample is drawn.

## 🎯 Statistical Significance (and why the unit downplays it)
- **Threshold decision** ➔ pick $\alpha$ (typically $0.05$); if $p<\alpha$ declare the result **statistically significant** and reject $H_0$.
- **Cost of the rule** ➔ committing to $\alpha$ accepts that $100\alpha\%$ of the time $H_0$ is **erroneously rejected** — a false positive built into the procedure, not a mistake in the arithmetic.
- **Deprecated in practice** ➔ the unit's stated preference is to **report and interpret the evidence** ($p$ plus effect size plus $n$) rather than collapse it to a binary reject/not-reject.
- **The threshold scales with the consequences** ➔ how much evidence is *enough* depends on the cost of a wrong rejection. A drug that cuts mortality but carries serious side effects and legal exposure may warrant demanding $p\le10^{-4}$ before claiming an effect, not $p<0.05$ ➔ statistics supplies the objective evidence; the decision threshold is a **judgement** about consequences.

## 🚫 Why the Null Can Never Be Proved
- **Falsification is one-directional** ➔ small $p$ rejects; large $p$ only says *this* experiment failed to falsify $H_0$.
- **The rival-law counterexample** ➔ against Ohm's $V=IR$, the fabricated law $V=\dfrac{R^2\sqrt I}{1000}$ predicts the **same** $V=1$ at $R=100,I=0.01$ ➔ that experiment yields a large $p$ for **both**, and cannot separate them.
- **Discrimination needs a discriminating setup** ➔ at $R=200,I=0.01$ Ohm predicts $\mu_0=2$ and the rival $\mu_0=4$ ➔ the rival is now rejected, yet Ohm is still only *unfalsified*: some untried setup could break it.
- **The physics precedent** ➔ Newtonian mechanics survives every ordinary experiment and fails at extremes; consistency with the data is never proof of truth.

## ⚠️ Common Mistakes
- 💡 **"A large $p$-value proves $H_0$"** ➔ the single biggest mark-loser: $p$ quantifies evidence **against** the null, so a large $p$ is an *absence of evidence*, never evidence of absence. Write "insufficient evidence to reject", never "we accept $H_0$" or "$H_0$ is true".
- 💡 **Reading $p$ as $P(H_0\text{ true})$** ➔ $p$ is $P(\text{data this extreme}\mid H_0)$, a probability over **samples**; $H_0$ is a fixed statement with no frequentist probability, exactly as $\mu$ has none in a CI.
- 💡 **Forgetting the factor of $2$** ➔ a two-sided test that reports one tail halves the $p$-value and manufactures evidence; conversely, doubling a one-sided $p$ throws evidence away.
- 💡 **Taking $\lvert z\rvert$ in a one-sided test** ➔ the sign **is** the information: $z_{\hat\mu}=-1.03$ against $H_A:\mu<\mu_0$ gives $p=P(Z<-1.03)$, whereas the sign-blind version would report the wrong tail entirely.
- 💡 **Confusing significance with importance** ➔ at large $n$ the standard error shrinks, so a trivially small effect can clear $p<0.01$; report the estimated difference alongside $p$.

## 🧠 Active Recall
> [!FAQ]- Your test returns $p=0.16$. A collaborator writes "we have shown the treatment has no effect". What exactly is wrong, and what should the sentence be?
> > [!SUCCESS]- Answer
> > - **Short answer:** the test only ever accumulates evidence **against** $H_0$; $p=0.16$ means a discrepancy this large occurs by chance about $1$ in $6$ times under the null — common — so there is **weak evidence against no-effect**, not evidence *for* it. Correct: "the data are not incompatible with no effect".
> > - **Why:** **Falsification asymmetry** ➔ many different hypotheses can predict the same $\mu_0$ for one experimental setup (the $V=R^2\sqrt I/1000$ counterexample), so failing to reject cannot single out $H_0$ as true. Only a setup where the rivals **disagree** can discriminate.

> [!FAQ]- Two studies test the same $H_0$ and both report $p=0.12$. Study A has $n=6$ with $\hat\mu-\mu_0$ large; study B has $n=5000$ with $\hat\mu-\mu_0$ tiny. Do they say the same thing?
> > [!SUCCESS]- Answer
> > - **Short answer:** no. B is **informative** — with a huge $n$ the standard error is minute, so a real effect of any size would have shown; the null is genuinely compatible. A is **inconclusive** — the grey zone from lack of data, since $\mathrm{se}=\sigma/\sqrt n$ is large and would flatten even a real effect.
> > - **Why:** **$p$ confounds effect size with sample size** ➔ $z_{\hat\mu}=\frac{\hat\mu-\mu_0}{\sigma/\sqrt n}$ scales with $\sqrt n$, so a small $n$ shrinks $\lvert z\rvert$ regardless of the truth. Always report $\hat\mu-\mu_0$ and $n$ next to $p$.

> [!FAQ]- *(Studio 5)* A leukemia trial halves mortality in the treatment arm vs placebo, $p=0.17$. Mark each true or false: **(a)** the treatment is useless; **(b)** stop developing it; **(c)** introduce it immediately; **(d)** run a larger trial.
> - **Hint:** Separate the effect size from the strength of evidence.
> > [!SUCCESS]- Answer
> > - **Short answer:** (a) **False** · (b) **False** · (c) **False** · (d) **True**.
> > - **Why:** **(a), (b) invert the falsification arrow** ➔ $p=0.17$ is weak evidence *against* no-effect, not evidence *for* it; the observed halving is a potentially strong effect. **(c) ignores the evidence** ➔ under the null, a reduction this large or larger would arise by chance in $17\%$ of trials, about $1$ in $6$. **(d) is the correct read of the grey zone** ➔ large effect $+$ borderline $p$ $+$ small $n$ ⟹ the standard error, not the drug, is the limiting factor, and $\mathrm{se}\propto1/\sqrt n$.

> [!FAQ]- A test returns $p=0.9$. State precisely what that means, and what it does **not** establish.
> > [!SUCCESS]- Answer
> > - **Short answer:** if $H_0$ were true, $90\%$ of the samples you could have drawn would show a discrepancy from $\mu_0$ **as large or larger** than the one observed — the data are entirely unremarkable under the null, so there is **no evidence against it**. It does **not** prove $\mu=\mu_0$.
> > - **Why:** **Evidence flows one way only** ➔ $p$ is computed *assuming* $H_0$, so it can only ever measure incompatibility; $9$ out of $10$ samples being at least this extreme is the definition of "not at odds with the null", not of "the null is true".

> [!FAQ]- Why is the two-sided $p$-value written $2P(Z<-\lvert z_{\hat\mu}\rvert)$ rather than $P(Z>z_{\hat\mu})$?
> > [!SUCCESS]- Answer
> > - **Short answer:** $H_A:\mu\neq\mu_0$ treats a discrepancy of the same magnitude in **either** direction as equally incriminating, so both tails beyond $\pm\lvert z_{\hat\mu}\rvert$ must be counted; symmetry of $N(0,1)$ makes the two tails equal, hence the factor $2$ on the lower one.
> > - **Why:** **The alternative selects the rejection region** ➔ $p$ is the null probability of the region "at least as inconsistent with $H_0$ as what we saw", and $H_A$ defines what *inconsistent* means. Under $H_A:\mu>\mu_0$ only the upper tail qualifies, so the same $z$ yields half the $p$.
