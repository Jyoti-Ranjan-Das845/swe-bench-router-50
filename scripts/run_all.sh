#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for model in glm_5_2 deepseek_v4_flash claude_opus_5; do
  "${root}/scripts/run_model.sh" "${model}"
done
