---
unit: FIT2099
week: 11
parent: "[[FIT2099_MOC]]"
tags: [SWE/Design, SWE/Process, Monash/CS_DS]
aliases: [SDLC, software development lifecycle, waterfall, analysis vs design, just enough design, just in time design, lean, decide as late as possible, conscious design, when to design]
---
# [[Software Design in the Lifecycle (FIT2099)]]

**Context:** [[FIT2099_MOC]] · where **design** sits in the broader development process · answers *when* and *why* to design (the [[Design Process and Techniques (FIT2099)|how]] is separate)

> [!abstract] Quick Revision
> - **🎯 Objective:** locate design between **requirements** (what to build) and **implementation** (the build) ➔ design answers **"how should we build it?"**
> - **⚡ Key Constraint:** the neat phase boxes are **misleading** — requirements/analysis/design **overlap** heavily in practice; and per **Lean** you should **decide as late as responsibly possible** so choices rest on **fact, not speculation**.

## 📝 The lifecycle (Waterfall recap)
- **Five phases** ➔ **Requirements** ("what should we build?", → requirements doc) ➔ **Design** ("how should we build it?", → architecture) ➔ **Implementation** (→ software) ➔ **Verification** ➔ **Maintenance**.
- **Analysis between** ➔ a realistic refinement inserts **Analysis** ("what do the requirements *mean*?") between Requirements and Design.
- **Overlap is real** ➔ hard to separate requirement **elicitation** from **analysis**, or **understanding** the domain from **modelling** it; the boxes are a simplification.

## ⏱️ Just-in-time, just-enough design (Lean)
- **Origin** ➔ Toyota's 1970s just-in-time manufacturing; absorbed into **Lean/Agile**.
- **7 Lean principles** ➔ eliminate waste · amplify learning · **decide as late as possible** · deliver as fast as possible · empower the team · build integrity in · optimise the whole.
- **Decide as late as possible (#3)** ➔ **the longer you wait to commit, the more information you have**; the **earlier** you commit, the **less flexible** you are. Best decisions rest on fact, not speculation.

## 🎯 When to do conscious (deliberate) design
- **Project inception** ➔ **architectural** big decisions — **hard/expensive to change**, so get them right early (e.g. a VR system's client/server/view layering).
- **Before something complex or risky** ➔ design ahead of a tricky implementation.
- **When refactoring** ➔ the design may have been bad from the start, or was good and **decayed** — see [[Refactoring (Java)]].
- **Unconscious design** ➔ the opposite: code shaped by unexamined earlier commitments (e.g. treating a `Dictionary` as a list with index loops) — needlessly complex.

## ⚠️ Common Mistakes
- 💡 **Diagrams are a means, not the end** ➔ the goal is a **good design** *and* a shared **understanding in the heads of stakeholders** (designers, implementers, maintainers, reviewers, client-code users). Documents/diagrams only **serve** that — they are not objectives in themselves.
- 💡 **Deciding too early** ➔ premature commitment locks in choices before the facts are in (violates Lean #3) and breeds rework.

## 🧠 Active Recall
> [!FAQ]- Why does Lean say "decide as late as possible" — isn't deciding early more organised?
> > [!SUCCESS]- Answer
> > - **Short answer:** information **accumulates** over a project; deferring a commitment until the last responsible moment means the decision is made on **fact rather than speculation**, and keeps options open.
> > - **Why:** **Flexibility cost** ➔ early commitment reduces flexibility and raises the chance of costly reversal; late (but not *too* late) commitment optimises the information-vs-flexibility trade-off.
