---
unit: FIT2099
week: 8
parent: "[[Design by Contract (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP, Monash/CS_DS]
aliases: [command-query separation, CQS, command, query, mutator, accessor, side effect]
---
# [[Command-Query Separation (Java)]]

**Context:** [[FIT2099_MOC]] · every method is **either** a command **or** a query, never both · makes [[Design by Contract (Java)|contract]] checks safe (queries have no side effects)

> [!abstract] Quick Revision
> - **🎯 Objective:** split methods into **commands** (do something, may change state) and **queries** (return a value, change nothing) ➔ predictable, side-effect-free reads.
> - **⚡ Key Constraint:** a method that **both** returns a value **and** mutates state (the "are you awake?" that also wakes you) violates CQS — you can't safely call it inside a precondition/postcondition check.

## 📝 Core
- **Command (mutator)** ➔ performs an action, **may change** the state of one or more objects; typically returns `void` (e.g. `insert(x)`, `setBalance(n)`).
- **Query (accessor)** ➔ **returns a value** and has **no side effects**; calling it twice gives the same answer and leaves the world unchanged (e.g. `find(x)`, `getBalance()`).
- **The rule** ➔ a method should do **one** of these, **not both**.
- **Why it pairs with DbC** ➔ you can use any **query** inside a precondition or postcondition check with confidence that you **won't change** the object you're checking.

## ⚠️ Common Mistakes
- 💡 **"Are you awake?" smell** ➔ a query that also mutates (returns a status *and* changes it) is the classic violation — the caller can't tell a read from a write.
- 💡 **Hidden side effects in getters** ➔ a `getX()` that lazily mutates internal state breaks CQS and makes contract checks unsafe.

## 🧠 Active Recall
> [!FAQ]- Why does Command-Query Separation make Design by Contract safer?
> > [!SUCCESS]- Answer
> > - **Short answer:** contract checks (pre/postconditions) call **queries** to test the object's state; if queries are guaranteed side-effect-free, evaluating the check **cannot alter** the state being verified.
> > - **Why:** **Pure reads** ➔ separating mutators (commands) from accessors (queries) means a check never changes what it measures.
