#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📏 Lesson: The 'wc' Command — Counting Words, Lines, and Characters${RESET}"
echo
echo "'wc' stands for 'word count'. It can count lines, words, characters, and bytes in files or input."
pause

# Step 1: Setup practice environment
TMPDIR="$HOME/.mr_linux_wc_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create sample files
cat <<EOF > sample.txt
Welcome to Mr Linux.
This file has a few lines.
It is for learning the wc command.
EOF

pause

# Step 2: Show file content
clear
echo -e "${YELLOW}${BOLD}📄 File: sample.txt${RESET}"
cat sample.txt
pause

# Step 3: Explain options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'wc' Command Options and Examples:${RESET}"

declare -A WC_USAGE
WC_USAGE["wc sample.txt"]="Display lines, words, and bytes"
WC_USAGE["wc -l sample.txt"]="Count lines only"
WC_USAGE["wc -w sample.txt"]="Count words only"
WC_USAGE["wc -c sample.txt"]="Count bytes"
WC_USAGE["wc -m sample.txt"]="Count characters"
WC_USAGE["echo 'Hello Linux' | wc -w"]="Count words from standard input"

for cmd in "${!WC_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WC_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task function
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
    "Display the number of lines, words, and bytes in 'sample.txt'" \
    "Try: wc sample.txt" \
    '^wc[[:space:]]+sample\.txt[[:space:]]*$'

ask_and_check \
    "Count only the number of lines in 'sample.txt'" \
    "Try: wc -l sample.txt" \
    '^wc[[:space:]]+-l[[:space:]]+sample\.txt[[:space:]]*$'

ask_and_check \
    "Count only the number of words in 'sample.txt'" \
    "Try: wc -w sample.txt" \
    '^wc[[:space:]]+-w[[:space:]]+sample\.txt[[:space:]]*$'

ask_and_check \
    "Count the number of characters in 'sample.txt'" \
    "Try: wc -m sample.txt" \
    '^wc[[:space:]]+-m[[:space:]]+sample\.txt[[:space:]]*$'

ask_and_check \
    "Use 'echo' to count words in the phrase 'Hello Mr Linux'" \
    "Try: echo 'Hello Mr Linux' | wc -w" \
    '^echo[[:space:]]+["'\'']?Hello[[:space:]]+Mr[[:space:]]+Linux["'\'']?[[:space:]]*\|[[:space:]]*wc[[:space:]]+-w[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You’ve completed the 'wc' command lesson!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
