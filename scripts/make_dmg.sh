#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
APP_PATH="dist/OpenGranola.app"
DMG_PATH="dist/OpenGranola.dmg"

if [[ ! -d "$APP_PATH" ]]; then
  echo "App not found at $APP_PATH"
  echo "Run ./scripts/build_swift_app.sh first"
  exit 1
fi

rm -f "$DMG_PATH"
hdiutil create -volname "OpenGranola" -srcfolder "$APP_PATH" -ov -format UDZO "$DMG_PATH"

# Sign the DMG if a signing identity is available
if [[ -z "${CODESIGN_IDENTITY:-}" ]]; then
  CODESIGN_IDENTITY=$(security find-identity -v -p codesigning | grep "Developer ID Application" | head -1 | sed 's/.*"\(.*\)"/\1/' || true)
  if [[ -z "$CODESIGN_IDENTITY" ]]; then
    CODESIGN_IDENTITY=$(security find-identity -v -p codesigning | grep "Apple Development" | head -1 | sed 's/.*"\(.*\)"/\1/' || true)
  fi
fi

if [[ -n "${CODESIGN_IDENTITY:-}" ]]; then
  echo "Signing DMG with: $CODESIGN_IDENTITY"
  codesign --force --sign "$CODESIGN_IDENTITY" "$DMG_PATH"
fi

echo "DMG created: $DMG_PATH"

# Notarize DMG if credentials are available
if [[ -n "${APPLE_ID:-}" && -n "${APPLE_TEAM_ID:-}" && -n "${APPLE_APP_PASSWORD:-}" ]]; then
  echo "Submitting DMG for notarization..."

  xcrun notarytool submit "$DMG_PATH" \
    --apple-id "$APPLE_ID" \
    --team-id "$APPLE_TEAM_ID" \
    --password "$APPLE_APP_PASSWORD" \
    --wait

  xcrun stapler staple "$DMG_PATH"
  echo "DMG notarization complete"
fi
