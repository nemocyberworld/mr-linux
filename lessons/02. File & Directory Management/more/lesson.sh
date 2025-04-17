#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📄 Lesson: The 'more' Command — Full Guide${RESET}"
echo
echo "'more' is used to view the contents of files one screen at a time, especially useful for long files."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Setting up a practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_more_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create a large test file
echo -e "${YELLOW}🛠️ Generating a long file to practice with...${RESET}"
yes "This is a line in the file." | head -n 100 > bigfile.txt
echo "End of file" >> bigfile.txt
pause

# Step 2: Show file preview
clear
echo -e "${YELLOW}${BOLD}📘 File: bigfile.txt preview (head -n 5):${RESET}"
head -n 5 bigfile.txt
pause

# Step 3: Explain 'more' with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'more' Command Options and Examples:${RESET}"

declare -A MORE_USAGE
MORE_USAGE["more bigfile.txt"]="View contents of a file one screen at a time"
MORE_USAGE["cat bigfile.txt | more"]="Pipe long output into 'more'"
MORE_USAGE["more +10 bigfile.txt"]="Start displaying from line 10"
MORE_USAGE["more -d bigfile.txt"]="Display [Press space to continue, 'q' to quit]"

for cmd in "${!MORE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${MORE_USAGE[$cmd]}${RESET}"
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
    "View 'bigfile.txt' one screen at a time" \
    "Try: more bigfile.txt" \
    '^more[[:space:]]+bigfile\.txt[[:space:]]*$'

ask_and_check \
    "Start reading 'bigfile.txt' from line 10" \
    "Try: more +10 bigfile.txt" \
    '^more[[:space:]]+\+10[[:space:]]+bigfile\.txt[[:space:]]*$'

ask_and_check \
    "Pipe output of cat into 'more'" \
    "Try: cat bigfile.txt | more" \
    '^cat[[:space:]]+bigfile\.txt[[:space:]]*\|[[:space:]]*more[[:space:]]*$'

ask_and_check \
    "Use the -d option to show hints while reading" \
    "Try: more -d bigfile.txt" \
    '^more[[:space:]]+-d[[:space:]]+bigfile\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'more' lesson! Well done!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
