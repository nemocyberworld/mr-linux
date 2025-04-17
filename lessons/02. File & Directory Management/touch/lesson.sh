#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📄 Lesson: The 'touch' Command — Create and Update Files${RESET}"
echo
echo "'touch' is used to create new empty files or update timestamps of existing files."
pause

# Step 1: Setup practice environment
echo -e "${BOLD}📦 Setting up practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_touch_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Directory Overview
clear
echo -e "${YELLOW}${BOLD}📁 Starting with an empty directory:${RESET}"
ls -la "$TMPDIR"
pause

# Step 3: Explain 'touch' options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'touch' Command Options and Examples:${RESET}"

declare -A TOUCH_USAGE
TOUCH_USAGE["touch file1.txt"]="Create a new empty file named file1.txt"
TOUCH_USAGE["touch file1.txt file2.txt"]="Create multiple files at once"
TOUCH_USAGE["touch -c file3.txt"]="Don't create the file if it doesn't exist (no error)"
TOUCH_USAGE["touch -t 202504160101 file1.txt"]="Set custom timestamp (YYYYMMDDhhmm)"
TOUCH_USAGE["touch -a file1.txt"]="Change only access time"
TOUCH_USAGE["touch -m file1.txt"]="Change only modification time"

for cmd in "${!TOUCH_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TOUCH_USAGE[$cmd]}${RESET}"
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
    "Create a file named 'notes.txt'" \
    "Try: touch notes.txt" \
    '^touch[[:space:]]+notes\.txt[[:space:]]*$'

ask_and_check \
    "Create two files at once: 'a.txt' and 'b.txt'" \
    "Try: touch a.txt b.txt" \
    '^touch[[:space:]]+a\.txt[[:space:]]+b\.txt[[:space:]]*$'

ask_and_check \
    "Update the modification time of 'notes.txt'" \
    "Try: touch notes.txt" \
    '^touch[[:space:]]+notes\.txt[[:space:]]*$'

ask_and_check \
    "Set the timestamp of 'notes.txt' to April 16, 2025 01:01" \
    "Use: touch -t 202504160101 notes.txt" \
    '^touch[[:space:]]+-t[[:space:]]+202504160101[[:space:]]+notes\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You’ve completed the 'touch' lesson.${RESET}"
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
