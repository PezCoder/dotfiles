#!/usr/bin/env bash
# Auto-fix tsgo settings.json to use v1.0
# This script fixes the settings.json file that gets reverted by prettier/yarn
# Usage: ./scripts/fix-tsgo-settings.sh [path-to-web-ui]

set -e

WEBUI_PATH="${1:-$HOME/dd/web-ui}"
SETTINGS_FILE="$WEBUI_PATH/.yarn/sdks/typescript-go/settings.json"

if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "❌ Error: settings.json not found at $SETTINGS_FILE"
    exit 1
fi

echo "🔧 Fixing tsgo settings.json..."

# Use jq to update the values in-place
/usr/bin/jq '.versionOverride.value = "v1.0" | .overridingDefault.value = "v1.0"' \
    "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && \
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

echo "✅ Updated tsgo settings to use v1.0"
echo ""
echo "Current settings:"
/usr/bin/jq '{versionOverride: .versionOverride.value, overridingDefault: .overridingDefault.value}' "$SETTINGS_FILE"
