---
unit: FIT2109
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2109: Computer Science Workshop

> [!INFO] Map of Content
> Index for **FIT2109 Computer Science Workshop** — the professional-tooling spine: shell → scripting → Git → remote machines → containers → debugging → profiling → automation → agentic coding. Taught by **productive failure**: the assessable skill is explaining *both the command and its output*, so every note pairs a correct invocation with its failure mode and the error text that identifies it. Shell notes are shared with [[FIT1043_MOC]] and [[FIT2014_MOC]] — FIT2109 contributes the **systems** angle (paths, permissions, processes, streams, exit status) to the same notes rather than forking a parallel tree.

## 📊 Assessment Map
- **Splits unrecorded** ➔ not stated in the Week 1 material; update this block from the unit guide before planning revision.
- **Format** ➔ weekly workshop with demos + group **handout activities** (Parts A–D/E) + a Poll Everywhere checkpoint at `pollev.com/fit2109`; weekly applied tasks between sessions.
- **What is actually assessed** ➔ fluency, not memorisation — you must be able to explain *why* a command ran or failed, and read an error message as a clue rather than noise.
- **Standard environment** ➔ **Bash** (`#!/usr/bin/env bash`); macOS defaults to **Zsh** since Catalina (`%` prompt) — identical for all W1 commands, diverging only in scripting syntax and expansions from W2.

## 🧰 Toolkit Cheatsheets
- [[Shell Toolkit (Cheatsheet)]] -> shared with FIT1043 + FIT2014; FIT2109 adds the paths, permissions, streams/redirection and exit-status blocks

## 📅 Knowledge Index

### Week 1 — Introduction to the Shell
- [[Unix Shell (Bash)]] -> Parent Framework: [[FIT2109_MOC]] *(Smart Merged: dual-unit + shell context, filesystem tree, path semantics, inspect-vs-change commands)*
- [[Shell Execution Model (Permissions, Processes, Streams)]] -> Parent Framework: [[Unix Shell (Bash)]] *(the "why did it fail?" note — 5-stage lookup → permission → process → streams → exit status)*

## 🎯 Learning Outcomes
- **W1** ➔ 
	- decode shell context (user · host · cwd · shell)
	- read command anatomy `name -option argument`
	- predict a `cd` destination from `.` `..` `~`, relative vs absolute
	- interpret a permission string and diagnose a non-running script
	- distinguish a stored program from a running process with a PID
	- explain `$PATH` lookup, the three streams, pipes, and exit status
