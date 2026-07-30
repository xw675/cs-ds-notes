---
unit: [FIT1043, FIT2014, FIT2109]
domain: [E, F]
week: [1, 9]
source: [lecture, applied, lab]
parent: "[[Data Wrangling]]"
tags: [DataScience/Tools, Tool/Shell, CS/Systems]
type: pattern
aliases: [Unix Shell, Unix Shell for Data Science, Bash, Zsh, Shell Commands, grep, awk, pipes, pwd, absolute path, relative path]
---
# [[Unix Shell (Bash)]]

**Context:** [[FIT1043_MOC]], [[FIT2014_MOC]], [[FIT2109_MOC]] · a CLI to explore/[[Data Wrangling|wrangle]] **large** data files before [[Python for Data Science|Python]]/[[R for Data Science|R]] · pipes let you process files too big for memory · labs: `30_Projects/FIT1043_Labs/Week9-Shell-Twitter.pdf`, `Week10-Shell-BigFiles-Solution.txt`
**FIT2014 (Lab 0):** all assignment work runs in Linux (Ed Workspaces); `grep` patterns are **regular expressions**, and text-transform tooling (`sed`, `tr`) lives in [[Text Processing with sed and tr]].
**FIT2109 (W1):** the shell as the *control surface* under modern software work — GUIs are fine for visible one-off tasks, but remote machines, configuration, logs and anything repeatable need a scriptable layer. Execution mechanics (permissions, processes, `$PATH`, streams, exit status) live in [[Shell Execution Model (Permissions, Processes, Streams)]].
**Problem it solves:** inspect, search, sort, filter and reshape a big text/CSV file from the command line.
**Command reference:** [[Shell Toolkit (Cheatsheet)]] — the full `tool | micro-syntax | gotcha` tables for code-from-blank revision.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a big text/CSV file to peek at or clean fast ➔ shell commands + pipes, no loading into Python/R.
> - **⚡ Key Constraint:** the **pipe `|` is buffered** — each stage produces data only as the next needs it, so memory stays bounded and processing **scales to enormous files**.

## 🔧 Minimal Working Example
```bash
# stream a gzipped CSV through decompress, then page it — nothing fully loaded into memory
cat hourly_44201_2014-06.csv.gz | gunzip | less
```
**Expected output:** the decompressed file shown a page at a time, even if the file is huge.

- **Navigate** ➔ `cd [dir]` (`cd ..` up, `cd` home); `ls` list; `cp [src] [dst]` copy.
- **Read** ➔ `less file` (page: ↑/↓, space, `q` quit, `shift+g` end, `/keyword` search); `cat` dump; `head`/`tail` first/last lines.
- **Search / count** ➔ `grep "elephant" file` (lines containing a keyword); `wc -l file` (line count; `wc` alone = lines/words/chars).
- **Sort (with flags)** ➔ `sort file` (alphabetical); `sort -n` (numeric); `sort -k2,2` (by column 2).
- **Columns** ➔ `cut -f 3 file` (column 3 of a **tab**-delimited file); `awk -F',' '{print $6,$7,$14}'` (columns 6/7/14, comma-delimited).
- **Pipe / redirect** ➔ `prog1 | prog2` chains programs; `>` saves output to a file instead: `... | gunzip > new.txt`.
- **Wildcards** ➔ `book*.txt` matches all; **bracketed** `book[1-5].txt` matches a range (books 1–5 only). The **shell expands the pattern into filenames before the command runs** — the command never sees the `*`.
- **Decompress on the fly** ➔ `gunzip file.gz` (in place) vs pipe `cat file.gz | gunzip | …`; `unzip -p file.zip | …` streams a zip to a pipe (no 2.5 GB temp file).

