---
unit: FIT2099
domain: B
week: 2
parent: "[[Java Program Structure]]"
tags: [SWE/Java, SWE/OOP]
aliases: [package, import, wildcard import, Java modules, project organization]
---
# [[Java Packages and Imports]]

**Context:** [[FIT2099_MOC]] · organise many [[OOP Building Blocks (Class, Object, Field, Method)|classes]] into named folders · the namespace layer above a single [[Java Program Structure|Java file]]

> [!abstract] Quick Revision
> - **🎯 Objective:** group related classes into a **package** (a namespace = a folder) ➔ avoid name clashes and structure a project.
> - **⚡ Key Constraint:** the `package` declaration must be the **very first statement** in the file (before any `import`); the folder path on disk must **match** the dotted package name.

## 📝 Core
- **Package** ➔ a namespace grouping related classes; declared `package com.smarthome;` as the **first line**.
- **Folder = package** ➔ `com.smarthome` ➔ the file lives in `com/smarthome/`; mismatch = won't compile.
- **Import** ➔ pull a class from another package into scope: `import java.util.ArrayList;` — then use `ArrayList` unqualified.
- **Order** ➔ `package` line → `import` lines → class declaration; imports sit **between** the two.
- **Fully-qualified name** ➔ without an import, refer to a class by its full path: `java.util.ArrayList list = ...`.
- **Module** ➔ (Java 9+) a collection of packages, one level above packages, described by a `module-info.java` **module descriptor**.

## 🧩 Modules (Java 9+)
- **`module-info.java`** ➔ declares the module's name plus its boundary:
```java
module my-module {
    requires javafx.controls;              // depend on (read) another module
    exports my.program.package;            // make this package visible to all
    exports my.program.package to other-module;   // ...or visible to ONE module
    provides someInterface with my.program.Implementation;  // offer a service
}
```
- **`requires`** ➔ a **dependency** — my-module *reads* the required module.
- **`exports`** ➔ makes a specific package **visible** (optionally only `to` a named module); unexported packages stay module-private even if `public`.
- **`provides … with …`** ➔ registers a concrete implementation of a service interface.

## ⚠️ Common Mistakes
- 💡 **Wildcard import `*`** ➔ `import java.util.*;` pulls the **whole** package — discouraged: hurts readability and risks ambiguous names; import the specific class.
- 💡 **`package` not first** ➔ any code (even an `import`) before the `package` line is a compile error.
- 💡 **Path ≠ name** ➔ the on-disk directory structure must mirror the dotted package name exactly.

## 🧠 Active Recall
> [!FAQ]- Why is a wildcard import (`import pkg.*;`) generally discouraged over naming the class?
> > [!SUCCESS]- Answer
> > - **Short answer:** it drags every class in the package into scope, hiding exactly what the file depends on and risking **name clashes** between two packages that both define a `Date` (or similar).
> > - **Why:** **Explicit dependencies** ➔ a specific import documents the real coupling and lets the compiler resolve names unambiguously.
