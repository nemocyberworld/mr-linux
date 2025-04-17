#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌳 Lesson: The 'pstree' Command — View Processes as a Tree${RESET}"
echo
echo "'pstree' shows running processes in a tree format, making it easier to visualize parent-child relationships between processes."
pause

# Step 1: Show help
clear
echo -e "${YELLOW}${BOLD}📘 pstree --help (partial):${RESET}"
pstree --help 2>&1 | head -20
pause

# Step 2: Common examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'pstree' Examples:${RESET}"

declare -A PSTREE_USAGE
PSTREE_USAGE["pstree"]="Display all processes in a tree format"
PSTREE_USAGE["pstree -p"]="Show PIDs (process IDs) with the tree"
PSTREE_USAGE["pstree -u"]="Show user names next to processes"
PSTREE_USAGE["pstree -a"]="Show command line arguments of each process"
PSTREE_USAGE["pstree <PID>"]="Show process tree for a specific process ID"

for cmd in "${!PSTREE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${PSTREE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Practice Environment
PRACTICE_DIR="$SCRIPT_DIR/playground/pstree_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Start a few dummy background processes to visualize in pstree
bash -c 'sleep 60' &
bash -c 'sleep 60' &
sleep_pid1=$!
bash -c 'bash -c "sleep 60"' &
sleep_pid2=$!
sleep 1  # allow pstree to register the processes

# Step 4: Interactive Task System
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

# Step 5: Tasks
ask_and_check \
    "Display the process tree" \
    "Use: pstree" \
    "^pstree[[:space:]]*$"

ask_and_check \
    "Display the process tree with PIDs" \
    "Use: pstree -p" \
    "^pstree[[:space:]]+-p[[:space:]]*$"

ask_and_check \
    "Display the process tree with usernames" \
    "Use: pstree -u" \
    "^pstree[[:space:]]+-u[[:space:]]*$"

ask_and_check \
    "Show full command lines of all processes in tree view" \
    "Use: pstree -a" \
    "^pstree[[:space:]]+-a[[:space:]]*$"

ask_and_check \
    "Display the tree for a specific PID ($sleep_pid1)" \
    "Use: pstree $sleep_pid1" \
    "^pstree[[:space:]]+$sleep_pid1[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've learned how to use pstree!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
kill $sleep_pid1 $sleep_pid2 2>/dev/null
rm -rf "$PRACTICE_DIR"
pause
