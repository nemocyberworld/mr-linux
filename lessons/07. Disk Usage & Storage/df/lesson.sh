#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}💾 Lesson: The 'df' Command — Disk Space Usage${RESET}"
echo
echo "'df' (disk free) reports file system disk space usage."
echo "It’s useful for checking how much space is used and available on your drives."
pause

# Practice directory
TMPDIR="$HOME/.mr_linux_df_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Show example output
clear
echo -e "${YELLOW}${BOLD}🔍 Example Output:${RESET}"
echo -e "Let's look at your disk space usage:"
echo
df -h | head -n 10
pause

# Step 2: Show examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'df' Options and Examples:${RESET}"

declare -A DF_USAGE
DF_USAGE["df"]="Basic usage – shows disk usage for all mounted filesystems"
DF_USAGE["df -h"]="Human-readable format (MB/GB)"
DF_USAGE["df -T"]="Show filesystem type"
DF_USAGE["df -i"]="Display inode usage instead of disk blocks"
DF_USAGE["df /"]="Check usage for root directory only"

for cmd in "${!DF_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${DF_USAGE[$cmd]}${RESET}"
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
    "Display disk usage in human-readable format" \
    "Use: df -h" \
    "^df[[:space:]]+-h[[:space:]]*$"

ask_and_check \
    "Display filesystem types with disk usage" \
    "Use: df -T" \
    "^df[[:space:]]+-T[[:space:]]*$"

ask_and_check \
    "Display disk usage for the root filesystem only in human-readable format" \
    "Use: df -h /" \
    "^df[[:space:]]+-h[[:space:]]+/[[:space:]]*$"

# Step 5: Cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
rm -rf "$TMPDIR"
pause
