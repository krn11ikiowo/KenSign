#!/bin/bash
set -e

WF=".github/workflows/build-and-sign.yml"
TEMPLATE="scripts/signer_workflow_template.yml"

echo "Checking signer workflow integrity…"

# 1. Ensure yq exists
if ! command -v yq >/dev/null 2>&1; then
    echo "yq not found — installing…"
    brew install yq || sudo apt install -y yq || true
fi

# 2. Ensure workflow file exists
if [ ! -f "$WF" ]; then
    echo "Workflow missing — regenerating…"
    cp "$TEMPLATE" "$WF"
    git add "$WF"
    git commit -m "Auto-regenerate signer workflow (missing file)"
    git push
    exit 0
fi

# 3. Ensure workflow file is not empty
if [ ! -s "$WF" ]; then
    echo "Workflow empty — regenerating…"
    cp "$TEMPLATE" "$WF"
    git add "$WF"
    git commit -m "Auto-regenerate signer workflow (empty file)"
    git push
    exit 0
fi

# 4. Validate YAML
if ! yq e '.' "$WF" >/dev/null 2>&1; then
    echo "Workflow corrupted — regenerating…"
    cp "$TEMPLATE" "$WF"
    git add "$WF"
    git commit -m "Auto-regenerate signer workflow (corrupted YAML)"
    git push
    exit 0
fi

echo "Workflow is valid — no regeneration needed."
