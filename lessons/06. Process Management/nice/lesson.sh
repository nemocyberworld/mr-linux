#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: The 'nice' Command — Launching Processes with Priority${RESET}"
echo
echo "'nice' is used to start a new process with a specified niceness (priority)."
echo "Niceness ranges from -20 (highest priority) to 19 (lowest priority)."
echo "Default niceness for normal users is 0; lowering it (e.g., -10) usually requires root."
pause

# Step 1: Show current priority of a sample process
clear
echo -e "${YELLOW}${BOLD}🔍 Example: Launching a process with a nice value${RESET}"
echo -e "Let's run a test command using 'nice' and observe its niceness."
pause

# Step 2: Demo
TMPDIR="$HOME/.mr_linux_nice_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Start with nice
nice -n 10 yes > /dev/null &
PID=$!
echo -e "${GREEN}✅ Launched 'yes' command with nice value 10, PID: $PID${RESET}"
pause

echo -e "${YELLOW}${BOLD}📊 Let's verify the niceness of the process:${RESET}"
ps -o pid,ni,comm -p "$PID"
pause

# Step 3: Show usage examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'nice' Options and Examples:${RESET}"

declare -A NICE_USAGE
NICE_USAGE["nice -n 10 sleep 30"]="Run 'sleep 30' with niceness 10"
NICE_USAGE["nice -n 19 make"]="Start 'make' with the lowest priority"
NICE_USAGE["sudo nice -n -5 updatedb"]="Start 'updatedb' with higher priority (requires root)"

for cmd in "${!NICE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${NICE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 4: Task Checker
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
            eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive tasks
ask_and_check \
    "Start the 'sleep 5' command with a niceness of 12" \
    "Use: nice -n 12 sleep 5" \
    "^nice[[:space:]]+-n[[:space:]]+12[[:space:]]+sleep[[:space:]]+5[[:space:]]*$"

ask_and_check \
    "Run 'yes' with niceness 19" \
    "Use: nice -n 19 yes" \
    "^nice[[:space:]]+-n[[:space:]]+19[[:space:]]+yes[[:space:]]*$"

# Step 6: Cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete! Cleaning up...${RESET}"
kill "$PID" &>/dev/null
rm -rf "$TMPDIR"
pause
