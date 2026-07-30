---
unit: FIT2102
week: 1
source: [lecture]
domain: H
parent: "[[Programming Paradigms]]"
tags: [CS/Languages, Tool/JavaScript]
type: pattern
aliases: [JavaScript Syntax, JavaScript, EcmaScript, const let, JavaScript Operators, strict equality, truthiness]
---
# [[JavaScript Basics (Syntax, Types, Control Flow)]]

**Context:** [[FIT2102_MOC]] · the imperative half of JavaScript, kept deliberately small so [[JavaScript Functions as Values]] can replace most of it · same role for JS as [[Python Basics (Syntax, Types, Control Flow)]] plays for Python
**Problem it solves:** bind values, branch, and loop in JavaScript — and know which of those constructs the unit wants you to stop using.
**Course notes:** JavaScript intro.

> [!abstract] Quick Revision
> - **🎯 Trigger:** any JS snippet ➔ `const` by default, `let` only where mutation is genuinely needed, `===` never `==`.
> - **⚡ Key Constraint:** **`const` freezes the *binding*, not the value** — `const a = [1,2]; a[0] = 9` is legal; `a = [9,2]` is not.

## 🔧 Minimal Working Example
```javascript
const z = 1;                       // constant (immutable binding) at global scope

/**
 * define a function with two parameters, print, and return the result
 */
function myFunction(x, y) {
  let t = x + y;                   // let -> mutable
  t += z;                          // += adds the right-hand expression to t
  const result = t;                // semicolons optional, but catch errors
  console.log("hello world");      // prints to the console
  return result;                   // returns to the caller
}
myFunction(1, 2);                  // logs "hello world", returns 4
```
**Expected output:** `hello world` on the console; return value `4` ($1+2+1$).

- **Bindings** ➔ `const` immutable binding (default choice) · `let` mutable. Reassigning a `const` is an error.
- **Branch, three surfaces** ➔ `if (c) { … } else { … }` · early return (`if (x >= y) return x; return y;`) · **conditional expression** `x >= y ? x : y`.
- **Loops** ➔ `while (cond) { … }` · `for (let i = 1; i <= n; i++) { … }`. Both are on the unit's discouraged list ➔ [[Programming Paradigms]].
- **Truthiness** ➔ `while (n)` terminates at zero because `Boolean(0) === false`. Concise, and a trap when `0` is a legitimate value.
- **Arrays** ➔ `const tutors = ['tim', 'michael', 'yan']` · `tutors.length` · `tutors[1]` (0-based). **The reference is immutable, the referenced array is not** — `tutors[1] = 'mic'` succeeds under `const`.
- **Comments** ➔ `//` line · `/** … */` JSDoc block above a function (the deck's house style for documenting parameters and return).

## 🔀 Operator reference
| Group | Operators | Gotcha |
| :-- | :-- | :-- |
| arithmetic | `+ - * /` · `x % y` (modulo) | — |
| **equality** | `x == y` / `x != y` **loose** · `x === y` / `x !== y` **strict** | loose comparison may **type-convert**; use strict whenever the types should already match |
| logical | `a && b` and · `a \|\| b` or | short-circuiting |
| bitwise | `a & b` · `a \| b` | ⚠ single character — a typo away from the logical form |
| unary | `i++` post-inc · `++i` pre-inc · `i--` · `--i` · `!x` not | **post** returns the old value then updates; **pre** updates then returns |
| in-place | `x += e` · also `-= *= /= \|= &=` | `x += e` adds the result of `e` to `x` |
| ternary | `<cond> ? <true result> : <false result>` | an **expression**, so it can be returned or passed |

## ✍️ Practice
> [!QUESTION]- Practice 1: Write `maxVal(x, y)` three ways — `if/else`, early return, and as a conditional expression. Which one can be passed straight to another function as a value, and why?
> > [!SUCCESS]- Reference solution
> > ```javascript
> > function maxVal(x, y) { if (x >= y) { return x; } else { return y; } }
> > function maxVal(x, y) { if (x >= y) return x; return y; }
> > function maxVal(x, y) { return x >= y ? x : y; }
> > ```
> > - **Key move:** all three are semantically identical. The **ternary body** `x >= y ? x : y` is an *expression* with a value, so it survives on its own (e.g. inside an arrow function `(x, y) => x >= y ? x : y`); an `if` is a *statement* and does not.

> [!QUESTION]- Practice 2: Predict the output, then explain the two surprises.
> ```javascript
> const a = [1, 2, 3];
> a[0] = 9;  console.log(a);
> let s = 0, n = 3;
> while (n) { s += n--; }  console.log(s, n);
> console.log(0 == '0', 0 === '0');
> ```
> > [!SUCCESS]- Reference solution
> > ```text
> > [9, 2, 3]        // const froze the BINDING, not the array contents
> > 6 0              // s = 3+2+1; n-- returns the old value, then decrements
> > true false       // == type-converts; === does not
> > ```
> > - **Key move:** three separate traps — `const` immutability is shallow, `n--` is *post*-decrement (the loop still adds `3` on the iteration that sets `n` to `2`), and loose equality converts `'0'` to a number.

## ⚠️ Common Mistakes
- 💡 **`const` on an array or object is not deep immutability** ➔ it forbids rebinding the name, not mutating what the name points at. This is the single most-quoted JS surprise.
- 💡 **`==` where `===` was meant** ➔ loose equality type-converts, so `0 == '0'` and `'' == 0` are `true`. Default to `===`/`!==` and only relax it deliberately.
- 💡 **Truthiness guards break on `0`** ➔ `while (n)` and `n ? a : b` treat a legitimate `0` as "done"/"false". Fine for `sumTo`, wrong for a count that may genuinely be zero.
- 💡 **`i++` vs `++i` inside an expression** ➔ post-increment yields the value *before* updating; mixing it into an accumulation (`sum += n--`) is exactly where off-by-one bugs hide.
