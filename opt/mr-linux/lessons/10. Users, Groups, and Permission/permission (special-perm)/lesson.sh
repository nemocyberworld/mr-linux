#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Lesson: Special Permissions in Linux (SUID, SGID, Sticky Bit)${RESET}"
echo
echo "Learn to apply advanced permissions using chmod: Set User ID, Set Group ID, and the Sticky Bit."
pause

# Setup
TMPDIR="$HOME/.mr_linux_special"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

touch suid_file sgid_file
mkdir sticky_dir

# Section: Help and Examples
clear
echo -e "${CYAN}${BOLD}📚 Special Permission Examples${RESET}"

declare -A EXAMPLES
EXAMPLES["chmod 4755 suid_file"]="Set SUID: Runs as file owner (4xxx)"
EXAMPLES["chmod 2755 sgid_file"]="Set SGID: Runs as group (2xxx)"
EXAMPLES["chmod 1777 sticky_dir"]="Set Sticky Bit: Only owner can delete (1xxx)"
EXAMPLES["ls -l"]="Shows special bits as 's' or 't' in permissions"

for cmd in "${!EXAMPLES[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${EXAMPLES[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Section: Interactive Tasks
ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            eval "$user_cmd"
            break
        else
            echo -e "${RED}❌ Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Tasks

ask_and_check \
    "Set SUID on suid_file" \
    "Use chmod 4755 suid_file" \
    '^chmod[[:space:]]+4755[[:space:]]+suid_file$' \
    "SUID set! This file will now run with owner's privileges."

ask_and_check \
    "Set SGID on sgid_file" \
    "Use chmod 2755 sgid_file" \
    '^chmod[[:space:]]+2755[[:space:]]+sgid_file$' \
    "SGID set! This file runs with group privileges."

ask_and_check \
    "Set Sticky Bit on sticky_dir" \
    "Use chmod 1777 sticky_dir" \
    '^chmod[[:space:]]+1777[[:space:]]+sticky_dir$' \
    "Sticky Bit applied! Only owners can delete inside this dir."

ask_and_check \
    "List permissions to verify special bits" \
    "Use ls -l" \
    '^ls[[:space:]]+-l$' \
    "Permissions displayed! Look for s or t in the mode string."

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 You’ve mastered special permissions in Linux!${RESET}"
echo "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
