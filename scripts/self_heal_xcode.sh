#!/bin/bash
set -e

LOG="build.log"

if grep -q "Provisioning profile" "$LOG"; then
    echo "Fixing provisioning profile…"
    cp signing/profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
fi

if grep -q "No signing certificate" "$LOG"; then
    echo "Re-importing signing certificate…"
    security import signing/cert.p12 -k build.keychain -P "$SIGNING_CERT_PASSWORD"
fi

if grep -q "bundle identifier" "$LOG"; then
    echo "Fixing bundle identifier…"
    sed -i '' 's/com.old.bundle/com.jeremiah.signerapp/g' project.yml
fi
