---
unit: [FIT1043, FIT2014]
domain: [D, E]
parent: "[[Data Wrangling]]"
tags: [Tool/Shell, DataScience/Wrangling, CS/Languages]
type: cheatsheet
aliases: [Shell Cheatsheet, Bash Cheatsheet, Unix Cheatsheet, grep awk sort cut cheatsheet, sed tr cheatsheet]
---
# [[Shell Toolkit (Cheatsheet)]]

**Context:** [[FIT1043_MOC]], [[FIT2014_MOC]] · navigate → inspect → search/count → sort → cut columns → pipe → compress → `awk` → **`sed`/`tr`/regex** → hand off · depth in [[Unix Shell (Bash)]]; text-transform detail in [[Text Processing with sed and tr]] · FIT2014 = Lab 0 tooling
**Read protocol:** scan tables → attempt the practice blank → follow the pattern-note link only where you failed.

> [!abstract] Quick Revision
> - **🎯 Objective:** explore/clean a **huge** text/CSV file from the command line without loading it into memory ➔ chain small tools with pipes, then hand the reduced file to [[R for Data Science|R]]/[[Python for Data Science|Python]].
> - **⚡ Key Constraint:** the **pipe `|` is buffered + line-at-a-time** — memory stays bounded so it scales past RAM; `>` **overwrites a file**, `|` **feeds the next program** — never confuse them.

## 🧩 Pipeline Anatomy (execution order)
```bash
cat big.csv.gz | gunzip | awk -F',' 'NR>1 {print $6,$14}' | sort -n | head
#   └─source──┘  └decomp┘  └──select cols, skip header──┘  └numeric┘ └peek┘
# reads L→R; each stage streams rows to the next as needed (nothing fully in memory)
```
- **Order** ➔ `source → transform → filter → sort → view/save`; put **cheap filters early** (less data flows downstream).
- **Save instead of view** ➔ replace the final `head`/`less` with `> out.txt` to persist the result.

## 📂 Navigate & files
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `cd` | `cd dir` · `cd ..` (up) · `cd` (home) | change directory |
| `ls` | `ls` · `ls -l` (long) · `ls -a` (hidden) | list directory |
| `pwd` | `pwd` | print working directory |
| `cp` / `mv` | `cp src dst` · `mv src dst` | copy / move-rename |
| `mkdir` / `rm` | `mkdir d` · `rm f` · `rm -r d` | make dir / remove (⚠ no undo) |

## 👀 Inspect / read
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `less` | `less file` — space/↑↓ page, `/kw` search, `shift+g` end, `q` quit | reads only the **start** → instant on huge files |
| `cat` | `cat file` | dump whole file (or concatenate) |
| `head` / `tail` | `head -n 20 file` · `tail -n 20 file` | first / last N lines (default 10) |
| `wc` | `wc -l file` (lines) · `wc` (lines/words/chars) | ⚠ must read the **whole** file → slow on huge files |

## 🔍 Search & count
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `grep` | `grep "elephant" file` | print lines containing the pattern |
| `grep -c` | `grep -c "kw" file` | count matching lines (= `grep … \| wc -l`) |
| `grep -i` / `-v` | `grep -i "kw"` · `grep -v "kw"` | case-insensitive · **invert** (non-matching) |
| count matches | `grep "kw" file \| wc -l` (pipe to count) | classic filter-then-count |

## 🔢 Sort
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `sort` | `sort file` | alphabetical (default) |
| `sort -n` | `sort -n file` | **numeric** (else `10` sorts before `2`) |
| `sort -r` | `sort -r file` | reverse order |
| `sort -k` | `sort -k2,2 file` | sort by **column 2** |
| `sort -t` | `sort -t',' -k2,2n` | set delimiter `,` + numeric key |
| `uniq` | `sort file \| uniq -c` | count duplicates (⚠ needs **sorted** input) |

## ✂️ Columns
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `cut -f` | `cut -f 3 file` | column 3 — assumes **tab** delimiter |
| `cut -d` | `cut -d',' -f 3 file` | set delimiter to comma |
| `awk` cols | `awk -F',' '{print $6,$7,$14}'` | columns 6/7/14; `-F','` = comma delimiter; `$0` = whole line |

## 🧠 `awk` power (one line at a time → scales)
| Task | Micro-syntax | Note |
| :-- | :-- | :-- |
| set delimiter | `awk -F',' '…'` | `-F` = field separator |
| row-range filter | `awk -F',' 'NR>1000 && NR<=1500 {print $6}'` | `NR` = current line number |
| skip header | `awk -F',' 'NR>1 {print $6}'` | drop line 1 |
| random sample | `awk 'rand()<1/100 {print $0}'` | keep ~1% of rows |
| value filter (+header) | `awk -F',' '$22=="\"California\"" \|\| NR==1 {print $6}'` | escape embedded quotes `\"` |

