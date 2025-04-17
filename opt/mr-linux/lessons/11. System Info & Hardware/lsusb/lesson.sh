#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'lsusb' — List USB Devices${RESET}"
echo
echo -e "The ${YELLOW}lsusb${RESET} command lists all USB buses and devices connected to your system."
echo -e "It's useful for identifying USB peripherals like flash drives, keyboards, webcams, and more."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}lsusb [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📋 Common Examples:${RESET}"
echo -e "${YELLOW}lsusb${RESET}                  → List all USB devices"
echo -e "${YELLOW}lsusb -v${RESET}               → Verbose output (detailed device info)"
echo -e "${YELLOW}lsusb -s 001:004${RESET}       → Show details for a specific device"
echo -e "${YELLOW}lsusb -t${RESET}               → Display devices as a tree"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_lsusb_lesson"
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
    "List all connected USB devices" \
    "Just run lsusb with no arguments." \
    '^lsusb\s*$' \
    "Great! You now see all USB-connected devices."

ask_and_check \
    "Get detailed info about USB devices" \
    "Use the verbose flag." \
    '^lsusb\s+-v\s*$' \
    "Awesome! Now you can view descriptor-level data."

ask_and_check \
    "Show USB devices in a tree view format" \
    "Use a flag that displays topology." \
    '^lsusb\s+-t\s*$' \
    "Nice! That shows how USB devices are connected hierarchically."

ask_and_check \
    "Find info for a specific USB device (bus:device)" \
    "Use the -s option with format like 001:004." \
    '^lsusb\s+-s\s+[0-9]{3}:[0-9]{3}\s*$' \
    "Perfect! You can now isolate a single USB device."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📦 Bonus Tip:${RESET}"
echo -e "Combine with grep to filter by device name:"
echo -e "${GREEN}lsusb | grep -i 'camera'${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}lsusb${RESET} tool for inspecting USB hardware."
pause
