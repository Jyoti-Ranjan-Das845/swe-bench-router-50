#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
python_bin="${root}/.venv/bin/python"
mini_bin="${root}/.venv/bin/mini-extra"
parquet="${root}/data/SWE-bench_Lite/data/test-00000-of-00001.parquet"

[[ -x "${python_bin}" && -x "${mini_bin}" ]] || { echo "Run scripts/setup.sh first." >&2; exit 1; }
[[ -f "${parquet}" ]] || { echo "Lite test Parquet is missing." >&2; exit 1; }
command -v docker >/dev/null || { echo "Docker is required." >&2; exit 1; }
docker info >/dev/null

"${python_bin}" - "${root}" "${parquet}" <<'PY'
import hashlib, json, sys
from pathlib import Path
import pyarrow.parquet as pq
root, parquet = map(Path, sys.argv[1:])
ids = [x for x in (root / 'input/selected_instance_ids.txt').read_text().splitlines() if x]
p = json.loads((root / 'input/provenance.json').read_text())
assert len(ids) == len(set(ids)) == 50
assert hashlib.sha256((root / 'input/selected_instance_ids.txt').read_bytes()).hexdigest() == p['selected_ids_sha256']
assert hashlib.sha256(parquet.read_bytes()).hexdigest() == p['source_parquet_sha256']
available = set(pq.read_table(parquet, columns=['instance_id']).column('instance_id').to_pylist())
assert set(ids) <= available
print('PASS: exact 50 IDs and exact source Lite test data')
PY
echo "PASS: Docker, mini-SWE-agent, and inputs are ready. No OpenRouter request was made."
