---
unit: FIT2099
week: 1
parent: "[[OOP Building Blocks (Class, Object, Field, Method)]]"
tags: [SWE/Java, SWE/OOP, Monash/CS_DS]
aliases: [Java Program Structure, main method, HelloWorld]
---
# [[Java Program Structure]]

**Context:** [[FIT2099_MOC]] · the skeleton every Java program shares · the entry point that runs a [[OOP Building Blocks (Class, Object, Field, Method)|class]] · [[Java Static Typing|statically typed]]

> [!abstract] Quick Revision
> - **🎯 Objective:** recognise the mandatory anatomy of a Java program ➔ a public class (named like its file) with a main entry point.
> - **⚡ Key Constraint:** `main` must be `public static void main(String[] args)` — `static` lets the JVM call it **without creating an object first**; every statement ends in `;`.

## 📝 Core
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```
- **`public`** ➔ visibility — this member is callable from outside the class (see [[Client-Supplier Relationship (Java)|clients]]).
- **`HelloWorld`** ➔ the class name **must match the file name** (`HelloWorld.java`).
- **`main(...)`** ➔ the program's **entry point**; `String[] args` are command-line arguments (`java HelloWorld arg1 arg2`).
- **`static`** ➔ the JVM calls `main` **without an object** (before any instance exists).
- **`void`** ➔ the return type "nothing"; **`System.out.println`** prints to the console.
- **`;`** ➔ Java is strict — every statement ends with a semicolon.

## ⚠️ Common Mistakes
- 💡 **File name ≠ class name = won't compile** ➔ a `public` class must live in a file of the same name.
- 💡 **Non-static `main` = JVM can't start it** ➔ `main` must be `static` so it runs before any object is created.

## 🧠 Active Recall
> [!FAQ]- Why must `main` be declared `static`, and what does `String[] args` hold?
> > [!SUCCESS]- Answer
> > - **Short answer:** `static` lets the JVM invoke `main` without first constructing an object of the class (there is none yet at start-up); `args` holds the command-line arguments passed after the class name.
> > - **Why:** **Entry before instances** ➔ a class-level (static) method belongs to the class, so it's callable without `new`.
