#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: The 'pkill' Command — Kill by Pattern Match${RESET}"
echo
echo "'pkill' sends signals to processes based on matching names, patterns, or other attributes."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}📘 What is 'pkill'?${RESET}"
echo
echo "'pkill' is used to kill processes by matching process names or attributes like user, terminal, session, etc."
echo
echo -e "🔹 ${YELLOW}pkill sleep${RESET} — sends SIGTERM to all processes named 'sleep'"
echo -e "🔹 ${YELLOW}pkill -9 sleep${RESET} — sends SIGKILL to 'sleep' processes"
echo -e "🔹 ${YELLOW}pkill -u username${RESET} — kill processes for specific user"
pause

# Step 2: Setup Practice Directory
PRACTICE_DIR="$SCRIPT_DIR/practice/pkill_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Step 3: Start Dummy Processes
sleep 300 & sleep 300 &
echo -e "${YELLOW}🛠️ Started two 'sleep' processes (300s each).${RESET}"
pause

# Step 4: Show Examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'pkill' Usage Examples:${RESET}"

declare -A PKILL_USAGE
PKILL_USAGE["pkill sleep"]="Kill all processes named 'sleep'"
PKILL_USAGE["pkill -9 sleep"]="Force kill all 'sleep' processes"
PKILL_USAGE["pkill -u \$USER"]="Kill all your own processes"
PKILL_USAGE["pkill -f \"python script.py\""]="Match full command line"

for cmd in "${!PKILL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${PKILL_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 5: Interactive Tasks
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local eval_cmd="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            [[ -n "$eval_cmd" ]] && eval "$eval_cmd"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Task 1
sleep 300 & sleep 300 &
ask_and_check \
    "Kill all processes named 'sleep'" \
    "Use: pkill sleep" \
    "^pkill[[:space:]]+sleep$" \
    "pkill sleep"

# Task 2
sleep 300 & sleep 300 &
ask_and_check \
    "Force kill all 'sleep' processes with SIGKILL" \
    "Use: pkill -9 sleep" \
    "^pkill[[:space:]]+-9[[:space:]]+sleep$" \
    "pkill -9 sleep"

# Task 3
ask_and_check \
    "Kill processes by user (you)" \
    "Use: pkill -u \$USER" \
    "^pkill[[:space:]]+-u[[:space:]]+\$USER$"

# Step 6: Cleanup
echo -e "${CYAN}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
echo -e "${GREEN}✅ Practice files removed.${RESET}"
pause

# Wrap-up
echo -e "${GREEN}${BOLD}🎉 Awesome! You’ve completed the 'pkill' command lesson!${RESET}"
pause
