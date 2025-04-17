#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'locate' Command — Fast File Search Using a Database${RESET}"
echo
echo "'locate' is a command-line utility used to quickly find file paths on your system using a prebuilt database."
echo "Unlike 'find', it's much faster because it doesn't scan directories live — it looks things up in an index."
pause

# Step 1: Setup info
echo -e "${BOLD}ℹ️ Make sure the 'mlocate' package is installed and the database is updated using 'updatedb'.${RESET}"
echo "The 'locate' command won't find recently created files unless the database has been updated."
pause

# Step 2: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔍 Basic usage:${RESET}"
echo -e "${BOLD}➡️ Command: locate bash${RESET}"
pause
locate bash | head -n 10
pause

# Step 3: Useful options
clear
echo -e "${CYAN}${BOLD}📚 Useful 'locate' Options and Examples:${RESET}"

declare -A LOCATE_USAGE
LOCATE_USAGE["locate bash"]="Find all paths containing 'bash'"
LOCATE_USAGE["locate -i BASH"]="Case-insensitive search"
LOCATE_USAGE["locate --regex '/bin/.*sh$'"]="Regex search (e.g. shells ending with 'sh' in /bin)"
LOCATE_USAGE["locate passwd | grep '/etc/'"]="Filter results using 'grep'"
LOCATE_USAGE["updatedb"]="Update the file location database (requires sudo)"

for cmd in "${!LOCATE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${LOCATE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Tasks
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
                eval "$user_cmd" | head -n 10
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
    "Find paths containing the string 'passwd'" \
    "Try: locate passwd" \
    "^locate[[:space:]]+passwd[[:space:]]*$"

ask_and_check \
    "Do a case-insensitive search for 'BASH'" \
    "Try: locate -i BASH" \
    "^locate[[:space:]]+-i[[:space:]]+BASH[[:space:]]*$"

ask_and_check \
    "Use grep to filter only results in the /etc directory when searching for 'passwd'" \
    "Try: locate passwd | grep '/etc/'" \
    "^locate[[:space:]]+passwd[[:space:]]*\|[[:space:]]*grep[[:space:]]+'/etc/'[[:space:]]*$"

ask_and_check \
    "Use regex to search for paths in /bin that end with 'sh'" \
    "Try: locate --regex '/bin/.*sh$'" \
    "^locate[[:space:]]+--regex[[:space:]]+'/bin/.*sh\$'[[:space:]]*$"

ask_and_check \
    "Update the locate database" \
    "Try: sudo updatedb" \
    "^sudo[[:space:]]+updatedb[[:space:]]*$" \
    true

# Step 5: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Excellent! You've completed the 'locate' lesson.${RESET}"
echo -e "⚠️  Note: The results of 'locate' may be out of date until 'updatedb' is run."
pause
