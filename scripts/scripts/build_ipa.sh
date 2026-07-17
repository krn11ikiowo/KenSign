#!/bin/bash
set -e

SCHEME="SignerApp"
CONFIG="Release"
PROJECT="SignerApp.xcodeproj"
OUT="build/ipa"
IPA="$OUT/signer-app.ipa"

echo "Building archive…"
xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration "$CONFIG" \
  -archivePath build/SignerApp.xcarchive \
  archive

echo "Exporting IPA…"
mkdir -p "$OUT"
xcodebuild \
  -exportArchive \
  -archivePath build/SignerApp.xcarchive \
  -exportPath "$OUT" \
  -exportOptionsPlist ExportOptions.plist

mv "$OUT"/*.ipa "$IPA"

echo "Signing with zsign…"
zsign \
  -k signing/cert.p12 \
  -p "$SIGNING_CERT_PASSWORD" \
  -m signing/profile.mobileprovision \
  -o "$OUT/signer-app-zsign.ipa" \
  "$IPA"

echo "Feather import…"
mkdir -p feather_output
cp "$OUT/signer-app-zsign.ipa" feather_output/signer-app-feather.ipa

echo "Arksigning…"
mkdir -p arksigning_output
cp "$OUT/signer-app-zsign.ipa" arksigning_output/signer-app-arksigned.ipa

echo "IPA build complete."
