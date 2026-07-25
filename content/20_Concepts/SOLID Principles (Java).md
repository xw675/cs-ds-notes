---
unit: FIT2099
domain: B
week: 5
parent: "[[Three Core Design Principles (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [SOLID, SRP, OCP, LSP, ISP, DIP, design principles, ReD, downcasting, instanceof, LCOM]
---
# [[SOLID Principles (Java)]]

**Context:** [[FIT2099_MOC]] · Robert C. Martin's five design **guidelines** (not laws) · the shared rationale vocabulary for the design assignment · all aimed at **Reducing Dependencies (ReD)**

> [!abstract] Quick Revision
> - **🎯 Objective:** judge and justify a design against five principles ➔ low coupling, high cohesion, easy extension.
> - **📦 Core Components:** [[Single Responsibility Principle (Java)|S]] · [[Open-Closed Principle (Java)|O]] · [[Liskov Substitution Principle (Java)|L]] · [[Interface Segregation Principle (Java)|I]] · [[Dependency Inversion Principle (Java)|D]].
> - **⚡ Key Constraint:** SOLID = **guidelines**, not laws — over-applying (too many tiny classes/abstractions) adds complexity; apply where it reduces real dependency pain.

## 📝 The Five Principles
| | Principle | One-line | Smell | Fix |
| :-- | :--- | :--- | :--- | :--- |
| **S** | [[Single Responsibility Principle (Java)\|Single Responsibility]] | one class, one reason to change | God class; unrelated methods | split by reason-to-change |
| **O** | [[Open-Closed Principle (Java)\|Open-Closed]] | open to extend, closed to modify | `instanceof` chain grows per feature | abstract method / polymorphism |
| **L** | [[Liskov Substitution Principle (Java)\|Liskov Substitution]] | a subtype must be usable as its base | override throws / empty / `instanceof` | fix the abstraction (sibling interface) |
| **I** | [[Interface Segregation Principle (Java)\|Interface Segregation]] | no client forced onto unused methods | empty method bodies to satisfy an interface | split into small interfaces |
| **D** | [[Dependency Inversion Principle (Java)\|Dependency Inversion]] | depend on abstractions, not concretes | high-level class references concrete types | inject/hold an interface type |

- **ReD thread** ➔ every principle ultimately **reduces dependencies** so the design tolerates change (coupling/cohesion/extensibility).
- **Chained relationships** ➔ ISP feeds LSP (small interfaces are easier to fully honour) and SRP (small interfaces → focused classes).

## 📐 LCOM — measuring cohesion (SRP)
- **Lack of Cohesion of Methods** ➔ $\text{LCOM} = 1 - \dfrac{\sum_{f \in F} |M_f|}{|M| \times |F|}$ where $M$ = methods, $F$ = instance fields, $M_f$ = methods touching field $f$.
- **Read it** ➔ **LCOM $= 0$** = perfectly cohesive (every method uses every field); **high LCOM** (→ 1) = the class splits into unrelated clusters ➔ SRP candidate.
- **Heuristic** ➔ $\text{LCOM} > 0.8$ with $|F| > 10$ and $|M| > 10$ is a warning sign (but hard to avoid entirely).

## ⚠️ Downcasting & `instanceof` (cross-cutting smell)
- **Upcasting** ➔ subclass → supertype, **implicit & safe** (`Vehicle v = new Sedan();`) — enables [[Polymorphism (Java)|polymorphism]]; good.
- **Downcasting** ➔ supertype → subclass, **explicit & risky** (`((Truck) vehicle).cargo();`) — bypasses compile checks, can throw `ClassCastException`.
- **Why bad (design)** ➔ depends on a lower-level type (breaks abstraction), often signals an **LSP** and **OCP** violation, and grows `if (x instanceof Y)` chains.
- **When tolerable** ➔ occasionally the cleaner-abstraction cost is too high; if you must downcast, guard with `instanceof` first and **justify it in the rationale** (rarely needed in assignments).

## 🧠 Active Recall
> [!FAQ]- Why are SOLID principles called "guidelines, not laws", and what goes wrong if you over-apply them?
> > [!SUCCESS]- Answer
> > - **Short answer:** They are heuristics for reducing dependency, not absolute rules; over-applying (e.g. SRP splitting classes until they're trivially small, or DIP adding an interface for everything) **overcomplicates** the design and adds its own coupling/complexity.
> > - **Why:** **Cost-benefit** ➔ each abstraction has a cost; apply a principle where it removes real change-pain, and stop when the abstraction costs more than the coupling it removes.
