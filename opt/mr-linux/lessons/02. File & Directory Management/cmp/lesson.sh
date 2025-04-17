#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔍 Lesson: The 'cmp' Command — Byte-by-Byte File Comparison${RESET}"
echo
echo "'cmp' is used to compare two files byte by byte."
echo "It is useful to check whether two files are identical or where they differ."
pause

# Step 1: Setup practice directory
TMPDIR="$HOME/.mr_linux_cmp_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo -e "${BOLD}📁 Creating sample files for testing...${RESET}"
echo "This is file one." > file1.txt
echo "This is file one." > file2.txt
echo "This is slightly different." > file3.txt
pause

# Step 2: Show basic example
clear
echo -e "${YELLOW}${BOLD}🔬 Basic Comparison:${RESET}"
echo -e "${BOLD}➡️  Command: cmp file1.txt file2.txt${RESET}"
pause
cmp file1.txt file2.txt && echo "✅ Files are identical"
pause

echo -e "${BOLD}➡️  Command: cmp file1.txt file3.txt${RESET}"
pause
cmp file1.txt file3.txt || echo "❌ Files are different"
pause

# Step 3: Show options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'cmp' Options and Examples:${RESET}"

declare -A CMP_USAGE
CMP_USAGE["cmp file1.txt file2.txt"]="Compare two files silently (no output if identical)"
CMP_USAGE["cmp -l file1.txt file3.txt"]="Print byte-by-byte differences (decimal/hex)"
CMP_USAGE["cmp -s file1.txt file3.txt"]="Silent mode — return code only, no output"

for cmd in "${!CMP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CMP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Interactive Task Function
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
                eval "$user_cmd"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Tasks
ask_and_check \
    "Compare file1.txt and file2.txt using cmp" \
    "Try: cmp file1.txt file2.txt" \
    "^cmp[[:space:]]+file1\.txt[[:space:]]+file2\.txt[[:space:]]*$"

ask_and_check \
    "Use cmp to compare file1.txt and file3.txt and show differences byte by byte" \
    "Try: cmp -l file1.txt file3.txt" \
    "^cmp[[:space:]]+-l[[:space:]]+file1\.txt[[:space:]]+file3\.txt[[:space:]]*$"

ask_and_check \
    "Use cmp in silent mode to compare file1.txt and file3.txt" \
    "Try: cmp -s file1.txt file3.txt" \
    "^cmp[[:space:]]+-s[[:space:]]+file1\.txt[[:space:]]+file3\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'cmp' command lesson.${RESET}"
echo -e "🧹 Cleaning up practice files..."
rm -rf "$TMPDIR"
pause
