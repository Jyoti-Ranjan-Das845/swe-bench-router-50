# SWE-Bench Router Challenge - Experiment Results

## What Is This?

This folder contains the results of running GLM-5.2, Claude Opus-5, and Claude Haiku-4.5 with mini-SWE-agent on a fixed 50-task subset of the SWE-bench Lite test split.

---

## Folder Structure

### `input/`

- [selected_instance_ids.txt](input/selected_instance_ids.txt) — the fixed 50 task IDs.

### `config/`

- [glm_5_2.yaml](config/glm_5_2.yaml) — GLM-5.2 base configuration.
- [claude_opus_5.yaml](config/claude_opus_5.yaml) — Claude Opus-5 base configuration.
- [claude_haiku_45.yaml](config/claude_haiku_45.yaml) — Claude Haiku-4.5 base configuration.
- [priority1_*.yaml](config/) — focused-run configuration files.

### `runs/`

Model patches and trajectories:

- [glm_5_2/](runs/glm_5_2/) — GLM baseline run (50 attempted; 49 non-empty patches).
- [claude_opus_5/](runs/claude_opus_5/) — Opus baseline run (43 completed; 38 non-empty patches).
- [claude_haiku_45/](runs/claude_haiku_45/) — Haiku Phase 0 run on the eight baseline disagreement instances.
- [glm_5_2_retest/](runs/glm_5_2_retest/), [claude_opus_5_retest/](runs/claude_opus_5_retest/), and [claude_haiku_45_retest/](runs/claude_haiku_45_retest/) — RUN2 retests.
- [claude_opus_5_priority1/](runs/claude_opus_5_priority1/), [glm_5_2_priority1_11848/](runs/glm_5_2_priority1_11848/), [glm_5_2_priority1_25638/](runs/glm_5_2_priority1_25638/), and [claude_haiku_45_priority1/](runs/claude_haiku_45_priority1/) — RUN3 focused runs.

Each run directory contains `preds.json` and, where present, per-instance `.traj.json` execution traces.

### `logs/run_evaluation/`

Official SWE-bench evaluation artifacts:

- [GLM baseline evaluation](logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/) — 49 non-empty GLM baseline patches. The paired analysis uses the 38 IDs shared with Opus.
- [Opus baseline evaluation](logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/) — the 38 paired baseline patches.
- [Haiku Phase 0 evaluation](logs/run_evaluation/claude_haiku_45_8instances_official/anthropic__claude-haiku-4.5/) — eight baseline disagreement instances.
- RUN2: [GLM](logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/), [Opus](logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/), and [Haiku](logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/).
- RUN3: [GLM on django-11848](logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/), [GLM on scikit-learn-25638](logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/), [Opus](logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/), and [Haiku](logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/).

The per-instance `report.json` files are the source of the resolved/unresolved results reported below.

---

## Runs and Results

### RUN1: Baseline

The fixed 50-task set was selected before model execution. GLM produced 49 non-empty patches; Opus produced 38. The paired comparison is the 38-task intersection with non-empty patches from both models.

| Model | Official evaluator result | Paired 38-task result |
|---|---:|---:|
| GLM-5.2 | 37/49 resolved | 28/38 resolved (73.7%) |
| Claude Opus-5 | 32/38 resolved | 32/38 resolved (84.2%) |

### Phase 0: Haiku on the Eight Baseline Disagreements

Haiku resolved 2/8 disagreement instances. The runs and evaluations are linked above; this was not a 38- or 50-task Haiku baseline.

### RUN2: Focused Retests

RUN2 re-ran four informative instances:

- GLM and Opus: `django__django-11019`, `django__django-14155`
- Haiku: `django__django-11848`, `scikit-learn__scikit-learn-25638`

`django__django-14155` changed from an Opus baseline failure to an Opus retest success. `scikit-learn__scikit-learn-25638` changed from a Haiku Phase 0 success to a Haiku RUN2 failure. These are observations of run-to-run variability.

### RUN3: Focused Follow-up

RUN3 made four model-task runs on three instances: Opus on `django__django-11019`; GLM on `django__django-11848` and `scikit-learn__scikit-learn-25638`; and Haiku on `scikit-learn__scikit-learn-25638`. None resolved.

---

## Key Documents

1. [PHASE_INSTANCE_TRACKING.md](PHASE_INSTANCE_TRACKING.md) — instances, run membership, and direct artifact links.
2. [PHASE_RESULTS_SUMMARY.md](PHASE_RESULTS_SUMMARY.md) — evaluator-derived results and follow-up histories.
3. [MINI_SWE_AGENT_RUNS.md](MINI_SWE_AGENT_RUNS.md) — recorded mini-SWE-agent configuration and command details.

## Repository Notes

- Models were accessed through OpenRouter.
- Docker provided isolated SWE-bench evaluation environments.
- mini-SWE-agent version recorded in trajectories: 2.4.6.
- The benchmark input is a fixed 50-task subset of SWE-bench Lite, not the complete Lite test split.
