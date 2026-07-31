---
unit: [FIT1043, FIT2086]
domain: E
parent: "[[Data Science]]"
tags: [Tool/R, DataScience/Wrangling, DataScience/Modelling]
type: cheatsheet
aliases: [R Cheatsheet, R Basics, R simulation cheatsheet]
---
# [[R Toolkit (Cheatsheet)]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · base R in one place — syntax → vectors → data frames → CSV → plots → `lm` → **simulation/distributions** · plots detailed in [[R Visualisation (base graphics)]]; simulation detailed in [[R Simulation and Random Sampling]] · lab: `30_Projects/FIT1043_Labs/Week8-R-Solution.pdf`
**Read protocol:** scan tables → attempt the practice blank → follow links only where you failed.

> [!abstract] Quick Revision
> - **🎯 Objective:** wrangle a data frame end-to-end in base R ➔ create/audit/extract/sort/merge/aggregate → plot → lm.
> - **⚡ Key Constraint:** indexing semantics — `df["col"]` (data frame) vs `df$col` (vector) vs `df[rows, cols]` (matrix-style); negative index = *drop*.

## 🧱 Language Core
| Tool | Micro-syntax | Output / gotcha |
| :-- | :-- | :-- |
| assign | `A <- 10` | `<-` is the R idiom, not `=` |
| types | `10.5` numeric · `as.integer(10.5)` · `1+2i` · `TRUE` · `"str"` | default number type is numeric (double) |
| inspect type | `class(y)` · `is.integer(y)` · `as.character(y)` | `is.*` tests, `as.*` converts |
| help | `help(c)` | — |
| if | `if (x > 0) { … }` | braces, C-style |
| for / while | `for (i in 1:3) { … }` · `while (i <= 6) { … }` | `1:n` is an inclusive sequence |
| break / next | `break` exits loop · `next` skips iteration | `next` ≈ Python's `continue` |
| stepped sequence | `seq(1, 15, 2)` · `1:15` | `seq(from,to,by)` avoids a modulo test |
| modulo / int div | `i %% 2` remainder · `i %/% 2` quotient | `%% 2 == 1` tests odd |
| print in a loop/fn | `cat("i is:", i, "\n")` | loops/functions **don't** auto-print; `\n` = newline |
| define a function | `f <- function(a, b) { return(a/b) }` | not usable until the definition is **executed** |
| multi-value return | `r = list(); r$min = 1; return(r)` | `list()` is R's struct; nests and mixes types |
| argument guard | `if (!is.numeric(x)) { stop("msg") }` | `stop()` aborts with a message |
| scalar vs vector OR | `\|\|` and `&&` in `if` · `\|` and `&` element-wise | `!` negates a logical |

## 🖥 Workspace & Scripts
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| list / remove objects | `ls()` · `rm(x, y)` · `rm(list=ls())` | `rm` removes **objects**; a data-frame column needs `df$col <- NULL` |
| help | `help("ls")` / `?ls` · `apropos("med")` | examples sit at the **bottom** of the help page |
| run a script | `source("studio1.R")` | the script — not console history — is the reproducible record |

## 🧮 Vectors (the atom of R)
| Task | Micro-syntax | Result |
| :-- | :-- | :-- |
| create / extend | `B <- c(5,6,3,0)` · `B <- c(B, c(1,2))` | `c()` concatenates anything |
| index (1-based!) | `x[c(1,3,4)]` · `x[1:3]` | R counts from **1** |
| negative index | `x[c(-1,-4)]` | **drops** positions (≠ Python end-index) |
| element-wise arith | `v1 * v2` | pairwise on equal-length vectors |
| missing values | `anyNA(x)` → one TRUE/FALSE · `is.na(x)` → element-wise mask | NA is R's null |

