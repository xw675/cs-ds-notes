---
unit: FIT1047
domain: F
week: 6
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [SMTP, POP, IMAP, MIME, E-Mail Protocols]
---
# [[Electronic Mail (SMTP, POP, IMAP, MIME)]]

**Context:** [[FIT1047_MOC]] · the second Application-layer case study · asymmetric design: **SMTP pushes** mail toward the destination server, **POP/IMAP pull** it to the reader

> [!abstract] Quick Revision
> - **🎯 Objective:** map the journey ➔ sender's client —SMTP→ sender's server —SMTP→ recipient's server —POP/IMAP→ recipient's client.
> - **📦 Core Components:** SMTP dialogue (HELO → MAIL FROM → RCPT TO → DATA → `.` → QUIT) ➔ POP vs IMAP retrieval ➔ MIME for anything beyond plain text.
> - **⚡ Key Constraint:** SMTP carries **plain text only** — attachments exist because MIME base64-encodes binary into text.

## 📝 Core
- **SMTP** ➔ transfers messages client→server AND server→server (e.g. `smtp.live.com` → `smtp.gmail.com`).
- **POP** ➔ download to the client, **delete from server** — one-device model.
- **IMAP** ➔ messages **stay on the server**; multiple clients share one mailbox simultaneously — the modern default.
- **MIME** ➔ Multi-Purpose Internet Mail Extensions: character sets (Unicode), non-text attachments, multi-part bodies — e.g. `Content-Type: image/jpeg` + `Content-Transfer-Encoding: base64` turning an image into text lines.

## 📊 Exam Execution Trace — lecture SMTP session (verbatim, server lines numbered)
```text
S: 220 MyMailServer ESMTP …            ← greeting
C: HELO my.laptop
S: 250 MyMailServer Hello laptop …
C: MAIL FROM:<alice@mymail.com>
S: 250 OK
C: RCPT TO:<john@mymail.edu>
S: 250 Accepted
C: DATA
S: 354 Enter message, ending with "." on a line by itself
C: From/To/Date/Subject headers … blank line … body … "."
S: 250 OK id=…
C: QUIT
S: 221 closing connection
```
- **Message anatomy inside DATA** ➔ header block (From, To, Date, Subject) + blank line + body — headers here are *content*, distinct from the SMTP envelope (MAIL FROM/RCPT TO).

## ⚖️ Core Decision Matrix — POP vs IMAP
| Aspect | POP | IMAP |
| :-- | :-- | :-- |
| messages live | on the client (server copy deleted) | on the server |
| multi-device | poor | designed for it (simultaneous clients) |
| offline habit | classic single PC | phones + laptop + webmail |

## ⚠️ Common Mistakes
- 💡 **Envelope ≠ header** ➔ `MAIL FROM:`/`RCPT TO:` route the mail; the `From:`/`To:` inside DATA are mere display text — spoofing exploits exactly this gap.
- 💡 **The lone dot terminates** ➔ `.` alone on a line ends DATA; it's protocol syntax, not punctuation.
- 💡 **SMTP both hops** ➔ students often say "SMTP = server-to-server only"; it also carries the first hop from the sender's client.

## 🧠 Active Recall
> [!FAQ]- Alice (hotmail) mails Bob (gmail). Name the protocol on each of the three hops.
> > [!SUCCESS]- Answer
> > - **Short answer:** Alice's client →SMTP→ smtp.live.com →SMTP→ smtp.gmail.com →POP or IMAP→ Bob's client.
> > - **Why:** **Push then pull** ➔ SMTP pushes toward the destination server; retrieval waits until Bob's client asks.

> [!FAQ]- Why does emailing a photo work when SMTP is text-only?
> > [!SUCCESS]- Answer
> > - **Short answer:** MIME encodes the binary as base64 text with `Content-Type`/`Content-Transfer-Encoding` headers; the receiving client decodes it back.
> > - **Why:** **Layered compatibility** ➔ extending the message format instead of the transfer protocol kept every existing SMTP server working.
