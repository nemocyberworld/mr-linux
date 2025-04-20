#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level15"
INPUT_FILE="$LEVEL_DIR/incoming_data.txt"
OUTPUT_FILE="$LEVEL_DIR/extracted.txt"
FLAG_FILE="$LEVEL_DIR/flag.txt"
KEYWORD="SECRET_STRING_42"

mkdir -p "$LEVEL_DIR"
rm -f "$OUTPUT_FILE" "$FLAG_FILE"

# Create input file with noise and one hidden flag line
cat <<EOF > "$INPUT_FILE"
Just some random logs...
System check passed.
User login: admin
Nothing to see here.
$KEYWORD: FLAG-L15-FILE-IO-COMPLETE
Disk usage: 42%
Another useless log line.
EOF

# ──────────────────────────────
# 🧪 Add a warm-up example file
EXAMPLE_FILE="$LEVEL_DIR/example.txt"
EXAMPLE_OUTPUT="$LEVEL_DIR/example_output.txt"
EXAMPLE_KEYWORD="findme"

cat <<EOF > "$EXAMPLE_FILE"
apple
banana
findme: this is the line you want
grape
orange
EOF

# ──────────────────────────────
# 📢 Display instructions
clear
echo -e "📂 \033[1;34mLevel 15: File I/O Frenzy\033[0m\n"

echo -e "🧪 \033[1mWARM-UP EXERCISE:\033[0m"
echo -e "  - Read lines from: \033[36m$EXAMPLE_FILE\033[0m"
echo -e "  - Extract the one containing: \033[33m$EXAMPLE_KEYWORD\033[0m"
echo -e "  - Save it to: \033[36m$EXAMPLE_OUTPUT\033[0m\n"
echo -e "🔧 Sample logic to help you:\n"
echo -e '\033[90mwhile IFS= read -r line; do\n  if [[ "$line" == *"findme"* ]]; then\n    echo "$line" > /tmp/mr_linux_level15/example_output.txt\n  fi\ndone < /tmp/mr_linux_level15/example.txt\033[0m\n'

echo -e "💪 Once you’re comfy with the warm-up, tackle the real challenge below!\n"

echo -e "🎯 \033[1mYour mission, Linux Warrior:\033[0m"
echo -e "  - Open the file \033[36m$INPUT_FILE\033[0m"
echo -e "  - Read it \033[33mline-by-line\033[0m in a Bash script"
echo -e "  - Extract only the line that contains the keyword: \033[32m$KEYWORD\033[0m"
echo -e "  - Save that line to \033[33m$OUTPUT_FILE\033[0m\n"

echo -e "💡 Pro Tips:"
echo -e "  - Use a \033[1mwhile read\033[0m loop or \033[1mgrep\033[0m"
echo -e "  - Once done, check if your output file exists and contains the flag!\n"

read -p "🚀 Press Enter when you're ready to scan the logs..."

# Check if output file was created and contains the flag
if [[ -f "$OUTPUT_FILE" ]] && grep -q "$KEYWORD" "$OUTPUT_FILE"; then
    grep "$KEYWORD" "$OUTPUT_FILE" | cut -d':' -f2- | xargs > "$FLAG_FILE"
    echo -e "\n🎉 \033[32mSuccess! You extracted the right line.\033[0m"
    echo -e "🏁 Flag collected: \033[33m$(cat "$FLAG_FILE")\033[0m"
else
    echo -e "\n❌ \033[31mOops! Either your output file is missing or doesn’t contain the magic line.\033[0m"
    echo -e "🛠️  Double-check your script and try again!"
fi
