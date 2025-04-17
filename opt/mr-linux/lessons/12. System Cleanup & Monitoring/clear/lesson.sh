#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'clear' — Clear Your Terminal Screen${RESET}"
echo
echo -e "The ${YELLOW}clear${RESET} command simply clears all content from your terminal screen."
echo -e "It gives you a clean workspace, which is helpful during long terminal sessions."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}clear${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Example:${RESET}"
echo -e "  Type some commands to fill your screen..."
echo -e "  Then use ${YELLOW}clear${RESET} to wipe everything away."
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_clear_lesson"
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
            echo -e "${RED}❌ Try again. This should be simple!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Clear your terminal screen" \
    "Just type the command that wipes the terminal clean." \
    '^clear\s*$' \
    "Nice! Your screen is now clean."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}clear${RESET} command."
pause
