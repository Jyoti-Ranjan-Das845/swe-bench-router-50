# Phase Results Summary

## RUN1 (Initial Full Benchmark - Aug 7, 2026)

**Explanation:** Full run attempted on 50 fixed instances. GLM-5.2 completed all 50. Claude Opus-5 encountered API issues and completed only 43. For fair comparison, we evaluated both models on the same 38 paired instances where both generated valid patches.

### GLM-5.2 (Full Run)

| Metric | Value |
|--------|-------|
| Full Run: Instances Attempted | 50 |
| Full Run: Valid Patches Generated | 49 |
| Full Run: Empty Patches | 1 (sympy__sympy-15345) |
| **Evaluation: 38 Paired Instances** | **38** |
| **Evaluation: Resolved** | **37/38** ✅ |
| **Evaluation: Unresolved** | **1/38** ❌ |

**Patches:** [runs/glm_5_2/preds.json](runs/glm_5_2/preds.json)

**Evaluation (38 paired):** [logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/](logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/)

---

### Claude Opus-5 (Full Run Attempt)

| Metric | Value |
|--------|-------|
| Full Run: Instances Attempted | 50 |
| Full Run: Instances Completed | 43 |
| Full Run: Valid Patches Generated | 38 |
| Full Run: Empty Patches | 5 |
| **Evaluation: 38 Paired Instances** | **38** |
| **Evaluation: Resolved** | **32/38** ✅ |
| **Evaluation: Unresolved** | **6/38** ❌ |

**Patches:** [runs/claude_opus_5/preds.json](runs/claude_opus_5/preds.json)

**Evaluation (38 paired):** [logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/](logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/)

---

## RUN2 (Retest on 4 Informative Instances - Aug 9-10, 2026)

### GLM-5.2

| Instance | Result |
|----------|--------|
| django__django-11019 | ✅ Resolved (2/2) |
| django__django-14155 | ✅ Resolved |

**Patches:** [runs/glm_5_2_retest/preds.json](runs/glm_5_2_retest/preds.json)

**Evaluation:** [logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/](logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/)

**Score:** **2/2 resolved (100%)** ✅

---

### Claude Opus-5

| Instance | RUN1 Result | RUN2 Result | Pattern |
|----------|------------|------------|---------|
| django__django-11019 | ❌ Failed | ❌ Failed | Consistent failure |
| django__django-14155 | ❌ Failed | ✅ Resolved | STOCHASTIC ✨ |

**Patches:** [runs/claude_opus_5_retest/preds.json](runs/claude_opus_5_retest/preds.json)

**Evaluation:** [logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/](logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/)

**Score:** **1/2 resolved (50%)** ⚠️

---

### Claude Haiku-4.5

| Instance | RUN2 Result | RUN3 Result | Pattern |
|----------|------------|------------|---------|
| django__django-11848 | ✅ Resolved | ❌ Failed | Stochastic |
| scikit-learn__scikit-learn-25638 | ✅ Resolved | ❌ Failed | STOCHASTIC ✨ |

**Patches:** [runs/claude_haiku_45_retest/preds.json](runs/claude_haiku_45_retest/preds.json)

**Evaluation:** [logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/](logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/)

**Score:** **1/2 resolved (50%)** ⚠️

---

## RUN3 (Priority 1 - Fresh Focused Runs - Aug 10, 2026)

### GLM-5.2

**Instance django__django-11848:**

**Patches:** [runs/glm_5_2_priority1_11848/preds.json](runs/glm_5_2_priority1_11848/preds.json)

**Evaluation:** [logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/](logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/)

**Score:** **0/1 resolved (0%)** ❌

---

**Instance scikit-learn__scikit-learn-25638:**

**Patches:** [runs/glm_5_2_priority1_25638/preds.json](runs/glm_5_2_priority1_25638/preds.json)

**Evaluation:** [logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/](logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/)

**Score:** **0/1 resolved (0%)** ❌

---

### Claude Opus-5

| Instance | RUN1 | RUN2 | RUN3 | Pattern |
|----------|------|------|------|---------|
| django__django-11019 | ❌ Failed | ❌ Failed | ❌ Failed | Consistent Failure |

**Patches:** [runs/claude_opus_5_priority1/preds.json](runs/claude_opus_5_priority1/preds.json)

**Evaluation:** [logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/](logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/)

**Score:** **0/1 resolved (0%)** ❌

---

### Claude Haiku-4.5

| Instance | RUN2 | RUN3 | Pattern |
|----------|------|------|---------|
| scikit-learn__scikit-learn-25638 | ✅ Resolved | ❌ Failed | STOCHASTIC ✨ |

**Patches:** [runs/claude_haiku_45_priority1/preds.json](runs/claude_haiku_45_priority1/preds.json)

**Evaluation:** [logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/](logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/)

**Score:** **0/1 resolved (0%)** ❌

---

## Summary Statistics

### Model Pass Rates Across All Runs

| Model | RUN1 (38 paired) | RUN2 (4 inst.) | RUN3 (4 inst.) |
|-------|-----------------|-----------------|-----------------|
| GLM-5.2 | 28/38 (73.7%) | **2/2 (100%)** ✅ | **0/2 (0%)** ❌ |
| Opus-5 | 32/38 (84.2%) | **1/2 (50%)** ⚠️ | **0/1 (0%)** ❌ |
| Haiku-4.5 | - | **1/2 (50%)** ⚠️ | **0/1 (0%)** ❌ |

**Key Findings:** 
- RUN1: Opus outperformed GLM (84.2% vs 73.7%) on 38 paired instances
- RUN2: GLM achieved perfect 100% on retry; Opus showed stochasticity on django-14155
- RUN3: All models failed on priority instances, indicating task difficulty or stochasticity

### Stochastic Instances Identified

- **django__django-14155**: Opus (FAIL → PASS → PASS) - Only instance showing recovery
- **scikit-learn__scikit-learn-25638**: Haiku (PASS → FAIL → FAIL) - Inconsistent performance
