#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mini_dir="${root}/vendor/mini-swe-agent"
mini_commit="a83fcae82d2a08f0ee0c688f9d137b3566c097f8"

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v uv >/dev/null || { echo "uv is required: https://docs.astral.sh/uv/" >&2; exit 1; }

if [[ ! -d "${mini_dir}/.git" ]]; then
  git clone https://github.com/SWE-agent/mini-swe-agent.git "${mini_dir}"
fi
git -C "${mini_dir}" fetch --tags --quiet
git -C "${mini_dir}" checkout --detach "${mini_commit}"

uv venv "${root}/.venv" --python 3.11
uv pip install --python "${root}/.venv/bin/python" -e "${mini_dir}"

"${root}/.venv/bin/hf" download princeton-nlp/SWE-bench_Lite \
  --repo-type dataset \
  --local-dir "${root}/data/SWE-bench_Lite"

echo "Setup complete. Add OPENROUTER_API_KEY to ${root}/.env, then run scripts/preflight.sh."
