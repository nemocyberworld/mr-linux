#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔍 Lesson: The 'find' Command — Powerful File Search Tool${RESET}"
echo
echo "'find' is used to search for files and directories based on various criteria like name, type, size, etc."
pause

# Step 1: Setup practice environment
TMPDIR="$HOME/.mr_linux_find_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test files and folders
mkdir -p folderA folderB folderC
touch folderA/file1.txt folderA/file2.log
touch folderB/file3.txt folderB/data.csv
touch folderC/script.sh folderC/readme.md
find . -type f -exec chmod +x {} \;  # Make all files executable
pause

# Step 2: Show structure
clear
echo -e "${YELLOW}${BOLD}📘 Files and directories used in this lesson:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Explain 'find' options and examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'find' Command Examples:${RESET}"

declare -A FIND_USAGE
FIND_USAGE["find . -name \"file1.txt\""]="Find a file by name"
FIND_USAGE["find . -type d"]="Find all directories"
FIND_USAGE["find . -type f -name \"*.txt\""]="Find all .txt files"
FIND_USAGE["find . -size +1k"]="Find files larger than 1KB"
FIND_USAGE["find . -executable"]="Find all executable files"
FIND_USAGE["find . -name \"*.sh\" -exec chmod -x {} \;"]="Find all .sh files and remove executable permission"

for cmd in "${!FIND_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${FIND_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checker
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-true}"

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

# Step 5: Interactive Tasks
ask_and_check \
    "Find the file named 'file3.txt'" \
    "Try: find . -name \"file3.txt\"" \
    '^find[[:space:]]+\.[[:space:]]+-name[[:space:]]+"?file3\.txt"?[[:space:]]*$'

ask_and_check \
    "Find all directories in the current path" \
    "Try: find . -type d" \
    '^find[[:space:]]+\.[[:space:]]+-type[[:space:]]+d[[:space:]]*$'

ask_and_check \
    "Find all .log files" \
    "Try: find . -name \"*.log\"" \
    '^find[[:space:]]+\.[[:space:]]+-name[[:space:]]+"?\*\.log"?[[:space:]]*$'

ask_and_check \
    "Find files larger than 1KB" \
    "Try: find . -size +1k" \
    '^find[[:space:]]+\.[[:space:]]+-size[[:space:]]+\+1k[[:space:]]*$'

ask_and_check \
    "Find all executable files" \
    "Try: find . -executable" \
    '^find[[:space:]]+\.[[:space:]]+-executable[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've mastered the basics of 'find'!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
