#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level16"
SCRIPT_FILE="$LEVEL_DIR/mysterious_script.sh"
FLAG_FILE="$LEVEL_DIR/flag.txt"

mkdir -p "$LEVEL_DIR"
rm -f "$FLAG_FILE"

# Create a broken Bash script that needs debugging
cat <<'EOF' > "$SCRIPT_FILE"
#!/bin/bash

# set, trap, indicates your script mistake
# don't forget to use set, trap in your script for dubugging purpose

set -euo pipefail

FLAG_FILE="/tmp/mr_linux_level16/flag.txt"

trap 'echo "💥 An error occurred. Time to debug!"; exit 1' ERR

echo "🔍 Starting mysterious operations..."

# Oops: MISTYPED variable name causes error
username="admin"
echo "User is $usernme"

echo "✨ Everything worked fine!" > "$FLAG_FILE"
EOF

chmod +x "$SCRIPT_FILE"

# Display instructions
clear
echo -e "🐞 \033[1;34mLevel 16: Debugging Dungeon\033[0m\n"
echo -e "🧩 Something’s broken… and it’s your job to fix it!\n"

echo -e "🧠 \033[1mYour mission:\033[0m"
echo -e "  - Run the script: \033[36m$SCRIPT_FILE\033[0m"
echo -e "  - Use Bash debugging tools to find and fix the issue:"
echo -e "      • \033[1mset -x\033[0m to trace execution"
echo -e "      • \033[1mtrap\033[0m to catch errors"
echo -e "      • \033[1mset -euo pipefail\033[0m to catch subtle bugs"
echo -e "  - Once fixed, make sure it writes a flag to: \033[33m$FLAG_FILE\033[0m\n"

echo -e "💡 Tips:"
echo -e "  - Watch out for typos and undefined variables."
echo -e "  - You might want to echo variables or add \033[1mset -x\033[0m temporarily!"
echo -e "  - Try editing the script directly: \033[36mvim $SCRIPT_FILE\033[0m\n"

read -p "🔧 Press Enter after you've fixed the script and run it successfully..."

# Check if flag exists
if [[ -f "$FLAG_FILE" ]]; then
    echo -e "\n🎉 \033[32mWell done! You’ve debugged the dungeon.\033[0m"
    echo -e "🏁 Flag found: \033[33m$(cat "$FLAG_FILE")\033[0m"
else
    echo -e "\n❌ \033[31mNo flag file found. Looks like the bug is still lurking...\033[0m"
    echo -e "🛠️  Edit the script, fix the issue, and run it again!"
fi
