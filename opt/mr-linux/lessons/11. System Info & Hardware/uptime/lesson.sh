#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'uptime' — System Uptime and Load${RESET}"
echo
echo -e "The ${YELLOW}uptime${RESET} command tells you:"
echo -e "  - How long the system has been running"
echo -e "  - How many users are currently logged in"
echo -e "  - The system load averages (1, 5, 15 minutes)"
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}uptime${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Example Output:${RESET}"
echo -e "  ${GREEN}$(uptime)${RESET}"
echo
echo -e "${YELLOW}Load Average:${RESET} These numbers represent how busy your CPU(s) are."
echo -e "  - A value of 1.00 means full usage of a single CPU core."
echo -e "  - On a 4-core CPU, a load of 4.00 means full usage."
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_uptime_lesson"
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
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Check how long the system has been running" \
    "Just use the command on its own." \
    '^uptime\s*$' \
    "Perfect! That's your system's uptime and load info."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}💡 Bonus Tip:${RESET}"
echo -e "You can also get load averages from:"
echo -e "  ${YELLOW}cat /proc/loadavg${RESET}"
echo -e "Or use ${YELLOW}w${RESET} to see uptime and who is logged in."
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}uptime${RESET} command."
pause
