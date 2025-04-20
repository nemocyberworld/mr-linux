#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/utils/input.sh"

echo -e "${BOLD}${CYAN}🔐 Level 8: Zip Zone Showdown${RESET}"
echo -e "Welcome to the compression battleground!"
echo -e "You've encountered a zip archive protected by a password."
echo -e "🧠 Your goal: Unzip the archive, dig through the folders, and find the secret message."
echo -e "Once found, enter it exactly as it appears."
echo

LEVEL_DIR="/tmp/mr_linux_level7"
ZIP_FILE="top_secret.zip"
PASSWORD="letmein123"
SECRET_FILENAME="classified.txt"
SECRET_CONTENT="zip_master_9000"

rm -rf "$LEVEL_DIR"
mkdir -p "$LEVEL_DIR/hidden/layers/inside"

echo "$SECRET_CONTENT" > "$LEVEL_DIR/hidden/layers/inside/$SECRET_FILENAME"

# Create password-protected zip
cd "$LEVEL_DIR"
zip -r -P "$PASSWORD" "$ZIP_FILE" hidden >/dev/null

# Clean up unarchived structure to force extraction
rm -rf "$LEVEL_DIR/hidden"

echo -e "🗃️ Zip archive created at: ${YELLOW}$LEVEL_DIR/$ZIP_FILE${RESET}"
echo -e "💡 Hint: The password is '${BOLD}${GREEN}$PASSWORD${RESET}'"
echo

ask_and_check "Enter the secret message from the unzipped file:" "$SECRET_CONTENT"

echo -e "${GREEN}🎉 Zip mastery unlocked! You're crushing this.${RESET}"
