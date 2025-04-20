#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'cd' Command — Full Guide${RESET}"
echo
echo "'cd' (change directory) is used to navigate between directories in the filesystem."
pause

# Step 1: Setup practice directories
echo -e "${BOLD}📦 Creating practice directory structure...${RESET}"
TMPDIR="$HOME/.mr_linux_cd_practice"
mkdir -p "$TMPDIR/dir1/dir1a" "$TMPDIR/dir2"
cd "$TMPDIR" || exit 1
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📘 Directories used in this lesson:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Show all options and examples for 'cd'
clear
echo -e "${CYAN}${BOLD}📚 All Useful Ways to Use 'cd':${RESET}"

declare -A CD_USAGE
CD_USAGE["cd /"]="Go to root directory"
CD_USAGE["cd ~"]="Go to home directory"
CD_USAGE["cd .."]="Go up one directory level"
CD_USAGE["cd -"]="Go to previous directory"
CD_USAGE["cd ."]="Stay in the current directory (no-op)"
CD_USAGE["cd dir1"]="Go to a subdirectory (relative path)"
CD_USAGE["cd \$HOME"]="Go to home using variable"
CD_USAGE["cd ~/../"]="Go to parent of home"
CD_USAGE["cd ./dir1"]="Go to subdirectory using relative path"

for cmd in "${!CD_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CD_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checking function
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
            break
            # eval "$user_cmd"
            # break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive tasks

ask_and_check \
    "Go to your home directory" \
    "Try: cd ~" \
    '^cd[[:space:]]+(~|\$HOME)[[:space:]]*$'

ask_and_check \
    "Move into 'dir1' from current directory" \
    "Try: cd dir1" \
    '^cd[[:space:]]+dir1[[:space:]]*$'

ask_and_check \
    "Go to subdirectory 'dir1a' using relative path './'" \
    "Try: cd ./dir1a" \
    '^cd[[:space:]]+\./dir1a[[:space:]]*$'

ask_and_check \
    "Go back to parent directory using '..'" \
    "Try: cd .." \
    '^cd[[:space:]]+\.\.[[:space:]]*$'

ask_and_check \
    "Return to previous directory using '-'" \
    "Try: cd -" \
    '^cd[[:space:]]+-[[:space:]]*$'

ask_and_check \
    "Stay in the current directory using '.'" \
    "Try: cd ." \
    '^cd[[:space:]]+\.[[:space:]]*$'

# Done
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'cd' lesson! Well done!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
