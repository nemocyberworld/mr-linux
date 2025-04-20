#!/bin/bash

LEVEL=5
LEVEL_NAME="Redirection — Master the Flow"
LEVEL_DIR="/tmp/mr_linux_redirection_level_$RANDOM"
mkdir -p "$LEVEL_DIR"
SECRET_FILE="$LEVEL_DIR/.secret_flag.txt"
ERROR_LOG="$LEVEL_DIR/errors.log"
OUTPUT_LOG="$LEVEL_DIR/output.log"

# Setup phase
echo "Redirection is power. Choose your operators wisely." > "$OUTPUT_LOG"
echo "Use your knowledge of >, >>, 2>, &>, <<<, and pipes to find the hidden flag." >> "$OUTPUT_LOG"
echo "SedAwk{flow_controlled}" > "$SECRET_FILE"
chmod 600 "$SECRET_FILE"

# Create a decoy script
cat <<EOF > "$LEVEL_DIR/runme.sh"
#!/bin/bash
echo "Welcome to the redirection challenge!" > "$LEVEL_DIR/result.txt"
cat "$SECRET_FILE" > /dev/null 2> "$LEVEL_DIR/errors.log"
echo "Processing complete." >> "$LEVEL_DIR/result.txt"
EOF

chmod +x "$LEVEL_DIR/runme.sh"

# Gameplay prompt
echo "[Level $LEVEL: $LEVEL_NAME]"
echo
echo "You've discovered a mysterious script at:"
echo "  $LEVEL_DIR/runme.sh"
echo "And it seems to be hiding something..."
echo "Figure out where the flag is being silently dropped or suppressed!"
echo
echo "Hints:"
echo " - The script silently handles something. Where does stderr go?"
echo " - Try modifying the script or using redirection to capture the flag."
echo " - Think: what's in .secret_flag.txt?"
echo

read -p "Enter the flag: " user_flag
user_flag=$(echo "$user_flag" | tr -d '[:space:]')

if [[ "$user_flag" == "SedAwk{flow_controlled}" ]]; then
    echo "✅ Excellent redirection skills, commander!"
    echo "Points earned: +20 🪙"
    echo "$LEVEL" >> ~/.mr_linux_game_progress
else
    echo "❌ Close, but the stream slipped through your fingers..."
fi
