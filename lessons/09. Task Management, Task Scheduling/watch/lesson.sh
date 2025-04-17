#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: The 'watch' Command — Repeatedly Run a Command${RESET}"
echo
echo "'watch' runs a command periodically, showing output fullscreen. Useful for monitoring changing outputs like 'df', 'ls', or 'ps'."
pause

# Step 1: Display help
clear
echo -e "${YELLOW}${BOLD}📘 watch Help:${RESET}"
echo -e "${BOLD}Syntax:${RESET} watch [options] command"
echo
echo -e "${BOLD}Useful Options:${RESET}"
echo -e "  -n <seconds>   Set interval in seconds (default: 2)"
echo -e "  -d             Highlight differences between updates"
echo -e "  -t             Turn off header"
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'watch' Examples:${RESET}"

declare -A WATCH_USAGE
WATCH_USAGE["watch date"]="Shows the current time, updating every 2 seconds"
WATCH_USAGE["watch -n 1 free -h"]="Monitors memory usage every 1 second"
WATCH_USAGE["watch -d ls -l"]="Highlights changes in 'ls -l' output"
WATCH_USAGE["watch -t df -h"]="Shows disk usage without header"

for cmd in "${!WATCH_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WATCH_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Simulated task prompt
echo -e "${CYAN}${BOLD}🧪 Time to Practice!${RESET}"
echo "We'll now simulate some real tasks with 'watch'. Type the correct commands."
pause

# Step 4: Task Check Function
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
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive Tasks
ask_and_check \
    "Use watch to display current date every 2 seconds" \
    "Use: watch date" \
    "^watch[[:space:]]+date[[:space:]]*$"

ask_and_check \
    "Monitor memory usage every 1 second" \
    "Use: watch -n 1 free -h" \
    "^watch[[:space:]]+-n[[:space:]]*1[[:space:]]+free[[:space:]]+-h[[:space:]]*$"

ask_and_check \
    "Watch and highlight changes in 'ls -l'" \
    "Use: watch -d ls -l" \
    "^watch[[:space:]]+-d[[:space:]]+ls[[:space:]]+-l[[:space:]]*$"

ask_and_check \
    "Display disk usage using 'df -h' without watch header" \
    "Use: watch -t df -h" \
    "^watch[[:space:]]+-t[[:space:]]+df[[:space:]]+-h[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've mastered the 'watch' command for real-time monitoring!${RESET}"
pause
