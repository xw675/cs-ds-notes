---
unit: FIT1061
week: 1
source: [lecture]
parent: "[[FIT1061_MOC]]"
tags: [CS/AI]
aliases: [AI Effect, Is It AI?]
type: argument
---
# [[The AI Effect (Defining AI)]]

**Context:** [[FIT1061_MOC]] · why the unit drops the label and classifies by algorithm instead — the successor move to [[Turing Test (Imitation Game)]]
**What it weighs:** whether "AI" picks out any stable property of a system, or only its novelty at the moment of asking.

> [!abstract] Quick Revision
> - **🎯 Test question:** does calling this system "AI" change anything you can predict about it?
> - **⚠️ Key Constraint:** the boundary is **not a property of the system** ➔ answer "is it AI?" by naming the machinery and the failure mode, never by defending a label.

## 📝 Core Commitments
- **McCarthy's definition** ➔ 1956, coining the term: *"AI is the science of making machines do things that would require intelligence if done by humans."* ➔ keyed to task difficulty **for humans**, not to any machinery.
- **The AI effect** ➔ McCarthy again: *"As soon as it works, no one calls it AI anymore."* ➔ the label tracks unfamiliarity, so every success removes a system from the category.
- **Restated 70 years on** ➔ Narayanan & Kapoor, *AI Snake Oil* (2024): *"AI is whatever hasn't been done yet."*
- **The boundary sits nowhere** ➔ spellcheck was AI in the 1980s and is not now while doing the identical thing; Roomba plans but never learns; AlphaFold solved a 50-year-old open problem yet reads as "not AI" to most people because it does not converse.
- **What the label refuses to track** ➔ novelty, conversational surface and marketing move it; capability, mechanism and risk do not.
- **The unit's resolution** ➔ classify by the question the algorithm answers ➔ [[AI Algorithm Blocks (Search, Uncertainty, Learning)]]; "intelligent" and "AI" are used as history, never as definitions.

## ⚖️ AI Boundary Spectrum
*(The ten W1 systems. The columns separate cleanly; the label does not.)*

| System | Machinery as taught | Learns from data? | Plans / searches? | Unit block |
| :--- | :--- | :--- | :--- | :--- |
| Mechanical thermostat | bimetallic coil tilts a mercury switch — no code at all | ✗ | ✗ | — |
| Nest learning thermostat | updates internal parameters from your behaviour | ✓ | ✗ | C (W10–11) |
| Google Maps routing | shortest path on a graph; algorithm published 1959 | ✗ | ✓ | A (W2–5) |
| Word spellcheck | dictionary lookup + edit distance to nearest match | ✗ | ✗ | — *(was AI in the 1980s)* |
| Spam filter | estimates $P(\text{spam} \mid \text{words})$ from past examples | ✓ | ✗ | B (W7) |
| Roomba | maps the room, plans a path — never learns | ✗ | ✓ | A |
| Tesla Autopilot | camera + deep network steers | ✓ | ✗ | C (W11) |
| AlphaFold | predicts 3D protein structure; 2024 Nobel | ✓ | ✗ | C (W10) |
| COMPAS recidivism score | $137$ inputs → risk score, used in US courts | ✓ | ✗ | B (W9) |
| LLM writing the lecture notes | next-token prediction, gradient-trained, agent-wrapped | ✓ | ✓ | A + B + C |

> [!NOTE] **When It Flips:** nothing in the two capability columns moves when the label does ➔ the label is tracking the calendar, not the machine.

## 🧩 Case Application Drill
> [!QUESTION]- Case 1: your bank markets its fraud detector as "AI-powered". A colleague insists it is "just statistics". Settle it.
> > [!SUCCESS]- Model verdict
> > - **Claim on trial:** that "AI" vs "just statistics" is a factual disagreement about the system.
> > - **Framework applied:** under McCarthy the task qualifies (a human analyst spotting fraud would need judgement); under the AI effect it stops qualifying the moment it ships and works. Both verdicts follow from the *label's* rules, not the detector's.
> > - **Verdict:** the disagreement is unresolvable **and unimportant**. The answerable questions are: it estimates $P(\text{fraud} \mid \text{features})$ from past labelled cases (Block B), it fails on fraud patterns absent from its training data, and it affects the customers it freezes out. Marketing pressure pushes the label up; the AI effect pushes it back down.
> > - **Counter-position answered:** "the label matters for regulation" ➔ then the regulation must name the machinery and the affected population, exactly because the label is a moving target.

> [!QUESTION]- Case 2: spellcheck was uncontroversially AI in the 1980s and is uncontroversially not AI today. Its algorithm never changed. What changed?
> > [!SUCCESS]- Model verdict
> > - **Claim on trial:** that the category "AI" tracks a property of systems.
> > - **Framework applied:** McCarthy's own observation — the category is defined relative to what machines are *not yet known* to do.
> > - **Verdict:** the expectations changed, not the system. Dictionary lookup plus edit distance was a machine doing something only careful humans did; once ubiquitous, it became "how spellcheck works". This is the AI effect in its cleanest form and it is why the unit indexes by algorithm.
> > - **Counter-position answered:** "so today's LLMs will stop being AI too" ➔ on this evidence, yes — which is precisely the argument for describing the machinery instead.

## ⚠️ Common Mistakes
- 💡 **Defending the label** ➔ arguing whether a system "really is AI" answers nothing; state the machinery, the failure mode, and who it affects.
- 💡 **Conversational bias** ➔ treating chat interfaces as the criterion, which misclassifies AlphaFold and Google Maps while flattering any chatbot.
- 💡 **McCarthy quoted flat** ➔ citing his 1956 definition without his own later retraction misses that he named the instability himself.
