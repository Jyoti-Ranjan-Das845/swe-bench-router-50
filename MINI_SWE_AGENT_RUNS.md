# Mini-SWE-Agent Runs Documentation

## Configuration Files Used

### RUN1, RUN2, RUN3 - Same Base Configs (No Changes)

All phases used identical base configuration files:

#### GLM-5.2 Configuration
**File:** `config/glm_5_2.yaml`
```yaml
model:
  model_name: "z-ai/glm-5.2"
environment:
  pull_timeout: 900
```

**Used in:** RUN1 (50 instances), RUN2 (2 instances), RUN3 (2 instances)

---

#### Claude Opus-5 Configuration
**File:** `config/claude_opus_5.yaml`
```yaml
model:
  model_name: "anthropic/claude-opus-5"
environment:
  pull_timeout: 900
```

**Used in:** RUN1 (43 instances), RUN2 (2 instances), RUN3 (1 instance)

---

#### Claude Haiku-4.5 Configuration
**File:** `config/claude_haiku_45.yaml`
```yaml
model:
  model_name: anthropic/claude-haiku-4.5
  model_kwargs:
    drop_params: true
    parallel_tool_calls: true
  set_cache_control: default_end
  cost_tracking: default
agent:
  step_limit: 250
  cost_limit: 1.0
  wall_time_limit_seconds: 0
```

**Used in:** RUN2 (2 instances), RUN3 (1 instance)

---

### Benchmark Configuration
**File:** `vendor/mini-swe-agent/src/minisweagent/config/benchmarks/swebench.yaml`

- Universal benchmark config used for all runs
- Defines agent behavior, environment (Docker), model templates
- Version: 2.4.6

---

## RUN Summary

### RUN1 (Aug 7, 2026)
**Command Format:**
```bash
mini-extra swebench \
  --subset data/SWE-bench_Lite \
  --split test \
  --filter "^(instance1|instance2|...)$" \
  --output runs/{model_name} \
  --workers 1 \
  --model-class openrouter \
  --config vendor/mini-swe-agent/src/minisweagent/config/benchmarks/swebench.yaml \
  --config config/{model}.yaml
```

**Runs Executed:**
- GLM-5.2: 50 instances → `runs/glm_5_2/`
- Claude Opus-5: 43 instances (50 attempted) → `runs/claude_opus_5/`

**Config Changes:** None

---

### RUN2 (Aug 9-10, 2026)
**Retest on 4 Most Informative Instances**

**Runs Executed:**
- GLM-5.2: django__django-11019, django__django-14155 → `runs/glm_5_2_retest/`
- Claude Opus-5: django__django-11019, django__django-14155 → `runs/claude_opus_5_retest/`
- Claude Haiku-4.5: django__django-11848, scikit-learn__scikit-learn-25638 → `runs/claude_haiku_45_retest/`

**Config Changes:** None (Haiku config added but same across all Haiku runs)

---

### RUN3 (Aug 10, 2026)
**Priority 1 - Fresh Focused Runs**

**Runs Executed:**
- GLM-5.2: django__django-11848, scikit-learn__scikit-learn-25638
  - Output: `runs/glm_5_2_priority1_11848/`, `runs/glm_5_2_priority1_25638/`
- Claude Opus-5: django__django-11019
  - Output: `runs/claude_opus_5_priority1/`
- Claude Haiku-4.5: scikit-learn__scikit-learn-25638
  - Output: `runs/claude_haiku_45_priority1/`

**Priority1 Config Files (Created but identical to base configs):**
- `config/priority1_opus_11019.yaml` - Same as `claude_opus_5.yaml`
- `config/priority1_glm_11848.yaml` - Same as `glm_5_2.yaml`
- `config/priority1_glm_25638.yaml` - Same as `glm_5_2.yaml`
- `config/priority1_haiku_25638.yaml` - Same as `claude_haiku_45.yaml`

**Config Changes:** None (Only added instance filter in config files)

---

## Configuration Analysis

### Key Points

✅ **Base Configurations Remained Identical Across All Phases**
- GLM config: Unchanged (2 lines)
- Opus config: Unchanged (2 lines)
- Haiku config: Unchanged (13 lines)

✅ **Benchmark Configuration**
- Used same `swebench.yaml` for all runs
- Mini-SWE-Agent version: 2.4.6

✅ **Model Parameters**
- GLM: Model name only + environment timeout
- Opus: Model name only + environment timeout
- Haiku: Extended with model_kwargs, agent limits, cost limits

⚠️ **Environment Settings**
- All models: `pull_timeout: 900` seconds (15 minutes for Docker image pull)
- Haiku: `step_limit: 250`, `cost_limit: 1.0`

✅ **Instance Filtering**
- Implemented via regex filter in command line
- Not changed in config files across phases
- Priority1 configs used same filtering approach

---

## Execution Details

### Mini-SWE-Agent Command Invocation

**Used:** `mini-extra swebench` (not `mini-swe-agent run`)

**Reason:** Official SWE-bench evaluation harness entry point for batch evaluation

**Components:**
- Model Selection: via `-config` flag (claude_opus_5.yaml, glm_5_2.yaml, etc.)
- Instance Selection: via `--filter` flag with regex pattern
- Output: via `--output` flag to separate directories per run
- Workers: `--workers 1` (sequential execution)
- Model Class: `openrouter` (via OpenRouter API)

---

## Summary

| Aspect | Status |
|--------|--------|
| Config Changes Across Phases | ✅ None |
| Base Configs Consistent | ✅ Yes |
| Benchmark Config | ✅ Same (swebench.yaml) |
| Mini-SWE-Agent Version | ✅ 2.4.6 (all runs) |
| API Provider | ✅ OpenRouter (all runs) |

**Conclusion:** All three runs used identical configurations with only instance IDs varying per run. Config stability ensures reproducibility and fair comparison.
