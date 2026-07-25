---
unit: FIT2099
week: 11
parent: "[[Software Design in the Lifecycle (FIT2099)]]"
tags: [SWE/Design, SWE/Process, Monash/CS_DS]
aliases: [design process, brainstorming, model storming, top-down, bottom-up, scenario-based design, use cases, design approaches, creative design]
---
# [[Design Process and Techniques (FIT2099)]]

**Context:** [[FIT2099_MOC]] · *how* to actually do design (the [[Software Design in the Lifecycle (FIT2099)|when/why]] is separate) · a toolkit of approaches, refined by [[CRC Cards (FIT2099)|CRC cards]]

> [!abstract] Quick Revision
> - **🎯 Objective:** treat design as a **creative act with many valid solutions** ➔ start by **understanding the problem domain**, then evolve models toward a design using a fitting approach.
> - **⚡ Key Constraint:** technique **doesn't guarantee** a good design (like art lessons don't guarantee good paintings) — it takes **practice**; and unlike art, design has an **audience of many** (clients/stakeholders), so it must **communicate**, not just satisfy the author.

## 📝 Design as a creative act
- **Art vs design** ➔ an artist has an **audience of one** (works until *they're* satisfied); a designer has an **audience of many** and works until it **communicates to the target**. *"Clients are the difference between design and art."* (Bierut)
- **A good design is measurable** ➔ judged against quality properties (for FIT2099: **coupling / cohesion / extensibility**), not taste.
- **Where to start** ➔ **understand the problem domain first**; draw **conceptual/domain class diagrams** (concepts + relationships) and **activity diagrams** (business processes), then **evolve** them toward a design — understanding the problem often makes the solution obvious.
- **Collaborative** ➔ a **partner or small team** usually beats working alone.

## 🧠 Idea-generation techniques
- **Brainstorming** ➔ group creativity (Osborn): **defer judgment, encourage wild ideas, build on others, stay on topic, one conversation at a time, be visual, go for quantity** — throw out the chaff later.
- **Model storming** ➔ software-specific variant (Ambler): quick sketches of UI/process/domain models; **less withholding of criticism** than pure brainstorming.

## 🔀 Structural approaches
| Approach | Idea | Pros | Cons |
| :--- | :--- | :--- | :--- |
| **Top-down** | start with the **high-level problem**, split into sub-problems (perhaps recursively), design each, combine | starts from **organisation's needs**; gives a **big picture** to client & designer | **time-consuming**; repeated sub-problems can breed **repetition** ⇒ needs refactoring |
| **Bottom-up** | solve a **small problem**, then a few more, assemble upward; useful as **"spikes"** to gain understanding | **quick**; **leverages previous experience** | may **miss organisational requirements**; **high risk of failure** |
- **Not exclusive** ➔ real design switches between them (a few bottom-up spikes, then back to top-down, repeatedly).

## 🎬 Scenario-based design
- **Loop** ➔ take a **scenario** the design must support (storyboard / **use case** / activity diagram / journey map / plain text) → **work through** it, tracing the design as it stands → **modify/rework** the design to support it (keeping quality properties in mind) → **repeat** with more scenarios.
- **Use cases** ➔ structured actor-action / system-response scripts. **Disadvantages:** natural-language text allows **ambiguity**, and reviewing any non-trivial use case can become **tedious**.

## ⚠️ Common Mistakes
- 💡 **Following a technique ≠ good design** ➔ approaches structure the work but guarantee nothing; keep the [[SOLID Principles (Java)|design principles]] in mind and expect to **practise**.
- 💡 **Skipping problem understanding** ➔ jumping to a solution before modelling the domain produces designs that miss the real requirements.
