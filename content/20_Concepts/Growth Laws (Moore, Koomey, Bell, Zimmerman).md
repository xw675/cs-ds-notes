---
unit: FIT1043
week: 9
parent: "[[Big Data and the Vs]]"
tags: [DataScience/BigData]
aliases: [Growth Laws, Moore's Law, Koomey's Law, Bell's Law, Zimmerman's Law]
---
# [[Growth Laws (Moore, Koomey, Bell, Zimmerman)]]

**Context:** [[FIT1043_MOC]] · the exponential trends behind [[Big Data and the Vs|Big Data]]'s growth · four named laws · why "big" is a **moving target**

> [!abstract] Quick Revision
> - **🎯 Objective:** explain the exponential growth of computing/data ➔ four laws (Moore, Koomey, Bell, Zimmerman).
> - **📦 Core Components:** Moore (transistors) | Koomey (energy efficiency) | Bell (computer classes) | Zimmerman (surveillance).
> - **⚡ Key Constraint:** Koomey and Bell are **corollaries of Moore's Law** — efficiency and new device classes follow from doubling transistor counts.

## 📝 How It Works
### 1. Moore's Law (Gordon Moore, Intel, 1965)
- **Claim** ➔ transistors per chip **double every ~2 years** (from 1975) ➔ more/bigger/faster memory and CPUs (smaller = faster).
- **Nature** ➔ microprocessor growth is **exponential**; the pace is currently **slowing**.

### 2. Koomey's Law (Jonathan Koomey, Stanford, 2010)
- **Claim** ➔ computations **per joule** of energy double every **~1.57 years** — energy **efficiency** doubles.
- **Consequence** ➔ battery needed falls ~100× per decade ➔ **ubiquitous computing** (a corollary of Moore's Law).

### 3. Bell's Law (Gordon Bell, DEC, 1972)
- **Claim** ➔ roughly **every decade** a new, lower-priced **computer class** forms on a new platform/network/interface ➔ new usage + a new industry.
- **Confirmed** ➔ PCs, mobile computing, cloud, IoT.

### 4. Zimmerman's Law (Phil Zimmermann, 2013, PGP creator)
- **Claim** ➔ **surveillance constantly increasing**, **privacy constantly decreasing**.

## ⚖️ Core Decision Matrix
| Law | Who / year | What grows | Rate / effect |
| :--- | :--- | :--- | :--- |
| **Moore** | Moore, 1965 | transistors per chip | ×2 every ~2 years |
| **Koomey** | Koomey, 2010 | computations per joule | ×2 every ~1.57 years |
| **Bell** | Bell, 1972 | new computer classes | one per ~decade |
| **Zimmerman** | Zimmermann, 2013 | surveillance (privacy ↓) | continuous |

> [!NOTE] **When It Flips:** Moore drives the others — doubling transistors (Moore) implies more compute per joule (Koomey) and cheaper new device classes (Bell); those together fuel the data explosion that makes "big" a moving target.

## 🧠 Active Recall
> [!FAQ]- Contrast Moore's and Koomey's laws, and state what each doubles and how often.
> > [!SUCCESS]- Answer
> > - **Short answer:** Moore's law: transistors per chip double every ~2 years (compute power); Koomey's law: computations per joule double every ~1.57 years (energy efficiency).
> > - **Why:** **Power vs efficiency** ➔ Moore is about raw transistor count; Koomey (a corollary) is about doing more computation per unit of energy, enabling mobile/ubiquitous devices.

> [!FAQ]- What does Bell's Law predict, and give confirming examples.
> > [!SUCCESS]- Answer
> > - **Short answer:** Roughly every decade a new, lower-priced class of computer emerges on a new platform/network/interface, creating new uses and industries — e.g. PCs, mobile, cloud, IoT.
> > - **Why:** **Cheaper compute (Moore/Koomey)** ➔ each cost/efficiency step unlocks a new device category and market.
