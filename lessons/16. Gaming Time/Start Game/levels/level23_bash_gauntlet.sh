#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level23"
WORKSPACE="$LEVEL_DIR/workspace"
FLAG_FILE="$LEVEL_DIR/final_flag.txt"

FLAG_CONTENT="FLAG-L23-BASH-GODMODE"

mkdir -p "$WORKSPACE"
rm -f "$FLAG_FILE"
rm -rf "$WORKSPACE"/*
chmod 700 "$LEVEL_DIR"

# Setup: Create clues and scripts
# Part 1: File parsing
cat <<EOF > "$WORKSPACE/server.log"
[INFO] Connection from 192.168.1.10
[ERROR] Disk full on /dev/sda1
[INFO] Connection from 10.0.0.5
[INFO] Connection from 192.168.1.42
[WARNING] CPU temperature high
[INFO] Connection from 192.168.1.42
EOF

# Part 2: Secret function script
cat <<'EOF' > "$WORKSPACE/script.sh"
#!/bin/bash

greet() {
  echo "Welcome, warrior of the shell."
}

calculate() {
  local x="$1"
  local y="$2"
  echo $((x + y))
}

final_test() {
  if [[ "$1" -eq 1337 ]]; then
    echo "Access granted."
    return 0
  else
    echo "Access denied."
    return 1
  fi
}
EOF

chmod +x "$WORKSPACE/script.sh"

# Part 3: Secret note for the challenge
cat <<EOF > "$WORKSPACE/README.txt"
🧠 Your multi-step mission:

1. Extract the most common IP from the server.log file.
2. Fix and use the calculate() function inside script.sh to get 1337.
3. If the output is correct, call final_test 1337.
4. If access is granted, echo the flag into: $FLAG_FILE

👾 No hints this time. Everything you’ve learned will help you now.

EOF

# Show instructions
clear
echo -e "👑 \033[1;35mLevel 23: The Final Boss — Bash Gauntlet\033[0m\n"
echo -e "🎯 Objective:"
echo -e "  - Combine your bash skills to complete a multi-step mission."
echo -e "  - Directory to conquer: \033[36m$WORKSPACE\033[0m\n"
echo -e "💾 When you're ready:"
echo -e "  - Run your script(s), modify the files, parse logs, and pass the test!"
echo -e "  - If successful, echo the final flag into: \033[33m$FLAG_FILE\033[0m\n"
echo -e "🏁 Final flag should be: \033[32m$FLAG_CONTENT\033[0m\n"

read -p "🚀 Ready for the final test? Press Enter to begin..."

# Give user time to work their magic...
sleep 3

# Check if they succeeded
if [[ -f "$FLAG_FILE" ]] && grep -q "$FLAG_CONTENT" "$FLAG_FILE"; then
    echo -e "\n🎉 \033[32mIncredible! You completed the Bash Gauntlet and claimed your title.\033[0m"
    echo -e "🏁 Flag: \033[33m$FLAG_CONTENT\033[0m"
else
    echo -e "\n❌ \033[31mNot quite there yet, chosen one. Review the tasks and try again.\033[0m"
    echo -e "💡 Everything you need is in $WORKSPACE. Show your mastery."
fi
