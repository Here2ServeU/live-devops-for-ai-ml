# DevOps for AI-ML Systems · Free Live Sessions

Ship models like code: reproducible, safely containerized, and gated on every push

**Free · Live · 30 minutes · Mondays and Thursdays, 7:30 PM Central** · with Dr. Emmanuel Naweji ([Transformed 2 Succeed](https://transformed2succeed.com))

### [Register free on Zoom](https://us06web.zoom.us/meeting/register/fT235rLjQaihJYrWj2_vjw)

Register once and you're in for every session. Zoom emails you the join link and reminders. Bring your questions: every session ends with live Q&A.

## When this course is live

- Thu, Nov 12, 2026 · 7:30–8:00 PM Central
- Thu, Dec 10, 2026 · 7:30–8:00 PM Central
- Thu, Jan 7, 2027 · 7:30–8:00 PM Central
- Thu, Feb 4, 2027 · 7:30–8:00 PM Central
- Thu, Mar 4, 2027 · 7:30–8:00 PM Central
- Thu, Apr 1, 2027 · 7:30–8:00 PM Central
- Thu, Apr 29, 2027 · 7:30–8:00 PM Central
- Thu, May 27, 2027 · 7:30–8:00 PM Central

## Watch the recordings

Missed a session or want to watch it again? Recordings are added here after each live session.

| Date | Recording |
|---|---|
| _Coming after the first session_ | |

## Download the slides

**[04_DevOps_for_AI_ML_Systems_Free_Live_Session.pdf](slides/04_DevOps_for_AI_ML_Systems_Free_Live_Session.pdf)** (PDF)

## What you'll learn

1. **Ship the Model Like Code**: Pin the seed, write a receipt per model, catch a silent data change with git.
2. **Pack It Once**: Containerize the model, find a secret hiding in your own image, and fix it.
3. **No Green, No Ship**: Build a pipeline with a quality gate, watch it block a bad model, run it on GitHub.

## Three things to remember

- **Same inputs, same model**: Module 1: pin code, data, params, environment. A receipt for every model.
- **Pack it once. Run it anywhere.**: Module 2: a safe container. Nothing secret in the box, not root, tagged by commit.
- **No green, no ship**: Module 3: test, train, gate, build on every push. Red means nothing ships.

## Try it yourself

Get the hands-on labs here: [devops-for-ai-ml](https://github.com/Here2ServeU/devops-for-ai-ml)

**Module 1 · Ship the Model Like Code**: Pin the seed. Train twice. Commit.

```bash
sed -i 's/"seed": null/"seed": 42/' params.json && git diff
python3 src/train.py && python3 src/train.py
git commit -am "pin seed for reproducible training"
python3 src/train.py && cat model/card.json
```

**Module 2 · Pack It Once**: The key lines of a good model image

```bash
FROM python:3.12-slim
COPY src/ src/
COPY model/ model/
USER appuser
```

**Module 3 · No Green, No Ship**: Watch the gate block a bad model

```bash
bash pipeline.sh
bash .lab/break_it.sh && git log --oneline -1
bash pipeline.sh; echo "exit code: $?"
git revert --no-edit HEAD && bash pipeline.sh | tail -3
```

## All free live sessions

A different course every session. The rotation repeats every 4 weeks, so if you miss one, it comes back around.

| Week | Day | Course | First session |
|---|---|---|---|
| Week 1 | Monday | [Linux for AI-ML Systems](https://github.com/Here2ServeU/live-linux-for-ai-ml) | Mon, Nov 2, 2026 |
| Week 1 | Thursday | [Python for AI-ML](https://github.com/Here2ServeU/live-python-for-ai-ml) | Thu, Nov 5, 2026 |
| Week 2 | Monday | [Zero to AI-ML Systems Engineering](https://github.com/Here2ServeU/live-zero-to-ai-ml) | Mon, Nov 9, 2026 |
| Week 2 | Thursday | **DevOps for AI-ML Systems** (you are here) | Thu, Nov 12, 2026 |
| Week 3 | Monday | [SRE for AI-ML Systems](https://github.com/Here2ServeU/live-sre-for-ai-ml) | Mon, Nov 16, 2026 |
| Week 3 | Thursday | [GPU Optimization for AI-ML Systems](https://github.com/Here2ServeU/live-gpu-optimization-for-ai-ml) | Thu, Nov 19, 2026 |
| Week 4 | Monday | [FinOps for AI-ML Systems](https://github.com/Here2ServeU/live-finops-for-ai-ml) | Mon, Nov 23, 2026 |
| Week 4 | Thursday | [AI Agent Operations](https://github.com/Here2ServeU/live-ai-agent-operations) | Thu, Nov 26, 2026 |

## Want the full course?

The membership gives you **all 8 courses, every module and every lab, for $49/month**, plus a live session every month where we build something together.

**[Join at transformed2succeed.com](https://transformed2succeed.com)**
