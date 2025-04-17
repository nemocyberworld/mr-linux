#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📖 Lesson: The 'man' Command — Linux Manual Pages${RESET}"
echo
echo "'man' stands for manual. It displays the manual pages for commands — like a built-in help guide."
pause

# Step 1: Setup (No files needed)
TMPDIR="$HOME/.mr_linux_man_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Explain 'man' with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'man' Command Examples:${RESET}"

declare -A MAN_USAGE
MAN_USAGE["man ls"]="Show manual page for 'ls'"
MAN_USAGE["man -k copy"]="Search man pages by keyword"
MAN_USAGE["man 5 passwd"]="Show section 5 of 'passwd' (file formats)"
MAN_USAGE["man -f ls"]="Display short description (same as whatis)"
MAN_USAGE["man -a passwd"]="Show all man pages for 'passwd', one by one"

for cmd in "${!MAN_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${MAN_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 3: Task checker
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-true}"

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

# Step 4: Interactive tasks
ask_and_check \
    "View the manual page for 'ls'" \
    "Try: man ls" \
    '^man[[:space:]]+ls[[:space:]]*$'

ask_and_check \
    "Search for manual entries related to the keyword 'copy'" \
    "Try: man -k copy" \
    '^man[[:space:]]+-k[[:space:]]+copy[[:space:]]*$'

ask_and_check \
    "Show the section 5 man page for 'passwd'" \
    "Try: man 5 passwd" \
    '^man[[:space:]]+5[[:space:]]+passwd[[:space:]]*$'

ask_and_check \
    "Use 'man -f' to describe the 'ls' command" \
    "Try: man -f ls" \
    '^man[[:space:]]+-f[[:space:]]+ls[[:space:]]*$'

ask_and_check \
    "Display all man pages available for 'passwd'" \
    "Try: man -a passwd" \
    '^man[[:space:]]+-a[[:space:]]+passwd[[:space:]]*$'

# Step 5: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You've learned how to use the 'man' command like a pro!${RESET}"
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
