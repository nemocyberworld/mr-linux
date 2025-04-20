#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level18"
OUTPUT_FILE="$LEVEL_DIR/sysinfo_summary.txt"
FLAG_FILE="$LEVEL_DIR/flag.txt"
mkdir -p "$LEVEL_DIR"
rm -f "$OUTPUT_FILE" "$FLAG_FILE"

# Define challenge parameters
EXPECTED_UPTIME_KEYWORD="load average"
EXPECTED_MEM_KEYWORD="Mem:"
EXPECTED_DISK_KEYWORD="/"

FLAG_CONTENT="FLAG-L18-SYSINFO-MASTERY"

# Clear screen and present mission
clear
echo -e "🖥️ \033[1;34mLevel 18: Sysinfo Challenge\033[0m\n"
echo -e "🎯 Objective:"
echo -e "  - Extract key system information using standard Linux commands"
echo -e "  - Save your summary to: \033[33m$OUTPUT_FILE\033[0m\n"
echo -e "🛠️ Required info in your summary:"
echo -e "  - Uptime info (look for '\033[32m$EXPECTED_UPTIME_KEYWORD\033[0m')"
echo -e "  - Memory usage (from line starting with '\033[32m$EXPECTED_MEM_KEYWORD\033[0m')"
echo -e "  - Disk space info (line with mount point '\033[32m$EXPECTED_DISK_KEYWORD\033[0m')\n"

echo -e "💡 Use commands like:"
echo -e "  \033[36muptime\033[0m — system uptime and load averages"
echo -e "  \033[36mfree -h\033[0m — memory usage"
echo -e "  \033[36mdf -h /\033[0m — disk usage for root\n"

echo -e "📥 Example (to guide you):"
echo -e "  \033[90muptime | tee -a $OUTPUT_FILE"
echo -e "  free -h | grep '^Mem:' | tee -a $OUTPUT_FILE"
echo -e "  df -h / | tail -1 | tee -a $OUTPUT_FILE\033[0m\n"

read -p "🚀 Press Enter when you've created your summary..."

# Validate if the output file contains required info
if [[ -f "$OUTPUT_FILE" ]] &&
   grep -q "$EXPECTED_UPTIME_KEYWORD" "$OUTPUT_FILE" &&
   grep -q "^$EXPECTED_MEM_KEYWORD" "$OUTPUT_FILE" &&
   grep -q "$EXPECTED_DISK_KEYWORD" "$OUTPUT_FILE"; then
    echo "$FLAG_CONTENT" > "$FLAG_FILE"
    echo -e "\n✅ \033[32mSystem scan complete! All required data found.\033[0m"
    echo -e "🏁 Flag collected: \033[33m$FLAG_CONTENT\033[0m"
else
    echo -e "\n❌ \033[31mOops! Your summary is missing some required lines.\033[0m"
    echo -e "🔍 Make sure it contains uptime, memory, and disk info!"
fi
