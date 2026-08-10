# Mini-SWE-Agent Runs Documentation

## Recorded Execution Setup

The trajectories record mini-SWE-agent version **2.4.6**. All runs used `mini-extra swebench`, OpenRouter, one worker, and the same SWE-bench benchmark configuration supplied by the installed mini-SWE-agent. That benchmark YAML is installed at run time; it is not copied into this repository.

The effective settings were consistent within each model across its baseline and follow-up runs. They were not identical across all three models.

| Model | Base configuration | Step limit | Cost ceiling per task | Command timeout | Recorded pull timeout |
|---|---|---:|---:|---:|---:|
| GLM-5.2 | [glm_5_2.yaml](config/glm_5_2.yaml) | 250 | $3 | 60 s | 900 s |
| Claude Opus-5 | [claude_opus_5.yaml](config/claude_opus_5.yaml) | 250 | $3 | 60 s | 900 s |
| Claude Haiku-4.5 | [claude_haiku_45.yaml](config/claude_haiku_45.yaml) | 250 | $1 | 60 s | 120 s |

`parallel_tool_calls` was enabled in the recorded configurations. The cost values above are ceilings, not measured API cost.

## Configuration Files

### Baseline Configurations

- [glm_5_2.yaml](config/glm_5_2.yaml) selects `z-ai/glm-5.2` and a 900-second image-pull timeout.
- [claude_opus_5.yaml](config/claude_opus_5.yaml) selects `anthropic/claude-opus-5` and a 900-second image-pull timeout.
- [claude_haiku_45.yaml](config/claude_haiku_45.yaml) selects `anthropic/claude-haiku-4.5`, enables `parallel_tool_calls`, sets cache control, and explicitly sets the 250-step/$1 agent limits.

### Focused-Run Configurations

- [priority1_glm_11848.yaml](config/priority1_glm_11848.yaml), [priority1_glm_25638.yaml](config/priority1_glm_25638.yaml), and [priority1_opus_11019.yaml](config/priority1_opus_11019.yaml) duplicate their respective base model and pull-timeout fields, then add only an `instance_filter`.
- [priority1_haiku_25638.yaml](config/priority1_haiku_25638.yaml) is not a full duplicate of [claude_haiku_45.yaml](config/claude_haiku_45.yaml): it specifies the model, pull timeout, and filter but does not repeat the Haiku-only agent/model options. The recorded trajectory is the source for the effective setting values above.

## Command Format

```bash
mini-extra swebench \
  --subset data/SWE-bench_Lite \
  --split test \
  --filter "^(instance1|instance2|...)$" \
  --output runs/{model_name} \
  --workers 1 \
  --model-class openrouter \
  --config <mini-SWE-agent swebench benchmark config> \
  --config config/{model}.yaml
```

- `--workers 1` ran tasks sequentially.
- `--filter` selected the fixed 50-task list for baseline execution or the named focused instances for follow-up execution.
- Each run wrote predictions and trajectories to its own [runs/](runs/) directory.

## Run Coverage

### RUN1: Baseline

- GLM-5.2: 50 attempted → [runs/glm_5_2/](runs/glm_5_2/)
- Claude Opus-5: 43 completed from 50 attempted → [runs/claude_opus_5/](runs/claude_opus_5/)

### Phase 0: Haiku Disagreement Check

- Claude Haiku-4.5: eight RUN1 disagreement instances → [runs/claude_haiku_45/](runs/claude_haiku_45/)

### RUN2: Retests

- GLM-5.2: two instances → [runs/glm_5_2_retest/](runs/glm_5_2_retest/)
- Claude Opus-5: two instances → [runs/claude_opus_5_retest/](runs/claude_opus_5_retest/)
- Claude Haiku-4.5: two instances → [runs/claude_haiku_45_retest/](runs/claude_haiku_45_retest/)

### RUN3: Focused Follow-up

- GLM-5.2: two instances → [runs/glm_5_2_priority1_11848/](runs/glm_5_2_priority1_11848/) and [runs/glm_5_2_priority1_25638/](runs/glm_5_2_priority1_25638/)
- Claude Opus-5: one instance → [runs/claude_opus_5_priority1/](runs/claude_opus_5_priority1/)
- Claude Haiku-4.5: one instance → [runs/claude_haiku_45_priority1/](runs/claude_haiku_45_priority1/)

## Reproducibility Notes

- The fixed 50 IDs are in [input/selected_instance_ids.txt](input/selected_instance_ids.txt).
- Evaluation outcomes are recorded in [logs/run_evaluation/](logs/run_evaluation/).
- The fixed limits are safeguards, not actual token or cost measurements. The available run artifacts do not provide a complete directly recorded input-token, output-token, or dollar-cost total for every call.