## 🗃 Data Frames
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| create | `df <- data.frame(names, ages, heights)` | column per vector |
| rename | `names(df) <- c("Names","Ages","Heights")` | `names()` on the LHS |
| audit | `nrow(df)` · `ncol(df)` · `dim(df)` · `str(df)` · `summary(df)` | `str` = dtypes+preview; `summary` = per-column stats |
| stats | `min(df$Ages)` · `mean(df$H)` · `sd(df$H)` | on `$` vectors |
| columns | `df["Ages"]` · `df[c("Names","Ages")]` · `df[2]` | returns data frame |
| column as vector | `df$Ages` · `df$Ages[3]` | `$` returns the raw vector |
| rows / cells | `df[1, ]` · `df[2:4, ]` · `df[1,2]` · `df[3:4, 2:3]` | `[row, col]`; trailing comma = all columns |
| sort | `df[order(df$Ages), ]` · `order(…, decreasing=TRUE)` · two keys: `order(df$A, df$H)` | `order()` returns indices — must wrap in `df[ , ]` |
| merge (join) | `merge(df1, df2, by="Names")` | SQL-join analogue |
| stack rows | `rbind(df1, df2)` | same columns required |
| aggregate | `aggregate(mtcars, by=list(cyl,vs), FUN=mean)` | R's groupby ➔ mean per group combo |
| peek | `head(df, 6)` · `tail(df)` · `View(df)` | never print a big df; `View` opens the RStudio grid |
| logical referencing | `df[df$SEX == 0, "AGE"]` · `df[df$A == 0 & df$B < 150, ]` | condition goes in the **row** slot; `==` not `=` |
| add / drop column | `df$AC <- df$AGE / df$CHOL` · `df$AC <- NULL` | assignment is vectorised; `NULL` deletes |

## 📐 Descriptive Statistics (details ➔ [[Measures of Centrality]], [[Measures of Spread and Boxplots]])
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| centre | `mean(x)` · `median(x)` | median for skewed data |
| spread | `var(x)` · `sd(x)` · `range(x)` · `IQR(x)` | `range` returns `c(min, max)`, not the difference |
| quantiles | `quantile(x)` · `quantile(x, probs=c(.05,.25,.5,.75,.95))` | default is the five-number summary |
| everything at once | `summary(x)` · `summary(df)` | per-column when given a data frame |
| frequency table | `table(x)` · `prop.table(table(x))` | counts vs proportions |
| cross-tabulate | `table(a, b)` · `prop.table(table(a,b), margin=1)` | `margin=1` rows sum to 1 — the fix for unequal group sizes |
| label a coded column | `factor(x, labels=c("MALE","FEMALE"), levels=c(0,1))` | `labels[i]` names `levels[i]` — a mapping you **assert** |
| correlation | `cor(x, y)` · `which.max(abs(r))` | linear only; rank by **absolute** value |

## 📂 Files, Libraries, Environment
- **Working dir** ➔ `getwd()` / `setwd("D:/Folder")` — set BEFORE read/write.
- **CSV / tables** ➔ `read.csv("file.csv", header=TRUE, stringsAsFactors=TRUE)` — **always pass `stringsAsFactors`** so text columns become categorical · `write.csv(df, "file.csv")` · `read.table("out.txt", header=TRUE)` (the shell→R handoff after `awk … > out.txt`, see [[Unix Shell (Bash)]]).
- **Packages** ➔ once: `install.packages("moments")`; per session: `library(moments)`; built-ins: `data()` then `data(mtcars)`.

## 📊 Plots (details ➔ [[R Visualisation (base graphics)]])
| Chart | Call | Signature extras |
| :-- | :-- | :-- |
| bar | `barplot(H, names.arg=M, xlab, ylab, main, col)` | stacked: feed `table(vs, gear)`; grouped: `beside=TRUE` |
| histogram | `hist(mtcars$hp, xlim=c(0,400), …)` | distribution of ONE numeric |
| boxplot | `boxplot(mpg ~ cyl, data=mtcars)` | formula = value ~ group; **outliers: `boxplot(x)$out`** |
| scatter | `plot(x=df$wt, y=df$mpg, xlim=, ylim=)` | two numerics |
| points on the axis | `plot(x=y, y=rep(0,length(y)), ylim=c(0,6))` | a rug of raw samples under a fitted density |
| overlay a curve | `xv = seq(1.4, 2, length.out=100)` then `lines(xv, dnorm(xv, mu, sd))` | `length.out` builds the smooth grid; `lines` needs a prior `plot` |
| legend | `legend(x=1.75, y=6, c("A","B"), lty=c(0,1), pch=c("o",""), col=, lwd=)` | `lty=0`/`pch=""` = no line / no symbol; `bty="n"` drops the box |
| panel of plots | `par(mfrow=c(1,2))` | rows × columns; persists until reset |

