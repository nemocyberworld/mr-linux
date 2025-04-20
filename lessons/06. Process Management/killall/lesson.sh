#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}💀 Lesson: The 'killall' Command — Kill Processes by Name${RESET}"
echo
echo "'killall' is used to send signals to all processes by name instead of PID. It's easier when you know the command name, not the PID."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}📘 What is 'killall'?${RESET}"
echo
echo "'killall' terminates processes by their name. It sends signals like SIGTERM, SIGKILL, etc."
echo
echo "Common signals:"
echo -e "${YELLOW}- SIGTERM (default): killall sleep"
echo -e "- SIGKILL (-9): killall -9 sleep"
echo -e "- SIGHUP (-1): killall -1 sleep"
pause

# Step 2: Setup Practice Directory
PRACTICE_DIR="$SCRIPT_DIR/practice/killall_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Start multiple dummy processes
sleep 300 & sleep 300 &
echo -e "${YELLOW}🛠️ Started two 'sleep' processes (300s each).${RESET}"
pause

# Step 3: Show Examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'killall' Usage Examples:${RESET}"

declare -A KILLALL_USAGE
KILLALL_USAGE["killall sleep"]="Send SIGTERM to all 'sleep' processes"
KILLALL_USAGE["killall -9 sleep"]="Force kill all 'sleep' processes"
KILLALL_USAGE["killall -v sleep"]="Verbose mode, shows what was killed"
KILLALL_USAGE["killall -l"]="List all available signals"

for cmd in "${!KILLALL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${KILLALL_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Tasks
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

# Step 5: Interactive Tasks
sleep 300 & sleep 300 &
ask_and_check \
    "Terminate all 'sleep' processes with default signal" \
    "Use: killall sleep" \
    "^killall[[:space:]]+sleep$" \
    "killall sleep"

sleep 300 & sleep 300 &
ask_and_check \
    "Force kill all 'sleep' processes using SIGKILL" \
    "Use: killall -9 sleep" \
    "^killall[[:space:]]+-9[[:space:]]+sleep$" \
    "killall -9 sleep"

ask_and_check \
    "List all available signals with killall" \
    "Use: killall -l" \
    "^killall[[:space:]]+-l$"

# Step 6: Cleanup
echo -e "${CYAN}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
echo -e "${GREEN}✅ Practice files removed.${RESET}"
pause

# Wrap-up
echo -e "${GREEN}${BOLD}🎉 Great work! You’ve mastered the 'killall' command.${RESET}"
pause
