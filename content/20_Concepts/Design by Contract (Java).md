---
unit: FIT2099
domain: B
week: 8
parent: "[[Client-Supplier Relationship (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [design by contract, DbC, precondition, postcondition, invariant, subcontracting, fail fast, Bertrand Meyer]
---
# [[Design by Contract (Java)]]

**Context:** [[FIT2099_MOC]] · Bertrand Meyer's approach — [[Client-Supplier Relationship (Java)|client & supplier]] agree **mutual obligations** · the formal basis of [[Liskov Substitution Principle (Java)|LSP]] · a framework for correctness, debugging and QA

> [!abstract] Quick Revision
> - **🎯 Objective:** specify each method as a **contract** — what the client must guarantee (precondition) and what the supplier then guarantees (postcondition) ➔ confidence the code is correct.
> - **📦 Core Components:** **precondition** (client's duty, before) · **postcondition** (supplier's duty, after) · **invariant** (true always, before & after every method).
> - **⚡ Key Constraint:** who's to blame on a breach — a broken **precondition** is the **client's** bug (throw an exception); a broken **postcondition/invariant** (when preconditions held) is the **supplier's** bug (an assertion).

## 📝 How It Works
### 1. The three assertions
- **Precondition** ➔ what the client must ensure is **true before** calling the supplier's method; violated ⇒ the **client has a bug**.
- **Postcondition** ➔ what the supplier **guarantees is true after** the method runs (if the precondition held); violated ⇒ usually the **supplier has a bug** (but not always — transient causes: network outage, server down, disk/memory).
- **Invariant** ➔ a condition the class keeps **true at all times** to stay valid — holds both **before and after** every supplier method.
- **Who writes it** ➔ the **supplier's designer** defines the contract; it's communicated via **Javadoc**, code comments, and **executable statements** (exceptions/assertions).

### 2. Obligations & Benefits (airport metaphor)
| | Obligations | Benefits |
| :--- | :--- | :--- |
| **Client** | ensure **preconditions** (be at MEL 30 min early, allowable luggage, pay) | may enjoy the **postcondition** (reach Sydney) |
| **Supplier** | ensure the **postcondition** (bring client to Sydney) | may **assume** the precondition (no duty to carry a late/unpaid/over-luggage client) |

## ⚙️ Breach Handling & Fail-Fast
> [!code]- Executable specification (Javadoc + code)
> ```java
> /**
>  * Find a value in an array.
>  * @param array array to search — requires that value occurs EXACTLY ONCE (precondition)
>  * @param value value to search for
>  * @return index i such that array[i] == value (postcondition)
>  */
> static int find(int[] array, int value) { /* ... */ }
> ```
> 💡 **Common Mistake:** **precondition broken ⇒ throw an exception** (client's fault — don't rescue them, let it propagate to the caller); **postcondition/invariant broken ⇒ an assertion** (supplier's fault).

- **Fail Fast** ➔ if code detects something wrong, **fail immediately** so the developer sees *where and when*; code that ignores warnings fails later, far from the cause, and is very hard to debug.
- **Cost curve** ➔ the cost of fixing a bug rises **exponentially** the later it's found (requirements → design → test → live) — DbC catches breaches early.
- **Java note** ➔ assertions are **disabled by default** in the JVM (fine — you fix your own bugs before shipping); client-facing failures use **exceptions**.

## ⚖️ Subcontracting = Liskov Substitution
- **Scenario** ➔ Alice (base class + contract) can send **Bob** (subclass) to do the job; the client accepts Bob **iff** he honours Alice's contract.
- **Rule** ➔ a subclass may substitute for its base **if and only if** its **preconditions are the same or weaker** AND its **postconditions are the same or stronger**.
  - Bob **can't** demand a bigger deposit or an earlier start (that would be a **stronger precondition**) — rejected.
  - Bob **can** ask for less upfront / more days (**weaker precondition**) and deliver a stronger, longer-lasting driveway (**stronger postcondition**) — accepted; the client needn't even know Bob exists.
- **This is the [[Liskov Substitution Principle (Java)|LSP]]** ➔ substitutability is exactly "weaker-or-equal preconditions, stronger-or-equal postconditions".

## 🧠 Active Recall
> [!FAQ]- A supplier method's postcondition fails even though the client met every precondition. Whose bug is it, and how should it surface — exception or assertion?
> > [!SUCCESS]- Answer
> > - **Short answer:** it's the **supplier's** bug (the client held up its end), so it should surface as an **assertion** (a broken internal guarantee) — unless a transient external cause (network/disk) is responsible.
> > - **Why:** **Blame follows the contract** ➔ precondition breach = client's exception; postcondition/invariant breach with valid preconditions = supplier's assertion.

> [!FAQ]- Why can a subclass **weaken** a precondition but not **strengthen** it?
> > [!SUCCESS]- Answer
> > - **Short answer:** client code was written against the base's precondition; a subclass that demands **more** would reject inputs the client legitimately sends, breaking substitutability. Demanding **less** never surprises the client.
> > - **Why:** **LSP via DbC** ➔ safe substitution requires preconditions no stronger and postconditions no weaker than the base's.
