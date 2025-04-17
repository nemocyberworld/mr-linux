#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📚 Lesson: The 'ps' Command — Process Status Viewer${RESET}"
echo
echo "'ps' shows current processes running on the system, with useful filtering and formatting options."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}📘 What is 'ps'?${RESET}"
echo
echo "'ps' displays information about active processes."
echo
echo -e "🔹 ${YELLOW}ps${RESET} — processes in the current shell"
echo -e "🔹 ${YELLOW}ps aux${RESET} — show all processes for all users"
echo -e "🔹 ${YELLOW}ps -ef${RESET} — full-format list of all processes"
pause

# Step 2: Setup Practice Directory
PRACTICE_DIR="$SCRIPT_DIR/practice/ps_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Step 3: Start Dummy Background Processes
sleep 120 & sleep 120 &
echo -e "${YELLOW}🛠️ Started background 'sleep' processes.${RESET}"
pause

# Step 4: Show Examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'ps' Usage Examples:${RESET}"

declare -A PS_USAGE
PS_USAGE["ps"]="Show processes in the current shell"
PS_USAGE["ps aux"]="Show all processes in BSD format"
PS_USAGE["ps -ef"]="Show all processes in full format"
PS_USAGE["ps -u \$USER"]="Show processes for your user"
PS_USAGE["ps -C sleep"]="Filter processes by command name"

for cmd in "${!PS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${PS_USAGE[$cmd]}${RESET}"
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
    "Display processes in your current terminal" \
    "Use: ps" \
    "^ps$"

# Task 2
ask_and_check \
    "Display all running processes in BSD format" \
    "Use: ps aux" \
    "^ps[[:space:]]+aux$"

# Task 3
ask_and_check \
    "Display all running processes in standard full format" \
    "Use: ps -ef" \
    "^ps[[:space:]]+-ef$"

# Task 4
ask_and_check \
    "Filter and show only 'sleep' processes" \
    "Use: ps -C sleep" \
    "^ps[[:space:]]+-C[[:space:]]+sleep$"

# Step 6: Cleanup
echo -e "${CYAN}🧹 Cleaning up...${RESET}"
killall sleep &>/dev/null
rm -rf "$PRACTICE_DIR"
echo -e "${GREEN}✅ Practice files and processes removed.${RESET}"
pause

# Wrap-up
echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'ps' command lesson!${RESET}"
pause
