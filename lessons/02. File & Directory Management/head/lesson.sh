#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'head' Command — Full Guide${RESET}"
echo
echo "'head' is used to display the first lines of a file. By default, it shows the first 10 lines."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Creating practice directory structure...${RESET}"
TMPDIR="$HOME/.mr_linux_head_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test file
seq 1 50 > numbers.txt
echo -e "${GREEN}Generated file: numbers.txt with 50 lines (numbers 1 to 50)${RESET}"
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📘 Files used in this lesson:${RESET}"
ls -lh "$TMPDIR"
pause

# Step 3: All head options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'head' Command Options and Examples:${RESET}"

declare -A HEAD_USAGE
HEAD_USAGE["head numbers.txt"]="Show the first 10 lines of the file"
HEAD_USAGE["head -n 5 numbers.txt"]="Show the first 5 lines"
HEAD_USAGE["head -n 20 numbers.txt"]="Show the first 20 lines"
HEAD_USAGE["head -c 10 numbers.txt"]="Show the first 10 bytes of the file"
HEAD_USAGE["head -q numbers.txt"]="Suppress headers when multiple files are given (quiet)"
HEAD_USAGE["head -v numbers.txt"]="Always print headers when multiple files are given (verbose)"

for cmd in "${!HEAD_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${HEAD_USAGE[$cmd]}${RESET}"
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
    "Show the first 10 lines of numbers.txt" \
    "Try: head numbers.txt" \
    '^head[[:space:]]+numbers\.txt[[:space:]]*$'

ask_and_check \
    "Show only the first 5 lines" \
    "Try: head -n 5 numbers.txt" \
    '^head[[:space:]]+-n[[:space:]]*5[[:space:]]+numbers\.txt[[:space:]]*$'

ask_and_check \
    "Show the first 15 lines" \
    "Try: head -n 15 numbers.txt" \
    '^head[[:space:]]+-n[[:space:]]*15[[:space:]]+numbers\.txt[[:space:]]*$'

ask_and_check \
    "Display the first 10 bytes of numbers.txt" \
    "Try: head -c 10 numbers.txt" \
    '^head[[:space:]]+-c[[:space:]]*10[[:space:]]+numbers\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'head' lesson! Great job!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
