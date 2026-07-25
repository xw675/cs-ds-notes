---
unit: FIT2099
type: MOC
tags: [2026/S1]
---
# 📘 FIT2099: Object-Oriented Design and Implementation

> [!INFO] Map of Content
> Index for **FIT2099 Object-Oriented Design and Implementation** (Java). Every design note carries a Mermaid `classDiagram`; designs are judged on **Coupling / Cohesion / Extensibility**. Start with [[OOP Building Blocks (Class, Object, Field, Method)]].

## 📊 Assessment Map

- **Assessment:** engine-based Java group project across milestones + individual work.
- **Assessed skills:** design rationale in Coupling/Cohesion/Extensibility terms, UML/Mermaid diagrams, SOLID application, smell → refactor.

## 🧰 Toolkit Cheatsheets
- 📌 [[FIT2099 Unit Cheatsheet]] — principles, smells→refactors, contracts, UML rules
- [[Java Toolkit (Cheatsheet)]] — code a class from a blank editor: class anatomy, modifiers, types/`==`-vs-`equals`, collections, inheritance/polymorphism/interfaces/enums, exceptions/DbC/CQS, DI/defensive copying, Factory Method, and the smell→refactoring quick-map.
- [[UML Toolkit (Cheatsheet)]] — draw from a blank page: class-diagram compartments/visibility/**relationship-arrow legend**/multiplicity/stereotypes, sequence-diagram lifelines/messages/activation/fragments, and the domain/activity/use-case/CRC modelling tools (Mermaid syntax throughout).

## 📅 Knowledge Index

### Week 1 — Java & OO Fundamentals
- [[Java Static Typing]] -> Parent Framework: [[Java Program Structure]]
- [[Java Program Structure]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]
- [[OOP Building Blocks (Class, Object, Field, Method)]] -> Parent Framework: [[Java Program Structure]]
- [[Java Data Types, Casting and References]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]
- [[Java Constructors]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]
- [[Java Control Flow (Conditionals and Loops)]] -> Parent Framework: [[Java Program Structure]]
- [[Java Arrays]] -> Parent Framework: [[Java Program Structure]]
- [[Client-Supplier Relationship (Java)]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]

### Week 2 — Modifiers, UML Relationships, Design Principles & Inheritance
- [[Java Packages and Imports]] -> Parent Framework: [[Java Program Structure]]
- [[Encapsulation and Access Modifiers (Java)]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]
- [[Static and Final (Java)]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]
- [[UML Associations and Dependencies (Java)]] -> Parent Framework: [[Client-Supplier Relationship (Java)]]
- [[Three Core Design Principles (Java)]] -> Parent Framework: [[Client-Supplier Relationship (Java)]]
- [[Inheritance (Java)]] -> Parent Framework: [[OOP Building Blocks (Class, Object, Field, Method)]]

### Week 3 — Collections, Polymorphism & Abstraction
- [[Java Collections (List, Set, Map)]] -> Parent Framework: [[Java Arrays]]
- [[Polymorphism (Java)]] -> Parent Framework: [[Inheritance (Java)]]
- [[Abstract Classes (Java)]] -> Parent Framework: [[Inheritance (Java)]]
- *(deepened this week: [[Static and Final (Java)]] — static↔instance access matrix, why-use/why-carefully; [[Encapsulation and Access Modifiers (Java)]] — encapsulation boundaries & ReD; [[Java Packages and Imports]] — `module-info.java`)*

### Week 4 — Interfaces & Enumerations
- [[Interfaces (Java)]] -> Parent Framework: [[Abstract Classes (Java)]]
- [[Enumerations (Java)]] -> Parent Framework: [[Three Core Design Principles (Java)]]
- *(deepened this week: [[Java Data Types, Casting and References]] — `==` (identity) vs `.equals()` (value) & the String Pool)*

