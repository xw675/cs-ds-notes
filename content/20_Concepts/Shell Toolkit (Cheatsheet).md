---
unit: [FIT1043, FIT2014, FIT2109]
domain: [D, E, F]
parent: "[[Data Wrangling]]"
tags: [Tool/Shell, DataScience/Wrangling, CS/Languages, CS/Systems]
type: cheatsheet
aliases: [Shell Cheatsheet, Bash Cheatsheet, Unix Cheatsheet, grep awk sort cut cheatsheet, sed tr cheatsheet, chmod cheatsheet, redirection cheatsheet]
---
# [[Shell Toolkit (Cheatsheet)]]

**Context:** [[FIT1043_MOC]], [[FIT2014_MOC]], [[FIT2109_MOC]] · locate → navigate → inspect → search/count → sort → cut columns → pipe → compress → `awk` → **`sed`/`tr`/regex** → **permissions/streams/status** → hand off · depth in [[Unix Shell (Bash)]]; text-transform detail in [[Text Processing with sed and tr]]; execution mechanics in [[Shell Execution Model (Permissions, Processes, Streams)]] · FIT2014 = Lab 0 tooling · FIT2109 = W1 systems angle
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
- **Only the LAST stage sets the exit status** ➔ a mid-pipeline failure is invisible; `set -o pipefail` in a script propagates it.

## 🧭 Location & pathnames
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `pwd` | `pwd` | print working directory — **first move when a command "mysteriously" fails** |
| absolute path | `/Users/student/fit2109/week1` | starts at root `/` → start-independent |
| relative path | `data/raw` | resolved from the **cwd** → meaning changes with location |
| `.` / `..` / `~` | `cd ..` · `cd ../..` · `cd ~` | current dir · parent · home |
| `man` | `man ls` · `ls --help` | look up every option for a command |
| shortcuts | `Tab` · `Ctrl-C` · `↑` | complete name · **kill running process** (not copy) · recall last command |
| `echo $SHELL` | `echo "$SHELL"` | which **interactive** shell (Bash `$` vs Zsh `%`); a `#!/usr/bin/env bash` script runs in Bash regardless |

## 📂 Navigate & files
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `cd` | `cd dir` · `cd ..` (up) · `cd` (home) | change directory |
| `ls` | `ls` · `ls -l` (long) · `ls -a` (hidden) | list directory |
| `cp` / `mv` | `cp src dst` · `mv src dst` | copy (**original stays**) / move-rename (**old path disappears**) |
| `mkdir` / `rm` | `mkdir d` · `rm f` · `rm -r d` | make dir / remove (⚠ no undo) |
| `touch` | `touch f` | create empty file, or update its timestamp |

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
| pipe | `prog1 \| prog2` | stream `stdout` of one into `stdin` of the next — **`stderr` does NOT travel down a pipe** |
| redirect out | `… > out.txt` (overwrite) · `… >> out.txt` (append) | ⚠ `>` **replaces** the file; retargets `stdout` **only** |
| redirect in | `prog < in.txt` | feed a file to `stdin` |
| redirect err | `… 2> err.txt` · `… 2>/dev/null` | capture / discard `stderr` separately |
| both | `… > out.txt 2> err.txt` | split results from diagnostics |
| wildcard `*` | `book*.txt` · `ls *.sh` | **shell expands to filenames before the command runs** |
| bracket range | `book[1-5].txt` | match a **range** (books 1–5 only) |
| `gunzip` | `gunzip file.gz` (in place) · `cat f.gz \| gunzip \| …` (stream) | decompress `.gz` |
| `unzip -p` | `unzip -p file.zip \| …` | stream a zip to a pipe — **no huge temp file** |
| background | `myprogram &` | run in background; scripts can be shell programs |

