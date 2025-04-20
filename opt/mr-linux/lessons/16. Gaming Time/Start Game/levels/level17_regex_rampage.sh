#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level17"
INPUT_FILE="$LEVEL_DIR/hacklog.txt"
OUTPUT_FILE="$LEVEL_DIR/matches.txt"
FLAG_FILE="$LEVEL_DIR/flag.txt"
EXAMPLE_FILE="$LEVEL_DIR/example.txt"
EXAMPLE_OUTPUT="$LEVEL_DIR/example_output.txt"
KEYWORD="FLAG-L17-REGEX-COMPLETE"

mkdir -p "$LEVEL_DIR"
rm -f "$OUTPUT_FILE" "$FLAG_FILE" "$EXAMPLE_FILE" "$EXAMPLE_OUTPUT"

# Create example input file
cat <<EOF > "$EXAMPLE_FILE"
[INFO] Hello world
[ERROR] Something bad happened
[DEBUG] Not important
[ERROR] Oops again
EOF

# Create actual input file with hidden flag
cat <<EOF > "$INPUT_FILE"
[INFO] System initialized at 12:00
[ERROR] Invalid login attempt from 192.168.1.10
[WARNING] Disk space below threshold
[ALERT] User admin triggered alarm
[DEBUG] Heartbeat received
[ERROR] File not found at /etc/shadow
[ERROR] FLAG-L17-REGEX-COMPLETE — breach signature detected
[NOTICE] Backup completed successfully
EOF

# Display instructions
clear
echo -e "🔍 \033[1;34mLevel 17: Regex Rampage\033[0m\n"

# --- Example walkthrough ---
echo -e "📚 \033[1;36mExample First!\033[0m"
echo -e "Let's warm up. Here's an example file: \033[33m$EXAMPLE_FILE\033[0m"
echo -e "It contains both [INFO], [DEBUG], and [ERROR] logs.\n"

echo -e "✅ Try this command:"
echo -e "  \033[32mgrep '\\[ERROR\\]' $EXAMPLE_FILE > $EXAMPLE_OUTPUT\033[0m\n"
echo -e "That will extract only the error lines. Check the result with:"
echo -e "  \033[32mcat $EXAMPLE_OUTPUT\033[0m\n"

echo -e "Once that works, you're ready for the real mission!\n"

# --- Actual mission ---
echo -e "🎯 \033[1mNow your mission:\033[0m"
echo -e "  - Read file \033[36m$INPUT_FILE\033[0m"
echo -e "  - Extract all lines that contain \033[33m[ERROR]\033[0m"
echo -e "  - Save them to \033[33m$OUTPUT_FILE\033[0m"
echo -e "  - One of those lines contains the secret flag!\n"

echo -e "💡 Pro Tips:"
echo -e "  - Use \033[1mgrep '\\[ERROR\\]'\033[0m or \033[1m[[ \$line =~ ... ]]\033[0m in a loop"
echo -e "  - Check the flag with: \033[3mcat $OUTPUT_FILE\033[0m\n"

read -p "🚀 Press Enter once you've handled the real log file..."

# Check for the flag
if [[ -f "$OUTPUT_FILE" ]] && grep -q "$KEYWORD" "$OUTPUT_FILE"; then
    echo "$KEYWORD" > "$FLAG_FILE"
    echo -e "\n🎉 \033[32mRegex conqueror! You extracted the correct line.\033[0m"
    echo -e "🏁 Flag: \033[33m$KEYWORD\033[0m"
else
    echo -e "\n❌ \033[31mYour regex didn’t hit the target.\033[0m"
    echo -e "🔍 Make sure you’re matching only [ERROR] lines."
    echo -e "🔁 Try running: \033[36mgrep '\\[ERROR\\]' $INPUT_FILE > $OUTPUT_FILE\033[0m"
fi
