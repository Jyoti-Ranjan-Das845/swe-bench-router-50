# Phase Results Summary

All resolved/unresolved figures below are taken from the linked official SWE-bench evaluator reports.

## RUN1: Baseline

The experiment attempted the same fixed 50 Lite test instances for GLM-5.2 and Claude Opus-5. GLM generated 49 non-empty patches and Opus generated 38. The paired set is the [38-instance intersection](common_completed_instances.txt) with non-empty patches from both models.

### GLM-5.2

| Metric | Value |
|---|---:|
| Fixed instances attempted | 50 |
| Non-empty patches generated | 49 |
| Empty patches | 1 (`sympy__sympy-15345`) |
| Full official evaluation | 37/49 resolved; 12/49 unresolved |
| Paired 38-task evaluation | 28/38 resolved; 10/38 unresolved |

**Patches:** [runs/glm_5_2/preds.json](runs/glm_5_2/preds.json)
**Official evaluation (49 patches):** [GLM evaluator reports](logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/)

### Claude Opus-5

| Metric | Value |
|---|---:|
| Fixed instances attempted | 50 |
| Instances completed | 43 |
| Non-empty patches generated | 38 |
| Empty patches | 5 |
| Paired 38-task evaluation | 32/38 resolved; 6/38 unresolved |

**Patches:** [runs/claude_opus_5/preds.json](runs/claude_opus_5/preds.json)
**Official evaluation (38 paired patches):** [Opus evaluator reports](logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/)

### Paired 38-Task Outcome

| Outcome | Tasks |
|---|---:|
| Both resolved | 26 |
| Opus only | 6 |
| GLM only | 2 |
| Neither resolved | 4 |

The eight disagreements are the six Opus-only and two GLM-only tasks. They were used for the Phase 0 Haiku check.

### Claude Haiku-4.5: Phase 0 on Eight Disagreements

| Instance | Result |
|---|---|
| `django__django-11019` | Unresolved |
| `django__django-11848` | Resolved |
| `django__django-14155` | Unresolved |
| `django__django-14667` | Unresolved |
| `matplotlib__matplotlib-23987` | Unresolved |
| `scikit-learn__scikit-learn-10949` | Unresolved |
| `scikit-learn__scikit-learn-25638` | Resolved |
| `sphinx-doc__sphinx-7686` | Unresolved |

**Score:** 2/8 resolved (25%)
**Patches:** [runs/claude_haiku_45/preds.json](runs/claude_haiku_45/preds.json)
**Official evaluation:** [Haiku Phase 0 evaluator reports](logs/run_evaluation/claude_haiku_45_8instances_official/anthropic__claude-haiku-4.5/)

---

## RUN2: Focused Retests

### GLM-5.2

| Instance | Result |
|---|---|
| `django__django-11019` | Resolved |
| `django__django-14155` | Resolved |

**Score:** 2/2 resolved
**Patches:** [runs/glm_5_2_retest/preds.json](runs/glm_5_2_retest/preds.json)
**Official evaluation:** [GLM RUN2 evaluator report](logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/report.json)

### Claude Opus-5

| Instance | RUN1 | RUN2 |
|---|---|---|
| `django__django-11019` | Unresolved | Unresolved |
| `django__django-14155` | Unresolved | Resolved |

**Score:** 1/2 resolved
**Patches:** [runs/claude_opus_5_retest/preds.json](runs/claude_opus_5_retest/preds.json)
**Official evaluation:** [Opus RUN2 evaluator report](logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/report.json)

### Claude Haiku-4.5

| Instance | Phase 0 | RUN2 |
|---|---|---|
| `django__django-11848` | Resolved | Resolved |
| `scikit-learn__scikit-learn-25638` | Resolved | Unresolved |

**Score:** 1/2 resolved
**Patches:** [runs/claude_haiku_45_retest/preds.json](runs/claude_haiku_45_retest/preds.json)
**Official evaluation:** [Haiku RUN2 evaluator report](logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/report.json)

---

## RUN3: Focused Follow-up

| Model | Instance | Result | Evaluation |
|---|---|---|---|
| GLM-5.2 | `django__django-11848` | Unresolved | [report](logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/report.json) |
| GLM-5.2 | `scikit-learn__scikit-learn-25638` | Unresolved | [report](logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/report.json) |
| Claude Opus-5 | `django__django-11019` | Unresolved | [report](logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/report.json) |
| Claude Haiku-4.5 | `scikit-learn__scikit-learn-25638` | Unresolved | [report](logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/report.json) |

All four RUN3 model-task runs were unresolved.

---

## Observed Histories for the Four Follow-up Tasks

| Instance | Observed result history |
|---|---|
| `django__django-11019` | Opus: unresolved in RUN1, RUN2, and RUN3; GLM: resolved in RUN1 and RUN2; Haiku: unresolved in Phase 0. |
| `django__django-14155` | Opus: unresolved in RUN1, resolved in RUN2; GLM: resolved in RUN1 and RUN2; Haiku: unresolved in Phase 0. |
| `django__django-11848` | Opus: resolved in RUN1; GLM: unresolved in RUN1 and RUN3; Haiku: resolved in Phase 0 and RUN2. |
| `scikit-learn__scikit-learn-25638` | Opus: resolved in RUN1; GLM: unresolved in RUN1 and RUN3; Haiku: resolved in Phase 0, then unresolved in RUN2 and RUN3. |

The changed results for Opus on `django__django-14155` and Haiku on `scikit-learn__scikit-learn-25638` show run-to-run variability. These limited reruns do not establish general reliability or a task-complexity label.
