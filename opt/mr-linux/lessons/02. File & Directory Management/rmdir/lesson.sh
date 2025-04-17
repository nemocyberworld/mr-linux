#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🗑️ Lesson: The 'rmdir' Command — Remove Empty Directories${RESET}"
echo
echo "'rmdir' is used to remove **empty directories** in Linux. It will not work if the directory contains files or other subdirectories."
pause

# Step 1: Setup practice environment
echo -e "${BOLD}📦 Creating practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_rmdir_practice"
mkdir -p "$TMPDIR/dir_empty" "$TMPDIR/dir_nonempty"
echo "Sample content" > "$TMPDIR/dir_nonempty/file.txt"
cd "$TMPDIR" || exit 1
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📁 Practice environment structure:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Explain rmdir with examples
clear
echo -e "${CYAN}${BOLD}📚 'rmdir' Command Usage and Examples:${RESET}"

declare -A RMDIR_USAGE
RMDIR_USAGE["rmdir dir_empty"]="Remove an empty directory"
RMDIR_USAGE["rmdir dir_nonempty"]="Will fail: directory not empty"
RMDIR_USAGE["rmdir -p dir1/dir2/dir3"]="Remove directory and parent directories if empty"

for cmd in "${!RMDIR_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${RMDIR_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checker
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-false}"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive tasks
ask_and_check \
    "Remove the empty directory named 'dir_empty'" \
    "Use: rmdir dir_empty" \
    '^rmdir[[:space:]]+dir_empty[[:space:]]*$'

ask_and_check \
    "Try removing 'dir_nonempty' and see the error message" \
    "Use: rmdir dir_nonempty" \
    '^rmdir[[:space:]]+dir_nonempty[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'rmdir' lesson!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
