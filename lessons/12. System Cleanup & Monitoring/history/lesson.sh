#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'history' — View Your Command History${RESET}"
echo
echo -e "${YELLOW}history${RESET} displays the list of previously run commands in your current shell session."
echo "It's useful for recalling and reusing past commands."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}history${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Common Usage:${RESET}"

echo -e "${YELLOW}View your command history:${RESET}"
echo -e "  ${GREEN}history${RESET}"

echo -e "\n${YELLOW}Search history for a keyword:${RESET}"
echo -e "  ${GREEN}history | grep ssh${RESET}"

echo -e "\n${YELLOW}Repeat a previous command by its number (e.g., 100):${RESET}"
echo -e "  ${GREEN}!100${RESET}"

echo -e "\n${YELLOW}Clear history for current session:${RESET}"
echo -e "  ${GREEN}history -c${RESET}"

pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_history_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

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
    "Display your command history" \
    "Just use the command by itself." \
    '^history\s*$' \
    "Correct! You've viewed your history."

ask_and_check \
    "Search your history for any command involving 'cd'" \
    "Use grep to filter history." \
    '^history\s*\|\s*grep\s+cd$' \
    "Nice! You've searched your history for 'cd'."

ask_and_check \
    "Clear the current session's command history" \
    "There is an option to clear history." \
    '^history\s+-c$' \
    "Boom! Your shell history is now clean."

ask_and_check \
    "Repeat a command using its history number" \
    "You need to use an exclamation mark (!) followed by a number." \
    '^!\d+$' \
    "Awesome! You've repeated a past command using its number."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've learned how to use the ${YELLOW}history${RESET} command like a pro."
pause
