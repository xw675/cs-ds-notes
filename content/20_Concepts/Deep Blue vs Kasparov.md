---
unit: FIT1061
week: 2
source: [lecture, applied]
parent: "[[Turing Test (Imitation Game)]]"
tags: [CS/AI, Ethics/AI]
type: argument
aliases: [Deep Blue, Kasparov 1997, Does How Matter]
---
# [[Deep Blue vs Kasparov]]

**Context:** [[FIT1061_MOC]] · the W2 milestone and Kialo motion — the first machine win judged by *result*, argued over by *method* · the case that stresses [[Turing Test (Imitation Game)]] and [[The AI Effect (Defining AI)]]
**What it weighs:** whether a victory counts as intelligence because of **what it achieved** or because of **how it was produced**.

> [!abstract] Quick Revision
> - **🎯 Test question:** *When an AI wins, does it matter how?* — the $150$–$250$ word reflective response, and the Kialo motion **"Deep Blue's win tells us nothing about intelligence."**
> - **⚠️ Key Constraint:** a verdict without the **machinery** named earns nothing ➔ say *brute-force tree search over $\approx2\times10^8$ positions/s with a hand-tuned evaluator*, then judge that, not "a computer".

## 📝 Core Commitments
- **The facts you argue from** ➔ 1997-05-11, Game 6: Kasparov resigns after $19$ moves, match lost $2.5$–$3.5$. IBM, over a decade, $\approx\$10$M; began as Feng-hsiung Hsu's CMU PhD ("ChipTest", 1985). $30$ processors $+$ $480$ special-purpose chess chips, $\approx2\times10^8$ positions/s.
- **The mechanism** ➔ no intuition, no experience, no learning ➔ it **searched** ([[Search Problem Formulation]]), evaluated the leaves, picked the best reachable outcome. Same skeleton as [[Uninformed Search (BFS and DFS)]], plus a heuristic evaluator and pruning.
- **Behavioural rule** ➔ judge only the observable output; the machinery is off-limits by design — Turing's whole move was to replace "can it think" with a performance test.
- **Mechanist rule** ➔ judge the process; a result produced by exhaustive enumeration is a statement about **hardware and search**, not about understanding.
- **What each refuses to count** ➔ the behavioural rule refuses "but it's only search" as evidence; the mechanist rule refuses the scoreboard as evidence.
- **The deflation trap** ➔ the moment chess fell, chess stopped counting as intelligence ([[The AI Effect (Defining AI)]]) ➔ any purely mechanist verdict must answer why the goalpost moved *after* the result.
- **Hsu's framing** ➔ *"The computer doesn't play chess like a human, any more than an airplane flies like a bird."* ➔ concedes the mechanism differs and denies that this diminishes the achievement.

## ⚖️ Framework Contrast
| Position | Test applied to Deep Blue | Verdict it reaches | Where it breaks down |
| :--- | :--- | :--- | :--- |
| **Behavioural** (Turing's substitution) | did it produce grandmaster-beating play under fair conditions? | intelligent — the output is what was ever testable | licenses a lookup table of every position as "intelligent" |
| **Mechanist** ("only search") | what machinery produced the moves? | not intelligence — enumeration plus an evaluator | the same objection dissolves human cognition into neurochemistry |
| **AI-effect deflation** | is the task still hard *now*? | not intelligence — chess is solved-ish, so it never counted | unfalsifiable: no achievement can ever survive the test |

## 🧩 Case Application Drill
> [!QUESTION]- Case 1: The Kialo motion — "Deep Blue's win tells us nothing about intelligence."
> > [!SUCCESS]- Model verdict
> > - **Duty-holder / claim-maker:** IBM, which staged the match as a scientific milestone and marketed the result.
> > - **Framework applied:** the mechanist rule fires cleanly on *this* machinery — depth-limited search plus a hand-tuned evaluator, zero learning, zero transfer; the same program cannot play draughts, let alone route a car.
> > - **Verdict:** the win tells us little about **general** intelligence and a great deal about **search**: that a well-pruned tree plus $2\times10^8$ positions/s outperforms the best human pattern recognition in a bounded, perfect-information domain. The strongest counter is behavioural — that "it's only search" is exactly the objection Turing pre-empted, since we grant humans intelligence without inspecting their machinery. Answer it by bounding the claim to *general* intelligence rather than denying the achievement.
> > - **Debate note:** W2 Kialo — citing is **optional** this week (expected in W7 and W11); the graded move is prompt → response → counter-argument → reply, so the counter-position must be engaged, not listed.

> [!QUESTION]- Case 2: Game 2, move 36 (Be4) — the move Kasparov could not explain, that an IBM engineer later attributed to a software bug producing a random move when the machine could not decide.
> > [!SUCCESS]- Model verdict
> > - **Stakeholders:** Kasparov (who read creativity into it and alleged human intervention), IBM (which refused a rematch and dismantled the machine), and everyone downstream who cannot now check.
> > - **Framework applied:** the behavioural rule is **falsified by its own success here** — the move looked intelligent precisely because the observer could not see the mechanism, and the mechanism turned out to be a coin flip.
> > - **Verdict:** attributing intelligence from behaviour alone is unsafe when the observer cannot audit the process; the case is the strongest available argument that *how* matters. Note the asymmetry that keeps it honest: a bug explains one anomalous move, not a $3.5$–$2.5$ match.
> > - **What it costs:** IBM dismantled Deep Blue and split the hardware between the Smithsonian and the Computer History Museum ➔ **the experiment is unrepeatable**, which is the reproducibility failure the unit's *how does it work* refrain exists to prevent.

> [!QUESTION]- Case 3: In 2026 a phone runs Stockfish at $\approx10^7$ nodes/s, Elo $\approx3500$, and beats Deep Blue (Elo $\approx2850$) comfortably — on $20\times$ **fewer** positions per second.
> > [!SUCCESS]- Model verdict
> > - **Framework applied:** the mechanist rule, turned productively — compare the machinery, not the scoreboard.
> > - **Verdict:** hardware shrank but that is not why the phone is stronger; it searches **fewer** positions and wins, so the gain is **algorithmic** — better pruning, better evaluation, better move ordering. The 1997 result was a hardware milestone; the 2026 result is the argument that strategy beats scale, which is exactly why the unit spends W3–W5 on heuristics rather than on faster loops.

## ⚠️ Common Mistakes
- 💡 **Retelling the match** ➔ the dates, the $19$ moves and the accusation are *evidence*, not an argument; every fact cited must be attached to a claim about intelligence.
- 💡 **Asserting a verdict with no rival named** ➔ the response is graded on engaging the counter-position; "it was just brute force" without the Turing objection answered is half an argument.
- 💡 **Sliding the goalposts silently** ➔ if the verdict is "chess never counted", say so and defend it against [[The AI Effect (Defining AI)]] — otherwise the position is unfalsifiable.
