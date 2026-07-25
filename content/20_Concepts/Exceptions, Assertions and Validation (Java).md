---
unit: FIT2099
domain: B
week: 8
parent: "[[Design by Contract (Java)]]"
tags: [SWE/Java, SWE/OOP]
type: pattern
aliases: [exception, custom exception, try catch, throw, IllegalArgumentException, assertion, assert, input validation, Scanner]
---
# [[Exceptions, Assertions and Validation (Java)]]

**Context:** [[FIT2099_MOC]] · the executable side of [[Design by Contract (Java)|Design by Contract]] · detect bad input and broken assumptions · exception = client-side runtime error, assertion = developer-side bug
**Problem it solves:** guard a method against illegal input and verify internal assumptions, choosing exception vs assertion correctly.

> [!abstract] Quick Revision
> - **🎯 Trigger:** illegal argument from a client ➔ throw an **exception** (precondition breach); a "this should never happen" internal check ➔ an **assertion**.
> - **⚡ Key Constraint:** **exceptions** are for runtime/client-side errors (bad input, network) and stay **on** in production; **assertions** catch developer bugs during dev and are **disabled** in shipped code.

## 🔧 Minimal Working Example
```java
// throw on a precondition breach (client passed an illegal argument)
public void addInteger(int integer) {
    if (integer >= 0 && integer <= 100) {
        integers.add(integer);
    } else {
        throw new IllegalArgumentException("Invalid integer! Must be between 0 and 100.");
    }
}
// client catches it instead of crashing:
try {
    list.addInteger(number);
    i++;                         // only advance if the value was accepted
} catch (IllegalArgumentException e) {
    System.out.println(e.getMessage());
}
```
**Expected output:** a valid number is stored and `i` advances; an invalid one throws, is caught, prints the message, and does **not** advance `i`.

- **`try` / `catch`** ➔ wrap code that may throw; the `catch` runs if a matching exception type (or subtype) occurs.
- **`throw`** ➔ raise an exception when a failure is detected (fail fast) instead of limping on with bad state.
- **Put the follow-up in the `try`** ➔ e.g. keep `i++` inside so an invalid input doesn't advance the loop.

## 🔀 Variations
- **Custom exception** ➔ extend `Exception` to carry extra data / a business-specific message:
```java
class ExistedUserNameException extends Exception {
    public ExistedUserNameException(String msg, String userName) { super(msg + userName); }
}
// throw new ExistedUserNameException("Username taken: ", newUserName);
```
- **Validation without exceptions (boolean flag)** ➔ `boolean addInteger(int x)` returns `false` if invalid — but the caller **may forget to check** the flag, silently skipping bad input (a weakness the exception approach avoids by forcing a `catch`).
- **Assertion** ➔ check a developer assumption; throws `AssertionError` if false:
```java
assert newIntegers.equals(sortWithSelectionSort()) : "QuickSort output disagrees with SelectionSort";
```

## ⚠️ Common Mistakes
- 💡 **Assertion vs exception** ➔ **assertion** = dev-time check for **your own logic bugs** (disabled in prod); **exception** = runtime, often **client-side** errors (illegal args, network) that stay active. Don't validate user input with `assert`.
- 💡 **`Scanner` newline trap** ➔ `nextInt()` leaves the trailing `\n`, so a following `nextLine()` reads an empty line and appears skipped. Fix: read with `nextLine()` and convert — `int n = Integer.parseInt(scanner.nextLine());`.
- 💡 **Catching too broadly** ➔ `catch (Exception e)` grabs every subtype; catch the **specific** type (`IllegalArgumentException`) so real bugs aren't swallowed.
- 💡 **Unchecked boolean flag** ➔ if the caller ignores a validation method's `boolean` return, invalid input is silently dropped — prefer throwing when correctness matters.
