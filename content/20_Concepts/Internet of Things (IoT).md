---
unit: FIT1047
domain: F
week: [9, 12]
parent: "[[Internet Structure and Governance]]"
tags: [CS/Networks, CS/Internet, CS/Security]
aliases: [IoT, Internet of Things, ZigBee, LoRaWAN, Mirai, Dyn DDoS, smart devices, device-to-device]
---
# [[Internet of Things (IoT)]]

**Context:** [[FIT1047_MOC]] · billions of small **devices** connected to the Internet — a possible future direction · enabling tech + its security problem

> [!abstract] Quick Revision
> - **🎯 Objective:** shift from the **traditional** Internet (humans → services) to **device-to-device** communication among everyday objects (home automation, sensors, smart vehicles).
> - **⚡ Key Constraint:** "**the S in IoT stands for Security**" — cheap mass-market devices that **expose an interface to the Internet** often ship with **no basic security**, making them easy targets (see the **Mirai / Dyn** attack).

## 📝 Core
- **Traditional vs IoT** ➔ traditional = **humans using client devices** to access services; IoT = **all kinds of devices connected**, talking device-to-device.
- **Applications** ➔ home automation (lights/heating/alarms), energy (smart meters/grid), environmental + medical sensors, smart cars/trains/planes, integrated manufacturing.
- **Enabling technologies** ➔ **cheap capable processors** (CPU+RAM+ROM+WiFi+I/O on a ~\$2 chip); **IPv6** (every device needs an IP, easy grouping into networks); **low-power wireless** (**Bluetooth, ZigBee, LoRaWAN, WiFi**).
- **Scale** ➔ tens of billions of connected devices; impressive growth.

## 🔒 Security in the IoT
- **Cheap + exposed** ➔ mass-market devices must be cheap, yet must **expose an interface to the Internet** (e.g. to switch lights remotely) → often **no basic security** → **easy target for hackers**.
- **2016 Dyn DDoS** ➔ attack on **Dyn's DNS servers** made major sites (Twitter, Amazon, Spotify, Reddit) unreachable across the US/Europe.
- **Mirai botnet** ➔ infected IoT devices (routers, IP cameras, baby monitors) by trying **~60 default user/password combos** (`admin`/`admin`, `root`/`password`…), then **spread** and awaited instructions — a simple attack on weak defaults.

## ⚠️ Common Mistakes
- 💡 **DNS was the target, IoT was the weapon** ➔ in the Dyn attack the **botnet** was IoT devices; the **victim** was DNS infrastructure. Losing this distinction misreads the incident.
- 💡 **Default credentials = the vulnerability** ➔ Mirai needed no exploit, just **unchanged factory passwords** — the practical lesson for IoT security.

## 🧠 Active Recall
> [!FAQ]- Why are IoT devices such a favourite target for building botnets?
> > [!SUCCESS]- Answer
> > - **Short answer:** they are **cheap, numerous, and Internet-exposed**, yet frequently ship with **default credentials and no basic security**, so a simple password-guessing attack (like **Mirai**) compromises huge numbers of them.
> > - **Why:** **Weak defaults at scale** ➔ millions of always-on devices with identical factory logins give an attacker a massive, easily-recruited army for a **DDoS** (e.g. against Dyn's DNS).
