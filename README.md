# SWE-bench Lite router challenge: reproducible 50-task run

This repository reproduces a fixed 50-task challenge subset from the
SWE-bench Lite **test** split. It runs the same tasks with three OpenRouter
models, sequentially:

1. `z-ai/glm-5.2`
2. `deepseek/deepseek-v4-flash`
3. `anthropic/claude-opus-5`

## Intent

The motivating question is whether SWE-bench Lite gives a cost-aware router
enough empirical evidence to distinguish tasks suitable for a cheaper model,
a middle-tier model, or a stronger model. Observable task variation alone
(for example issue length, patch churn, tests, or repository) does not prove
that different capability levels are required. The same fixed tasks must be
attempted by all candidate models.

Running every Lite task with every model is unnecessarily expensive for an
initial study. This repository therefore fixes a reproducible 50-task,
repository-and-churn-diverse challenge subset. The exact instance IDs and
their hashes are committed under `input/`; the selected data cannot drift when
the upstream dataset changes.

The agent receives only the normal mini-SWE-agent SWE-bench task context. It
does not receive gold patches, test patches, test lists, routing tiers, or
model outcomes.

This is an experiment runner, not a router-training package. It creates the
same controlled model-attempt data on another machine; conclusions are made
only after the resulting patches are evaluated.

## Requirements

Use an x86_64 Linux machine with Docker and substantial free disk space. The
official SWE-bench guidance recommends about 120 GB free storage. Apple
Silicon Macs can run x86_64 images through emulation, but this is slow and
storage-intensive.

Install `git`, Docker, Python 3.11, and [uv](https://docs.astral.sh/uv/).
You also need an OpenRouter API key with access to the three pinned models.

## Setup

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd swe-bench-router-50
cp .env.example .env
# Edit .env and add OPENROUTER_API_KEY
./scripts/setup.sh
./scripts/preflight.sh
```

`setup.sh` clones mini-SWE-agent at the exact recorded commit, creates a
local virtual environment, and downloads the Lite development split locally.
The exact pinned Lite **test** Parquet used by this experiment is committed in
this repository at `data/SWE-bench_Lite/data/test-00000-of-00001.parquet`.
It makes no model request.

## Run

Each task is isolated in its own SWE-bench Docker environment. The initial
pass may pull task images; Docker caches successful image pulls, so later
models reuse them for the same instance IDs.

Run one model:

```bash
RUN_MODEL=1 ./scripts/run_model.sh glm_5_2
```

Or execute the fixed full order:

```bash
RUN_MODEL=1 ./scripts/run_all.sh
```

The upstream mini-SWE-agent behavior is retained: source-only edits,
`/testbed` working directory, 60-second shell-command timeout, 250-step
maximum, and a $3 API-spend maximum per task. This repository changes only
the model identifier, selected task filter, output location, and image-start
timeout (15 minutes) so a first Docker pull is allowed to finish.

Each model writes trajectories and `preds.json` under `runs/<model>/`. Those
outputs can be supplied to the official SWE-bench evaluator after the run.

## Reproducibility record

See `input/provenance.json` for the SWE-bench Lite test Parquet SHA-256,
selected-ID SHA-256, mini-SWE-agent commit, and model order.
