#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/utils/input.sh"

echo -e "${BOLD}${CYAN}🔧 Level 11: Process Management - Kill the Runaway!${RESET}"
echo -e "A rogue process has been spawned!"
echo -e "It's pretending to be innocent, but it's eating your CPU cycles!"
echo -e "Use tools like \`ps\`, \`top\`, \`grep\`, and \`kill\` to find and stop it."
echo
echo -e "💡 The process runs a script that reveals a secret when terminated."

SECRET="terminated_the_rogue"
TMP_DIR="/tmp/mr_linux_level11"
mkdir -p "$TMP_DIR"
SCRIPT_PATH="$TMP_DIR/rogue.sh"

# Create the rogue script
cat <<EOF > "$SCRIPT_PATH"
#!/bin/bash
trap 'echo "$SECRET" > "$TMP_DIR/secret.txt"; exit 0' SIGTERM
while true; do
  echo "😈 I am a runaway process..." > /dev/null
  sleep 1
done
EOF
chmod +x "$SCRIPT_PATH"

# Launch in background
bash "$SCRIPT_PATH" &

echo -e "The rogue process is running now!"
echo -e "🕵️‍♂️ Your mission: Find its PID and terminate it."
echo -e "  Hint: You can use \`ps aux | grep rogue.sh\` or \`top\` to identify it."
echo

# Wait until the secret file appears
while [[ ! -f "$TMP_DIR/secret.txt" ]]; do
  sleep 1
done

# Read secret after successful kill
SECRET_REVEALED=$(cat "$TMP_DIR/secret.txt")
ask_and_check "Enter the secret revealed after killing the process:" "$SECRET_REVEALED"

# Cleanup
rm -rf "$TMP_DIR"
echo -e "${GREEN}✅ Great job! You've successfully taken down the rogue process.${RESET}"
