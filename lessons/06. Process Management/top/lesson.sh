#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📚 Lesson: The 'top' Command — Real-Time Process Monitor${RESET}"
echo
echo "'top' is used to display real-time dynamic info about system processes and resource usage."
pause

# Step 1: Introduction
clear
echo -e "${CYAN}${BOLD}📘 What is 'top'?${RESET}"
echo
echo "'top' gives a live view of CPU usage, memory usage, running processes, and more."
echo
echo -e "🔹 ${YELLOW}top${RESET} — Run the real-time system monitor"
echo -e "🔹 ${YELLOW}top -u \$USER${RESET} — Show only your processes"
echo -e "🔹 ${YELLOW}top -n 1${RESET} — Run 'top' once and exit"
pause

# Step 2: Start Dummy Processes
PRACTICE_DIR="$SCRIPT_DIR/practice/top_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit
sleep 120 & sleep 120 &
echo -e "${YELLOW}🛠️ Started dummy 'sleep' background processes.${RESET}"
pause

# Step 3: Usage Tips
clear
echo -e "${CYAN}${BOLD}📘 While in 'top', try:${RESET}"
echo
echo -e "🔹 Press ${YELLOW}P${RESET} to sort by CPU"
echo -e "🔹 Press ${YELLOW}M${RESET} to sort by memory"
echo -e "🔹 Press ${YELLOW}u${RESET} to filter by username"
echo -e "🔹 Press ${YELLOW}k${RESET} to kill a process"
echo -e "🔹 Press ${YELLOW}q${RESET} to quit"
pause

# Step 4: Examples
clear
declare -A TOP_USAGE
TOP_USAGE["top"]="Run the live system monitor"
TOP_USAGE["top -u $USER"]="Show only processes from your user"
TOP_USAGE["top -n 1"]="Run once and exit"

echo -e "${CYAN}${BOLD}📘 Examples of 'top' command:${RESET}"
for cmd in "${!TOP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TOP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 5: Interactive Tasks
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Task 1
ask_and_check \
    "Run 'top' to view live system stats" \
    "Just type: top" \
    "^top$"

# Task 2
ask_and_check \
    "Run 'top' once and then quit" \
    "Use: top -n 1" \
    "^top[[:space:]]+-n[[:space:]]*1$"

# Task 3
ask_and_check \
    "Run 'top' and show only your processes" \
    "Use: top -u \$USER" \
    "^top[[:space:]]+-u[[:space:]]*\$USER$"

# Step 6: Cleanup
echo -e "${CYAN}🧹 Cleaning up dummy processes...${RESET}"
killall sleep &>/dev/null
rm -rf "$PRACTICE_DIR"
echo -e "${GREEN}✅ Cleanup done.${RESET}"
pause

# Step 7: Completion
echo -e "${GREEN}${BOLD}🎉 Congrats! You’ve completed the 'top' command lesson!${RESET}"
pause
