#!/bin/bash
set -e

curl -X POST -F "file=@feather_output/signer-app-feather.ipa" https://your-feather-endpoint/upload
curl -X POST -F "file=@arksigning_output/signer-app-arksigned.ipa" https://your-arksigning-endpoint/upload
curl -X POST -F "file=@build/ipa/signer-app-zsign.ipa" https://sidestore-endpoint/upload
