# SWE-Bench Router Challenge - Phase Instance Tracking

## RUN1 (Initial Full Benchmark - Aug 7, 2026)

**All 50 Fixed Instances:** See [input/selected_instance_ids.txt](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/input/selected_instance_ids.txt)

**Note on Results:**
The initial benchmark was designed to run 50 fixed instances from SWE-bench Lite. GLM-5.2 completed all 50 instances successfully (49 valid patches, 1 empty). Claude Opus-5 encountered API credit issues and completed only 43 instances (38 valid patches, 5 empty). We identified 38 instances where BOTH models successfully generated valid patches. These 38 instances form the common evaluation set for comparing model performance.

**38 Common Instances (Both Models):**
astropy__astropy-6938, django__django-11019, django__django-11179, django__django-11848, django__django-12589, django__django-12708, django__django-13265, django__django-13551, django__django-13757, django__django-13933, django__django-14155, django__django-14667, django__django-14752, django__django-16041, django__django-16046, django__django-16400, django__django-16408, django__django-16527, django__django-16820, matplotlib__matplotlib-22711, matplotlib__matplotlib-23913, matplotlib__matplotlib-23987, matplotlib__matplotlib-24970, psf__requests-2674, pydata__xarray-3364, pylint-dev__pylint-7228, pytest-dev__pytest-5103, pytest-dev__pytest-7490, pytest-dev__pytest-8365, scikit-learn__scikit-learn-10949, scikit-learn__scikit-learn-13241, scikit-learn__scikit-learn-25638, sphinx-doc__sphinx-10451, sphinx-doc__sphinx-7686, sphinx-doc__sphinx-8721, sympy__sympy-12171, sympy__sympy-13480, sympy__sympy-13895, sympy__sympy-14024, sympy__sympy-14317, sympy__sympy-15345, sympy__sympy-16792, sympy__sympy-20049

---

### GLM-5.2 (Run1)

**Instances:** 50 total

**Patches Storage:** [runs/glm_5_2/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/glm_5_2/)

**Evaluation Results:** [logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/claude_vs_glm_38_official/z-ai__glm-5.2/)

**Summary:** 49 valid patches (1 empty: sympy__sympy-15345) | 37/38 resolved on common instances

---

### Claude Opus-5 (Run1)

**Instances:** 43 completed (50 attempted)

**Patches Storage:** [runs/claude_opus_5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/claude_opus_5/)

**Evaluation Results:** [logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/claude_opus_5_38_official/anthropic__claude-opus-5/)

**Summary:** 38 valid patches (5 empty) | 32/38 resolved on common instances

---

## RUN2 (Retest on 4 Most Informative Instances - Aug 9-10, 2026)

**Group 1 - Claude Failed, GLM Passed (2 instances):**
- django__django-11019
- django__django-14155

**Group 2 - Claude Passed, GLM Failed, Haiku Passed (2 instances):**
- django__django-11848
- scikit-learn__scikit-learn-25638

---

### GLM-5.2 (Run2)

**Instances:**
- django__django-11019
- django__django-14155

**Patches Storage:** [runs/glm_5_2_retest/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/glm_5_2_retest/)

**Evaluation Results:** [logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run2_glm_retest/z-ai__glm-5.2/)

**Score:** 2/2 resolved (100%)

**Summary:** Retest to verify consistency

---

### Claude Opus-5 (Run2)

**Instances:**
- django__django-11019
- django__django-14155

**Patches Storage:** [runs/claude_opus_5_retest/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/claude_opus_5_retest/)

**Evaluation Results:** [logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run2_opus_retest/anthropic__claude-opus-5/)

**Score:** 1/2 resolved (50%) - django-14155 showed stochasticity (FAIL → PASS)

**Summary:** Retest to verify consistency

---

### Claude Haiku-4.5 (Run2)

**Instances:**
- django__django-11848
- scikit-learn__scikit-learn-25638

**Patches Storage:** [runs/claude_haiku_45_retest/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/claude_haiku_45_retest/)

**Evaluation Results:** [logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run2_haiku_retest/anthropic__claude-haiku-4.5/)

**Score:** 1/2 resolved (50%) - scikit-learn-25638 showed stochasticity (PASS → FAIL)

**Summary:** First evaluation on these instances to test stochasticity

---

## RUN3 (Priority 1 - Fresh Focused Runs - Aug 10, 2026)

### GLM-5.2 (Run3)

**Instances:**
- django__django-11848
- scikit-learn__scikit-learn-25638

**Patches Storage:** 
- [runs/glm_5_2_priority1_11848/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/glm_5_2_priority1_11848/)
- [runs/glm_5_2_priority1_25638/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/glm_5_2_priority1_25638/)

**Evaluation Results:**
- [logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run3_glm_priority1_11848/z-ai__glm-5.2/)
- [logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run3_glm_priority1_25638/z-ai__glm-5.2/)

**Score:** 0/2 resolved (0%)

---

### Claude Opus-5 (Run3)

**Instances:**
- django__django-11019

**Patches Storage:** [runs/claude_opus_5_priority1/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/claude_opus_5_priority1/)

**Evaluation Results:** [logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run3_opus_priority1/anthropic__claude-opus-5/)

**Score:** 0/1 resolved (0%)

---

### Claude Haiku-4.5 (Run3)

**Instances:**
- scikit-learn__scikit-learn-25638

**Patches Storage:** [runs/claude_haiku_45_priority1/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/runs/claude_haiku_45_priority1/)

**Evaluation Results:** [logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/](/Users/dzen/Spaces/exps/swebenchtest/swe-bench-repo/logs/run_evaluation/run3_haiku_priority1/anthropic__claude-haiku-4.5/)

**Score:** 0/1 resolved (0%)
