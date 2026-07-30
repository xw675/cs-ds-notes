---
unit: FIT2109
week: 1
source: [lecture, applied]
domain: F
parent: "[[Unix Shell (Bash)]]"
tags: [CS/Systems, Tool/Shell]
aliases: [PATH, $PATH, Standard Streams, stdout, stderr, Exit Status, File Permissions, chmod, Program vs Process, Shebang]
---
# [[Shell Execution Model (Permissions, Processes, Streams)]]

**Context:** [[FIT2109_MOC]] · the answer to *"why did this command run or fail?"* · command inventory in [[Shell Toolkit (Cheatsheet)]], navigation and text pipelines in [[Unix Shell (Bash)]] · the OS layer beneath it is [[Operating Systems and Multi-Processing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** typing a command fires **lookup ➔ permission check ➔ process ➔ streams ➔ exit status** ➔ name the stage that failed from the error text alone.
> - **📦 Core Components:** `$PATH` lookup ➔ `command not found` | permission bits ➔ `permission denied` | path resolution ➔ `no such file or directory`.
> - **⚡ Key Constraint:** each stage has ONE signature error message — the message *is* the diagnosis, so read it before touching anything.

## 🗺️ Layer & Dataflow
Every command passes these five stages in order; the first one to fail produces the error you see.

| # | Stage | What the shell does | Signature failure | Fix |
| :-- | :-- | :-- | :-- | :-- |
| 1 | **Lookup** | resolve the name: builtin first, else scan `$PATH` dirs in order | `command not found` | give an explicit path, or add the dir to `$PATH` |
| 2 | **Path resolution** | resolve the pathname to an existing inode | `no such file or directory` | check `pwd`, check spelling, check relative vs absolute |
| 3 | **Permission check** | is the execute bit set *for you*? | `permission denied` | `chmod u+x file` |
| 4 | **Process** | fork/exec ➔ a running instance with a **PID** | program's own runtime errors | read the program's message, not the shell's |
| 5 | **Report** | wire up `stdin`/`stdout`/`stderr`, return an **exit status** | silent wrong output | inspect `$?`, not just the screen |

- **Program vs process** ➔ a **program** is stored code on disk; a **process** is a *running instance* of it, identified by a **PID**. One program ➔ many concurrent processes.
- **Whose error is it?** ➔ stages 1–3 fail in the **shell**; stage 4 onward the message comes from the **program**. Misattributing this sends you debugging the wrong thing.

## 📝 How It Works

### 1. Command lookup — `$PATH` and the builtin/external split
- **Builtin vs external** ➔ `cd` is built into the shell (it must be — it changes the shell's *own* working directory); `ls` is a separate executable program on disk.
- **`$PATH` is a search list, not the whole disk** ➔ a colon-separated list of directories, scanned **left to right**; the first match wins, the rest are never seen.
- **A bare name is a lookup request** ➔ `run.sh` asks the shell *"find me a command called `run.sh`"*, and `.` (the current directory) is **not** on `$PATH` on modern systems ➔ `command not found`.
- **A path is an instruction, not a request** ➔ any name containing `/` (`./scripts/run.sh`) skips lookup entirely and uses that path directly. This is the whole reason for the leading `./`.
- **Shebang beats your interactive shell** ➔ a script starting `#!/usr/bin/env bash` runs in **Bash** whatever shell you typed in. `echo "$SHELL"` reports the interactive one.

### 2. Permissions — existence is not access
- **Read the string in four blocks** ➔ `-rwxr-xr-x` = `-` filetype · `rwx` owner · `r-x` group · `r-x` others.
- **Filetype character** ➔ `-` regular file, `d` directory.
- **`r` `w` `x`** ➔ read · write · execute; a `-` in the slot means that permission is **absent**.
- **`x` on a directory means *traverse*** ➔ not "run it" — without it you cannot `cd` into it or resolve a path through it.
- **`chmod u+x file`** ➔ adds execute for the **owner** only; it changes the *metadata*, never a single byte of the file's contents.
- **The classic composite failure** ➔ the file exists, the path is right, the code is correct, and it still won't run — because stage 3 rejected it.

### 3. Streams — three separate channels
- **`stdin`** ➔ where the program reads input from by default (the keyboard).
- **`stdout`** ➔ where normal results go (the screen).
- **`stderr`** ➔ where error messages go — a **different channel** that happens to land on the same screen.
- **Redirection retargets one channel** ➔ `> f` overwrite `stdout` · `>> f` append · `< f` feed `stdin` · `2> f` capture `stderr`.
- **Why the split exists** ➔ `cmd > out.txt` saves results while errors still appear on screen; nothing useful gets buried in the data file.
- **Pipes chain `stdout` into `stdin`** ➔ `A | B | C` makes each tool small and focused; **`stderr` does not travel down the pipe**.

### 4. Exit status — the machine-readable verdict
- **Convention** ➔ every command returns a small integer: `0` = success, **nonzero** = failure. Read it with `echo $?`.
- **Status ≠ output** ➔ a command can print nothing and succeed (`grep` finding no match is a *legitimate* nonzero), or print plenty and fail. Never infer success from the screen.
- **A pipeline reports only its LAST stage** ➔ `bad_cmd | wc -l` exits `0` because `wc` succeeded; `set -o pipefail` in a script makes any failing stage propagate.
- **`$$` is the current shell's own PID** ➔ the handle for asking `ps` about the process you are typing into.

## ⚙️ Core Implementation

### 🔹 Diagnosing the three signature failures
> [!code]- lookup vs permission vs path
> ```bash
> $ run.sh                      # bare name -> $PATH lookup; '.' is not on $PATH
> bash: run.sh: command not found            # STAGE 1
>
> $ ./scripts/run.sh            # contains '/', so used as a literal path
> bash: ./scripts/run.sh: Permission denied  # STAGE 3 -- it was FOUND, just not executable
>
> $ ls -l scripts/run.sh
> -rw-r--r--  1 student  staff  128 Jul 30 10:12 scripts/run.sh
> #^ no 'x' anywhere -- that is the whole diagnosis
>
> $ chmod u+x scripts/run.sh && ./scripts/run.sh
> hello from the script                      # STAGE 4: now a process with a PID
> ```
> 💡 **Common Mistake:** **Adding `./` when the real fault was the `x` bit** ➔ `command not found` and `permission denied` are *different stages*; `./` only fixes the first. Run `ls -l` before guessing.

### 🔹 Streams: separating results from errors
> [!code]- redirect each channel independently
> ```bash
> $ ls good.txt missing.txt > out.txt
> ls: missing.txt: No such file or directory   # stderr -> still on screen
> $ cat out.txt
> good.txt                                     # stdout -> only this landed in the file
>
> $ ls good.txt missing.txt > out.txt 2> err.txt   # split both away
> $ ls missing.txt 2>/dev/null; echo $?
> 2                                            # error silenced, status still reports failure
> ```
> 💡 **Common Mistake:** **Assuming `>` captured everything** ➔ it only retargets `stdout`. An error you "redirected away" is still on screen, and an error you *did* silence still needs `$?` to be detected.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
`cat app.log | grep "ERROR" | sort | uniq -c` — each stage transforms the stream:

| Step | Stage | `stdin` | `stdout` | Rows out |
| :-- | :-- | :-- | :-- | :-- |
| 1 | `cat app.log` | file | all lines | 4000 |
| 2 | `grep "ERROR"` | 4000 lines | matching lines only | 37 |
| 3 | `sort` | 37 lines | same lines, ordered | 37 |
| 4 | `uniq -c` | 37 sorted lines | count + distinct message | 6 |
| — | `echo $?` | — | `0` — **`uniq`'s** status, not `grep`'s | — |

- **Order matters** ➔ the cheap filter (`grep`) sits early so only 37 rows reach `sort`; `uniq -c` needs `sort` first because it collapses **adjacent** duplicates only.

### Applied Exercise
**Problem:** `./deploy.sh` prints `Permission denied`. `ls -l` shows `-rw-r--r--`. State the failing stage, the fix, and what the permission string looks like afterwards.
**Answer:** stage **3** (permission check) — the file was found, so lookup and path resolution both succeeded. `chmod u+x deploy.sh` ➔ `-rwxr--r--`. The contents are untouched; only the owner's execute bit flipped.
**Final Extracted Output:** `-rwxr--r--`, and `echo $?` after a successful run returns `0`.

## ⚠️ Common Mistakes
- 💡 **Reading `permission denied` as "the file is missing"** ➔ it is the *opposite* — the file was found and rejected. `no such file or directory` is the missing-file message.
- 💡 **Treating an empty screen as success** ➔ output and exit status are independent. Check `$?`.
- 💡 **Trusting a pipeline's exit status** ➔ only the last stage is reported; a failure mid-pipeline is invisible without `set -o pipefail`.
- 💡 **`Ctrl-C` is not copy** ➔ it sends an interrupt that **kills the running process**. Losing work this way in a terminal is a Week-1 rite of passage.

## 🧠 Active Recall
> [!FAQ]- Why does `./scripts/run.sh` work when `run.sh` does not — and why is that *not* a permissions issue?
> - **Hint:** One is a request to search, the other is an instruction.
> > [!SUCCESS]- Answer
> > - **Short answer:** A bare name triggers a `$PATH` search, and `.` is not on `$PATH`; a name containing `/` bypasses lookup and is used as a literal path.
> > - **Why:** **Different stage** ➔ this is a **lookup** failure (`command not found`), distinct from a **permission** failure (`permission denied`) where the file *was* located. `.` is deliberately kept off `$PATH` so a stray `ls` in a downloaded folder cannot hijack the real `ls`.

> [!FAQ]- A script exists, the path is correct, the code is valid — and it still refuses to run. What is left, and how do you confirm it?
> > [!SUCCESS]- Answer
> > - **Short answer:** The execute bit. Run `ls -l`; if no `x` appears in the owner block, `chmod u+x file`.
> > - **Why:** **Existence ≠ access** ➔ permissions are metadata checked at stage 3, *after* the file has been found. `chmod` alters that metadata only — the file's bytes never change, which is why "the code is fine" and "it won't run" are compatible.

> [!FAQ]- Why does Unix keep `stdout` and `stderr` as separate streams instead of one output channel?
> > [!SUCCESS]- Answer
> > - **Short answer:** So results can be redirected or piped onward while diagnostics stay visible.
> > - **Why:** **Composability** ➔ `cmd > data.txt` must not poison `data.txt` with error text, and `A | B` must not feed `A`'s complaints into `B`'s input. One channel carries the *answer*, the other carries the *explanation of failure* — and `2>` retargets only the latter.