## 🔐 Permissions & execution (FIT2109 — details ➔ [[Shell Execution Model (Permissions, Processes, Streams)]])
| Item | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| read the string | `-rwxr-xr-x` = type \| owner \| group \| others | `-` file, `d` directory; a `-` in a slot = permission **absent** |
| `r` `w` `x` | read · write · execute | on a **directory**, `x` means *traverse* (needed to `cd` in) |
| `chmod` | `chmod u+x file` | add execute for owner; changes **metadata only**, never file contents |
| `ls -l` | `ls -l file` | ⚠ run this **before** guessing why a script won't run |
| `$PATH` | `echo $PATH` | colon-separated dirs, scanned **left to right**; `.` is **not** on it |
| bare name | `run.sh` | a **lookup request** → `command not found` if not on `$PATH` |
| explicit path | `./scripts/run.sh` | contains `/` → **skips lookup**, used literally |
| builtin vs external | `cd` (builtin) vs `ls` (program on disk) | `cd` must be builtin — it changes the shell's *own* cwd |
| shebang | `#!/usr/bin/env bash` | script runs in **Bash** whatever your interactive shell is |
| `ps` / `$$` | `ps` · `echo $$` | process status (`pid`, `ppid`, `comm`) · PID of the current shell |
| exit status | `echo $?` | `0` = success, nonzero = failure — **independent of what was printed** |

**Three signature errors = three stages** ➔ `command not found` (lookup) · `permission denied` (found, but no `x`) · `no such file or directory` (path resolves to nothing). The message *is* the diagnosis.

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

## 🤝 Hand-off & setup
| Task | Micro-syntax | Note |
| :-- | :-- | :-- |
| shell → R | `awk … > out.txt` then in `R`: `df <- read.table('out.txt', header=TRUE)` | reduce first, analyse in R |
| Windows setup | install **Cygwin** or WSL | provides a Unix shell on Windows |
| macOS (Big Sur+) | `chsh -s /bin/bash` | default is now **zsh** (`%` prompt); switch to bash |

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

> [!QUESTION]- Practice 3: From `app.log`, save the six most frequent `ERROR` messages to `top_errors.txt` while keeping any error output from the pipeline on screen — then prove the pipeline succeeded.
> > [!SUCCESS]- Reference solution
> > ```bash
> > grep "ERROR" app.log | sort | uniq -c | sort -nr | head -n 6 > top_errors.txt
> > echo $?                              # 0 -> but this is HEAD's status, not grep's
> > set -o pipefail                      # (in a script) make any failing stage propagate
> > ```
> > - **Key move:** four tools combined — `grep` filters, `sort` makes duplicates adjacent for `uniq -c`, `sort -nr` ranks by count, `head` truncates. `>` retargets `stdout` only, so `stderr` stays visible; and `$?` reports only the **last** stage unless `pipefail` is set.

> [!QUESTION]- Practice 4: `./tools/clean.sh` prints `Permission denied`. Diagnose it in two commands and fix it in one.
> > [!SUCCESS]- Reference solution
> > ```bash
> > pwd                                  # 1. am I where I think I am?
> > ls -l tools/clean.sh                 # 2. -rw-r--r--  <- no 'x' anywhere
> > chmod u+x tools/clean.sh             # fix: owner gains execute -> -rwxr--r--
> > ```
> > - **Key move:** `permission denied` means the file **was found** — so this is not a path or lookup problem. `chmod` edits metadata; the script's contents are irrelevant to the failure.

## ⚠️ Common Mistakes
- 💡 **`>` overwrites, `|` chains** ➔ redirect **replaces** the target file; pipe **feeds** the next program.
- 💡 **Mind the delimiter** ➔ `cut -f` assumes **tab**; for CSV use `awk -F','` or `cut -d','`. Check the real delimiter first (`/<tab>` search in `less`).
- 💡 **`wc`/`sort`/`uniq` read the whole file** ➔ slow + memory-heavy on huge files; `less`/`head` only read the start → instant. Put cheap filters **before** them.
- 💡 **`sort` is alphabetical by default** ➔ add `-n` for numbers, and `uniq` only collapses **adjacent** duplicates (so `sort | uniq`).
- 💡 **`>` does not capture errors** ➔ it retargets `stdout` only; `stderr` still hits the screen and needs `2>`.
- 💡 **Empty output ≠ success** ➔ check `echo $?`; and a pipeline's status is only its **last** stage's.
- 💡 **`permission denied` ≠ file missing** ➔ that is `no such file or directory`. Match the message to the stage before acting.