## 📈 Linear Regression & Model Selection (FIT2086 W6 — details ➔ [[Multiple Regression and Stepwise Selection in R]])
| Task | Micro-syntax | Output / gotcha |
| :-- | :-- | :-- |
| fit simple | `fit <- lm(height ~ weight)` | formula reads "height explained by weight" |
| fit multiple | `lm(BP ~ Age + Weight + BSA, data = d)` | `data =` keeps columns out of the global env |
| all other columns | `lm(BP ~ ., data = d)` | `.` = every column except the response |
| read coefficients | `fit$coefficients[1]` intercept · `[2]` slope · `coef(fit)` | named vector; $\hat h = 61.38+1.415\,w$ on the FIT1043 data |
| full report | `summary(fit)` | `Estimate` $\hat\beta_j$ · `Std. Error` $\operatorname{se}$ · `t value` $t_j$ · `Pr(>\|t\|)` tests $H_0:\beta_j=0$ · `Multiple R-squared` $R^2$ |
| unbiased error sd | `summary(fit)$sigma` | this is $\hat\sigma_u$ on $n-p-1$ df, **not** $\hat\sigma_{ML}$ ➔ [[Least Squares as Maximum Likelihood]] |
| residuals / fitted | `residuals(fit)` · `fitted(fit)` | $\sum e_i=0$ and $\operatorname{corr}(x,e)=0$ **by construction** |
| overlay the line | `plot(x, y); abline(lm(y ~ x))` | `abline` needs a **simple** regression |
| polynomial term | `lm(y ~ x + I(x^2))` | `I()` protects `^` from formula syntax |
| interaction | `lm(y ~ a * b)` | expands to `a + b + a:b`; `a:b` alone gives the product only |
| categorical predictor | `d$g <- factor(d$g)` then `lm(y ~ g)` | R builds $K-1$ indicators; **first level is the baseline** |
| stepwise, **AIC** | `step(full, direction = "both", trace = 0)` | AIC is the **default**; `trace = 0` hides the search log |
| stepwise, **BIC** | `n <- nrow(d); step(full, direction="both", k = log(n), trace = 0)` | `k = log(n)` is the **entire** AIC➔BIC change |
| forward from empty | `step(lm(y ~ 1, data=d), scope = ~ a + b + c, direction = "forward")` | `scope` is **mandatory** — an intercept-only model names no candidates |
| predict new data | `predict(fit, newdata = data.frame(Age = 50, Weight = 95))` | `newdata` needs every predictor column, named exactly |
| decision tree | `library(party); ctree(y ~ a + b, data = d)` | needs `install.packages("party")` once ➔ [[R Modelling (lm and Decision Trees)]] |

