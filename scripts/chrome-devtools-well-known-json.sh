#!/usr/bin/env bash
# Crea el JSON que Chrome/DevTools solicita en jekyll serve. La carpeta .well-known está en .gitignore.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIR="$ROOT/.well-known/appspecific"
mkdir -p "$DIR"
printf '%s\n' '{}' > "$DIR/com.chrome.devtools.json"
