# DevOps for AI-ML Systems · Free Live Sessions

Ship models like code: reproducible, safely containerized, and gated on every push

Free, live, 30-minute sessions with **Dr. Emmanuel Naweji** ([Transformed 2 Succeed](https://transformed2succeed.com)).
This course is presented on **Week 2, Thursday at 7:30 PM Central** of a 4-week rotation (8 courses, every Monday and Thursday).
This repo holds the slides, the recording of every live session, and the notes and links from each one.

## Session recordings

| Date | Recording | Notes |
|---|---|---|
| _First session coming soon_ | | |
<!-- sessions:end -->

## What the session covers

1. **Ship the Model Like Code**: Pin the seed, write a receipt per model, catch a silent data change with git.
2. **Pack It Once**: Containerize the model, find a secret hiding in your own image, and fix it.
3. **No Green, No Ship**: Build a pipeline with a quality gate, watch it block a bad model, run it on GitHub.

## Three things to remember

- **Same inputs, same model**: Module 1: pin code, data, params, environment. A receipt for every model.
- **Pack it once. Run it anywhere.**: Module 2: a safe container. Nothing secret in the box, not root, tagged by commit.
- **No green, no ship**: Module 3: test, train, gate, build on every push. Red means nothing ships.

## Try it yourself

Clone the course lab repo: [devops-for-ai-ml](https://github.com/Here2ServeU/devops-for-ai-ml)

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

## Slides

[`slides/04_DevOps_for_AI_ML_Systems_Free_Live_Session.pptx`](slides/04_DevOps_for_AI_ML_Systems_Free_Live_Session.pptx): the presenter deck, with full speaker notes.

## Free live session schedule (Mondays and Thursdays, 7:30 PM Central)

| Week | Day | Course |
|---|---|---|
| Week 1 | Monday | [Linux for AI-ML Systems](https://github.com/Here2ServeU/live-linux-for-ai-ml) |
| Week 1 | Thursday | [Python for AI-ML](https://github.com/Here2ServeU/live-python-for-ai-ml) |
| Week 2 | Monday | [Zero to AI-ML Systems Engineering](https://github.com/Here2ServeU/live-zero-to-ai-ml) |
| Week 2 | Thursday | **DevOps for AI-ML Systems** (this repo) |
| Week 3 | Monday | [SRE for AI-ML Systems](https://github.com/Here2ServeU/live-sre-for-ai-ml) |
| Week 3 | Thursday | [GPU Optimization for AI-ML Systems](https://github.com/Here2ServeU/live-gpu-optimization-for-ai-ml) |
| Week 4 | Monday | [FinOps for AI-ML Systems](https://github.com/Here2ServeU/live-finops-for-ai-ml) |
| Week 4 | Thursday | [AI Agent Operations](https://github.com/Here2ServeU/live-ai-agent-operations) |

## Want all of it?

The membership gives you **all 8 courses, every module and every lab, for $49/month**, plus a live session every month where we build something together.
Join at **https://transformed2succeed.com**.

---

### For the presenter: logging a session

After each live session, run:

```bash
bash scripts/new-session.sh 2026-11-03 "https://link-to-the-recording"
git add -A && git commit -m "Session 2026-11-03" && git push
```

This creates `sessions/2026-11-03.md` from the template (fill in the Q&A and links) and adds a row to the recordings table above.
