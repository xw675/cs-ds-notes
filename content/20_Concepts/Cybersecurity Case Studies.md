---
unit: FIT1047
week: 12
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security]
aliases: [case studies, Stuxnet, F5 BIG-IP, CVE-2022-1388, Bangladesh Bank, SWIFT, Turkey pipeline, air gap, RCE, management plane]
---
# [[Cybersecurity Case Studies]]

**Context:** [[Information Security and Cryptography]] · real incidents that show how vulnerabilities + exposure become **physical and financial damage** · the "why it matters" evidence

> [!abstract] Quick Revision
> - **🎯 Objective:** four real attacks ➔ exposed management interfaces, jumped air gaps, hijacked control systems, and abused trusted banking networks.
> - **⚡ Key Constraint:** the recurring lesson — **exposure + default/insecure configuration** is the killer; **minimise services reachable from the Internet *and* internally**, and assume patches alone don't fix an already-compromised device.

## 📝 The incidents
| Incident | Year | Mechanism | Impact / Lesson |
| :--- | :--- | :--- | :--- |
| **F5 BIG-IP** (CVE-2022-1388) | 2022 | **RCE** via the **management plane**; ≥2500 devices had it **open to the Internet**; POC released fast | Patch came quickly, but an **already-corrupted** device may stay vulnerable → **never expose the management plane** |
| **Stuxnet** | 2009–10 | Worm on **USB** **jumped the air gap** to Siemens **PLCs**; varied centrifuge speeds | Physically **destroyed ~1000** Iranian centrifuges → air gaps are **not** absolute |
| **Turkey pipeline** | 2008 | Hacked **security cameras** as entry → raised valve **pressure**, disabled alerts | **"Main weapon was a keyboard"** — cyber attack, **no explosives**, 40-min blind spot |
| **Bangladesh Bank** | 2016 | Fraudulent **SWIFT** transfers | Attempted **US$951M**, **US$101M** succeeded (Sri Lanka recovered, Philippines lost) |

## 🎓 What to learn
- **Exposure is the root risk** ➔ if management/control interfaces are reachable, **any additional vulnerability becomes exploitable**.
- **Minimise services** ➔ towards the Internet **and** from the internal network (defence in depth beyond the [[Firewalls and Packet Filtering|firewall]]).
- **Secure the defaults** ➔ most appliances are **insecure out of the box**; follow hardening guidelines and **read security newsletters/advisories**.
- **Patching ≠ clean** ➔ a device compromised before patching can remain compromised.

## ⚠️ Common Mistakes
- 💡 **Air gap ≠ invulnerable** ➔ Stuxnet crossed a physically isolated network via **USB during configuration** — removable media and human process are the bridge.
- 💡 **Cyber attacks cause physical harm** ➔ Turkey/Stuxnet show OT/ICS attacks destroy equipment; this is not only a data-confidentiality problem.

## 🧠 Active Recall
> [!FAQ]- The F5 vulnerability was patched quickly — why did experts still consider exposed devices high-risk?
> > [!SUCCESS]- Answer
> > - **Short answer:** the flaw was only exploitable via the **management plane**, which **should never be Internet-facing**; a patch doesn't undo a device **already compromised**, and an exposed interface invites the **next** vulnerability.
> > - **Why:** **Reduce exposure, not just patch** ➔ the durable fix is architectural — keep management/control interfaces off the public Internet and minimise reachable services, so a future zero-day has no path in.
