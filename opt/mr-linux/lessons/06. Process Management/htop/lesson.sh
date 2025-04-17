#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🖥️ Lesson: The 'htop' Command — Interactive Process Viewer${RESET}"
echo
echo "'htop' is a real-time, interactive process monitoring tool that shows system resource usage in a colorful and user-friendly interface."
pause

# Step 1: Overview
clear
echo -e "${CYAN}${BOLD}🔍 What does 'htop' do?${RESET}"
echo
echo "'htop' is like an enhanced version of 'top'. It lets you scroll, search, sort, and manage system processes easily."
pause

# Step 2: Create a practice directory (for consistency)
PRACTICE_DIR="$SCRIPT_DIR/practice/htop_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit
echo -e "${YELLOW}📁 Practice directory created: $PRACTICE_DIR${RESET}"
pause

# Step 3: Show usage examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'htop' Usage Examples:${RESET}"

declare -A HTOP_USAGE
HTOP_USAGE["htop"]="Launch the interactive process viewer"
HTOP_USAGE["htop -u root"]="Show only processes for the user 'root'"
HTOP_USAGE["htop --sort-key=PERCENT_MEM"]="Sort by memory usage"
HTOP_USAGE["htop --sort-key=PERCENT_CPU"]="Sort by CPU usage"
HTOP_USAGE["sudo htop"]="Run with root privileges to manage all processes"

for cmd in "${!HTOP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${HTOP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checker
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
            echo -e "${YELLOW}🔄 'htop' will now launch. Exit it by pressing ${BOLD}F10${RESET}${YELLOW} or ${BOLD}q${RESET}${YELLOW}.${RESET}"
            pause
            eval "$user_cmd"
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
    "Launch 'htop'" \
    "Just type: htop" \
    '^htop[[:space:]]*$'

ask_and_check \
    "Show only processes for the user 'root'" \
    "Use the -u option" \
    '^htop[[:space:]]+-u[[:space:]]+root[[:space:]]*$'

ask_and_check \
    "Run 'htop' with root privileges" \
    "Use: sudo htop" \
    '^sudo[[:space:]]+htop[[:space:]]*$'

# Step 6: Cleanup
echo -e "${CYAN}🧹 No files to clean up in this lesson.${RESET}"
pause

# Wrap-up
echo -e "${GREEN}${BOLD}🎉 Excellent! You've mastered the 'htop' command.${RESET}"
pause
