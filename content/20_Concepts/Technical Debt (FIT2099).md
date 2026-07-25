---
unit: FIT2099
domain: B
week: 11
parent: "[[Refactoring (Java)]]"
tags: [SWE/Design, SWE/Process]
aliases: [technical debt, tech debt, debt quadrant, reckless, prudent, deliberate, inadvertent, refactoring debt]
---
# [[Technical Debt (FIT2099)]]

**Context:** [[FIT2099_MOC]] · the cost of choosing a **quick-but-messy** solution over a **clean** one · accrues "interest", **repaid** by [[Refactoring (Java)|refactoring]]

> [!abstract] Quick Revision
> - **🎯 Objective:** name the trade-off — a fast messy implementation now **borrows against** future changeability ➔ later changes cost more ("interest") until you refactor.
> - **⚡ Key Constraint:** debt is **inevitable and not inherently bad** (like borrowing to grow a business) — what matters is whether it was taken **prudently and deliberately**, and whether you **refactor to a *better* design** to repay it.

## 📝 Core
- **Fowler's framing** ➔ two ways to add functionality: **one quick but messy** (you *know* it makes future change harder) vs **one cleaner but slower**. Choosing quick-and-messy = taking on debt.
- **Burn-down picture** ➔ managerial pressure to hit a **deadline** makes you ship below the "ideal quality" line; the gap between that rushed launch and the **optimal** one **is** the technical debt.
- **Inevitable** ➔ real systems always carry some; sometimes you *must* get features out the door.
- **Repayment = refactoring** ➔ debt is "repaid" by refactoring — **but you must refactor to a genuinely better design**, else you've paid nothing.

## 🧭 The Technical-Debt Quadrant (Fowler)
| | **Reckless** | **Prudent** |
| :--- | :--- | :--- |
| **Deliberate** | ❌ *"We don't have time for design"* | ✅ *"We must ship now and deal with the consequences"* |
| **Inadvertent** | ❌ *"What's layering?"* (ignorance) | ✅ *"Now we know how we should have done it"* (learning) |

- **Prudent = "good" debt** ➔ a conscious, informed trade-off (deliberate) or a lesson learned in hindsight (inadvertent).
- **Reckless = "bad" debt** ➔ skipping design to save time, or incurring debt through **not knowing** basic design.

## ⚠️ Common Mistakes
- 💡 **Debt ≠ refactoring** ➔ debt is the *state* (messy design owed); refactoring is the *repayment action*. Refactoring that doesn't reach a better design leaves the debt outstanding.
- 💡 **Reckless-inadvertent is the trap** ➔ debt taken through ignorance ("what's layering?") is the worst quadrant — you didn't even choose it. Knowing the design principles is the defence.
- 💡 **Unpaid interest compounds** ➔ deferring repayment indefinitely makes every future change slower; schedule refactoring, ideally with tests as the safety net.

## 🧠 Active Recall
> [!FAQ]- Is taking on technical debt always a bad decision?
> > [!SUCCESS]- Answer
> > - **Short answer:** no — like borrowing money to grow a business, **prudent, deliberate** debt ("we must ship now and deal with the consequences") is a legitimate, informed trade-off; it becomes bad only when **reckless** or **inadvertent** (ignorance of design).
> > - **Why:** **Deliberate × Prudent quadrant** ➔ debt is acceptable when the team *knows* the cost and plans to repay it by refactoring to a better design; it's harmful when incurred without awareness or without a repayment plan.
