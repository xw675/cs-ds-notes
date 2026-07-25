---
unit: [FIT1043, FIT2086]
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
| peek | `head(df, 6)` · `tail(df)` | never print a big df |

## 📂 Files, Libraries, Environment
- **Working dir** ➔ `getwd()` / `setwd("D:/Folder")` — set BEFORE read/write.
- **CSV / tables** ➔ `read.csv("file.csv")` · `write.csv(df, "file.csv")` · `read.table("out.txt", header=TRUE)` (the shell→R handoff after `awk … > out.txt`, see [[Unix Shell (Bash)]]).
- **Packages** ➔ once: `install.packages("moments")`; per session: `library(moments)`; built-ins: `data()` then `data(mtcars)`.

## 📊 Plots (details ➔ [[R Visualisation (base graphics)]])
| Chart | Call | Signature extras |
| :-- | :-- | :-- |
| bar | `barplot(H, names.arg=M, xlab, ylab, main, col)` | stacked: feed `table(vs, gear)`; grouped: `beside=TRUE` |
| histogram | `hist(mtcars$hp, xlim=c(0,400), …)` | distribution of ONE numeric |
| boxplot | `boxplot(mpg ~ cyl, data=mtcars)` | formula = value ~ group; **outliers: `boxplot(x)$out`** |
| scatter | `plot(x=df$wt, y=df$mpg, xlim=, ylim=)` | two numerics |

## 📈 Linear Regression
- **Fit** ➔ `fit <- lm(height ~ weight)` — formula reads "height explained by weight".
- **Read** ➔ `fit$coefficients[1]` intercept · `[2]` slope · `summary(fit)` full report (residuals, $R^2$).
- **Meaning** ➔ $\hat{h} = 61.38 + 1.415\,w$ from the lecture data; same model family as [[Linear and Polynomial Regression]].

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
| random draws | `rnorm(n, mean, sd)` · `runif(n)` · `rbinom(n,size,prob)` | `r` = simulate `n` values |
| Monte Carlo prob | `mean(rnorm(1e6) > 1.5)` | proportion of draws = estimated probability |

*(the four prefixes `d`/`p`/`q`/`r` attach to every distribution suffix: `norm`, `binom`, `pois`, `unif`, `exp`, …)*

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
