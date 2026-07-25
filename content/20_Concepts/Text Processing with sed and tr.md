---
unit: [FIT2014, FIT1043]
domain: [D, E]
parent: "[[Unix Shell (Bash)]]"
tags: [Tool/Shell, CS/Languages]
type: pattern
aliases: [sed, tr, stream editor, character translator, sed substitution, backreference, POSIX regex, grep regex, BRE]
---
# [[Text Processing with sed and tr]]

**Context:** [[FIT2014_MOC]] · Lab 0 Linux tooling · the **applied** face of [[Regular Expressions]] — `sed`/`grep` patterns *are* regular expressions (POSIX BRE) · extends [[Shell Toolkit (Cheatsheet)]]
**Problem it solves:** transform or search text line-by-line by a pattern — substitute, delete, translate, or match.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "replace/delete/translate/match text by a pattern" ➔ **sed** (substitute), **tr** (char-by-char map), **grep** (search). The patterns are **regular expressions**.
> - **⚡ Key Constraint:** `sed`/`grep` use **POSIX BRE**, where grouping and repetition are **backslash-escaped** — `\(...\)`, `\{...\}` — the opposite of the theory notation. And `s///` replaces only the **first** match per line unless you add `g`.

## 🔧 sed — substitute by regex
`sed 's/pattern/replacement/flags' file` — for each line, replace `pattern` with `replacement`.
```bash
sed 's/A Lady/Jane Austen/' file    # first match per line
sed 's/A Lady/Jane Austen/g' file   # g = every match on the line
echo "0001" | sed 's/001/10/'       # -> 010 (leftmost match only)
```
- **Output only** ➔ result goes to stdout; the file is **unchanged** (redirect with `>` to save).
- **Special chars in patterns** ➔ `\t` tab, `\n` newline, `\/` a literal slash (since `/` delimits the script).

## 🎯 Character classes & anchors (POSIX BRE)
| Pattern | Matches | Example |
| :-- | :-- | :-- |
| `[aeiou]` | any one listed char | `b[aeiou]t` → bat/bet/bit/bot/but |
| `[a-z]` | a range (by ASCII order) | `[N-Z]` upper half; `[0-9]` a digit |
| `[^aeiou]` | any char **not** listed (`^` first) | `[^a-zA-Z]` a non-letter |
| `^pat` | line **starts with** pat | anchor at start |
| `pat$` | line **ends with** pat | anchor at end |
| `^pat$` | whole line **is** pat | both anchors |

## 🔁 Subpatterns & backreferences
Wrap part of the pattern in `\(...\)`; reuse the captured text as `\1` (up to `\9`, left-to-right) in the replacement.
```bash
# fix NSW postcodes (2xxx) to Victorian (3xxx), keeping the last 3 digits:
sed 's/2\([0-9][0-9][0-9]\)/3\1/' file      # 2xxx -> 3xxx
# swap a single-digit fraction  a / b  ->  b / a :
sed 's/ \([0-9]\)\/\([0-9]\) / \2\/\1 /' file
```
- **`\1` = the first `\(...\)`** ➔ counted by opening paren, left to right.

## 🔤 tr — translate characters
`tr string1 string2` maps each char in `string1` (the domain) to the char at the same position in `string2`.
```bash
echo "abracadabra" | tr abc 123      # -> 12r131d12r1  (a->1, b->2, c->3)
tr 'A-Z' 'a-z'                        # uppercase -> lowercase
tr -d 'aeiou'                        # -d: DELETE listed chars (no string2)
tr -s ' '                            # -s: SQUEEZE runs of a char to one
```
- **No file args** ➔ `tr` reads stdin, writes stdout; use redirection/pipes for files.

## ✍️ Practice (write from blank)
> [!QUESTION]- Practice 1: Remove every character that is **not a letter** from a file.
> > [!SUCCESS]- Reference solution
> > ```bash
> > sed 's/[^a-zA-Z]//g' file        # delete = replace non-letters with nothing
> > # or, streaming, with tr:
> > tr -d -c 'a-zA-Z' < file          # -c = complement of the set, then delete
> > ```
> > - **Key move:** `[^a-zA-Z]` is "not a letter"; replacing with empty (`//`) deletes. `g` makes it every match, not just the first.

> [!QUESTION]- Practice 2: Convert US dates `MM/DD/YYYY` to Australian `DD/MM/YYYY`.
> > [!SUCCESS]- Reference solution
> > ```bash
> > sed 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9]\{4\}\)/\2\/\1\/\3/' file
> > ```
> > - **Key move:** capture MM, DD, YYYY in three `\(...\)` groups, then re-emit as `\2\/\1\/\3` — swapping the first two. `\{4\}` repeats the digit class four times (BRE braces are escaped).

## ⚠️ Common Mistakes
- 💡 **BRE escaping is inverted** ➔ in `sed`/`grep` BRE, `(`, `)`, `{`, `}` are **literal**; grouping/repetition need `\(`, `\)`, `\{`, `\}`. (The theory's $R^*$, $(R\cup S)$ use bare metacharacters — see [[Regular Expressions]].)
- 💡 **`s///` is first-match-only** ➔ add the `g` flag for all matches on a line; forgetting `g` silently leaves later matches untouched.
- 💡 **Ranges are ASCII, not alphabetic-only** ➔ `[A-z]` accidentally includes `[`, `\`, `]`, `^`, `_`, backtick; use `[A-Za-z]`.
- 💡 **These tools stream to stdout** ➔ they never edit the file in place here; capture with `> out` (⚠ overwrites) or a pipe.
- 💡 **`tr` maps single characters, not strings** ➔ `tr abc xyz` is a per-character map (a→x, b→y, c→z), **not** a word substitution — for word replacement use `sed`.

## 🧠 Active Recall
> [!FAQ]- The FIT2014 theory writes regex as $(a\cup b)^*$, but `grep`/`sed` reject that syntax — why, and what's the equivalent?
> > [!SUCCESS]- Answer
> > - **Short answer:** tools use **POSIX BRE**, a different concrete syntax for the *same idea*. Alternation/grouping/repetition are written `\(a\|b\)*` (or in ERE `grep -E '(a|b)*'`), and a character class `[ab]` stands for $a\cup b$ over single letters.
> > - **Why:** **Same languages, different notation** ➔ regular expressions are a mathematical object ([[Regular Expressions]]); every implementation picks its own escaping and extensions, which is exactly the "tools differ" caveat — `\(...\)` in BRE vs bare `(...)` in the theory, `[a-z]` shorthand for a union, etc.

> [!FAQ]- What does `sed 's/2\([0-9][0-9][0-9]\)/3\1/'` do, and what is `\1`?
> > [!SUCCESS]- Answer
> > - **Short answer:** it finds a `2` followed by three digits and replaces it with `3` followed by **those same three digits** — rewriting `2xxx` as `3xxx`. `\1` is the text captured by the first `\(...\)` group (the three digits).
> > - **Why:** **Backreference reuse** ➔ `\(...\)` captures a subpattern; `\1`…`\9` re-emit captured groups in the replacement, letting a substitution keep part of what it matched (here, the postcode's last three digits).
