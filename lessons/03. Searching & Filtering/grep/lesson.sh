#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔍 Lesson: The 'grep' Command — Pattern Matching in Text${RESET}"
echo
echo "'grep' is a command-line tool for searching plain-text data for lines that match a regular expression."
echo "It’s widely used to filter output or search through files efficiently."
pause

# Step 1: Setup practice directory
TMPDIR="$HOME/.mr_linux_grep_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo -e "${BOLD}📁 Creating example files...${RESET}"
cat <<EOF > fruits.txt
apple
banana
cherry
blueberry
pineapple
orange
grapefruit
EOF

cat <<EOF > animals.txt
dog
cat
dolphin
elephant
antelope
ant
EOF
pause

# Step 2: Basic grep usage
clear
echo -e "${YELLOW}${BOLD}📘 Basic 'grep' usage:${RESET}"
echo -e "${BOLD}➡️  Command: grep 'apple' fruits.txt${RESET}"
pause
grep 'apple' fruits.txt
pause

# Step 3: Useful options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'grep' Options and Examples:${RESET}"

declare -A GREP_USAGE
GREP_USAGE["grep 'ant' animals.txt"]="Match 'ant' in each line"
GREP_USAGE["grep -i 'APPLE' fruits.txt"]="Case-insensitive search"
GREP_USAGE["grep -v 'apple' fruits.txt"]="Invert match: show lines not containing 'apple'"
GREP_USAGE["grep -n 'berry' fruits.txt"]="Show line numbers"
GREP_USAGE["grep -E '^a.*e$' animals.txt"]="Use extended regex to match lines starting with 'a' and ending in 'e'"

for cmd in "${!GREP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${GREP_USAGE[$cmd]}${RESET}"
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
    "Search for lines that contain the word 'apple' in fruits.txt" \
    "Try: grep 'apple' fruits.txt" \
    "^grep[[:space:]]+'?apple'?[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Perform a case-insensitive search for 'apple' in fruits.txt" \
    "Try: grep -i 'apple' fruits.txt" \
    "^grep[[:space:]]+-i[[:space:]]+'?apple'?[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Search for lines that do NOT contain 'apple' in fruits.txt" \
    "Try: grep -v 'apple' fruits.txt" \
    "^grep[[:space:]]+-v[[:space:]]+'?apple'?[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Search for lines containing 'berry' and show line numbers" \
    "Try: grep -n 'berry' fruits.txt" \
    "^grep[[:space:]]+-n[[:space:]]+'?berry'?[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Use regex to find animals starting with 'a' and ending with 'e'" \
    "Try: grep -E '^a.*e$' animals.txt" \
    "^grep[[:space:]]+-E[[:space:]]+'?\^a\.\*e\$'?[[:space:]]+animals\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You’ve completed the 'grep' lesson.${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
