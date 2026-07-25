---
unit: FIT2099
week: 1
parent: "[[Java Program Structure]]"
tags: [SWE/Java, SWE/OOP, Monash/CS_DS]
aliases: [Static Typing, Compile-Time Type Checking]
---
# [[Java Static Typing]]

**Context:** [[FIT2099_MOC]] · how Java treats variable types · contrasts dynamically-typed Python · the safety net behind [[Java Data Types, Casting and References|typed variables]]

> [!abstract] Quick Revision
> - **🎯 Objective:** give every variable a fixed type at declaration ➔ the compiler checks type compatibility **before** the program runs.
> - **⚡ Key Constraint:** Java catches type errors at **compile time**; Python (dynamically typed) only crashes at **run time** when the bad line executes.

## 📝 Core
- **Statically typed** ➔ a variable is given a **type when declared** and keeps it for its whole lifetime.
- **Compiler checks** ➔ (1) the value is a **compatible type** (int into int, String into String); (2) the object is an instance of a class that implements the method called.
- **Compile-time vs run-time** ➔ Java refuses to build if types clash (`incompatible types: String cannot be converted to int`); Python happily *defines* the bad call and only errors when that line runs.
- **Payoff** ➔ programs are far less likely to ship with type errors, because they never compile in the first place.

## ⚠️ Common Mistakes
- 💡 **"It ran once" ≠ safe (Python)** ➔ a dynamically-typed program can pass some calls and crash on a later one; static typing rejects the whole program up front.
- 💡 **Type is permanent** ➔ you can't later store a `String` in an `int` variable; conversions need explicit [[Java Data Types, Casting and References|casting]].

## 🧠 Active Recall
> [!FAQ]- Why does a type error surface at compile time in Java but only at run time in Python?
> > [!SUCCESS]- Answer
> > - **Short answer:** Java is statically typed — the compiler knows every variable's fixed type and checks compatibility before building, so a `String`-into-`int` mistake fails to compile. Python is dynamically typed, so the interpreter only discovers the mismatch when it executes that line.
> > - **Why:** **Check-before-run** ➔ static typing shifts type errors left to compile time, making shipped programs safer.
