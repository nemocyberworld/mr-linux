#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'ls' Command — Full Guide${RESET}"
echo
echo "'ls' is used to list files and directories. It's one of the most commonly used commands in Linux."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Setting up a practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_ls_practice"
mkdir -p "$TMPDIR/testdir/subdir"
cd "$TMPDIR" || exit 1
touch file1.txt file2.log .hiddenfile
ln -s file1.txt symlink
chmod +x file2.log
pause

# Step 2: Show current structure
clear
echo -e "${YELLOW}${BOLD}📘 Directory contents:${RESET}"
tree "$TMPDIR"
pause

# Step 3: All ls options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'ls' Command Options and Examples:${RESET}"

declare -A LS_USAGE
LS_USAGE["ls"]="List files in current directory"
LS_USAGE["ls -l"]="Long listing format"
LS_USAGE["ls -a"]="Include hidden files"
LS_USAGE["ls -lh"]="Human-readable file sizes"
LS_USAGE["ls -R"]="Recursive listing"
LS_USAGE["ls -t"]="Sort by modification time"
LS_USAGE["ls -S"]="Sort by file size"
LS_USAGE["ls -i"]="Show inode numbers"
LS_USAGE["ls -F"]="Classify file types with symbols"
LS_USAGE["ls -d */"]="List only directories"

for cmd in "${!LS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${LS_USAGE[$cmd]}${RESET}"
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
    "List all files in the current directory" \
    "Try: ls" \
    '^ls[[:space:]]*$'

ask_and_check \
    "List files with detailed info (permissions, size, etc)" \
    "Try: ls -l" \
    '^ls[[:space:]]+-l[[:space:]]*$'

ask_and_check \
    "Include hidden files in the listing" \
    "Try: ls -a" \
    '^ls[[:space:]]+-a[[:space:]]*$'

ask_and_check \
    "Show human-readable file sizes in long format" \
    "Try: ls -lh" \
    '^ls[[:space:]]+-lh[[:space:]]*$'

ask_and_check \
    "Recursively list files and directories" \
    "Try: ls -R" \
    '^ls[[:space:]]+-R[[:space:]]*$'

ask_and_check \
    "List only subdirectories (ending with /)" \
    "Try: ls -d */" \
    '^ls[[:space:]]+-d[[:space:]]+\*/[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'ls' lesson! Excellent work!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
