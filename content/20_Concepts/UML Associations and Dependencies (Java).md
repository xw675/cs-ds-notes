---
unit: FIT2099
domain: B
week: 2
parent: "[[Client-Supplier Relationship (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [association, dependency, multiplicity, aggregation, composition, has-a, uses-a, UML relationships]
---
# [[UML Associations and Dependencies (Java)]]

**Context:** [[FIT2099_MOC]] · name the arrows between classes in a UML `classDiagram` · which [[Client-Supplier Relationship (Java)|client–supplier]] link is which · full notation legend in [[UML Class Diagrams (Java)]]
**Parent Framework:** [[Client-Supplier Relationship (Java)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** distinguish **association** (has-a, a stored field) from **dependency** (uses-a, a transient method parameter/return) ➔ draw the right arrow.
> - **📦 Core Components:** association (solid `-->`, an attribute) | dependency (dashed `..>` «use», a parameter) | multiplicity (1, `*`, ranges).
> - **⚡ Key Constraint:** **FIT2099 will NOT ask you to *use* Aggregation or Composition** — focus your modelling on **Association, Dependency, and [[Inheritance (Java)|Inheritance]]**. Know aggregation/composition only to *read* diagrams.

## 📝 How It Works
### 1. Association — "has-a" (persistent)
- **Definition** ➔ one class **holds another as a field** and uses it over its lifetime.
- **UML** ➔ solid line / arrow `A --> B`; label with a role and **multiplicity**.
- **Code smell for it** ➔ the other class appears as an **attribute** in the class body.

### 2. Dependency — "uses-a" (transient)
- **Definition** ➔ one class uses another **only briefly** — as a method **parameter**, **return type**, or local variable — not stored.
- **UML** ➔ dashed arrow `A ..> B` stereotyped `«use»`.
- **Rule of thumb** ➔ if it's a stored field ➔ association; if it just passes through a method ➔ dependency.

### 3. Multiplicity
- **`1`** ➔ exactly one · **`0..1`** ➔ optional · **`*` / `0..*`** ➔ many (often an array/`ArrayList`) · **`1..*`** ➔ one or more · **`2`** ➔ exactly two.

### 4. Aggregation vs Composition *(read-only for FIT2099)*
- **Aggregation** ➔ hollow diamond ◇ — a "whole-part" where the part can outlive the whole; often a modelling **placebo** (adds little over plain association).
- **Composition** ➔ filled diamond ◆ — the whole is **responsible for creating** the part and controls its **lifetime** (part dies with the whole).

## ⚙️ Core Implementation
### 🔹 SmartHomeDriver — association + dependency
> [!code]- classDiagram
> ```mermaid
> classDiagram
>   class SmartHomeDriver {
>     -SmartSwitch theSwitch
>     +run(SmartBulb bulb) void
>   }
>   class SmartSwitch {
>     +toggle() void
>   }
>   class SmartBulb {
>     +setBrightness(int level) void
>   }
>   SmartHomeDriver --> "1" SmartSwitch : has-a (association)
>   SmartHomeDriver ..> SmartBulb : «use» (dependency)
> ```
> 💡 **Common Mistake:** **stored field `-SmartSwitch theSwitch` = association (`-->`)**, but `SmartBulb` only appears as a **method parameter** of `run(...)` ➔ dependency (`..>`), never an attribute.

> [!NOTE] **When It Flips:** more associations and dependencies = more **coupling**. Judge a design on Domain-B metrics — prefer fewer, thinner links to small public interfaces; a dependency (transient) is looser coupling than an association (stored) for the same collaboration.

## 🧠 Active Recall
> [!FAQ]- A `Printer` receives a `Document` as a method parameter and prints it, but never stores it. Association or dependency? Draw the arrow.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Dependency** — `Printer ..> Document` (dashed, «use»). Because the `Document` is only used transiently inside a method and is **not held as a field**.
> > - **Why:** **Field vs parameter** ➔ stored attribute ⇒ association (`-->`); passing-through method argument/return ⇒ dependency (`..>`).

> [!FAQ]- Why does FIT2099 tell you to model with association/dependency rather than composition/aggregation?
> > [!SUCCESS]- Answer
> > - **Short answer:** Aggregation especially is often a **semantic placebo** — it rarely changes the code and invites unproductive debate; the assessable, code-visible distinction is has-a-field (association) vs uses-in-a-method (dependency).
> > - **Why:** **Design clarity** ➔ the unit judges Coupling/Cohesion/Extensibility, which the association/dependency split expresses cleanly.
