#!/bin/bash
set -e

WF=".github/workflows/build-and-sign.yml"
TEMPLATE="scripts/signer_workflow_template.yml"

if ! yq e '.' "$WF" >/dev/null 2>&1; then
    echo "Regenerating signer workflow…"
    cp "$TEMPLATE" "$WF"
    git add "$WF"
    git commit -m "Auto-regenerate signer workflow"
    git push
fi
