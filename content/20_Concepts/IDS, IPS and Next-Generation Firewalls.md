---
unit: FIT1047
week: 11
parent: "[[Firewalls and Packet Filtering]]"
tags: [CS/Security, CS/Networks]
aliases: [IDS, IPS, intrusion detection system, intrusion prevention system, next-generation firewall, NGF, signature-based detection, anomaly-based detection, HTTPS interception]
---
# [[IDS, IPS and Next-Generation Firewalls]]

**Context:** [[Firewalls and Packet Filtering]] · going beyond header filtering — **detect and react** to attacks, and inspect **applications** · closes the app-layer gap of packet filters

> [!abstract] Quick Revision
> - **🎯 Objective:** **IDS** monitors + alerts + logs; **IPS** adds **active blocking**; **NGFs** proxy all traffic (even encrypted) to inspect apps/roles/users ➔ detect attacks a packet filter misses.
> - **⚡ Key Constraint:** to inspect encrypted traffic an NGF **proxies TLS**, which **breaks end-to-end security** and creates a **single point of attack** holding all decrypted data.

## 📝 IDS vs IPS
- **IDS (Intrusion Detection System)** ➔ **monitors** network/system activity, **alerts** on potentially malicious activity, **logs** it. Passive.
- **IPS (Intrusion Prevention System)** ➔ IDS **+ active functionality**: attempts to **block/stop** malicious activity.
- **Monitoring examples** ➔ detect **port scans**, **OS fingerprinting**, known-vulnerability exploits (**CVE** list), known **malware**, **behavioural anomalies**.
- **Reactions** ➔ **drop** malicious packets + alarm, **block** IPs, **correct fragmentation** in packet streams, **raise alerts** → may trigger a human **incident response team**.

## ⚖️ Signature vs anomaly detection
| Method | Strength | Weakness |
| :--- | :--- | :--- |
| **Signature-based** | **Fast**, **few false positives**, **no learning phase** | Only catches **known** attacks (needs a signature) |
| **Anomaly-based** | Can detect **previously unknown** attacks | More false positives; needs a **learning** baseline |

## 🧱 Next-generation firewalls (NGF)
- **Promise** ➔ integrated security: **proxy for all traffic (even encrypted)**, inspect **applications, logical segments, roles, services, users**.
- **Problems** ➔ policy rules get **too complex**; the **TLS proxy breaks end-to-end security** → a **single point of attack** with full access to decrypted data; **encapsulated encryption** can still hide traffic; **privacy** concerns; still **can't detect new (disguised) malware**.

## ⚠️ Common Mistakes
- 💡 **IPS = IDS + action** ➔ the only difference is that an IPS **actively blocks**; an IDS merely **detects and alerts**.
- 💡 **HTTPS interception is a double-edged sword** ➔ proxying TLS (a 2017 study showed weakened downgraded cipher suites) lets the NGF inspect content but **undermines the very end-to-end guarantee** of [[Secure Channels - TLS and VPNs|TLS]].

## 🧠 Active Recall
> [!FAQ]- Signature-based detection is fast and accurate — why do IDS/IPS also run anomaly-based detection?
> > [!SUCCESS]- Answer
> > - **Short answer:** signature-based detection can only match **already-known** attacks; a brand-new (**zero-day**) attack has no signature and slips past, so **anomaly-based** detection is needed to flag **previously unknown** behaviour.
> > - **Why:** **Coverage vs precision** ➔ signatures give speed and low false positives for known threats; anomaly detection trades more false positives for the ability to catch novel attacks — the two are **complementary**.
