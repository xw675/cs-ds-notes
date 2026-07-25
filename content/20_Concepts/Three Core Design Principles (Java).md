---
unit: FIT2099
week: 2
parent: "[[Client-Supplier Relationship (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [DRY, SRP, single responsibility, feature envy, avoid literals, magic numbers, design principles, design smell]
---
# [[Three Core Design Principles (Java)]]

**Context:** [[FIT2099_MOC]] · early heuristics for judging a design on **Coupling / Cohesion / Extensibility** · the "smell → fix" lens · precursor to the full [[SOLID Principles (Java)|SOLID]] set (class-responsibility ➔ [[Single Responsibility Principle (Java)|SRP]])

> [!abstract] Quick Revision
> - **🎯 Objective:** apply three rules — **DRY**, **classes own their properties**, **avoid excessive literals** — to spot design smells and refactor.
> - **⚡ Key Constraint:** each principle is really about **where change lands** — duplication, misplaced responsibility, and buried literals all mean one change forces edits in many places.

## 📝 Core
### A. DRY — Don't Repeat Yourself
- **Rule** ➔ replace repeated code with a **single abstraction** (a method, constant, or class).
- **Smell** ➔ the same block copy-pasted (e.g. `System.out.println("IIT - Madras")` in three methods) — fix the string/logic once, reuse it.
- **Payoff** ➔ one change point ➔ fewer bugs, easier maintenance.

### B. Classes Are Responsible for Their Own Properties (SRP-seed)
- **Rule** ➔ if some data and the logic over it **change together, keep them together** in one class.
- **Smell — feature envy** ➔ a method that reaches into **another** class's fields to do its work belongs on **that** class instead.
- **Link** ➔ this is the seed of the **Single Responsibility Principle (SRP)** — each class has one reason to change ➔ high **cohesion**.

### C. Avoid Excessive Use of Literals
- **Literal** ➔ a fixed value written directly in source (`3.14`, `"IIT - Madras"`, `'a'`, `true`).
- **Rule** ➔ name recurring/meaningful literals as [[Static and Final (Java)|`static final` constants]] instead of scattering "magic numbers/strings".
- **Payoff** ➔ a named constant documents intent and gives **one** place to change the value.

## ⚠️ Common Mistakes
- 💡 **DRY over-applied** ➔ merging code that is *coincidentally* identical (not conceptually the same) creates false coupling — abstract only genuine duplication.
- 💡 **Feature envy misread** ➔ a getter call isn't automatically envy; the smell is **logic** that overwhelmingly uses another class's data.
- 💡 **Every literal ≠ constant** ➔ don't name-constant a one-off `0` or `1`; reserve it for meaningful/repeated values.

## 🧠 Active Recall
> [!FAQ]- A method in `ReportPrinter` reads and formats several fields of a `SmartBulb` to build its label. Which principle is violated and what's the fix?
> > [!SUCCESS]- Answer
> > - **Short answer:** "Classes responsible for their own properties" — the smell is **feature envy**. Fix: move the label-building method **onto `SmartBulb`** (e.g. a `describe()` method), so the data and its logic live together.
> > - **Why:** **Cohesion ↑, coupling ↓** ➔ `ReportPrinter` stops depending on `SmartBulb`'s internal fields and calls one public method; `SmartBulb` now has a single, clear responsibility over its own state.
