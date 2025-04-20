#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_sedawk_level_$RANDOM"
mkdir -p "$LEVEL_DIR"
FILE="$LEVEL_DIR/transmission.txt"

cat <<EOF > "$FILE"
== Start Transmission ==
Name: K4rmA
Date: 2025-04-19
Content: nothing to see here
Code: A32XC9
Message: The password is encrypted
---
Name: N3m0
Date: 2025-04-19
Content: FLAG:SedAwk{stream_magic}
Code: XZ9E31
Message: Hidden in plain sight
---
Name: R4nd0m
Date: 2025-04-19
Content: please ignore
Code: LOL123
Message: nothing important
== End Transmission ==
EOF

echo "[Level 4: Sed & Awk — Text Bender]"
echo
echo "You found a strange file at: $FILE"
echo "Rumor says a flag is encoded inside a 'Content:' line."
echo "Use only sed or awk to extract it. When you're ready, enter the flag."
echo
echo "Example command: awk \"/Pattern:/\" /tmp/mr_linux_sedawk_level_X/XXXXX.txt"
echo

read -p "Enter the flag: " user_flag
user_flag=$(echo "$user_flag" | tr -d '[:space:]')

if [[ "$user_flag" == "SedAwk{stream_magic}" ]]; then
    echo "🎉 You bent the stream and revealed the truth!"
    echo "Points earned: +20 🪙"
    echo "$LEVEL_DIR" >> ~/.mr_linux_game_progress
else
    echo "❌ Incorrect. Your stream editing magic needs work!"
fi
