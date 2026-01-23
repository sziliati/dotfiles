#!/usr/bin/env bash
set -e

# Beállítások
APP="Cursor"
INSTALL_DIR="/opt/cursor"
BIN_PATH="/usr/local/bin/cursor"
DESKTOP_FILE="/usr/share/applications/cursor.desktop"

# Legfrissebb release lekérése a GitHub API-ról
echo "🔍 Legfrissebb Cursor AppImage keresése..."
URL="curl -L "https://downloader.cursor.sh/linux/appImage/x64" -o cursor-latest.AppImage"

if [[ -z "$URL" ]]; then
  echo "❌ Nem sikerült megtalálni a Cursor AppImage letöltési linkjét."
  exit 1
fi

echo "📥 Letöltés innen: $URL"
mkdir -p "$INSTALL_DIR"
curl -L "$URL" -o "$INSTALL_DIR/cursor.AppImage"

# Jogosultságok
chmod +x "$INSTALL_DIR/cursor.AppImage"

# Symlink létrehozása
ln -sf "$INSTALL_DIR/cursor.AppImage" "$BIN_PATH"

# Desktop entry létrehozása
cat <<EOF | sudo tee "$DESKTOP_FILE" > /dev/null
[Desktop Entry]
Name=Cursor
Exec=$BIN_PATH %U
Icon=$INSTALL_DIR/icon.png
Type=Application
Categories=Development;IDE;
Terminal=false
EOF

echo "✅ Telepítés kész! Indíthatod a menüből vagy futtasd: cursor"