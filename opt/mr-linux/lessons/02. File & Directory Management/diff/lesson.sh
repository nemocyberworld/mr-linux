#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📑 Lesson: The 'diff' Command — File Comparison Tool${RESET}"
echo
echo "'diff' is used to compare files line by line and show differences."
echo "It's especially useful for developers, sysadmins, and script writers."
pause

# Step 1: Setup practice directory
TMPDIR="$HOME/.mr_linux_diff_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo -e "${BOLD}📁 Creating example files for practice...${RESET}"
cat <<EOF > file1.txt
line 1: apples
line 2: bananas
line 3: cherries
EOF

cat <<EOF > file2.txt
line 1: apples
line 2: blueberries
line 3: cherries
EOF

cat <<EOF > file3.txt
line 1: apples
line 2: bananas
line 3: cherries
line 4: dragonfruit
EOF
pause

# Step 2: Basic diff example
clear
echo -e "${YELLOW}${BOLD}📘 Basic 'diff' usage:${RESET}"
echo -e "${BOLD}➡️  Command: diff file1.txt file2.txt${RESET}"
pause
diff file1.txt file2.txt
pause

# Step 3: Useful options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'diff' Options and Examples:${RESET}"

declare -A DIFF_USAGE
DIFF_USAGE["diff file1.txt file2.txt"]="Show line-by-line differences"
DIFF_USAGE["diff -u file1.txt file2.txt"]="Unified format (used in patches)"
DIFF_USAGE["diff -c file1.txt file2.txt"]="Context format"
DIFF_USAGE["diff -y file1.txt file3.txt"]="Side-by-side comparison"
DIFF_USAGE["diff --suppress-common-lines -y file1.txt file3.txt"]="Side-by-side but hide matching lines"

for cmd in "${!DIFF_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${DIFF_USAGE[$cmd]}${RESET}"
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
    "Compare file1.txt and file2.txt using basic diff" \
    "Try: diff file1.txt file2.txt" \
    "^diff[[:space:]]+file1\.txt[[:space:]]+file2\.txt[[:space:]]*$"

ask_and_check \
    "Compare file1.txt and file3.txt using unified format" \
    "Try: diff -u file1.txt file3.txt" \
    "^diff[[:space:]]+-u[[:space:]]+file1\.txt[[:space:]]+file3\.txt[[:space:]]*$"

ask_and_check \
    "Compare file1.txt and file3.txt side-by-side" \
    "Try: diff -y file1.txt file3.txt" \
    "^diff[[:space:]]+-y[[:space:]]+file1\.txt[[:space:]]+file3\.txt[[:space:]]*$"

ask_and_check \
    "Use side-by-side comparison and suppress common lines" \
    "Try: diff --suppress-common-lines -y file1.txt file3.txt" \
    "^diff[[:space:]]+--suppress-common-lines[[:space:]]+-y[[:space:]]+file1\.txt[[:space:]]+file3\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You’ve completed the 'diff' lesson.${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
