#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📄 Lesson: The 'tail' Command — View the End of Files${RESET}"
echo
echo "'tail' is used to display the last lines of a file. It's commonly used for logs or files where new content is appended at the end."
pause

# Step 1: Setup practice environment
echo -e "${BOLD}📦 Creating practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_tail_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create a sample file
for i in {1..20}; do echo "Line $i" >> file.txt; done
pause

# Step 2: Show the content of the file
clear
echo -e "${YELLOW}${BOLD}📘 Content of file.txt:${RESET}"
cat file.txt
pause

# Step 3: Show tail options with examples
clear
echo -e "${CYAN}${BOLD}📚 'tail' Command Options and Examples:${RESET}"

declare -A TAIL_USAGE
TAIL_USAGE["tail file.txt"]="Show the last 10 lines of the file"
TAIL_USAGE["tail -n 5 file.txt"]="Show the last 5 lines"
TAIL_USAGE["tail -n +15 file.txt"]="Show the file starting from line 15"
TAIL_USAGE["tail -f file.txt"]="Follow the file (live updates, useful for logs)"

for cmd in "${!TAIL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TAIL_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checking function
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
    "Show the last 10 lines of file.txt" \
    "Use: tail file.txt" \
    '^tail[[:space:]]+file\.txt[[:space:]]*$'

ask_and_check \
    "Show only the last 3 lines of file.txt" \
    "Use: tail -n 3 file.txt" \
    '^tail[[:space:]]+-n[[:space:]]+3[[:space:]]+file\.txt[[:space:]]*$'

ask_and_check \
    "Show lines from line 15 onward in file.txt" \
    "Use: tail -n +15 file.txt" \
    '^tail[[:space:]]+-n[[:space:]]+\+15[[:space:]]+file\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You’ve finished the 'tail' lesson.${RESET}"
echo -e "🧹 Cleaning up practice files..."
rm -rf "$TMPDIR"
pause
