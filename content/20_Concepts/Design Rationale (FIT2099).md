---
unit: FIT2099
week: 6
parent: "[[SOLID Principles (Java)]]"
tags: [SWE/Design, SWE/OOP]
aliases: [design rationale, design goals, assignment rationale, YAGNI]
---
# [[Design Rationale (FIT2099)]]

**Context:** [[FIT2099_MOC]] · the written justification accompanying the UML for Assignment 1 · explains **why** a design meets its goals, not what it does · the marked communication artefact

> [!abstract] Quick Revision
> - **🎯 Objective:** explicitly document the **reasons** behind each design decision ➔ show the working, sell the design, earn the mark.
> - **⚡ Key Constraint:** rationale = **WHY**, not WHAT — describing the diagram or the algorithm (the HOW) belongs in Javadoc / sequence diagrams, and wastes rationale marks.

## 📝 Core
- **Definition** ➔ "explicit documentation of the reasons behind decisions made when designing a system", paired with the UML class + sequence diagrams (which are **visual aids**, not the whole system).
- **Design goals** ➔ abstract quality targets set **before coding** (extensibility, maintainability, readability, low coupling); the rationale assesses the design **against these goals**.
- **Each decision should give** ➔ the reason/justification · the **alternatives considered** · the compromises/trade-offs · the thought process that led to the choice.
- **Structure** ➔ intro (summary + goals + audience) → per-feature/per-requirement decisions with pros-cons.

## ⚠️ Common Mistakes (the marked don'ts)
- 💡 **Restating principle definitions** ➔ don't list SOLID as subheadings and force features under each (the classic LLM pattern) — instead say **why this feature needs this principle / what design smell it fixes**.
- 💡 **Describing, not justifying** ➔ "we made an abstract `Character` with 5 subclasses" repeats the diagram; add the *reason* (e.g. shared attributes ➔ DRY) and an **alternative** (interface) with its trade-off.
- 💡 **Vague / subjective words** ➔ "beautiful", "great way", "easily", "because it works" carry no argument — be sharp and objective; abbreviate principles (SRP, OCP…).
- 💡 **Personal preference** ➔ "I made this interface because I think it suits" is not a rationale; argue from goals + principles + smells.
- 💡 **Over-future-proofing (YAGNI)** ➔ designing abstract methods for unimplemented features adds needless rigidity; justify against **current** features and only **clearly known** next-iteration ones.

## 🧠 Active Recall
> [!FAQ]- Why is "an abstract `Character` class is better than a `Character` interface here" a *good* rationale sentence, while "we used an abstract class because it follows DRY" is weak?
> > [!SUCCESS]- Answer
> > - **Short answer:** the strong version names the **alternative** (interface) and the concrete trade-off — in Java an interface's attributes are `public static final`, which would break encapsulation and risk unintended mutability, so a `private`-field abstract class is chosen. The weak version just asserts a principle without saying what problem it solves.
> > - **Why:** **Reason + alternative + trade-off** ➔ good rationale compares decisions against design goals (encapsulation, coupling), not against a principle's definition.

> [!FAQ]- Where should the step-by-step algorithm of a feature go, if not in the rationale?
> > [!SUCCESS]- Answer
> > - **Short answer:** in **Javadoc** comments or a **UML sequence diagram** — the rationale states *why* the design is shaped that way, not *how* the feature executes.
> > - **Why:** **Rationale = reasons** ➔ mechanism/description is the specs' or code-docs' job; mixing it in convolutes the justification.
