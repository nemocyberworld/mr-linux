#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level22"
BOMB_SCRIPT="$LEVEL_DIR/boom.sh"
FLAG_FILE="$LEVEL_DIR/flag.txt"

FLAG_CONTENT="FLAG-L22-FORK-BOMB-DEFUSED"

# Prep
mkdir -p "$LEVEL_DIR"
rm -f "$BOMB_SCRIPT" "$FLAG_FILE"

# Create the "bomb"
cat <<'EOF' > "$BOMB_SCRIPT"
#!/bin/bash
# 💣 Fork bomb disguised as a useful function
:() {
  : | : &
};
echo "This script is totally safe to run, trust me 😈"
read -p "Press Enter to begin: "
:
EOF

chmod +x "$BOMB_SCRIPT"

# Game intro
clear
echo -e "💥 \033[1;31mLevel 22: Fork Bomb Disarm\033[0m\n"
echo -e "🧠 Your mission:"
echo -e "  - Investigate the script: \033[36m$BOMB_SCRIPT\033[0m"
echo -e "  - Identify the potential threat before running it!"
echo -e "  - Delete or neutralize the fork bomb *without executing it*\n"
echo -e "💡 Hints:"
echo -e "  - Look closely at the function definition"
echo -e "  - A fork bomb will endlessly spawn processes until your system dies"
echo -e "  - You must *prevent* it from running, not just avoid it\n"
echo -e "🛑 Do NOT run this script on a real machine — it's just a trap!\n"
echo -e "✅ To win:"
echo -e "  - Disarm the bomb script safely (e.g., remove the ': | :' line)"
echo -e "  - Then create the flag manually with: \033[33mecho \"$FLAG_CONTENT\" > $FLAG_FILE\033[0m\n"

read -p "🕵️ You're now in bomb disposal mode. Press Enter when you're ready..."

# Wait for player to investigate
sleep 2

# Check if they defused it
if [[ -f "$FLAG_FILE" ]] && grep -q "$FLAG_CONTENT" "$FLAG_FILE"; then
    echo -e "\n🎉 \033[32mBoom avoided! You spotted the fork bomb and earned the flag.\033[0m"
    echo -e "🏁 Flag: \033[33m$FLAG_CONTENT\033[0m"
else
    echo -e "\n❌ \033[31mYou didn't disarm the bomb in time... or maybe you ran it 😬\033[0m"
    echo -e "💡 Try again — and this time, stop it before it runs!"
fi
