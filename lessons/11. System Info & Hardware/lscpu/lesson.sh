#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'lscpu' — Display CPU Architecture Info${RESET}"
echo
echo -e "The ${YELLOW}lscpu${RESET} command displays detailed information about the system's CPU architecture."
echo -e "It's a quick and easy way to see how many cores, threads, sockets, and features your CPU has."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}lscpu [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📋 Common Usage:${RESET}"
echo -e "${YELLOW}lscpu${RESET}             → Show all CPU architecture details"
echo -e "${YELLOW}lscpu | grep 'Model name'${RESET} → Show just the CPU model"
echo -e "${YELLOW}lscpu | grep '^CPU(s):'${RESET} → Show total number of CPUs"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_lscpu_lesson"
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
    "Display complete CPU architecture info" \
    "No options needed!" \
    '^lscpu\s*$' \
    "Great! That shows everything about your CPU."

ask_and_check \
    "Display just the CPU model name" \
    "Use grep to filter for 'Model name'" \
    '^lscpu\s*\|\s*grep\s+["'\''"]?Model name["'\''"]?$' \
    "Nice! That gets your exact CPU model."

ask_and_check \
    "Find out how many CPUs (logical processors) are available" \
    "Use grep with '^CPU(s):'" \
    '^lscpu\s*\|\s*grep\s+["'\''"]?\^CPU\(s\):["'\''"]?$' \
    "Awesome! That's the number of logical CPUs."

ask_and_check \
    "Find the number of cores per socket" \
    "Use grep with 'Core(s) per socket'" \
    '^lscpu\s*\|\s*grep\s+["'\''"]?Core\(s\) per socket["'\''"]?$' \
    "Perfect! That tells you how many cores per physical CPU."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📦 Bonus: Count threads, sockets, and virtualization support${RESET}"
echo -e "${GREEN}lscpu | grep Thread${RESET}      → Shows threads per core"
echo -e "${GREEN}lscpu | grep Socket${RESET}      → Number of CPU sockets"
echo -e "${GREEN}lscpu | grep Virtualization${RESET} → Check virtualization support"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}lscpu${RESET} tool for checking CPU info!"
pause