## 🧭 Shell Context and Location (FIT2109 W1)
- **The shell is a read–interpret–run–report loop** ➔ it reads a line of text, interprets it, runs a command, reports the result. **The output usually matters more than the command.**
- **Command anatomy, read left to right** ➔ `ls -l scripts` = **name** (the action) · **option** `-l` (changes *how* it behaves) · **argument** `scripts` (what it acts *on*). `man ls` lists every option.
- **Names are abbreviations** ➔ the expansion *is* the definition: `pwd` print working directory · `cd` change directory · `ls` list · `cp` copy · `mv` move · `rm` remove · `mkdir` make directory · `cat` concatenate · `chmod` change mode · `ps` process status · `wc` word count · `man` manual · `grep` **g**lobal **r**egular **e**xpression **p**rint.
- **The shell always stands in one directory** ➔ it carries context (user · machine · cwd · environment), so **the same command means something different after the context changes**. `pwd` reports where you are; most "command mistakes" are really **location mistakes**.
- **The filesystem is a tree** ➔ root is `/`; every directory has one parent and any number of children; a **pathname is a route through that tree**.
- **Absolute vs relative** ➔ absolute starts at the root (`/Users/student/fit2109/week1`); relative starts at the cwd (`data/raw`). Shorthands: `.` current · `..` parent · `~` home.
- **Inspect vs change** ➔ files and directories *are* state. `ls`/`pwd` **inspect**; `mkdir`/`touch`/`cp`/`mv`/`rm` **change**. `cp` leaves the original; `mv` makes the old path **disappear**; `rm` has no undo. Professional habit: **inspect before and after** any risky change.
- **Three survival shortcuts** ➔ `Tab` completes a name · `Ctrl-C` **kills the running command** (it is *not* copy) · `↑` recalls the previous command to rerun or edit.
- **Bash vs Zsh** ➔ Bash is the default on most Linux and WSL; macOS defaults to **Zsh** since Catalina (2019), shown by a `%` prompt. Identical for `ls`/`cd`/`pwd`/pipes/redirection; they diverge in scripting syntax and some expansions. `echo "$SHELL"` names the interactive shell.

## 🔀 Variations
*(awk processes one line at a time, so all of these scale to massive files.)*
- **Select columns** ➔ `awk -F',' '{print $6,$7,$14}'` — `-F','` sets the comma delimiter.
- **Row-range filter** ➔ `awk -F',' 'NR>1000 && NR<=1500 {print $6,$7,$14}'` — `NR` is the current line number.
- **Random sample** ➔ `awk -F',' 'rand()<1/100 {print $0}'` keeps ~1% of rows.
- **Value filter (+ keep header)** ➔ `awk -F',' '$22=="\"California\"" || NR==1 {print $6,$7,$14}'` — escape embedded quotes with `\"`.
- **Shell → R handoff** ➔ after `awk … > out.txt`, launch `R` in the shell and `df <- read.table('out.txt', header=TRUE); summary(df$col)`.
- **Setup** ➔ Windows: install **Cygwin** (or WSL); MacOS (Big Sur+): `chsh -s /bin/bash` (default is now zsh).
- **Parallel / scripts** ➔ run a program in the background with `myprogram &`; Python scripts can be used as shell programs too.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Count how many lines in `data.csv` contain "ERROR", and save just those lines to `errors.txt`.
> > [!SUCCESS]- Reference solution
> > ```bash
> > grep "ERROR" data.csv | wc -l          # count matching lines
> > grep "ERROR" data.csv > errors.txt      # save matching lines
> > ```
> > - **Key move:** `grep` filters lines; pipe to `wc -l` to count, or `>` to save.

> [!QUESTION]- Practice 2: You are in `/Users/student/fit2109/week1`. Give the destination of `cd ..`, `cd ../..`, `cd ~`, `cd /`, and `cd data/raw` — then say which one is unaffected by where you started.
> > [!SUCCESS]- Reference solution
> > ```text
> > cd ..        -> /Users/student/fit2109        (parent)
> > cd ../..     -> /Users/student                (parent's parent)
> > cd ~         -> /Users/student                (home — absolute, start-independent)
> > cd /         -> /                             (root — absolute, start-independent)
> > cd data/raw  -> /Users/student/fit2109/week1/data/raw   (relative)
> > ```
> > - **Key move:** only `~` and `/`-leading paths are **absolute** and therefore start-independent; everything else is resolved from the cwd, which is why `pwd` is the first move when a command "mysteriously" fails.

## ⚠️ Common Mistakes
- 💡 **`>` overwrites, `|` chains** ➔ `>` redirects output to a file (replacing it); `|` feeds output to the next program — don't confuse them.
- 💡 **Why it scales** ➔ buffered pipes and line-at-a-time tools (`awk`) never hold the whole file in memory, so they handle files far larger than RAM.
- 💡 **`wc`/`sort` are slower than `less`/`head`** ➔ counting or sorting must read the **whole** file into memory; `less`/`head` only read the start, so they return instantly on huge files.
- 💡 **Mind the delimiter** ➔ `cut -f` assumes **tab**; for CSV use `awk -F','` (or `cut -d','`); check the real delimiter first (`/<tab>` search in `less`).
- 💡 **A wrong command is often a wrong location** ➔ before debugging the command, run `pwd` and `ls`; a relative path resolved from the wrong cwd produces the same error as a typo.
- 💡 **`Ctrl-C` does not copy** ➔ in a terminal it interrupts and kills the running process.