*(R scores on the $-2\log L$ scale, so its default `k = 2` is the lecture's $\alpha=k_M$ and `k = log(n)` is $\alpha=\tfrac{k_M}{2}\log n$ — the selected subset is identical either way. Lower score wins ➔ [[Model Selection and Information Criteria (AIC, BIC)]].)*

## 🎲 Simulation & Distributions (FIT2086 — details ➔ [[R Simulation and Random Sampling]])
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| reproducible RNG | `set.seed(1)` | set **before each** block you want repeatable |
| sample (no replace) | `sample(1:10, 4)` | default; `size` ≤ set size |
| sample (with replace) | `sample(1:6, 10, replace=TRUE)` | needed when `size` > set size (dice rolls) |
| permutation | `sample(1:10)` | omit `size` → shuffle all |
| density (pmf/pdf) | `dnorm(x, mean, sd)` · `dpois(x, lambda)` | a density, **not** a probability |
| CDF $P(X\le q)$ | `pnorm(q, mean, sd)` · `lower.tail=FALSE` for $>$ | `p` = probability |
| quantile $F^{-1}(p)$ | `qnorm(p, mean, sd)` | inverse of `pnorm` |
| CI critical value $z_{\alpha/2}$ | `qnorm(1 - 0.05/2)` $\to1.96$ | pass the **percentile** $1-\alpha/2$, never $\alpha$ or $\alpha/2$ |
| CI critical value $t_{\alpha/2,n-1}$ | `qt(1 - 0.05/2, df = n - 1)` | `df` $=n-1$; at $n=8$ gives $2.36$ ➔ [[Confidence Intervals]] |
| unbiased variance $\hat\sigma^2_u$ | `var(y)` · `sd(y)` | divisor is $n-1$ ➔ this is $\hat\sigma^2_u$, **not** $\hat\sigma^2_{ML}$ |
| random draws | `rnorm(n, mean, sd)` · `runif(n)` · `rbinom(n,size,prob)` | `r` = simulate `n` values |
| Monte Carlo prob | `mean(rnorm(1e6) > 1.5)` | proportion of draws = estimated probability |
| Bernoulli draws | `rbinom(n, size=1, prob=theta)` | **no `*bern` family** — a binomial with `size = 1` |
| "$k$ or more" | `pbinom(k-1, n, p, lower.tail=FALSE)` | `pbinom(k)` is $P(X\le k)$ **inclusive** ➔ pass `k-1` |
| "**strictly** less than $k$" (discrete) | `ppois(k-1, lambda)` | $P(X<k)=P(X\le k-1)$ ➔ the boundary carries mass, unlike the continuous case |
| pmf by hand | `4^1 * exp(-4) / factorial(1)` | `exp()` and `factorial()` reproduce `dpois(1,4)` — use to check a translation |
| standardise then look up | `1 - pnorm((2-0)/4, 0, 1)` | identical to `1 - pnorm(2, 0, 4)` — self-similarity of the normal |
| help for a whole family | `?dbinom` | one help page documents `d`/`p`/`q`/`r` together |
| preallocate a vector | `mu <- vector(mode="numeric", length=n)` | `c(mu, val)` in a loop is $O(n^2)$ — preallocate for $O(n)$ |
| constant reference line | `rep(0, 1000)` / `rep(1/2, 1000)` | how you draw a horizontal line via `plot(..., type="l")` |
| overlay extra curves | `lines(x, y, col="red")` | `plot()` first, then `lines()`; set `ylim=c(0,1)` on the **`plot`** call — `lines` ignores it |
| running mean (WLLN demo) | accumulator loop ➔ [[R Simulation and Random Sampling]] | one running sum `S`, then `mu[i] <- S/i` |
| preallocate by repetition | `mu_hat = rep(0, niterations)` · `numeric(k)` | the simulation-study idiom ➔ [[Monte Carlo Estimator Comparison]] |
| empirical probability | `mean(test$heights > 1.7)` | logical ➔ `TRUE`=1 ➔ the mean **is** the proportion |
| overwrite a slice | `y[1:nc] = rnorm(nc, mu, 4*sigma)` | contaminating the first `nc` points, in place |
| optional argument | `f <- function(..., nc = 0)` | a default keeps every existing call site valid |
| index a sweep | `for (i in seq_along(n_vals))` | safe when the vector is empty, unlike `1:length(x)` |
| guard an argument | `if (alpha <= 0 \|\| alpha >= 1) stop("...")` | `stop()` aborts loudly; `\|\|` is the **scalar** or, `\|` is vectorised |
| interval containment test | `if (mu >= CI[1] && mu <= CI[2])` | `&&` short-circuits on scalars ➔ [[Confidence Interval Coverage Simulation]] |
| build both endpoints at once | `mu.hat + c(-t*se, t*se)` | vector recycling ➔ a length-2 interval from one expression |
| preallocate a results grid | `matrix(NA, 4, 5)` · `rep.int(0, 98)` | `NA` fill makes an unwritten cell obvious, unlike `0` |
| label a results matrix | `results <- data.frame(M)`; `row.names(results) <- ...`; `names(results) <- ...` | turn a bare matrix into a readable table before reporting |
| plot legend | `legend(x=60, y=0.85, c("A","B"), lty=c(1,1), lwd=c(2.5,2.5), col=c("black","red"))` | `lty`/`lwd`/`col` must be given per series, in the same order as the labels |

*(the four prefixes `d`/`p`/`q`/`r` attach to every distribution suffix; the per-distribution argument names are the trap)*

| Suffix  | Args           | Distribution                                                              |
| :------ | :------------- | :------------------------------------------------------------------------ |
| `norm`  | `mean`, `sd`   | $N(\mu,\sigma^2)$ — pass the **sd**, not $\sigma^2$                       |
| `binom` | `size`, `prob` | $Bin(\theta,n)$ — `size` $=n$                                             |
| `pois`  | `lambda`       | $Pois(\lambda)$ — rescale $\lambda$ to the question's interval first      |
| `unif`  | `min`, `max`   | $U(a,b)$                                                                  |
| `exp`   | `rate`         | exponential                                                               |
| `t`     | `df`           | [[Student-t Distribution\|Student-t]] with $\nu=$ `df` degrees of freedom |


## 🧪 Hypothesis Tests (FIT2086 W5 — details ➔ [[Hypothesis Testing]])
| Task | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| two-sided $p$ from a $z$-score | `2 * pnorm(-abs(z))` | the `-abs()` puts you in the **lower** tail so the doubling is valid |
| one-sided upper $p$ | `1 - pnorm(z)` · `pnorm(z, lower.tail=FALSE)` | **no** `abs()`, **no** factor of $2$ — the sign carries the evidence |
| one-sided lower $p$ | `pnorm(z)` | used directly when $H_A:\mu<\mu_0$ |
| two-sided $p$ from a $t$-score | `2 * pt(-abs(t), df = n - 1)` | `df` $=n-1$; `pt` mirrors `pnorm` ➔ [[Student-t Distribution]] |
| $t$ critical value for bracketing | `qt(1 - 0.05, df = 14)` $\to1.7613$ · `qt(1 - 0.025, df = 14)` $\to2.1448$ | bracket an observed $t$ between two criticals to bound $p$ without a computer |
| one-sample / two-sample $t$-test | `t.test(x, mu = 24.5)` · `t.test(x, y)` | `mu` is the **null value** $\mu_0$, never $\bar y$; no `sigma` argument exists ➔ always a $t$-test ➔ [[Tests for Normal Means (z-test and t-test)]] |
| pick the tail | `t.test(x, mu=120, alternative="less")` · `"greater"` · `"two.sided"` (default) | follows $H_A$; the one-sided $p$ is **exactly half** the two-sided one |
| interval coverage | `t.test(x, conf.level = 0.99)` | wider as `conf.level` $\to1$; with `alternative="less"` the interval becomes an **upper bound** $(-\infty,u)$ |
| Welch vs pooled two-sample | `t.test(x, y, var.equal = FALSE)` *(default)* · `var.equal = TRUE` | **`FALSE` is the default**; pooling when variances differ ($9383$ vs $7002$) *widens* the interval |
| extract from the test object | `rv <- t.test(x, y); rv$p.value` · `rv$conf.int` · `rv$statistic` | R prints `p-value < 2.2e-16` as a floor — pull the number out when the magnitude matters |
| $z$-test by hand (known $\sigma$) | `z <- (mu.hat - mu0)/(sigma/sqrt(n)); 2*pnorm(-abs(z))` | there is **no** `z.test` in base R ➔ [[Hypothesis Testing in R (t.test, binom.test, prop.test)]] |
| exact one-proportion test | `binom.test(x = 37, n = 60, p = 0.5)` | `x` = successes, `n` = trials, `p` = $\theta_0$; **exact**, beats the normal $z$ ($0.0924$ vs $0.0707$) |
| exact two-proportion test | `prop.test(c(mx, my), c(nx, ny))` | pass counts and totals as vectors ➔ [[Tests for Bernoulli Populations]] |
| sensitivity sweep | `for (x in 4:1) print(binom.test(x, 12, 1/2)$p.value)` | $0.388\to0.146\to0.0386\to0.0063$ — answers "how much bias before I suspect?" |

## ✍️ Practice 
> [!QUESTION]- Load `students.csv` (columns Name, Age, Score); report dimensions and structure; mean and sd of Score; the top-3 rows by Score (descending); boxplot Score and extract its outliers; fit Score ~ Age and state the slope.
> > [!SUCCESS]- Reference solution
> > ```r
> > df <- read.csv("students.csv")
> > dim(df); str(df)
> > mean(df$Score); sd(df$Score)
> > head(df[order(df$Score, decreasing=TRUE), ], 3)
> > out <- boxplot(df$Score)$out
> > fit <- lm(Score ~ Age, data=df)
> > fit$coefficients[2]
> > ```
> > - **Key moves:** `order()` wrapped in `df[ , ]`; `$out` for outliers; formula syntax in `lm`.

## ⚠️ Common Mistakes
- 💡 **1-based indexing** ➔ `x[1]` is the first element; muscle-memory from Python costs marks.
- 💡 **Negative index drops** ➔ `x[-1]` = everything EXCEPT first (Python: last element).
- 💡 **`order` returns indices** ➔ sorting is `df[order(df$col), ]` — forgetting the outer `df[ , ]` returns numbers, not rows.
- 💡 **`rbinom(n, size, prob)`: `n` ≠ the binomial's $n$** ➔ `n` is **how many variates to generate**, `size` is the number of trials ➔ `rbinom(10, 5, 0.25)` gives 10 draws from $Bin(5,0.25)$.
- 💡 **`*norm` takes `sd`, `*pois` takes an interval-matched `lambda`** ➔ pass $\sigma$ not $\sigma^2$; rescale $\lambda$ to the question's interval **before** the call.
- 💡 **`step()` is AIC unless told otherwise** ➔ a "BIC model" without `k = log(n)` is an AIC model; compute `n <- nrow(d)` first.
