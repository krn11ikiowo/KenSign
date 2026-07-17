#!/bin/bash
set -e

echo "Checking workflows…"

WORKFLOW_DIR=".github/workflows"
TEMPLATE="scripts/workflow_template.yml"

if [ ! -d "$WORKFLOW_DIR" ]; then
    echo "No workflow directory found, creating…"
    mkdir -p "$WORKFLOW_DIR"
fi

for wf in $WORKFLOW_DIR/*.yml; do
    if ! yq e '.' "$wf" >/dev/null 2>&1; then
        echo "Repairing broken workflow: $wf"
        cp "$TEMPLATE" "$wf"
        git add "$wf"
        git commit -m "Auto-repair workflow $wf"
        git push
    fi
done

echo "Workflow check complete."
