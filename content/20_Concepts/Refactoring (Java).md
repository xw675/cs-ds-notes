---
unit: FIT2099
week: [9, 10]
parent: "[[Design Smells (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [refactoring, two hats, refactor first, when to refactor, meta-technique, Fowler]
---
# [[Refactoring (Java)]]

**Context:** [[FIT2099_MOC]] · the *treatment* for [[Design Smells (Java)|design smells]] · **LO4** (refactor & debug OO implementations) · disciplined, behaviour-preserving cleanup

> [!abstract] Quick Revision
> - **🎯 Objective:** restructure existing code to **improve internal structure without changing external behaviour** ➔ reduce a smell while the program still does exactly the same thing.
> - **⚡ Key Constraint:** the invariant is **behaviour-preserving** — if outputs change, it is *not* refactoring, it's a rewrite. **Automated unit tests** are what make it safe: change → test → repeat.

## 📝 Core
- **Fowler's definition** ➔ "a **disciplined technique** for restructuring an existing body of code, **altering its internal structure without changing its external behavior**."
- **Meta-technique (the loop)** ➔ (1) **identify a code smell**, (2) **identify a refactoring** that fixes it, (3) **apply** it, (4) **test** — if broken, fix; if fine, **commit** — (5) **repeat** until code quality is acceptable. Many tiny safe steps, not one big risky edit.
- **Tests = safety net** ➔ a good automated test suite lets you refactor confidently; without it you can't prove behaviour was preserved. Commit only on green.
- **When to refactor** ➔ opportunistically, driven by a task: **adding a feature**, **fixing a bug**, or during **code review** — not as an open-ended standalone project.
- **Why refactor working code?** ➔ "if it ain't broke" misses the point: the driver is **making future change easier**. Fowler's theatrical-players `statement()` works, but the client now wants **HTML *and* plaintext** output and **many new play types** (history, pastoral, …) — refactor *first* so those changes become easy ([[Design Smells (Java)|smell]]-driven, upholds [[Open-Closed Principle (Java)|OCP]]).

## 🎩 The "Two Hats" rule
- **Two distinct activities** ➔ *adding function* (new capability, tests can go red→green) **vs** *refactoring* (no new function, tests stay green). Wear **one hat at a time**.
- **Refactor first** ➔ when a feature is awkward to add, **put on the refactoring hat first**, reshape the code so the feature fits cleanly, then swap to the feature hat and add it. Never do both in the same edit — you lose the ability to tell a behaviour change from a restructure.

## 🔀 Smell lifecycle
- **Introduced ➔ Detected ➔ act** ➔ once a smell is spotted you choose: **Refactor** (remove it now), **No action** (tolerate it — cost > benefit right now), or **Discard** (the code is going away anyway).
- **"It depends"** ➔ whether to refactor weighs the smell's cost against effort and risk; not every smell must be fixed immediately.

## ⚠️ Common Mistakes
- 💡 **Behaviour must not change** ➔ if a "refactor" alters outputs it is a bug or a redesign — mixing the two hats hides which one broke things.
- 💡 **No tests = no safe refactor** ➔ restructuring without a test suite risks silent behavioural drift; write/enable tests first.
- 💡 **Big-bang refactor** ➔ one huge restructuring edit is hard to verify; prefer the small-change→test→repeat loop so any regression is caught immediately.

## 🧠 Active Recall
> [!FAQ]- Why must you wear only one "hat" at a time when refactoring vs adding a feature?
> > [!SUCCESS]- Answer
> > - **Short answer:** refactoring **preserves behaviour** (tests stay green) while adding a feature **changes behaviour** (tests move red→green); doing both at once makes it impossible to tell whether a failing test is the new feature or a broken restructure.
> > - **Why:** **Behaviour-preserving invariant** ➔ separating the activities keeps the test suite a valid oracle for each change, so regressions are localised.
