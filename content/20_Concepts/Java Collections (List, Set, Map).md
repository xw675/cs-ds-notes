---
unit: FIT2099
week: 3
parent: "[[Java Arrays]]"
tags: [SWE/Java, SWE/OOP, Monash/CS_DS]
type: pattern
aliases: [ArrayList, List, HashSet, Set, HashMap, Map, TreeMap, collections, generics]
---
# [[Java Collections (List, Set, Map)]]

**Context:** [[FIT2099_MOC]] · dynamic, resizable alternatives to a fixed [[Java Arrays|array]] · store objects and look them up by index / uniqueness / key
**Problem it solves:** hold a growing collection of objects and add/find/remove them without managing a fixed size.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need a resizable collection ➔ **List** (ordered, duplicates, index) · **Set** (unique, unordered) · **Map** (key→value).
> - **⚡ Key Constraint:** collections hold **objects only** — use wrapper types (**Integer**, **Long**) not primitives inside `<>`; declare to the **interface** (`List`) not the concrete class (`ArrayList`) for flexibility.

## 🔧 Minimal Working Example
```java
import java.util.*;                       // List, ArrayList, Set, HashSet, Map, HashMap, Collections

List<String> papers = new ArrayList<>();  // program to the interface (List), not ArrayList
papers.add("Title 1");                    // append
papers.add("Title 2");
papers.set(0, "Updated");                 // replace index 0
papers.get(0);                            // read  -> "Updated"
papers.remove(1);                         // delete by index
papers.size();                            // 1
Collections.sort(papers);                 // ascending (Collections.reverseOrder() for desc)

Set<String> moods = new HashSet<>();
moods.add("Happy"); moods.add("Happy");   // duplicate ignored -> size 1
moods.contains("Happy");                  // true  (no get-by-index on a Set)

Map<Long,String> books = new HashMap<>();
books.put(9780393634990L, "Hello World"); // key -> value
books.get(9780393634990L);                // "Hello World"
```
**Expected output:** `papers` size 1 after removal; `moods` size 1 (dup dropped); `books.get(...)` returns the title.

- **Program to the interface** ➔ `List<X> v = new ArrayList<>();` lets you swap in `LinkedList` later.
- **Generics `<Type>`** ➔ fix the element type at compile time; primitives use wrappers (`Integer`, `Long`).
- **Import `java.util.*`** ➔ (or the specific classes) or it won't compile.

## 🔀 Variations
| Feature | List (`ArrayList`) | Set (`HashSet`) | Map (`HashMap`) |
| :--- | :--- | :--- | :--- |
| **Duplicates?** | Yes | No | Keys no, values yes |
| **Keeps insertion order?** | Yes | No (use `LinkedHashSet`) | No (use `TreeMap` to sort keys) |
| **`get()` by index?** | Yes | No — use `contains()` | No — `get(key)` |
| **Nulls** | many | one | one null key, many null values |
| **Traverse** | `for` / for-each | for-each / `Iterator` | `keySet()` · `values()` · `entrySet()` |
| **Use when** | access by position | enforce uniqueness | key→value lookup |

- **Map iteration** ➔ `for (Long k : books.keySet())` (keys), `for (String v : books.values())` (values), or `books.entrySet().forEach(e -> ... e.getKey() ... e.getValue())`.
- **LinkedList vs ArrayList** ➔ `LinkedList` faster for end insert/delete; `ArrayList` faster for generic store/index access.

## ✍️ Practice
> [!QUESTION]- Practice 1: Count how many times each word appears in a `String[] words`, using a `Map<String,Integer>`. Print each word and its count.
> > [!SUCCESS]- Reference solution
> > ```java
> > Map<String,Integer> counts = new HashMap<>();
> > for (String w : words) {
> >     counts.put(w, counts.getOrDefault(w, 0) + 1);  // read-or-0, then increment
> > }
> > for (String w : counts.keySet()) {
> >     System.out.println(w + " : " + counts.get(w));
> > }
> > ```
> > - **Key move:** `getOrDefault(key, 0)` seeds unseen keys so `+1` always works; `keySet()` to walk the map.

## ⚠️ Common Mistakes
- 💡 **Primitives in `<>`** ➔ `List<int>` won't compile — use `List<Integer>` (wrapper class).
- 💡 **`get(index)` on a Set/Map** ➔ Sets are unordered (no index); use `contains()`; Maps use `get(key)`.
- 💡 **Declaring the concrete type** ➔ `ArrayList<X> v` locks you in; prefer `List<X> v` so the implementation can change.
- 💡 **Duplicate into a Set is silently dropped** ➔ the existing element is kept, the new one is **not** added and does **not** replace it.
