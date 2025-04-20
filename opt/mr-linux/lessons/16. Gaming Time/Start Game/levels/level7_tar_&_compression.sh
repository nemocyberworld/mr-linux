#!/bin/bash

LEVEL=7
LEVEL_NAME="Tar & Compression — Deal with .tar.gz, .zip, etc."
LEVEL_DIR="/tmp/mr_linux_tar_level_$RANDOM"
ARCHIVE_NAME="archive.tar.gz"
SECRET_FILENAME="super_secret.txt"
SECRET_CONTENT="TarCompress{archive_power}"

mkdir -p "$LEVEL_DIR/nested/folder/hidden"

# Place the secret inside the deep nested folder
echo "$SECRET_CONTENT" > "$LEVEL_DIR/nested/folder/hidden/$SECRET_FILENAME"

# Create a .tar.gz archive
tar -czf "$LEVEL_DIR/$ARCHIVE_NAME" -C "$LEVEL_DIR" nested

# Remove original directory so player must extract
rm -rf "$LEVEL_DIR/nested"

# Intro Prompt
echo "[Level $LEVEL: $LEVEL_NAME]"
echo
echo "A compressed archive is hiding a secret in a deeply nested folder..."
echo
echo "🗂️ Archive location:"
echo "  $LEVEL_DIR/$ARCHIVE_NAME"
echo
echo "Your task:"
echo "  - Extract the archive"
echo "  - Find the secret file"
echo "  - Enter the secret message"
echo

# Read user input
read -p "Enter the secret message: " user_input
user_input=$(echo "$user_input" | tr -d '[:space:]')

if [[ "$user_input" == "$SECRET_CONTENT" ]]; then
    echo "✅ Compression cracked! You’re a tarball whisperer!"
    echo "Points earned: +20 🪙"
    echo "$LEVEL" >> ~/.mr_linux_game_progress
else
    echo "❌ Not quite. Maybe peek deeper into the folders you unpacked?"
fi
