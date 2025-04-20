#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📘 Lesson: The 'sed' Command — Stream Editor Guide${RESET}"
echo
echo "'sed' is a stream editor used to perform basic text transformations on input from files or piped data."
pause

# Step 1: Setup environment
TMPDIR="$HOME/.mr_linux_sed_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

cat <<EOF > fruits.txt
apple
banana
cherry
banana
grape
EOF

pause

# Step 2: Show original file
clear
echo -e "${YELLOW}${BOLD}📄 File: fruits.txt${RESET}"
cat fruits.txt
pause

# Step 3: Explain sed options with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'sed' Examples:${RESET}"

declare -A SED_USAGE
SED_USAGE["sed 's/banana/orange/' fruits.txt"]="Replace first occurrence of 'banana' with 'orange'"
SED_USAGE["sed 's/banana/orange/g' fruits.txt"]="Replace all 'banana' with 'orange' globally"
SED_USAGE["sed '2d' fruits.txt"]="Delete line 2"
SED_USAGE["sed -n '2p' fruits.txt"]="Print only line 2"
SED_USAGE["sed 's/^/fruit: /' fruits.txt"]="Add 'fruit: ' at the beginning of each line"
SED_USAGE["sed 's/$/ is tasty/' fruits.txt"]="Add ' is tasty' at the end of each line"

for cmd in "${!SED_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${SED_USAGE[$cmd]}${RESET}"
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

# Step 5: Interactive Tasks
ask_and_check \
    "Replace first 'banana' with 'orange'" \
    "Use: sed 's/banana/orange/' fruits.txt" \
    "^sed[[:space:]]+'s/banana/orange/'[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Replace all 'banana' with 'orange'" \
    "Use: sed 's/banana/orange/g' fruits.txt" \
    "^sed[[:space:]]+'s/banana/orange/g'[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Delete line 2 from fruits.txt" \
    "Use: sed '2d' fruits.txt" \
    "^sed[[:space:]]+'2d'[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Print only line 2 from fruits.txt" \
    "Use: sed -n '2p' fruits.txt" \
    "^sed[[:space:]]+-n[[:space:]]+'2p'[[:space:]]+fruits\.txt[[:space:]]*$"

ask_and_check \
    "Add 'fruit: ' at the beginning of each line" \
    "Use: sed 's/^/fruit: /' fruits.txt" \
    "^sed[[:space:]]+'s/\\^/fruit: /'[[:space:]]+fruits\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Excellent! You’ve completed the 'sed' command lesson!${RESET}"
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
