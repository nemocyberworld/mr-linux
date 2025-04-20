#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level20"
TARGET_FILE="$LEVEL_DIR/target.txt"
FLAG_FILE="$LEVEL_DIR/flag.txt"
HIDDEN_FLAG="$LEVEL_DIR/.hidden_flag.txt"

mkdir -p "$LEVEL_DIR"
rm -f "$TARGET_FILE" "$FLAG_FILE" "$HIDDEN_FLAG"

FLAG_CONTENT="FLAG-L20-REACT-NOW"

# Setup files
echo "Waiting for change..." > "$TARGET_FILE"
echo "$FLAG_CONTENT" > "$HIDDEN_FLAG"
chmod 600 "$HIDDEN_FLAG"
touch "$FLAG_FILE"

# Simulate a simple change and flag drop
(
    sleep 5
    echo "🔥 The file has changed!" > "$TARGET_FILE"
    cp "$HIDDEN_FLAG" "$FLAG_FILE"
) &

# Instructions
clear
echo -e "🧠 \033[1;34mLevel 20: React to File Changes (Beginner Mode)\033[0m\n"
echo -e "🎯 Challenge:"
echo -e "  - Keep an eye on: \033[36m$TARGET_FILE\033[0m"
echo -e "  - When it changes, open: \033[33m$FLAG_FILE\033[0m to find the flag\n"
echo -e "💡 Hint:"
echo -e "  - You can use: \033[36mwatch cat $TARGET_FILE\033[0m"
echo -e "  - Or a simple Bash loop like: \033[36mwhile true; do cat; done\033[0m\n"

read -p "🕵️ Ready? Press Enter to begin..."

# Give them time
sleep 10

# Ask for the flag
read -p "📥 What was the flag in flag.txt? " user_flag

# Check input
if [[ "$user_flag" == "$FLAG_CONTENT" ]]; then
    echo -e "\n🎉 \033[32mGreat job! You caught the flag.\033[0m"
    echo -e "🏁 Flag: \033[33m$FLAG_CONTENT\033[0m"
else
    echo -e "\n❌ \033[31mIncorrect. Try again and watch for the change!\033[0m"
fi
