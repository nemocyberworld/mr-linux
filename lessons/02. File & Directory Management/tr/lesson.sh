#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔤 Lesson: The 'tr' Command — Translate or Delete Characters${RESET}"
echo
echo "'tr' is used to translate, squeeze, or delete characters from standard input. It does not read files directly."
pause

# Step 1: Setup practice directory and test file
TMPDIR="$HOME/.mr_linux_tr_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

cat <<EOF > sample.txt
hello world
HELLO WORLD
123456
EOF

pause

# Step 2: Show file content
clear
echo -e "${YELLOW}${BOLD}📄 File: sample.txt${RESET}"
cat sample.txt
pause

# Step 3: Explain tr options with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'tr' Examples:${RESET}"

declare -A TR_USAGE
TR_USAGE["cat sample.txt | tr 'a-z' 'A-Z'"]="Convert lowercase to uppercase"
TR_USAGE["cat sample.txt | tr 'A-Z' 'a-z'"]="Convert uppercase to lowercase"
TR_USAGE["echo '112233' | tr -s '2'"]="Squeeze repeated '2's into one"
TR_USAGE["echo 'hello 123' | tr -d '0-9'"]="Delete digits"
TR_USAGE["echo 'hello world' | tr ' ' '\\n'"]="Replace spaces with newlines"

for cmd in "${!TR_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TR_USAGE[$cmd]}${RESET}"
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
    "Translate lowercase to uppercase using 'sample.txt'" \
    "Try: cat sample.txt | tr 'a-z' 'A-Z'" \
    "^cat[[:space:]]+sample\.txt[[:space:]]*\|[[:space:]]*tr[[:space:]]+'a-z'[[:space:]]+'A-Z'[[:space:]]*$"

ask_and_check \
    "Translate uppercase to lowercase using 'sample.txt'" \
    "Try: cat sample.txt | tr 'A-Z' 'a-z'" \
    "^cat[[:space:]]+sample\.txt[[:space:]]*\|[[:space:]]*tr[[:space:]]+'A-Z'[[:space:]]+'a-z'[[:space:]]*$"

ask_and_check \
    "Delete digits from 'hello 123'" \
    "Try: echo 'hello 123' | tr -d '0-9'" \
    "^echo[[:space:]]+'hello[[:space:]]123'[[:space:]]*\|[[:space:]]*tr[[:space:]]+-d[[:space:]]+'0-9'[[:space:]]*$"

ask_and_check \
    "Replace spaces with newlines in 'hello world'" \
    "Try: echo 'hello world' | tr ' ' '\\n'" \
    "^echo[[:space:]]+'hello[[:space:]]world'[[:space:]]*\|[[:space:]]*tr[[:space:]]+' '[[:space:]]+'\\\\n'[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'tr' command lesson!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
