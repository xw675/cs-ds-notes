---
unit: [FIT1043, FIT2086]
week: 8
parent: "[[R for Data Science]]"
tags: [DataScience/Tools, DataScience/Visualisation, Tool/R]
type: pattern
aliases: [R plotting, barplot, hist, boxplot, R scatter plot]
---
# [[R Visualisation (base graphics)]]

**Context:** [[FIT1043_MOC]] · base-R plotting · same [[Data Visualisation (Chart Types)|chart-per-type]] logic as [[Plotting with Matplotlib (Pandas)|matplotlib]] · on [[R Data Frames and IO|data frames]] · lab: `30_Projects/FIT1043_Labs/Week8-R-Solution.pdf`
**Problem it solves:** draw the chart matching a variable's type, and read outliers off a boxplot.

> [!abstract] Quick Revision
> - **🎯 Trigger:** visualise an R column ➔ barplot / hist / boxplot / plot chosen by data type.
> - **⚡ Key Constraint:** categorical → `barplot` (often via `table()`), continuous → `hist`/`boxplot`; two continuous → `plot` (scatter).

## 🔧 Minimal Working Example
```r
H <- c(25,12,43,7,51); M <- c("Delhi","Beijing","Washington","Tokyo","Moscow")
barplot(H, names.arg=M, xlab="City", ylab="Happiness", col="blue", main="Happiness Index")
```
**Expected output:** a labelled bar chart, one bar per city.

- **Bar (categorical)** ➔ `barplot(H, names.arg=, xlab=, ylab=, main=, col=)`.
- **Stacked / grouped** ➔ `counts <- table(mtcars$vs, mtcars$gear); barplot(counts, ...)`; add `beside=TRUE` for grouped (else stacked). `table()` makes a frequency cross-tab.
- **Histogram (continuous)** ➔ `hist(mtcars$hp, xlim=c(0,400), col="blue")`.
- **Boxplot (continuous, by group)** ➔ `boxplot(mpg ~ cyl, data=mtcars)` — formula `y ~ group`.
- **Scatter (two continuous)** ➔ `plot(x=input$wt, y=input$mpg, xlab=, ylab=)`.

## 🔀 Variations
- **Outliers from a boxplot** ➔ `outliers <- boxplot(mydata)$out` returns the flagged points (IQR rule; see [[Measures of Spread and Boxplots]]).
- **Plot to a file** ➔ `png("chart.png")` → draw → `dev.off()` to close the device (repeat `dev.off()` until "null device").

## ✍️ Practice 
> [!QUESTION]- Practice 1: From `mydata <- c(1,5,6,6,6,6,7,10)`, extract the outlier values using a boxplot.
> > [!SUCCESS]- Reference solution
> > ```r
> > mydata <- c(1,5,6,6,6,6,7,10)
> > outliers <- boxplot(mydata)$out
> > outliers   # the value(s) beyond 1.5*IQR
> > ```
> > - **Key move:** `boxplot(...)$out` pulls the outliers the IQR rule flagged.

## ⚠️ Common Mistakes
- 💡 **Match the chart to the type** ➔ `barplot` is for categorical counts; use `hist` for a continuous distribution.
- 💡 **`png()` needs `dev.off()`** ➔ after plotting to a file the output is redirected; call `dev.off()` to finish the file and restore on-screen plotting.
