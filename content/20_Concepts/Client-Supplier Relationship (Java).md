---
unit: FIT2099
week: 1
parent: "[[OOP Building Blocks (Class, Object, Field, Method)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
aliases: [Client-Supplier, Composition, has-a, Coupling]
---
# [[Client-Supplier Relationship (Java)]]

**Context:** [[FIT2099_MOC]] · one way to *use* a [[OOP Building Blocks (Class, Object, Field, Method)|class]] — become its **client** · a class holding other objects as fields · the first taste of **coupling**
**Parent Framework:** [[OOP Building Blocks (Class, Object, Field, Method)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build a class from other classes ➔ hold them as fields (has-a) and call their methods.
> - **📦 Core Components:** **client** (uses) ↔ **supplier** (provides) | composition (`this.x = new X()`) | calling public methods.
> - **⚡ Key Constraint:** the client needs to know **only how to call** a supplier's method — **not how it's implemented** (information hiding); it is coupled to the *interface*, not the internals.

## 📝 How It Works
### 1. Client and Supplier
- **Client** ➔ a class that **uses** another; it holds the supplier as an attribute and calls its methods.
- **Supplier** ➔ the class being used; it **provides** the behaviour.
- **Composition** ➔ the client typically creates its suppliers in its constructor (`this.coffee = new Coffee();`).

### 2. Why It Matters
- **Information hiding** ➔ `MealMachine` calls `coffee.serve()` without knowing *how* `serve()` works — only its signature.
- **Coupling** ➔ the client depends on the supplier's **public interface**; keep that interface small/stable to keep coupling **loose**.

## ⚙️ Core Implementation
### 🔹 MealMachine (client of Coffee & Bread)
> [!code]- classDiagram + Java
> ```mermaid
> classDiagram
>   class MealMachine {
>     -Coffee coffee
>     -Bread bread
>     +serveBreakfast() String
>   }
>   class Coffee { +serve() String }
>   class Bread { +toast() String }
>   MealMachine *-- Coffee : has-a
>   MealMachine *-- Bread : has-a
> ```
> ```java
> class MealMachine {
>     Coffee coffee;   // client of Coffee
>     Bread bread;     // client of Bread
>     MealMachine() {
>         this.coffee = new Coffee();
>         this.bread = new Bread();
>     }
>     String serveBreakfast() {
>         return coffee.serve() + " and " + bread.toast();  // call suppliers' methods
>     }
> }
> ```
> 💡 **Common Mistake:** **`*--` = composition (has-a) in a classDiagram** ➔ `MealMachine` owns a `Coffee` and a `Bread`; it depends only on their **public** methods, not their private fields.

> [!NOTE] **When It Flips:** measure this design on coupling (how many suppliers, how much of each interface it uses), **cohesion** (does `MealMachine` do one job?), **extensibility** (could a new meal item slot in without editing `MealMachine` much?). Loose coupling to small interfaces is the goal.

## 🧠 Active Recall
> [!FAQ]- What must a client know about its supplier, and what must it *not* need to know?
> > [!SUCCESS]- Answer
> > - **Short answer:** The client must know **how to call** the supplier's public methods (their signatures); it must **not** need to know how those methods are implemented internally.
> > - **Why:** **Information hiding + coupling** ➔ depending only on the interface keeps coupling loose, so a supplier's internals can change without breaking the client.

> [!FAQ]- How does the client–supplier relationship show up in a class diagram and in code?
> > [!SUCCESS]- Answer
> > - **Short answer:** In the diagram, a `*--` (composition/has-a) arrow from client to supplier; in code, the supplier is a **field** the client creates and whose methods it calls.
> > - **Why:** **Has-a** ➔ `MealMachine` holds `Coffee`/`Bread` fields and calls `serve()`/`toast()`.