## 🔀 Pipes, redirect, wildcards, compression
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| pipe | `prog1 \| prog2` | stream output of one into the next |
| redirect | `… > out.txt` (overwrite) · `… >> out.txt` (append) | ⚠ `>` **replaces** the file |
| wildcard `*` | `book*.txt` | match any characters |
| bracket range | `book[1-5].txt` | match a **range** (books 1–5 only) |
| `gunzip` | `gunzip file.gz` (in place) · `cat f.gz \| gunzip \| …` (stream) | decompress `.gz` |
| `unzip -p` | `unzip -p file.zip \| …` | stream a zip to a pipe — **no huge temp file** |
| background | `myprogram &` | run in background; scripts can be shell programs |

## 🤝 Hand-off & setup
| Task | Micro-syntax | Note |
| :-- | :-- | :-- |
| shell → R | `awk … > out.txt` then in `R`: `df <- read.table('out.txt', header=TRUE)` | reduce first, analyse in R |
| Windows setup | install **Cygwin** | provides a Unix shell on Windows |
| macOS (Big Sur+) | `chsh -s /bin/bash` | default is now **zsh**; switch to bash |

## 🔤 Text transform — sed / tr / grep-regex (FIT2014 — details ➔ [[Text Processing with sed and tr]])
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `sed` substitute | `sed 's/pat/rep/' file` | first match per line; **file unchanged** (stdout) |
| `sed` global | `sed 's/pat/rep/g' file` | `g` = every match on the line |
| `sed` backref | `sed 's/2\([0-9]*\)/3\1/'` | `\(...\)` captures, `\1`..`\9` reuse in replacement |
| `sed` delete chars | `sed 's/[^a-zA-Z]//g'` | replace-with-nothing = delete |
| char class | `[aeiou]` · `[a-z]` · `[^a-z]` | set · range (ASCII) · complement (`^` first) |
| anchors | `^pat` · `pat$` · `^pat$` | starts / ends / whole line |
| `tr` map | `tr 'A-Z' 'a-z'` | per-**character** map (not words) |
| `tr -d` / `-s` | `tr -d 'aeiou'` · `tr -s ' '` | delete listed · squeeze runs to one |
| `grep` regex | `grep '[aeiou][aeiou]' f` · `grep '^a.*b$' f` | grep patterns **are** regexes ([[Regular Expressions]]) |

*(⚠ POSIX **BRE**: grouping/repetition are escaped — `\(...\)`, `\{n\}`; bare `()` `{}` are literal. Opposite of the theory notation.)*

## ✍️ Integration Practice
> [!QUESTION]- Practice 1: From gzipped `air.csv.gz` (comma-delimited, header on line 1), print the **10 largest** values of column 14, ignoring the header.
> > [!SUCCESS]- Reference solution
> > ```bash
> > cat air.csv.gz | gunzip | awk -F',' 'NR>1 {print $14}' | sort -nr | head
> > ```
> > - **Key move:** decompress → `awk` skips header + selects col → `sort -nr` (numeric, reverse) → `head`. Filter (`NR>1`) sits early so less data flows on.

> [!QUESTION]- Practice 2: Count how many rows in `data.csv` have "ERROR" in them, then save just those rows to `errors.txt`.
> > [!SUCCESS]- Reference solution
> > ```bash
> > grep -c "ERROR" data.csv            # count matching rows
> > grep "ERROR" data.csv > errors.txt   # save matching rows
> > ```
> > - **Key move:** `grep -c` counts in one step; `>` persists the filtered rows (use `>>` to append instead of overwrite).

## ⚠️ Common Mistakes
- 💡 **`>` overwrites, `|` chains** ➔ redirect **replaces** the target file; pipe **feeds** the next program.
- 💡 **Mind the delimiter** ➔ `cut -f` assumes **tab**; for CSV use `awk -F','` or `cut -d','`. Check the real delimiter first (`/<tab>` search in `less`).
- 💡 **`wc`/`sort`/`uniq` read the whole file** ➔ slow + memory-heavy on huge files; `less`/`head` only read the start → instant. Put cheap filters **before** them.
- 💡 **`sort` is alphabetical by default** ➔ add `-n` for numbers, and `uniq` only collapses **adjacent** duplicates (so `sort | uniq`).
