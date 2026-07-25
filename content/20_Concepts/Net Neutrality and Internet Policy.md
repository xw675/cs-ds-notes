---
unit: FIT1047
week: 9
parent: "[[Internet Structure and Governance]]"
tags: [CS/Internet, CS/Ethics, Monash/CS_DS]
aliases: [net neutrality, network neutrality, apps vs open standards, platform vs public utility, natural monopoly, law enforcement internet, internet ethics]
---
# [[Net Neutrality and Internet Policy]]

**Context:** [[FIT1047_MOC]] · the legal/ethical/political questions the Internet raises — access, control, regulation · "more questions than answers"

> [!abstract] Quick Revision
> - **🎯 Objective:** **net neutrality** = ISPs must **treat all traffic equally** (no paid prioritisation/blocking) ➔ a level playing field for new entrants.
> - **⚡ Key Constraint:** it is **not guaranteed** and **not absolute** — some prioritisation is arguably *good* (emergency calls, blocking attacks), so the real question is *which* discrimination is acceptable, a **political** not purely technical choice.

## 📝 Core
- **Definition** ➔ net neutrality means ISPs **treat all traffic equally** — regardless of source, content, or application.
- **Why it matters (case study)** ➔ if a customer's ISP delivers a **competitor's data at higher priority** (a paid deal, or via a large CDN's preferential arrangements), a **start-up can't enter the market** — the network is **not a neutral communication device**.
- **Not guaranteed** ➔ some countries **regulate** for it (e.g. USA attempts), some **block/filter** outright; controversial among ISPs, big content providers, even Internet pioneers.

## ⚖️ Should networks be 100% neutral?
- **Arguably-good discrimination** ➔ **e-mail spam filters**; **blocking coordinated attacks** on servers; **blocking insecure ports** (e.g. port 25 SMTP); **prioritising real-time** traffic (live video) over file downloads; **prioritising emergency calls** over other IP traffic.
- **Takeaway** ➔ strict 100% neutrality conflicts with useful/necessary exceptions → the debate is *where to draw the line*.

## 🧩 Other tricky questions
- **Apps vs open standards** ➔ e-mail (open standard, many apps, user choice) vs WhatsApp/WeChat (closed ecosystem, single vendor, full corporate control) — apps offer convenience/integration but concentrate control. *Is this the future of the Internet?*
- **Platform vs public utility** ➔ **public utilities** (electricity, water, gas) are **natural monopolies** (inefficient to duplicate; everyone needs them) → **heavily state-regulated**. Are large **ISPs** or **social-media/messaging** platforms effectively public utilities that should be regulated the same way?
- **Law enforcement** ➔ hard online — **cross-border** jurisdiction, **strong encryption / dark web**, **massive scale**, and grey areas (gambling, crypto, tax, hate vs free speech, harassment, disinformation).

## ⚠️ Common Mistakes
- 💡 **Neutrality is not binary** ➔ "treat all traffic equally" sounds absolute, but spam/attack/port blocking and emergency prioritisation are widely accepted exceptions — the exam point is recognising the **trade-off**, not picking a side.
- 💡 **Natural monopoly is the utility argument** ➔ the case for regulating big Internet companies rests on them behaving like **natural monopolies** (duplication is inefficient, near-universal need), not merely on being large.

## 🧠 Active Recall
> [!FAQ]- Why is "networks should be 100% neutral" harder to defend than it first sounds?
> > [!SUCCESS]- Answer
> > - **Short answer:** several forms of **non-neutral** treatment are clearly beneficial — spam filtering, blocking DDoS attacks and insecure ports, and **prioritising emergency calls / real-time media** — so absolute equality would forbid useful, even safety-critical, behaviour.
> > - **Why:** **Line-drawing problem** ➔ the goal is preventing *anticompetitive* discrimination (paid fast lanes) while allowing *legitimate* traffic management — a **political/normative** decision that technologists must inform, not settle alone.

> [!NOTE] These are sensitive policy questions with legitimate views on multiple sides; this note summarises the lecture's framing (IT × law/economics/ethics) rather than advocating a position.
