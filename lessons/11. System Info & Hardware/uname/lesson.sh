#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'uname' — System Information${RESET}"
echo
echo -e "The ${YELLOW}uname${RESET} command prints system information."
echo -e "It's useful for identifying the kernel, architecture, and operating system."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}uname [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📋 Common Options:${RESET}"
echo -e "${YELLOW}uname${RESET}              → Print the kernel name (default)"
echo -e "${YELLOW}uname -r${RESET}           → Kernel release"
echo -e "${YELLOW}uname -v${RESET}           → Kernel version"
echo -e "${YELLOW}uname -m${RESET}           → Machine hardware name"
echo -e "${YELLOW}uname -a${RESET}           → All available system information"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_uname_lesson"
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
    "Print the kernel name" \
    "Run uname without any options." \
    '^uname\s*$' \
    "Correct! That's the system's kernel name."

ask_and_check \
    "Print the kernel release version" \
    "Use a flag to get the kernel release." \
    '^uname\s+-r\s*$' \
    "Nice! Now you know which kernel release is running."

ask_and_check \
    "Print the machine architecture" \
    "Look for an option that reveals hardware architecture." \
    '^uname\s+-m\s*$' \
    "Good job! That's the system's hardware architecture."

ask_and_check \
    "Print all available system info" \
    "There's a flag that shows everything in one go." \
    '^uname\s+-a\s*$' \
    "Awesome! That’s a full snapshot of system info."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}💡 Extra Tip:${RESET}"
echo -e "Use ${GREEN}uname -o${RESET} to print the operating system (on supported systems)."
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've mastered the ${YELLOW}uname${RESET} command for inspecting system info."
pause
