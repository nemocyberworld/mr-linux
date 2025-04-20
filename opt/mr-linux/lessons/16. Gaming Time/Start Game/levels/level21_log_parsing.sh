#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level21"
LOG_FILE="$LEVEL_DIR/server.log"
FLAG_FILE="$LEVEL_DIR/flag.txt"

mkdir -p "$LEVEL_DIR"
rm -f "$LOG_FILE" "$FLAG_FILE"

FLAG_CONTENT="FLAG-L21-LOG-PRO"

# 📝 Create a dummy log file with various lines
cat <<EOF > "$LOG_FILE"
[INFO] 2025-04-19 09:00:00 - Server started
[WARNING] 2025-04-19 09:01:12 - Disk space low on /dev/sda1
[ERROR] 2025-04-19 09:02:45 - Failed login attempt from 192.168.1.42
[INFO] 2025-04-19 09:03:33 - User nemo logged in
[ERROR] 2025-04-19 09:04:10 - Service crash: nginx
[INFO] 2025-04-19 09:05:55 - Backup completed
[ERROR] 2025-04-19 09:07:01 - Failed login attempt from 192.168.1.99
[ERROR] 2025-04-19 09:07:42 - Failed login attempt from 192.168.1.42
[INFO] 2025-04-19 09:09:30 - Cleanup script finished
EOF

# Instruction text
clear
echo -e "🧠 \033[1;34mLevel 21: Log Parsing\033[0m\n"
echo -e "🎯 Your challenge:"
echo -e "  - Read the log file at: \033[36m$LOG_FILE\033[0m"
echo -e "  - Extract all unique IPs that failed to log in"
echo -e "  - Submit the IPs in sorted order, one per line\n"
echo -e "💡 Hint:"
echo -e "  - Use \033[36mgrep\033[0m, \033[36msed\033[0m, \033[36mawk\033[0m, or \033[36mcut\033[0m"
echo -e "  - Think about using: \033[36msort | uniq\033[0m"
echo -e "  - Focus on lines with: \033[33m\"Failed login\"\033[0m\n"

read -p "🔍 Ready to parse? Press Enter..."

# Prompt user input
echo -e "\n📥 Enter the unique sorted IPs (one per line), then Ctrl+D:"
user_input=$(</dev/stdin)

# Define the expected result
expected_ips=$(grep "Failed login" "$LOG_FILE" | \
               grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | \
               sort | uniq | tr '\n' '|')

user_ips=$(echo "$user_input" | sort | uniq | tr '\n' '|')

# Check answer
if [[ "$user_ips" == "$expected_ips" ]]; then
    echo "$FLAG_CONTENT" > "$FLAG_FILE"
    echo -e "\n🎉 \033[32mLog parsed perfectly! You've earned the flag.\033[0m"
    echo -e "🏁 Flag: \033[33m$FLAG_CONTENT\033[0m"
else
    echo -e "\n❌ \033[31mIncorrect! Either wrong format or missing IPs.\033[0m"
    echo -e "💡 Try again. Watch for duplicates or unsorted results."
fi
