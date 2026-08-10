# SWE-Bench Router Challenge - Phase Instance Tracking

## RUN1: Baseline

**All 50 fixed instances:** [input/selected_instance_ids.txt](input/selected_instance_ids.txt)

The 50-task subset was fixed before model execution. GLM produced 49 non-empty patches; Opus produced 38. The common evaluation set is the 38-instance intersection with non-empty patches from both models, recorded in [common_completed_instances.txt](common_completed_instances.txt).

### GLM-5.2

- **Run output:** [runs/glm_5_2/](runs/glm_5_2/)
- **Official evaluation:** [logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/](logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/)
- **Result:** 37/49 resolved in the full official evaluation; 28/38 resolved on the common set.

### Claude Opus-5

- **Run output:** [runs/claude_opus_5/](runs/claude_opus_5/)
- **Official evaluation:** [logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/](logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/)
- **Result:** 32/38 resolved on the common set.

## Phase 0: Haiku on RUN1 Disagreements

**Instances:** the eight RUN1 disagreement tasks: `django__django-11019`, `django__django-11848`, `django__django-14155`, `django__django-14667`, `matplotlib__matplotlib-23987`, `scikit-learn__scikit-learn-10949`, `scikit-learn__scikit-learn-25638`, and `sphinx-doc__sphinx-7686`.

- **Run output:** [runs/claude_haiku_45/](runs/claude_haiku_45/)
- **Official evaluation:** [logs/run_evaluation/claude_haiku_45_8instances_official/anthropic__claude-haiku-4.5/](logs/run_evaluation/claude_haiku_45_8instances_official/anthropic__claude-haiku-4.5/)
- **Result:** 2/8 resolved.

## RUN2: Retests

### GLM-5.2

**Instances:** `django__django-11019`, `django__django-14155`

- **Run output:** [runs/glm_5_2_retest/](runs/glm_5_2_retest/)
- **Official evaluation:** [logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/](logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/)
- **Result:** 2/2 resolved.

### Claude Opus-5

**Instances:** `django__django-11019`, `django__django-14155`

- **Run output:** [runs/claude_opus_5_retest/](runs/claude_opus_5_retest/)
- **Official evaluation:** [logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/](logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/)
- **Result:** 1/2 resolved. `django__django-14155` changed from unresolved in RUN1 to resolved in RUN2.

### Claude Haiku-4.5

**Instances:** `django__django-11848`, `scikit-learn__scikit-learn-25638`

- **Run output:** [runs/claude_haiku_45_retest/](runs/claude_haiku_45_retest/)
- **Official evaluation:** [logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/](logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/)
- **Result:** 1/2 resolved. `scikit-learn__scikit-learn-25638` changed from resolved in Phase 0 to unresolved in RUN2.

## RUN3: Focused Follow-up

### GLM-5.2

**Instances:** `django__django-11848`, `scikit-learn__scikit-learn-25638`

- **Run outputs:** [django-11848](runs/glm_5_2_priority1_11848/), [scikit-learn-25638](runs/glm_5_2_priority1_25638/)
- **Official evaluations:** [django-11848](logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/), [scikit-learn-25638](logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/)
- **Result:** 0/2 resolved.

### Claude Opus-5

**Instance:** `django__django-11019`

- **Run output:** [runs/claude_opus_5_priority1/](runs/claude_opus_5_priority1/)
- **Official evaluation:** [logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/](logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/)
- **Result:** 0/1 resolved.

### Claude Haiku-4.5

**Instance:** `scikit-learn__scikit-learn-25638`

- **Run output:** [runs/claude_haiku_45_priority1/](runs/claude_haiku_45_priority1/)
- **Official evaluation:** [logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/](logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/)
- **Result:** 0/1 resolved.

The changed results in RUN2 are run-to-run variability observations, not task-difficulty labels.
