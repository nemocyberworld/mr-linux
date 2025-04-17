#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'cp' Command — Full Guide${RESET}"
echo
echo "'cp' is used to copy files and directories in Linux. It's essential for file management tasks."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Creating practice directory structure...${RESET}"
TMPDIR="$HOME/.mr_linux_cp_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test files and directories
echo "This is file1" > file1.txt
mkdir -p folder1
echo "Inside folder1" > folder1/file2.txt
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📘 Files and directories used in this lesson:${RESET}"
tree "$TMPDIR"
pause

# Step 3: All cp options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'cp' Command Options and Examples:${RESET}"

declare -A CP_USAGE
CP_USAGE["cp file1.txt file1_copy.txt"]="Copy a file to a new file"
CP_USAGE["cp -i file1.txt file1_copy.txt"]="Prompt before overwriting (interactive)"
CP_USAGE["cp -v file1.txt file1_copy.txt"]="Show what is being copied (verbose)"
CP_USAGE["cp file1.txt folder1/"]="Copy file into a directory"
CP_USAGE["cp -r folder1 folder_copy"]="Recursively copy a directory"
CP_USAGE["cp -u file1.txt file1_copy.txt"]="Copy only if the source is newer"

for cmd in "${!CP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CP_USAGE[$cmd]}${RESET}"
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
    "Copy 'file1.txt' to 'copy1.txt'" \
    "Try: cp file1.txt copy1.txt" \
    '^cp[[:space:]]+file1\.txt[[:space:]]+copy1\.txt[[:space:]]*$'

ask_and_check \
    "Copy 'file1.txt' into folder1/" \
    "Try: cp file1.txt folder1/" \
    '^cp[[:space:]]+file1\.txt[[:space:]]+folder1/?[[:space:]]*$'

ask_and_check \
    "Recursively copy folder1 to folder_backup" \
    "Try: cp -r folder1 folder_backup" \
    '^cp[[:space:]]+-r[[:space:]]+folder1[[:space:]]+folder_backup[[:space:]]*$'

ask_and_check \
    "Copy 'file1.txt' to copy2.txt with verbose output" \
    "Try: cp -v file1.txt copy2.txt" \
    '^cp[[:space:]]+-v[[:space:]]+file1\.txt[[:space:]]+copy2\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'cp' lesson! Great job!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