### Week 5 — SOLID Principles
- [[SOLID Principles (Java)]] -> Parent Framework: [[Three Core Design Principles (Java)]]  *(hub: overview table, ReD, LCOM, downcasting/`instanceof`)*
- [[Single Responsibility Principle (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]
- [[Open-Closed Principle (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]
- [[Liskov Substitution Principle (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]
- [[Interface Segregation Principle (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]
- [[Dependency Inversion Principle (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]

### Week 6 — Applying Abstraction: Injection, Copying & Rationale
- [[Dependency Injection (Java)]] -> Parent Framework: [[Dependency Inversion Principle (Java)]]
- [[Defensive Copying (Java)]] -> Parent Framework: [[Encapsulation and Access Modifiers (Java)]]
- [[Design Rationale (FIT2099)]] -> Parent Framework: [[SOLID Principles (Java)]]  *(⭐ Assignment 1 writing artefact)*
- *(deepened this week: [[Dependency Inversion Principle (Java)]] — hinge point + DI link; [[Encapsulation and Access Modifiers (Java)]] — abstraction-layer sizing & connascence)*

### Week 7 — Dynamic Modelling
- [[UML Sequence Diagrams (Java)]] -> Parent Framework: [[UML Associations and Dependencies (Java)]]  *(⭐ Assignment interaction diagrams)*

### Week 8 — Design by Contract, Exceptions & Factory
- [[Design by Contract (Java)]] -> Parent Framework: [[Client-Supplier Relationship (Java)]]
- [[Command-Query Separation (Java)]] -> Parent Framework: [[Design by Contract (Java)]]
- [[Exceptions, Assertions and Validation (Java)]] -> Parent Framework: [[Design by Contract (Java)]]
- [[Factory Method Pattern (Java)]] -> Parent Framework: [[Abstract Classes (Java)]]  *(first GoF pattern)*
- *(deepened this week: [[Liskov Substitution Principle (Java)]] — the DbC subcontracting formulation, weaker-pre/stronger-post)*

### Week 9 — Code & Design Smells + Refactoring
- [[Design Smells (Java)]] -> Parent Framework: [[SOLID Principles (Java)]]  *(smell catalogue + smell→refactoring map)*
- [[Refactoring (Java)]] -> Parent Framework: [[Design Smells (Java)]]

### Week 10 — Refactoring to Address Code Smells
- *(deepened this week: [[Refactoring (Java)]] — the refactor-to-enable-change motivation (Fowler `statement()` scenario) + the identify→fix→apply→test→commit→repeat loop; no new note — Week 10 is a worked deepening of the Week 9 material.)*

### Week 11 — Design in the Lifecycle, Technical Debt & the Design Process
- [[Software Design in the Lifecycle (FIT2099)]] -> Parent Framework: [[FIT2099_MOC]]  *(when/why to design; SDLC + Lean)*
- [[Technical Debt (FIT2099)]] -> Parent Framework: [[Refactoring (Java)]]
- [[Design Process and Techniques (FIT2099)]] -> Parent Framework: [[Software Design in the Lifecycle (FIT2099)]]  *(how to design)*
- [[CRC Cards (FIT2099)]] -> Parent Framework: [[Design Process and Techniques (FIT2099)]]

### 📐 UML Notation References (consolidated)
- [[UML Class Diagrams (Java)]] — the **static** notation legend *(visibility marks, stereotypes, full arrow table + multiplicity — gathers syntax taught piecemeal across W2–4)*
- [[UML Sequence Diagrams (Java)]] — the **dynamic** notation legend (see Week 7).

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = assignment-critical; ⭐ = graded artefact skill)*

- **W1 — Java foundations:** [[Java Static Typing]] → [[Java Program Structure]] → **[[OOP Building Blocks (Class, Object, Field, Method)]]** → [[Java Data Types, Casting and References]] → [[Java Constructors]] → [[Java Control Flow (Conditionals and Loops)]] → [[Java Arrays]] → [[Client-Supplier Relationship (Java)]] → [[Java Packages and Imports]]
- **W2 — encapsulation & first principles:** **[[Encapsulation and Access Modifiers (Java)]]** → [[Static and Final (Java)]] → **[[UML Associations and Dependencies (Java)]]** *(association/dependency/inheritance only)* → [[Three Core Design Principles (Java)]] → [[Inheritance (Java)]]
- **W3 — polymorphism & abstraction:** [[Java Collections (List, Set, Map)]] → **[[Polymorphism (Java)]]** → [[Abstract Classes (Java)]]
- **W4 — capability contracts:** **[[Interfaces (Java)]]** → [[Enumerations (Java)]]
- **W5 — SOLID:** **[[SOLID Principles (Java)]]** *(hub)* → [[Single Responsibility Principle (Java)]] → [[Open-Closed Principle (Java)]] → [[Liskov Substitution Principle (Java)]] → [[Interface Segregation Principle (Java)]] → [[Dependency Inversion Principle (Java)]]
- **W6 — applied abstraction:** [[Dependency Injection (Java)]] → [[Defensive Copying (Java)]] → ⭐ **[[Design Rationale (FIT2099)]]** *(the A1 justification artefact)*
- **W7 — dynamic modelling:** ⭐ **[[UML Sequence Diagrams (Java)]]** *(concrete classes only)*
- **W8 — contracts:** **[[Design by Contract (Java)]]** → [[Command-Query Separation (Java)]] → [[Exceptions, Assertions and Validation (Java)]] → [[Factory Method Pattern (Java)]]
- **W9–10 — smells & refactoring:** **[[Design Smells (Java)]]** *(smell → refactoring map)* → **[[Refactoring (Java)]]** *(behaviour-preserving, two hats)*
- **W11 — design process & meta:** [[Software Design in the Lifecycle (FIT2099)]] → [[Technical Debt (FIT2099)]] → [[Design Process and Techniques (FIT2099)]] → [[CRC Cards (FIT2099)]]

## 🎯 Learning Outcomes

**Unit LOs:** 
1. design with UML (class + interaction diagrams) 
2. judge design quality 
3. implement abstraction/information-hiding/inheritance/polymorphism in Java 
4. refactor + debug 
5. practise with IDEs, UML tools, version control

**Key skills per week:**

- **W1** ➔ 
	- static typing catches errors at compile time 
	- class = blueprint, object = instance 
	- value vs reference semantics 
	- constructors, control flow, arrays 
	- client couples to the interface only *(LO3)*
- **W2** ➔ 
	- private fields + deliberate accessors 
	- static = class-level, final = assign-once (reference ≠ immutable) 
	- draw association vs dependency vs inheritance arrows 
	- DRY / own-your-properties / no magic literals *(LO1–3)*
- **W3** ➔ 
	- program to the collection interface (wrapper types in generics) 
	- runtime type dispatches the override, declared type limits visibility 
	- abstract = never instantiated *(LO3)*
- **W4** ➔ 
	- one `extends`, many `implements` — capability contracts 
	- enums kill magic-number smells with compile-time checks *(LO3)*
- **W5** ➔ 
	- argue every design decision through SRP/OCP/LSP/ISP/DIP 
	- principles are guidelines — over-application is its own smell *(LO1–2)*
- **W6** ➔ 
	- inject collaborators from outside (DI beyond DIP) 
	- defensive-copy mutable state at boundaries 
	- write rationale = WHY + alternative + trade-off, never description *(LO1–3, A1)*
- **W7** ➔ 
	- sequence diagram one narrow scenario, concrete classes only, correct message/activation notation *(LO1, A1)*
- **W8** ➔ 
	- precondition breach = client bug (exception), postcondition = supplier bug (assertion) 
	- commands vs queries 
	- Factory Method returns the parent type *(LO2–3)*
- **W9–10** ➔ 
	- recognise smell families as hints not proofs 
	- type-branching → Replace Conditional with Polymorphism 
	- refactor behaviour-preserving under tests, two hats *(LO4)*
- **W11** ➔ 
	- decide as late as responsibly possible (Lean) 
	- take technical debt deliberately + repay by refactoring to better design 
	- explore with CRC cards, split when the card overflows *(LO1, LO5)*
