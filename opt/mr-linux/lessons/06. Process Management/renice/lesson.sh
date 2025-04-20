#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: The 'renice' Command — Adjusting Process Priority${RESET}"
echo
echo "'renice' is used to change the priority (niceness) of a running process."
echo "Lower nice value = higher priority. Default is 0. Range is -20 (highest) to 19 (lowest)."
pause

# Step 1: Setup practice environment
echo -e "${BOLD}🧪 Creating a background test process...${RESET}"
TMPDIR="$HOME/.mr_linux_renice_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create a background process
yes > /dev/null &
TEST_PID=$!
echo -e "Started CPU-hungry process with PID: ${YELLOW}$TEST_PID${RESET}"
pause

# Step 2: Show current nice value
clear
echo -e "${YELLOW}${BOLD}🔍 Checking process niceness using 'ps':${RESET}"
ps -o pid,ni,comm -p "$TEST_PID"
pause

# Step 3: Explain renice options
clear
echo -e "${CYAN}${BOLD}📚 Useful 'renice' Options and Examples:${RESET}"

declare -A RENICE_USAGE
RENICE_USAGE["renice 10 -p $TEST_PID"]="Change nice value of a process to 10"
RENICE_USAGE["renice -n -5 -p $TEST_PID"]="Lower the nice value by 5 (requires sudo)"
RENICE_USAGE["renice 15 -p $TEST_PID"]="Set nice value to 15 for a process"

for cmd in "${!RENICE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${RENICE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 4: Task checker
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-false}"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            fi
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
    "Change the nice value of the test process to 10" \
    "Try: renice 10 -p $TEST_PID" \
    "^renice[[:space:]]+10[[:space:]]+-p[[:space:]]+$TEST_PID[[:space:]]*$"

ask_and_check \
    "Increase the nice value by 5 for the test process" \
    "Try: renice -n 5 -p $TEST_PID" \
    "^renice[[:space:]]+-n[[:space:]]+5[[:space:]]+-p[[:space:]]+$TEST_PID[[:space:]]*$"

# Step 6: Clean up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! Cleaning up...${RESET}"
kill "$TEST_PID" &>/dev/null
rm -rf "$TMPDIR"
pause
