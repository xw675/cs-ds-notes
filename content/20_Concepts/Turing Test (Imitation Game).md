---
unit: FIT1061
week: 1
source: [lecture]
parent: "[[FIT1061_MOC]]"
tags: [CS/AI]
aliases: [Imitation Game]
type: argument
---
# [[Turing Test (Imitation Game)]]

**Context:** [[FIT1061_MOC]] · the unit's opening criterion — and the one it abandons in [[The AI Effect (Defining AI)]]
**What it weighs:** whether a judge can *reliably* separate machine from human through text alone ➔ behaviour only, never machinery.

> [!abstract] Quick Revision
> - **🎯 Test question:** after a fixed text-only conversation, can the judge tell which respondent is the machine?
> - **⚠️ Key Constraint:** a pass is evidence about the **judge's discrimination**, not the machine's understanding ➔ never cite "fooled $33\%$" without naming the format (duration, topic breadth, persona).

## 📝 Core Commitments
- **Refuses the question** ➔ Turing (1950, *Computing Machinery and Intelligence*) calls "can machines think?" too vague to answer and **substitutes a game** instead of defining thinking.
- **Operationalisation is the contribution** ➔ unanswerable metaphysical question ⟹ testable behavioural one.
- **The setup** ➔ three players — human judge · human respondent · machine respondent; text-only channel (teletype); Turing's suggested budget $\approx 5$ minutes.
- **The criterion** ➔ judge cannot *reliably* identify the machine ⟹ "for any practical purpose, the machine thinks".
- **What it refuses to count** ➔ architecture, memory, understanding ➔ a $200$-line pattern matcher and a $100$B-parameter model are judged on identical evidence.
- **ELIZA effect** ➔ the projection runs from human to machine, not the reverse; Weizenbaum (1976): *"extremely short exposures to a relatively simple computer program could induce powerful delusional thinking in quite normal people."*
- **Suitcase word** ➔ Mitchell (2019) — "intelligence" packs pattern recognition, abstract reasoning, language, social judgement, embodied skill, planning, creativity and self-awareness into one label, so every verdict silently drops most of them.
- **Where it lands** ➔ once the test is passed on general fluency, "can machines think?" collapses into *what does thinking mean?*

## ⚖️ Framework Contrast
| Criterion | Test applied to a system | Verdict it tends to reach | Where it breaks down |
| :--- | :--- | :--- | :--- |
| **Turing test** (behavioural) | can a judge distinguish it from a human by text? | passed in the broad sense by 2022–25 LLMs | says nothing about mechanism ➔ ELIZA-grade tricks and general fluency score alike |
| **[[The AI Effect (Defining AI)\|McCarthy task definition]]** | would the task require intelligence *if a human did it*? | almost everything qualifies, briefly | the label retreats as soon as the system works |
| **Mitchell suitcase decomposition** | *which* capacity — reasoning, planning, social judgement? | "intelligent at X, not at Y" | gives no single yes/no, so headlines ignore it |
| **[[AI Algorithm Blocks (Search, Uncertainty, Learning)\|FIT1061 algorithmic move]]** | which of the three questions does the algorithm answer? | classifies the machinery, declines the label | answers "how does it work", not "does it think" |

## 🧩 Case Application Drill
> [!QUESTION]- Case 1: Weizenbaum's secretary watched him build ELIZA, knew it was $200$ lines of pattern-matching, and still asked to be left alone with it. Does this show ELIZA thinks?
> > [!SUCCESS]- Model verdict
> > - **Claim on trial:** being convincing to a user $\Rightarrow$ passing the test.
> > - **Framework applied:** the imitation game requires a *judge actively discriminating* between two respondents; she was not judging — she knew which was the machine and engaged anyway.
> > - **Verdict:** no pass, and no evidence of thinking. ELIZA had no model of conversation, no memory across turns, and merely rearranged the input into a question; the DOCTOR script's Rogerian persona turns every input back into a question, doing the work the machine cannot.
> > - **Counter-position answered:** "but the effect was real" ➔ yes, and it is a fact about **human projection** (the ELIZA effect), which is exactly why behavioural evidence needs format controls.

> [!QUESTION]- Case 2: 2014 headlines — "Turing test passed". Eugene Goostman fooled $33\%$ of judges in five-minute chats. Evaluate the claim.
> > [!SUCCESS]- Model verdict
> > - **Claim on trial:** $33\%$ deception in $5$ minutes $\Rightarrow$ the criterion is met.
> > - **Framework applied:** "cannot *reliably* tell" needs a format where failure is attributable to the machine — open topic, adequate duration, no excuse structure.
> > - **Verdict:** rejected. The persona (a $13$-year-old non-native English speaker) is an excuse generator — every knowledge gap and grammatical failure is pre-explained — and five minutes caps how far any judge can probe. The experts' response: *"that's not the test we meant."*
> > - **Counter-position answered:** Turing himself named five minutes ➔ he named it as a suggestion in $1950$, not as a threshold immune to adversarial persona design.

> [!QUESTION]- Case 3: GPT-3.5 holds $30$-minute conversations most users cannot place; GPT-4 scores top $10\%$ on the US bar exam; o1 and R1 solve olympiad-level mathematics. Has the test been passed?
> > [!SUCCESS]- Model verdict
> > - **Claim on trial:** the $2022$–$25$ systems meet Turing's criterion.
> > - **Framework applied:** the pass here comes from **general fluency across open topics**, not from a narrow persona or a scripted domain — so the Case 2 objections do not apply.
> > - **Verdict:** yes, in the broad sense. And the pass settles nothing: it retires the *test*, not the question, because the suitcase never got unpacked.
> > - **Counter-position answered:** "then machines think" ➔ only under Turing's own hedge, *for any practical purpose*; the substitution was never a definition, so a pass cannot license a claim about understanding.

## ⚠️ Common Mistakes
- 💡 **Headline as evidence** ➔ quoting a deception percentage without the format conditions; the persona and the clock usually did the work, not the machine.
- 💡 **Test read as definition** ➔ Turing explicitly declined to define thinking, so "it passed, therefore it understands" imports a claim he refused to make.
- 💡 **Unpacked suitcase** ➔ asserting a system "is / is not intelligent" without naming *which* capacity is being claimed.
