#!/usr/bin/env bash
set -euo pipefail

# The base image ships Python 3.12 but not the venv/ensurepip bits.
if ! python3 -c "import ensurepip" >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends python3.12-venv
fi

if [ ! -x .venv/bin/python ]; then
  python3 -m venv .venv
fi

.venv/bin/pip install --upgrade pip
.venv/bin/pip install -r requirements.txt

# llama-index-legacy still imports pkg_resources, which setuptools>=81 removed.
.venv/bin/pip install "setuptools<81"
