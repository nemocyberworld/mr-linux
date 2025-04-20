#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'journalctl' — View Systemd Journal Logs${RESET}"
echo
echo -e "${YELLOW}journalctl${RESET} is used to query and display logs from the systemd journal."
echo "It provides powerful filtering and formatting options."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}journalctl [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Common Options:${RESET}"

echo -e "${YELLOW}View all logs:${RESET}"
echo -e "  ${GREEN}journalctl${RESET}"

echo -e "\n${YELLOW}View logs from current boot:${RESET}"
echo -e "  ${GREEN}journalctl -b${RESET}"

echo -e "\n${YELLOW}Follow logs (like tail -f):${RESET}"
echo -e "  ${GREEN}journalctl -f${RESET}"

echo -e "\n${YELLOW}View logs for a specific service (e.g. ssh):${RESET}"
echo -e "  ${GREEN}journalctl -u ssh.service${RESET}"

echo -e "\n${YELLOW}Limit output to recent logs:${RESET}"
echo -e "  ${GREEN}journalctl -n 20${RESET}"

pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_journalctl_lesson"
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
    "View all logs available on the system" \
    "No flags, just the base command." \
    '^journalctl\s*$' \
    "Perfect! That's how you see all logs."

ask_and_check \
    "View logs only from the current boot" \
    "There’s a flag that means 'boot'." \
    '^journalctl\s+-b$' \
    "Nice! Now you're reading only today's logs."

ask_and_check \
    "Follow the logs in real-time" \
    "Like tail -f for journalctl." \
    '^journalctl\s+-f$' \
    "Awesome! Real-time logs in action."

ask_and_check \
    "Show logs for the SSH service" \
    "Look for logs of sshd (systemd unit name)." \
    '^journalctl\s+-u\s+ssh(\.service)?$' \
    "Yes! You've filtered logs by service."

ask_and_check \
    "Limit output to the 20 most recent log entries" \
    "Use -n for number of lines." \
    '^journalctl\s+-n\s+20$' \
    "Great! That shows the latest 20 logs."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You’ve now mastered the ${YELLOW}journalctl${RESET} command for log inspection."
pause
