#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'free' — Check Memory Usage${RESET}"
echo
echo -e "The ${YELLOW}free${RESET} command shows the amount of used and available memory in your system."
echo -e "It reports RAM and swap usage in human-readable format."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}free [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📊 Output Fields:${RESET}"
echo -e "  ${YELLOW}total${RESET}     — Total memory"
echo -e "  ${YELLOW}used${RESET}      — Memory currently in use"
echo -e "  ${YELLOW}free${RESET}      — Unused memory"
echo -e "  ${YELLOW}shared${RESET}    — Memory used by tmpfs"
echo -e "  ${YELLOW}buff/cache${RESET} — Buffers + cache"
echo -e "  ${YELLOW}available${RESET} — Memory available to apps"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}⚙️ Common Options:${RESET}"
echo -e "${YELLOW}-b${RESET}   → Show output in bytes"
echo -e "${YELLOW}-k${RESET}   → Kilobytes (default)"
echo -e "${YELLOW}-m${RESET}   → Megabytes"
echo -e "${YELLOW}-g${RESET}   → Gigabytes"
echo -e "${YELLOW}-h${RESET}   → Human-readable (auto unit)"
echo -e "${YELLOW}-s [N]${RESET} → Update output every N seconds (like a monitor)"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_free_lesson"
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
    "Display memory info in human-readable format" \
    "Use the -h option" \
    '^free\s+-h$' \
    "Perfect! That shows memory in GB/MB."

ask_and_check \
    "Display memory usage in megabytes" \
    "Use the -m flag" \
    '^free\s+-m$' \
    "Great! Megabytes are often easier to read than KB."

ask_and_check \
    "Check memory stats every 2 seconds" \
    "Use -s with 2" \
    '^free\s+-s\s+2$' \
    "Exactly! That lets you monitor usage in real-time."

ask_and_check \
    "Display output in gigabytes" \
    "Use -g" \
    '^free\s+-g$' \
    "Correct! Great for systems with lots of RAM."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've learned how to use ${YELLOW}free${RESET} to monitor system memory!"
pause
