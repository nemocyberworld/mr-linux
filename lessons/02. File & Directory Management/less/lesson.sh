#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'less' Command — Full Guide${RESET}"
echo
echo "'less' is a pager command used to view large files one screen at a time."
echo "It allows scrolling forward/backward, searching, and more — all without loading the entire file into memory."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Creating practice directory structure...${RESET}"
TMPDIR="$HOME/.mr_linux_less_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test files
seq 1 200 > longfile.txt
echo -e "${GREEN}Generated: longfile.txt with 200 lines (numbers 1 to 200)${RESET}"
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📘 Files used in this lesson:${RESET}"
ls -lh "$TMPDIR"
pause

# Step 3: All less usage examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'less' Command Examples and Controls:${RESET}"

declare -A LESS_USAGE
LESS_USAGE["less longfile.txt"]="Open file with less"
LESS_USAGE["(Inside less) q"]="Quit the viewer"
LESS_USAGE["(Inside less) /search_term"]="Search for 'search_term'"
LESS_USAGE["(Inside less) n"]="Next search match"
LESS_USAGE["(Inside less) b"]="Scroll back one page"
LESS_USAGE["(Inside less) space"]="Scroll forward one page"
LESS_USAGE["less +50 longfile.txt"]="Start viewing from line 50"
LESS_USAGE["less -N longfile.txt"]="Show line numbers"

for cmd in "${!LESS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${LESS_USAGE[$cmd]}${RESET}"
    [[ "$cmd" =~ ^less ]] && echo -e "${BOLD}➡️  Example: $cmd${RESET}"
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
    "View the contents of 'longfile.txt' using less" \
    "Try: less longfile.txt" \
    '^less[[:space:]]+longfile\.txt[[:space:]]*$'

ask_and_check \
    "Open 'longfile.txt' with line numbers displayed" \
    "Try: less -N longfile.txt" \
    '^less[[:space:]]+-N[[:space:]]+longfile\.txt[[:space:]]*$'

ask_and_check \
    "Start viewing from line 50 in longfile.txt" \
    "Try: less +50 longfile.txt" \
    '^less[[:space:]]+\+50[[:space:]]+longfile\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'less' lesson! Great job!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
