#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🚚 Lesson: The 'mv' Command — Full Guide${RESET}"
echo
echo "'mv' is used to move or rename files and directories in Linux. It’s essential for organizing data."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Setting up a practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_mv_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test files and directories
echo "This is file1" > file1.txt
echo "This is file2" > file2.txt
mkdir -p folder1 folder2
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📁 Practice environment structure:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Explain 'mv' with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'mv' Command Options and Examples:${RESET}"

declare -A MV_USAGE
MV_USAGE["mv file1.txt file3.txt"]="Rename a file"
MV_USAGE["mv file2.txt folder1/"]="Move a file into a directory"
MV_USAGE["mv -i file3.txt folder1/"]="Interactive move (ask before overwrite)"
MV_USAGE["mv -v file3.txt folder2/"]="Verbose move (shows what is being done)"
MV_USAGE["mv folder1 folder_backup"]="Rename a directory"

for cmd in "${!MV_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${MV_USAGE[$cmd]}${RESET}"
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
    "Rename file1.txt to renamed_file.txt" \
    "Try: mv file1.txt renamed_file.txt" \
    '^mv[[:space:]]+file1\.txt[[:space:]]+renamed_file\.txt[[:space:]]*$'

ask_and_check \
    "Move file2.txt into folder2/" \
    "Try: mv file2.txt folder2/" \
    '^mv[[:space:]]+file2\.txt[[:space:]]+folder2/?[[:space:]]*$'

ask_and_check \
    "Rename folder1 to folder_backup" \
    "Try: mv folder1 folder_backup" \
    '^mv[[:space:]]+folder1[[:space:]]+folder_backup[[:space:]]*$'

ask_and_check \
    "Use the -v flag to move renamed_file.txt to folder2/" \
    "Try: mv -v renamed_file.txt folder2/" \
    '^mv[[:space:]]+-v[[:space:]]+renamed_file\.txt[[:space:]]+folder2/?[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'mv' lesson! Excellent work!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
