#!/bin/bash

LEVEL=6
LEVEL_NAME="Find & Locate — Hunt files across the filesystem"
LEVEL_DIR="/tmp/mr_linux_findlocate_level_$RANDOM"
mkdir -p "$LEVEL_DIR"

# Plant the flag in a random hidden location
SECRET_DIR="$LEVEL_DIR/.hidden_treasure"
mkdir -p "$SECRET_DIR"
FLAG_FILE="$SECRET_DIR/flag_hidden.txt"
echo "SedAwk{file_foundation}" > "$FLAG_FILE"

# Add distraction files
for i in {1..10}; do
    touch "$LEVEL_DIR/file_$i.txt"
    echo "Just noise..." > "$LEVEL_DIR/file_$i.txt"
done

# Add nested distraction directories
mkdir -p "$LEVEL_DIR/deep/deeper/deepest"
echo "Not here!" > "$LEVEL_DIR/deep/deeper/deepest/trick.txt"

# Game start
echo "[Level $LEVEL: $LEVEL_NAME]"
echo
echo "Somewhere inside this directory lies a hidden file containing the next flag."
echo "Your mission is to find it using only your command-line tracking skills."
echo
echo "Directory: $LEVEL_DIR"
echo
echo "You may want to use:"
echo "  - \`find\` to recursively search"
echo "  - \`locate\` (if available) for a database-powered hunt"
echo "  - Look for files with names containing 'flag'..."
echo

read -p "Enter the flag: " user_flag
user_flag=$(echo "$user_flag" | tr -d '[:space:]')

if [[ "$user_flag" == "SedAwk{file_foundation}" ]]; then
    echo "🏁 Well done, filesystem explorer!"
    echo "Points earned: +20 🪙"
    echo "$LEVEL" >> ~/.mr_linux_game_progress
else
    echo "❌ The flag remains hidden… dig deeper!"
fi
