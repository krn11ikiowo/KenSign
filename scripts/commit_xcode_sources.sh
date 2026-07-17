#!/bin/bash
set -e

echo "Committing all Xcode source files…"

# Ensure Git identity exists (GitHub Actions needs this)
git config user.name "CI Auto Commit"
git config user.email "ci@github.com"

# Add all Xcode-related files
git add SignerApp \
        SignerApp/**/* \
        *.xcodeproj \
        *.xcworkspace \
        **/*.swift \
        **/*.plist \
        **/*.entitlements \
        **/*.xcassets \
        project.yml \
        scripts \
        swift_signer

# If nothing changed, exit quietly
if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit
git commit -m "Auto‑commit: Xcode source files updated"

# Push
git push

echo "Xcode source files committed and pushed successfully."
