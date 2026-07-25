---
unit: FIT1047
domain: F
week: 12
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security]
aliases: [vulnerability, buffer overflow, command injection, SQL injection, XSS, cross-site scripting, input sanitisation, CWE, Bobby Tables]
---
# [[Software Vulnerabilities (Injection, XSS, Buffer Overflow)]]

**Context:** [[Information Security and Cryptography]] · concrete software **weaknesses** attackers exploit · catalogued at **CWE** (cwe.mitre.org); the common root is **unchecked input**

> [!abstract] Quick Revision
> - **🎯 Objective:** four classic vulnerabilities — **buffer overflow**, **command injection**, **XSS**, **SQL injection** ➔ each lets attacker input become **executed code/commands**.
> - **⚡ Key Constraint:** the shared root cause is **missing input sanitisation** (+ running with excessive privileges) — the single defence theme across all four.

## 📝 The four vulnerabilities
- **Buffer overflow** ➔ input **larger than the buffer** overwrites the **return address** in the activation record (cf. [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)|subroutine return]]); a crafted payload redirects execution to injected code (e.g. `execve("myshell")`). **Countermeasures:** stack **canary**, **address-space layout randomisation (ASLR)**.
- **Command injection** ➔ user input is passed into a shell command and **executed**; runs with the **host program's privileges** (root ⇒ full compromise).
- **Cross-site scripting (XSS)** ➔ attacker injects a **script** that runs in the victim's browser **with the visited domain's rights** (same-origin trust abused); **stored XSS** persists on the server and can **steal session tokens**.
- **SQL injection** ➔ input is concatenated into an SQL statement so it **executes extra commands** (the "**Bobby Tables**" `'); DROP TABLE Students;--`); can escalate to wider system compromise.

## 🔧 Minimal example (command injection)
```c
int main(char* argc, char** argv) {
  char cmd[CMD_MAX] = "/usr/bin/cat ";
  strcat(cmd, argv[1]);   // argv[1] is NOT sanitised
  system(cmd);            // runs the whole string in a shell
}
```
**Exploit:** argument `;rm -rf /` → `cat` fails, then `rm -rf /` runs — as **root**, it wipes the root partition.

## 🛡️ Defences
- **Sanitise/validate input** ➔ the common thread; reject or escape dangerous characters.
- **Use safe interfaces** ➔ **parameterised queries / stored procedures** (SQLi), **output encoding** (XSS — see the **OWASP** cheat sheets), avoid `system()` with user data (command injection). Helps but does **not guarantee** safety.
- **Least privilege** ➔ don't run services as root; limits the blast radius when a vuln is hit.

## ⚠️ Common Mistakes
- 💡 **Sanitisation reduces, not eliminates** ➔ predefined interfaces "**can prevent … but do not guarantee**" — defence in depth (least privilege, ASLR/canaries) still matters.
- 💡 **XSS abuses trust, not a server bug alone** ➔ the browser runs the script **because it appears to come from the trusted domain** — the injection point is often stored user content.

## 🧠 Active Recall
> [!FAQ]- Buffer overflow, command injection, XSS and SQL injection look unrelated — what do they share?
> > [!SUCCESS]- Answer
> > - **Short answer:** all four arise from **treating untrusted input as trusted** — unchecked input crosses a boundary and becomes **executed code** (machine code, a shell command, browser script, or SQL).
> > - **Why:** **Input sanitisation + least privilege** ➔ validating/escaping input and dropping privileges cuts every one of them; the damage scales with the **privileges** of the exploited process (root ⇒ total compromise).
