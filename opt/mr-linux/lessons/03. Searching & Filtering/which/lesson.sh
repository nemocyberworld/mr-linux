#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'which' Command — Locate Executable Path${RESET}"
echo
echo "'which' shows the full path of the executable that would be run when a command is entered."
echo "It's useful for verifying the exact binary being used, especially when multiple versions exist."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔍 Basic usage:${RESET}"
echo -e "${BOLD}➡️ Command: which ls${RESET}"
pause
which ls
pause

# Step 2: Useful Examples
clear
echo -e "${CYAN}${BOLD}📚 'which' Command Examples:${RESET}"

declare -A WHICH_USAGE
WHICH_USAGE["which bash"]="Find the location of the 'bash' shell binary"
WHICH_USAGE["which python"]="Find the currently active Python binary"
WHICH_USAGE["which grep"]="Locate the 'grep' executable"
WHICH_USAGE["which --skip-alias ls"]="Ignore aliases and locate real binary (if supported)"

for cmd in "${!WHICH_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WHICH_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 3: Tasks
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
                eval "$user_cmd"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Find the full path to the 'bash' binary" \
    "Try: which bash" \
    "^which[[:space:]]+bash[[:space:]]*$"

ask_and_check \
    "Find where 'grep' is located on your system" \
    "Try: which grep" \
    "^which[[:space:]]+grep[[:space:]]*$"

ask_and_check \
    "Find the active Python executable path" \
    "Try: which python or which python3" \
    "^which[[:space:]]+python[[:digit:]]?[[:space:]]*$"

# Step 4: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You’ve completed the 'which' command lesson.${RESET}"
echo -e "🧠 Use 'which' to confirm which executable will run from your PATH."
pause
