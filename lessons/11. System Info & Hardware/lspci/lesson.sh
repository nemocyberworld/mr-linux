#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'lspci' — List PCI Devices${RESET}"
echo
echo -e "The ${YELLOW}lspci${RESET} command shows all PCI buses and devices connected to them."
echo -e "Useful for identifying hardware like graphics cards, network cards, etc."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}lspci [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📋 Common Examples:${RESET}"
echo -e "${YELLOW}lspci${RESET}                     → Show basic list of all PCI devices"
echo -e "${YELLOW}lspci -v${RESET}                  → Verbose output (more details)"
echo -e "${YELLOW}lspci -nn${RESET}                 → Show numeric vendor/device codes"
echo -e "${YELLOW}lspci -k${RESET}                  → Show kernel drivers used"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_lspci_lesson"
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
    "List all PCI devices" \
    "Just run lspci with no options." \
    '^lspci\s*$' \
    "Great! That shows all PCI-connected devices."

ask_and_check \
    "List PCI devices with detailed information" \
    "Use the -v flag for verbose." \
    '^lspci\s+-v\s*$' \
    "Awesome! That's a more detailed output."

ask_and_check \
    "List PCI devices showing numeric device/vendor IDs" \
    "Try using -nn." \
    '^lspci\s+-nn\s*$' \
    "Nice! Now you can match devices to specific chipsets."

ask_and_check \
    "Find out what kernel drivers are used for each PCI device" \
    "Use the -k flag." \
    '^lspci\s+-k\s*$' \
    "Perfect! That shows driver bindings."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📦 Bonus Tip:${RESET}"
echo -e "Combine flags like: ${GREEN}lspci -vnnk${RESET} for full details including driver and IDs."
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}lspci${RESET} tool for PCI hardware inspection."
pause
