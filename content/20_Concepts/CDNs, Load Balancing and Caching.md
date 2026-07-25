---
unit: FIT1047
week: 9
parent: "[[Internet Structure and Governance]]"
tags: [CS/Networks, CS/Internet]
aliases: [CDN, Content Delivery Network, load balancing, DNS load balancing, content caching, cache engine, point of presence, why the internet still works]
---
# [[CDNs, Load Balancing and Caching]]

**Context:** [[FIT1047_MOC]] · how huge services stay fast even though the Internet's base protocols weren't built for this scale · "why the Internet still works"

> [!abstract] Quick Revision
> - **🎯 Objective:** three techniques keep big services fast ➔ **load balancing** (spread requests over many servers), **caching** (store data closer to users), **CDNs** (both, at global scale).
> - **⚡ Key Constraint:** the base protocols (**HTTP, TCP/IP, BGP**) were **not designed** for billions of users and low-latency apps; load balancing alone only solves the *server* side — you also need content **physically close** to users (a CDN).

## 📝 The problem
- **Growth** ➔ not just more hosts, but greater **distance**; modern apps (video, streaming, web) need **low latency**; services have millions–billions of users.
- **Base protocols weren't designed for this** ➔ HTTP/TCP-IP/BGP scale poorly on their own — yet the Internet still works because of the techniques below.

## ⚖️ Load balancing
- **Why** ➔ one server can't handle the load (e.g. Google ~40k searches/s; Netflix ~10.2 Tbps avg) → **spread over many servers**.
- **DNS-based** ➔ one host name **maps to multiple IPs**; different users resolve to **different (often nearer) servers** — e.g. `www.google.com` resolves to different IPs / RTTs from Monash vs Optus vs Germany.
- **Dedicated hardware** ➔ a **load balancer** sits in front, accepts all requests, and routes each to a back-end server.

## 🗄️ Content caching
- **Idea** ➔ store web data (pages, images) **closer to users**; can be **transparent** — a router on the path queries a **cache engine**; if content is present **and not expired**, serve it locally.
- **HTTP support** ➔ **GET** requests are cacheable; HTTP headers carry an **`Expires:`** field; the cache serves only **unexpired GET** responses.
- **Benefit** ➔ reduces duplicate data transfer over long links.

## 🌐 Content Delivery Networks (CDNs)
- **Why (beyond load balancing)** ➔ load balancing distributes requests **once they arrive**, but requests/responses still cross the whole Internet → CDNs put content **near the user**.
- **How** ➔ operate servers in **many locations**, run their **own high-bandwidth network**, place **points of presence** close to end users (combination of load balancing + caching).
- **CDNs and peering** ➔ CDNs sit **at IXPs** and **peer for free**; small ISPs avoid paying upstream for popular content (e.g. **Netflix peers with Australian ISPs → "unmetered" access**); network inefficiencies aren't blamed on the content provider. See [[Internet Structure and Governance|peering]].

## ⚠️ Common Mistakes
- 💡 **Load balancing ≠ CDN** ➔ load balancing only spreads load **within** your data centre; a **CDN** also gets the content **geographically near** the user (caching + distributed servers).
- 💡 **Only GET is cacheable** ➔ POST/side-effecting requests must not be cached; caches respect the **`Expires:`** header to avoid serving stale data.

## 🧠 Active Recall
> [!FAQ]- The Internet's core protocols weren't designed for billions of users — why does it still deliver low-latency video?
> > [!SUCCESS]- Answer
> > - **Short answer:** engineering layers **on top** of the base protocols compensate — **load balancing** spreads demand across many servers, and **CDNs** cache content at **points of presence physically close to users**, cutting distance and latency.
> > - **Why:** **Distance is the killer** ➔ DNS-based load balancing routes users to nearby servers, and CDN peering at **IXPs** keeps popular content one short hop away instead of crossing the globe.
