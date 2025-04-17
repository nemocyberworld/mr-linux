#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'xargs' — Build and Execute Command Lines from Standard Input${RESET}"
echo
echo -e "${YELLOW}xargs${RESET} reads items from standard input and executes a command using them as arguments."
echo
echo -e "${BOLD}📌 Basic Syntax:${RESET}"
echo -e "  ${GREEN}command | xargs <another_command>${RESET}"
echo
echo -e "${BOLD}🔍 Example:${RESET}"
echo -e "  ${GRAY}echo file1 file2 | xargs rm${RESET} — Removes file1 and file2 by passing them as arguments to rm."
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_xargs_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Prepare files
touch apple.txt banana.txt cherry.txt

ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧪 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Not quite. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "List all '.txt' files and remove them using xargs." \
    "Use: ls *.txt | xargs rm" \
    '^ls +\*\.txt *\| *xargs +rm *$' \
    "Nice job! You used xargs to remove multiple files from a list."

# Re-create files for next tasks
touch apple.txt banana.txt cherry.txt

ask_and_check \
    "Use find to locate all '.txt' files and delete them using xargs." \
    "Try: find . -name '*.txt' | xargs rm" \
    '^find +\. +-name +["\047]?\\?*\.txt["\047]? *\| *xargs +rm *$' \
    "Perfect! You combined find and xargs like a pro."

# Re-create files again
touch apple.txt banana.txt cherry.txt

ask_and_check \
    "Use xargs with echo to prefix each file with 'Processing:'" \
    "Try: ls *.txt | xargs -I {} echo Processing: {}" \
    '^ls +\*\.txt *\| *xargs +-I +\{\} +echo +Processing: +\{\} *$' \
    "Awesome! You used placeholders with -I {} correctly."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧠 Bonus Tip:${RESET}"
echo -e "Use ${YELLOW}xargs -0${RESET} with ${YELLOW}find -print0${RESET} to safely handle filenames with spaces:"
echo -e "  ${GRAY}find . -name \"*.txt\" -print0 | xargs -0 rm${RESET}"
pause

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo -e "You’ve learned how to use ${YELLOW}xargs${RESET} to pass arguments from one command to another efficiently!"
pause
