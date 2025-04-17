#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}💾 Lesson: The 'lsblk' Command — List Block Devices${RESET}"
echo
echo "'lsblk' lists information about block devices (e.g., hard drives, SSDs, USBs)."
echo "It's useful to view partitions and mounted filesystems."
pause

# Step 1: Show example output
clear
echo -e "${YELLOW}${BOLD}🔍 Example Output:${RESET}"
echo -e "Let's run 'lsblk' to see your current block devices:"
echo
lsblk
pause

# Step 2: Show usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'lsblk' Options and Examples:${RESET}"

declare -A LSB_USAGE
LSB_USAGE["lsblk"]="Default list of block devices"
LSB_USAGE["lsblk -f"]="Shows filesystems and labels"
LSB_USAGE["lsblk -a"]="Shows all devices, including empty ones"
LSB_USAGE["lsblk -o NAME,SIZE,TYPE,MOUNTPOINT"]="Custom columns"
LSB_USAGE["lsblk -d"]="List only device, no partitions"

for cmd in "${!LSB_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${LSB_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Interactive task system
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 4: Tasks
ask_and_check \
    "List block devices along with filesystem info" \
    "Use: lsblk -f" \
    "^lsblk[[:space:]]+-f[[:space:]]*$"

ask_and_check \
    "List all block devices including empty ones" \
    "Use: lsblk -a" \
    "^lsblk[[:space:]]+-a[[:space:]]*$"

ask_and_check \
    "Display only device names, sizes, types, and mountpoints" \
    "Use: lsblk -o NAME,SIZE,TYPE,MOUNTPOINT" \
    "^lsblk[[:space:]]+-o[[:space:]]+NAME,SIZE,TYPE,MOUNTPOINT[[:space:]]*$"

# Step 5: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
pause
