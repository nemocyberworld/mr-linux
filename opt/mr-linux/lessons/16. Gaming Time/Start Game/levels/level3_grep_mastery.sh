#!/bin/bash

# === Level 3: Grep Mastery ===
LEVEL=3
TITLE="Grep Mastery"
SECRET="FLAG{grep_the_truth}"
TMP_DIR="/tmp/mr_linux_grep_level_$RANDOM"
LOGFILE="$TMP_DIR/logs.txt"
PROGRESS_FILE="$HOME/.mr_linux_progress"

mkdir -p "$TMP_DIR"

# Create the noisy log file
cat > "$LOGFILE" <<EOF
$(head -c 3000 /dev/urandom | tr -dc 'a-zA-Z0-9 ' | fold -w80 | head -n 30)
2025-04-18 INFO User logged in
2025-04-18 WARN Disk space low
2025-04-18 $SECRET
2025-04-18 INFO Task complete
$(head -c 3000 /dev/urandom | tr -dc 'a-zA-Z0-9 ' | fold -w80 | head -n 30)
EOF

clear
echo "=== Mr. Linux Game - Level $LEVEL: $TITLE ==="
echo
echo "The logs are messy. Somewhere inside the haystack of this log file is a secret line."
echo "Your mission: find the flag!"
echo
echo "Log file path: $LOGFILE"
echo
echo "Use your grep-fu wisely. When you've found it, type the secret flag exactly below."
echo

read -rp "Enter the flag: " user_input

if [[ "$user_input" == "$SECRET" ]]; then
    echo "✅ Correct! You truly are the Grep Master."
    # Save progress
    mkdir -p "$(dirname "$PROGRESS_FILE")"
    if ! grep -q "Level $LEVEL" "$PROGRESS_FILE" 2>/dev/null; then
        echo "Level $LEVEL: $TITLE" >> "$PROGRESS_FILE"
    fi
else
    echo "❌ Nope! That's not the flag. Try again, grep harder."
    exit 1
fi

# Cleanup
rm -rf "$TMP_DIR"
