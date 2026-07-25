---
unit: FIT1047
week: 9
parent: "[[Internet Structure and Governance]]"
tags: [CS/Networks, CS/Internet, Monash/CS_DS]
aliases: [Internet access, dial-up modem, ADSL, DSLAM, VDSL, FTTN, NBN, GPON, fibre to the premises, 4G, 5G, mobile data, last mile]
---
# [[Internet Access Technologies]]

**Context:** [[FIT1047_MOC]] · how an end user's device physically joins an [[Internet Structure and Governance|ISP]] and becomes part of the Internet · the "last mile" technologies

> [!abstract] Quick Revision
> - **🎯 Objective:** end user makes a **physical** connection to an ISP ➔ ISP **authenticates**, **assigns an IP**, and tells the device its **router + DNS** ➔ device can send/receive packets.
> - **⚡ Key Constraint:** know each technology's medium + rough speed and the two key acronyms — **ADSL is asymmetric** (more download than upload, ends at a **DSLAM**); **NBN** uses a **GPON** fibre backbone with several last-mile options.

## 📝 Access basics
- **Physical connection** ➔ to the ISP network via ADSL / NBN / 4G etc.
- **ISP steps** ➔ **authenticate** (security + billing) → **assign an IP address** → inform the device of the **router IP and DNS servers** → device becomes **part of the Internet**.

## 🔌 The four technologies
### 1. Dial-up modem
- **Mod**ulator / **Dem**odulator ➔ converts **digital data ↔ analog "sound"** sent over the telephone copper voice band.
- **Speed** ➔ max **54 kbit/s** (occupies the phone line — no simultaneous calls).

### 2. ADSL (Asymmetric Digital Subscriber Line)
- **Compromise** ➔ reuse existing **telephone copper** but use the **full bandwidth** (0–1104 kHz), not just the 4 kHz voice band.
- **Frequency split** ➔ 0–4 kHz **voice**, ~25–138 kHz **upstream**, ~138–1104 kHz **downstream** → split into **4 kHz sub-bands** ("247 modems"); bad channels are simply dropped.
- **Asymmetric** ➔ far more **download** than upload (upload limited by **crosstalk/noise at the DSLAM**); up to **~24 Mbps**.
- **Setup** ➔ a **filter** (splitter) separates voice + data at the home; the line runs to the **DSLAM (DSL Access Multiplexer)** — modem + switch — at the telephone exchange.
- **Last mile** ➔ the **most expensive** part of rollout (an individual cable to every customer).
- **Extensions** ➔ **VDSL** (cancels DSLAM crosstalk, up to ~100 Mbps); **Fibre-to-the-Node (FTTN)** shortens the copper run (node <1 km away).

### 3. NBN (National Broadband Network, Australia)
- **Backbone** ➔ fibre-optic **GPON (Gigabit Passive Optical Network)** — uses **unpowered optical splitters** (cheaper, more reliable; downstream broadcast).
- **Customer connections** ➔ **Fibre-to-the-Premises (FTTP)**, **FTTN/curb** (+VDSL/HFC), **fixed wireless (LTE)**, **satellite** (remote).
- **Wholesale model** ➔ NBN owns/operates the network; **Retail Service Providers (RSPs)** sell to customers via **~121 Points of Interconnect (PoI)**; the customer end is a **Network Termination Device (NTU)**.

### 4. Mobile data (4G / 5G)
- **Cellular** ➔ ISP-operated antennas split an area into **cells** (few hundred m in cities → up to 100 km rural); **seamless roaming** between cells; **IP-based**.
- **4G** ➔ frequencies ~450 MHz–5 GHz; ~**100 Mbit/s** (theoretical up to 1 Gbit/s).
- **5G** ➔ up to **10 Gbit/s** (usually ~1 Gbit/s); **higher frequencies (24–54 GHz)** → more bandwidth but **shorter range → smaller cells**; aims: fast + **low-latency, reliable**, massive device counts (**[[Internet of Things (IoT)|IoT]]**); competes with fixed NBN.
- **Growth** ➔ mobile is ~**⅓ of Internet traffic**, driven by smartphone apps + video.

## ⚠️ Common Mistakes
- 💡 **"Asymmetric" = the A in ADSL** ➔ download bandwidth ≫ upload; the asymmetry is caused by **crosstalk at the DSLAM**, not a marketing choice.
- 💡 **DSLAM vs filter** ➔ the **filter/splitter** is at the *home* (separates voice+data); the **DSLAM** is at the *exchange* (aggregates many lines). Don't swap them.
- 💡 **Higher 5G frequency ⇒ shorter range** ➔ more bandwidth but needs **more, smaller cells** — a direct physics trade-off.

## 🧠 Active Recall
> [!FAQ]- Why did ADSL win the early broadband market despite fibre being faster?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **last mile** is the most expensive part of any rollout, and ADSL **reused the copper telephone cables already installed to every home**, avoiding new cabling.
> > - **Why:** **Full-bandwidth reuse** ➔ ADSL exploits the whole 0–1104 kHz range of existing copper (splitting into 4 kHz sub-bands) instead of laying fibre to each premises.
