#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'dmesg' — Kernel Message Buffer${RESET}"
echo
echo -e "${YELLOW}dmesg${RESET} prints the messages from the kernel ring buffer."
echo "These messages are usually system boot logs, hardware info, driver activity, and kernel events."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}dmesg${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Common Usage:${RESET}"

echo -e "${YELLOW}View all boot-time logs:${RESET}"
echo -e "  ${GREEN}dmesg${RESET}"

echo -e "\n${YELLOW}Filter messages related to USB:${RESET}"
echo -e "  ${GREEN}dmesg | grep -i usb${RESET}"

echo -e "\n${YELLOW}Follow real-time kernel logs (like tail -f):${RESET}"
echo -e "  ${GREEN}dmesg --follow${RESET}"

echo -e "\n${YELLOW}Show human-readable timestamps:${RESET}"
echo -e "  ${GREEN}dmesg -T${RESET}"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_dmesg_lesson"
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
    "View the full kernel log buffer" \
    "Just run the command without any options." \
    '^dmesg\s*$' \
    "Correct! You just printed the kernel ring buffer."

ask_and_check \
    "Show human-readable timestamps in kernel logs" \
    "Use the -T option." \
    '^dmesg\s+-T$' \
    "Nice! Timestamps now show real dates."

ask_and_check \
    "Find USB-related messages" \
    "Pipe it with grep and search for 'usb' (case-insensitive)." \
    '^dmesg\s*\|\s*grep\s+-i\s+usb$' \
    "Awesome! You've filtered kernel messages for USB."

ask_and_check \
    "Watch kernel messages in real-time" \
    "Use the option that follows the buffer output as it changes." \
    '^dmesg\s+--follow$' \
    "Perfect! You're watching the kernel logs live."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}dmesg${RESET} command."
pause
