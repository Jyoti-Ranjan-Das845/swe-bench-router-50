#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -z "${OPENROUTER_API_KEY:-}" && -f "${root}/.env" ]]; then
  set -a
  source "${root}/.env"
  set +a
fi

[[ $# -eq 1 ]] || { echo "Usage: $0 {glm_5_2|deepseek_v4_flash|claude_opus_5}" >&2; exit 2; }
[[ "${RUN_MODEL:-}" == "1" ]] || { echo "Set RUN_MODEL=1 to authorize a paid model run." >&2; exit 2; }
[[ -n "${OPENROUTER_API_KEY:-}" ]] || { echo "OPENROUTER_API_KEY is required." >&2; exit 2; }

case "$1" in glm_5_2|deepseek_v4_flash|claude_opus_5) ;; *) echo "Unknown model: $1" >&2; exit 2;; esac
mini_bin="${root}/.venv/bin/mini-extra"
base_config="${root}/vendor/mini-swe-agent/src/minisweagent/config/benchmarks/swebench.yaml"
dataset="${root}/data/SWE-bench_Lite"
[[ -x "${mini_bin}" && -d "${dataset}" ]] || { echo "Run scripts/setup.sh first." >&2; exit 1; }

regex="$(${root}/.venv/bin/python - "${root}/input/selected_instance_ids.txt" <<'PY'
import re, sys
ids = [x.strip() for x in open(sys.argv[1]) if x.strip()]
print('^(' + '|'.join(map(re.escape, ids)) + ')$')
PY
)"
mkdir -p "${root}/runs/$1" "${root}/logs"
exec "${mini_bin}" swebench \
  --subset "${dataset}" --split test --filter "${regex}" \
  --output "${root}/runs/$1" --workers 1 --model-class openrouter \
  --config "${base_config}" --config "${root}/config/$1.yaml" \
  2>&1 | tee "${root}/logs/$1-$(date -u +%Y%m%dT%H%M%SZ).log"
