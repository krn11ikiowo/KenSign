#!/bin/bash
set -e

PLIST="SignerApp/Info.plist"

VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$PLIST")
BUILD=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$PLIST")

NEW_BUILD=$((BUILD + 1))

/usr/libexec/PlistBuddy -c "Set CFBundleVersion $NEW_BUILD" "$PLIST"

git add "$PLIST"
git commit -m "Auto-increment build number to $NEW_BUILD"
git push
