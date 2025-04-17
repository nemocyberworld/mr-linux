#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'whereis' Command — Locate Binary, Source, and Man Pages${RESET}"
echo
echo "'whereis' helps you find the binary, source code, and manual page of a command or program in Linux."
echo "It's a fast and simple tool often used to verify installation paths or documentation availability."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔍 Basic usage:${RESET}"
echo -e "${BOLD}➡️ Command: whereis ls${RESET}"
pause
whereis ls
pause

# Step 2: Common options
clear
echo -e "${CYAN}${BOLD}📚 Useful 'whereis' Options and Examples:${RESET}"

declare -A WHEREIS_USAGE
WHEREIS_USAGE["whereis bash"]="Find binary, source, and man page for bash"
WHEREIS_USAGE["whereis -b bash"]="Only show binary path"
WHEREIS_USAGE["whereis -m bash"]="Only show man page location"
WHEREIS_USAGE["whereis -s bash"]="Only show source file location"
WHEREIS_USAGE["whereis -l"]="List all paths that 'whereis' searches"

for cmd in "${!WHEREIS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WHEREIS_USAGE[$cmd]}${RESET}"
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
    "Find all locations (binary, source, man) for 'bash'" \
    "Try: whereis bash" \
    "^whereis[[:space:]]+bash[[:space:]]*$"

ask_and_check \
    "Find only the binary for 'bash'" \
    "Try: whereis -b bash" \
    "^whereis[[:space:]]+-b[[:space:]]+bash[[:space:]]*$"

ask_and_check \
    "Find only the man page for 'bash'" \
    "Try: whereis -m bash" \
    "^whereis[[:space:]]+-m[[:space:]]+bash[[:space:]]*$"

ask_and_check \
    "List all the paths that 'whereis' will search" \
    "Try: whereis -l" \
    "^whereis[[:space:]]+-l[[:space:]]*$"

# Step 4: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'whereis' lesson.${RESET}"
echo -e "🧠 Use 'whereis' when you want to quickly find where a command lives and where its man pages are!"
pause
