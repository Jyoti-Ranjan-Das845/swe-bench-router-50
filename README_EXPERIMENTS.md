# SWE-Bench Router Challenge - Experiment Results

## What is This?

This folder contains the complete results of running three language models (GLM-5.2, Claude Opus-5, Claude Haiku-4.5) on the SWE-bench Lite benchmark. The goal was to test how well each model can fix real GitHub issues across 50 software engineering tasks.

---

## Folder Structure

### `input/`
- **selected_instance_ids.txt** - List of 50 fixed task IDs used for the benchmark

### `config/`
- **glm_5_2.yaml** - Configuration for GLM-5.2 model
- **claude_opus_5.yaml** - Configuration for Claude Opus-5 model
- **claude_haiku_45.yaml** - Configuration for Claude Haiku-4.5 model
- **priority1_*.yaml** - Configs for focused retest runs

### `runs/`
Output from all model runs:
- **glm_5_2/** - GLM full run (50 instances)
- **claude_opus_5/** - Opus full run (43 instances completed)
- **claude_haiku_45_retest/** - Haiku's first evaluation (2 instances)
- **claude_opus_5_retest/** - Opus retest (2 instances)
- **glm_5_2_retest/** - GLM retest (2 instances)
- **claude_opus_5_priority1/** - Opus focused run (1 instance)
- **glm_5_2_priority1_*/** - GLM focused runs (2 instances)
- **claude_haiku_45_priority1/** - Haiku focused run (1 instance)

Each directory contains:
- `preds.json` - Model patches for each instance
- `{instance_id}/` subdirectories with `{instance_id}.traj.json` (execution trace)

### `logs/run_evaluation/`
Official SWE-bench evaluation results:
- **claude_vs_glm_38_official/** - GLM evaluation on 38 paired instances
- **claude_opus_5_38_official/** - Opus evaluation on 38 paired instances
- **claude_haiku_45_retest/** - Haiku retest evaluation
- **claude_retest_official/** - Opus retest evaluation
- **glm_retest_official/** - GLM retest evaluation
- **priority1_*_official/** - Priority 1 evaluation results

Each contains instance-specific `report.json` files showing pass/fail results.

---

## The Three Runs

### RUN1: Full Benchmark (Aug 7, 2026)
**What:** Run models on 50 fixed instances
- GLM-5.2: 50/50 completed (49 valid patches)
- Opus-5: 43/50 completed (38 valid patches)

**Evaluation:** Used same 38 paired instances for fair comparison
- Opus: **32/38 resolved (84.2%)**
- GLM: **28/38 resolved (73.7%)**

**Files:** 
- See [PHASE_INSTANCE_TRACKING.md](PHASE_INSTANCE_TRACKING.md)
- See [PHASE_RESULTS_SUMMARY.md](PHASE_RESULTS_SUMMARY.md)

---

### RUN2: Retest (Aug 9-10, 2026)
**What:** Rerun 4 most informative instances to check for stochasticity

**Instances tested:**
- Group 1: django__django-11019, django__django-14155 (Opus failed, GLM passed)
- Group 2: django__django-11848, scikit-learn__scikit-learn-25638 (Haiku test)

**Key Finding:** 
- **django__django-14155**: Opus FAILED → PASSED (stochastic!)
- **scikit-learn__scikit-learn-25638**: Haiku PASSED → FAILED (stochastic!)

**Files:** 
- See [PHASE_INSTANCE_TRACKING.md](PHASE_INSTANCE_TRACKING.md)
- See [PHASE_RESULTS_SUMMARY.md](PHASE_RESULTS_SUMMARY.md)

---

### RUN3: Priority 1 (Aug 10, 2026)
**What:** Fresh runs on 3 unique instances (4 model-task runs) to verify stochasticity patterns

**Instances tested:** 3 unique instances, 4 model-task runs
- Opus on django__django-11019 (check consistent failure)
- GLM on django__django-11848, scikit-learn__scikit-learn-25638
- Haiku on scikit-learn__scikit-learn-25638

**Result:** 0 resolved across all 4 runs

**Files:** 
- See [PHASE_INSTANCE_TRACKING.md](PHASE_INSTANCE_TRACKING.md)
- See [PHASE_RESULTS_SUMMARY.md](PHASE_RESULTS_SUMMARY.md)

---

## Key Files to Read

1. **[PHASE_INSTANCE_TRACKING.md](PHASE_INSTANCE_TRACKING.md)**
   - Which instances were run in each phase
   - Links to patches and evaluation results

2. **[PHASE_RESULTS_SUMMARY.md](PHASE_RESULTS_SUMMARY.md)**
   - Pass/fail numbers for each model
   - Stochastic instances identified
   - Summary statistics

3. **[MINI_SWE_AGENT_RUNS.md](MINI_SWE_AGENT_RUNS.md)**
   - How each run was executed
   - Configurations used (all identical across phases)
   - Command format and parameters

---

## Quick Summary

| Model | RUN1 Score | Best Instance | Worst Instance |
|-------|-----------|----------------|-----------------|
| **Opus** | 32/38 (84.2%) | Strong across diverse tasks | django__django-11019 (consistent failure) |
| **GLM** | 28/38 (73.7%) | Good at specific problem types | Multiple sympy instances |
| **Haiku** | - | django__django-11848 | scikit-learn__scikit-learn-25638 (stochastic) |

## Stochastic Behavior Found

Some models produce inconsistent results on specific instances:
- **django__django-14155**: Opus sometimes solves it, sometimes doesn't
- **scikit-learn__scikit-learn-25638**: Haiku passed once, failed twice

This suggests model performance on certain tasks is probabilistic, not deterministic.

---

## How to Use This Data

- **To understand which instances we tested:** Read PHASE_INSTANCE_TRACKING.md
- **To see final pass/fail numbers:** Read PHASE_RESULTS_SUMMARY.md
- **To see model patches:** Check `runs/*/preds.json` files
- **To see execution details:** Check `runs/*/*/traj.json` trajectory files
- **To see official test results:** Check `logs/run_evaluation/*/report.json` files

---

## Repository Contents & Coverage

**Committed to this branch (complete):**
- ✅ RUN1 baseline results: GLM (28/38), Opus (32/38) on 38 paired instances
- ✅ RUN1 Haiku Phase 0: 2/8 on 8 disagreement instances (8 trajectory files, patches, logs)
- ✅ RUN2 retest results: All model patches, trajectories, and evaluation logs
- ✅ RUN3 priority1 results: All model patches, trajectories, and evaluation logs
- ✅ All model configurations (base configs + priority1 configs)
- ✅ Complete evaluation harness and benchmark configs

**All files in git:**
- 627 total files tracked in remote repository

**Model coverage:**
- **Opus/GLM:** Full 50-instance run (38 paired instances used for comparison)
- **Haiku:** Selected tasks only (8 disagreement tasks initially, then 4 retest/priority tasks)

---

## Contact/Notes

- All models accessed via OpenRouter API
- Docker used for isolated test environments (SWE-bench official harness)
- Total cost: ~$50 for all runs
- Benchmark version: SWE-bench Lite (50-instance subset)
- Mini-SWE-Agent version: 2.4.6
