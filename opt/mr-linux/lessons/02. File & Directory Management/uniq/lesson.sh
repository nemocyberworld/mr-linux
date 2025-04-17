#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔁 Lesson: The 'uniq' Command — Find Unique or Repeated Lines${RESET}"
echo
echo "'uniq' filters out or displays duplicate lines from input. It usually works on **sorted input**."
pause

# Step 1: Setup practice directory and input file
TMPDIR="$HOME/.mr_linux_uniq_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

cat <<EOF > names.txt
Alice
Bob
Bob
Charlie
Charlie
Charlie
David
EOF

pause

# Step 2: Show the content of file
clear
echo -e "${YELLOW}${BOLD}📄 File: names.txt${RESET}"
cat names.txt
pause

# Step 3: Show uniq options with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'uniq' Command Options and Examples:${RESET}"

declare -A UNIQ_USAGE
UNIQ_USAGE["uniq names.txt"]="Remove adjacent duplicates"
UNIQ_USAGE["sort names.txt | uniq"]="Ensure duplicates are grouped before removing"
UNIQ_USAGE["uniq -c names.txt"]="Count occurrences of each line"
UNIQ_USAGE["uniq -d names.txt"]="Show only duplicated lines"
UNIQ_USAGE["uniq -u names.txt"]="Show only unique (non-repeated) lines"

for cmd in "${!UNIQ_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${UNIQ_USAGE[$cmd]}${RESET}"
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
    "Show unique lines (remove adjacent duplicates) from names.txt" \
    "Try: uniq names.txt" \
    "^uniq[[:space:]]+names\.txt[[:space:]]*$"

ask_and_check \
    "Sort names.txt and remove duplicates (safest method)" \
    "Try: sort names.txt | uniq" \
    "^sort[[:space:]]+names\.txt[[:space:]]*\|[[:space:]]*uniq[[:space:]]*$"

ask_and_check \
    "Count number of occurrences for each line" \
    "Try: uniq -c names.txt" \
    "^uniq[[:space:]]+-c[[:space:]]+names\.txt[[:space:]]*$"

ask_and_check \
    "Show only lines that appear more than once" \
    "Try: uniq -d names.txt" \
    "^uniq[[:space:]]+-d[[:space:]]+names\.txt[[:space:]]*$"

ask_and_check \
    "Show only lines that appear once (not repeated)" \
    "Try: uniq -u names.txt" \
    "^uniq[[:space:]]+-u[[:space:]]+names\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You've finished the 'uniq' command lesson!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
