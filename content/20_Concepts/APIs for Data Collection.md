---
unit: FIT1043
week: 3
parent: "[[Data Sources and Open Data]]"
tags: [DataScience/DataSources, WebDev/API]
aliases: [API, REST API, RESTful API]
---
# [[APIs for Data Collection]]

**Context:** [[FIT1043_MOC]] · how to reach **new** [[Data Sources and Open Data|data sources]] programmatically · one of the best ways to gather data for a project

> [!abstract] Quick Revision
> - **🎯 Objective:** access an application's data/functionality **by code** ➔ a computer-facing interface (not a human UI).
> - **⚡ Key Constraint:** the consumer↔provider split — you (consumer) request from a provider's API, usually needing a **key** (sign-up/auth).

## 📝 Core
- **API (Application Programmer Interface)** ➔ routines giving **programmatic** access to an application or its data; like a UI but for **computers**.
- **Machine-to-machine** ➔ programs talk to each other to access data/services (e.g. Google Maps).
- **Consumer vs provider** ➔ the **provider** exposes the API; the **consumer** calls it.
- **REST API** ➔ the common web style; e.g. **OpenWeather** — sign up, verify email, copy an **API key**, then call it from Python.
- **Rich metadata** ➔ e.g. Twitter/X exposes users, follower networks, locations, hashtags, emojis; real-time tweet filtering via the streaming API; multi-language client libraries.
- **Widespread** ➔ Facebook, Twitter/X, LinkedIn, Google Maps, YouTube, Amazon Advertising, TripAdvisor.

## ⚠️ Common Mistakes
- 💡 **An API is for computers, not people** ➔ it returns structured data (often JSON/XML) for code, not a rendered web page.
- 💡 **Keys and policies apply** ➔ most providers require a key and enforce a developer policy / rate limits; you're a consumer of *their* service.

## 🧠 Active Recall
> [!FAQ]- What is an API, and how do the consumer and provider roles differ?
> > [!SUCCESS]- Answer
> > - **Short answer:** An API is a computer-facing interface giving programmatic access to an application's data/functionality; the provider exposes it, the consumer calls it (often with an API key), commonly as a REST API.
> > - **Why:** **Machine-to-machine** ➔ programs exchange structured data (e.g. OpenWeather returning weather JSON) instead of a human loading a web page.
