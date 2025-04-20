#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}💀 Lesson: The 'kill' Command — Terminate Processes${RESET}"
echo
echo "'kill' is used to send signals to processes. By default, it sends the SIGTERM signal to terminate a process."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}📘 What is 'kill'?${RESET}"
echo
echo "The 'kill' command is used to stop a process by sending it a signal. You need the PID (Process ID) of the target process."
echo
echo "Common signals:"
echo -e "${YELLOW}- SIGTERM (15): Graceful stop (default)"
echo -e "- SIGKILL (9): Force stop (cannot be ignored)"
echo -e "- SIGHUP (1): Hang up signal"
pause

# Step 2: Setup Practice Directory
PRACTICE_DIR="$SCRIPT_DIR/practice/kill_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Start a background process to kill
sleep 300 &
PID=$!
echo -e "${YELLOW}🛠️ Simulated process started with PID $PID (sleep 300)${RESET}"
pause

# Step 3: Show Examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'kill' Usage Examples:${RESET}"

declare -A KILL_USAGE
KILL_USAGE["kill $PID"]="Send default SIGTERM to PID $PID"
KILL_USAGE["kill -9 $PID"]="Send SIGKILL to forcefully terminate PID $PID"
KILL_USAGE["kill -1 $PID"]="Send SIGHUP to PID $PID"
KILL_USAGE["kill -l"]="List all signal names"

for cmd in "${!KILL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${KILL_USAGE[$cmd]}${RESET}"
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
ask_and_check \
    "Terminate the process using default signal (SIGTERM)" \
    "Use: kill $PID" \
    "^kill[[:space:]]+$PID$" \
    "kill $PID"

sleep 1
sleep 300 &  # start another for next task
PID2=$!
echo -e "${YELLOW}🔄 New process started with PID $PID2${RESET}"
pause

ask_and_check \
    "Force kill the process using SIGKILL" \
    "Use: kill -9 $PID2" \
    "^kill[[:space:]]+-9[[:space:]]+$PID2$" \
    "kill -9 $PID2"

ask_and_check \
    "List all available kill signals" \
    "Use: kill -l" \
    "^kill[[:space:]]+-l$"

# Step 6: Cleanup
echo -e "${CYAN}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
echo -e "${GREEN}✅ Practice files removed.${RESET}"
pause

# Wrap-up
echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'kill' command lesson.${RESET}"
pause
