#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'uptime' — How Long Has Your System Been Running?${RESET}"
echo
echo -e "${YELLOW}uptime${RESET} displays how long the system has been running, how many users are currently logged in, and the system load averages."
echo
echo -e "${BOLD}📌 Basic Syntax:${RESET}"
echo -e "  ${GREEN}uptime${RESET}"
echo
echo -e "${BOLD}🔍 Example Output:${RESET}"
echo -e "  ${GRAY}14:38:16 up 3 days, 2:17,  2 users,  load average: 0.00, 0.03, 0.05${RESET}"
echo
echo -e "${BOLD}What each part means:${RESET}"
echo -e "  🕓 ${CYAN}14:38:16${RESET} — current system time"
echo -e "  🔋 ${CYAN}up 3 days, 2:17${RESET} — how long the system has been running"
echo -e "  👤 ${CYAN}2 users${RESET} — how many users are logged in"
echo -e "  📊 ${CYAN}load average: 0.00, 0.03, 0.05${RESET} — system load in the last 1, 5, and 15 minutes"
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
            echo -e "${RED}❌ Not quite. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Display system uptime" \
    "Use the basic command." \
    '^uptime\s*$' \
    "Correct! This shows system uptime and load."

ask_and_check \
    "Check current load average values" \
    "These are included in the output of uptime." \
    '^uptime\s*$' \
    "Nice! Load average gives insight into CPU load over time."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🤓 Fun Fact:${RESET}"
echo -e "The load average values show how busy the CPU is. A value of 1.00 on a single-core CPU means it's fully utilized."
pause

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo -e "You’ve learned how to use the ${YELLOW}uptime${RESET} command to check how long the system has been running and the current load status."
pause
