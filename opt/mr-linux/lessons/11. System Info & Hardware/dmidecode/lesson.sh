#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧬 Lesson: dmidecode – BIOS & Hardware Details${RESET}"
echo
echo -e "The ${YELLOW}dmidecode${RESET} command displays low-level system hardware information"
echo "by reading data from the DMI (Desktop Management Interface) tables."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}sudo dmidecode [options]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧠 What kind of info can dmidecode show?${RESET}"
echo
echo "- BIOS version and release date"
echo "- System manufacturer and serial number"
echo "- Motherboard model"
echo "- Memory device info (RAM slots, size, type)"
echo "- CPU socket info"
echo "- UUID and product name"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}⚙️ Commonly used options:${RESET}"
echo
echo -e "${YELLOW}-t [type]${RESET} → Filter by DMI type (e.g. bios, system, memory)"
echo -e "${YELLOW}-s [keyword]${RESET} → Display a specific string field (e.g. system-serial-number)"
echo
echo -e "${BOLD}Examples:${RESET}"
echo -e "  ${GREEN}sudo dmidecode -t bios${RESET}"
echo -e "  ${GREEN}sudo dmidecode -t memory${RESET}"
echo -e "  ${GREEN}sudo dmidecode -s system-serial-number${RESET}"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_dmidecode_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your answer: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Try again!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Show full BIOS information" \
    "Use the -t flag with the type 'bios'" \
    '^sudo\s+dmidecode\s+-t\s+bios$' \
    "Nice! That will print BIOS details like vendor, version, and date."

ask_and_check \
    "Display system manufacturer info only" \
    "Use the -s flag with 'system-manufacturer'" \
    '^sudo\s+dmidecode\s+-s\s+system-manufacturer$' \
    "Correct! That's how you get a single field."

ask_and_check \
    "Check memory device information (RAM slots)" \
    "Use the -t flag with 'memory'" \
    '^sudo\s+dmidecode\s+-t\s+memory$' \
    "Perfect! That will show each memory slot’s size and type."

ask_and_check \
    "Find the system’s serial number" \
    "Hint: Try using -s with 'system-serial-number'" \
    '^sudo\s+dmidecode\s+-s\s+system-serial-number$' \
    "Excellent! That's how you fetch the serial number."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo "Now you can explore your system’s low-level hardware info using dmidecode."
pause
