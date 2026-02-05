#!/usr/bin/env bash
set -e

# Beállítások
INSTALL_DIR="$HOME/Applications"
DESKTOP_FILE="/usr/local/share/applications/cursor.desktop"

echo "🔍 Legfrissebb Cursor AppImage keresése..."

JSON=$(curl -fsSL "https://cursor.com/api/download?platform=linux-x64&releaseTrack=latest")

URL=$(echo "$JSON" | jq -r '.downloadUrl')

echo "⬇️ Letöltési URL:"
echo "$URL"

curl -L "$URL" -o $INSTALL_DIR/cursor.AppImage
chmod +x $INSTALL_DIR/cursor.AppImage

echo "✅ Frissítettük: $INSTALL_DIR/cursor.AppImage"