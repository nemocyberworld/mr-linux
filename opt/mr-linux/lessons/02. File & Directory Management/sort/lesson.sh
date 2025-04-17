#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔤 Lesson: The 'sort' Command — Sorting Text Files in Linux${RESET}"
echo
echo "'sort' arranges the lines of text files in a specified order — alphabetical, numerical, or custom."
pause

# Step 1: Setup environment
TMPDIR="$HOME/.mr_linux_sort_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test files
cat <<EOF > names.txt
Zebra
apple
Orange
banana
Cat
dog
EOF

cat <<EOF > numbers.txt
42
7
13
3
101
58
EOF

pause

# Step 2: Show content
clear
echo -e "${YELLOW}${BOLD}📄 Sample Files:${RESET}"
echo -e "${BOLD}names.txt:${RESET}"; cat names.txt; echo
echo -e "${BOLD}numbers.txt:${RESET}"; cat numbers.txt
pause

# Step 3: Explain options
clear
echo -e "${CYAN}${BOLD}📚 Useful 'sort' Command Options and Examples:${RESET}"

declare -A SORT_USAGE
SORT_USAGE["sort names.txt"]="Sort lines alphabetically (uppercase before lowercase)"
SORT_USAGE["sort -f names.txt"]="Case-insensitive alphabetical sort"
SORT_USAGE["sort -r names.txt"]="Reverse alphabetical order"
SORT_USAGE["sort numbers.txt"]="Sort numbers as strings (not ideal)"
SORT_USAGE["sort -n numbers.txt"]="Sort numbers numerically"
SORT_USAGE["sort -nr numbers.txt"]="Sort numbers in descending numeric order"
SORT_USAGE["sort -u names.txt"]="Remove duplicate lines during sort"

for cmd in "${!SORT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${SORT_USAGE[$cmd]}${RESET}"
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
    "Sort 'names.txt' in alphabetical order" \
    "Try: sort names.txt" \
    '^sort[[:space:]]+names\.txt[[:space:]]*$'

ask_and_check \
    "Sort 'names.txt' in case-insensitive order" \
    "Try: sort -f names.txt" \
    '^sort[[:space:]]+-f[[:space:]]+names\.txt[[:space:]]*$'

ask_and_check \
    "Sort 'numbers.txt' in ascending numeric order" \
    "Try: sort -n numbers.txt" \
    '^sort[[:space:]]+-n[[:space:]]+numbers\.txt[[:space:]]*$'

ask_and_check \
    "Sort 'numbers.txt' in descending numeric order" \
    "Try: sort -nr numbers.txt" \
    '^sort[[:space:]]+-nr[[:space:]]+numbers\.txt[[:space:]]*$'

ask_and_check \
    "Sort 'names.txt' and remove duplicates" \
    "Try: sort -u names.txt" \
    '^sort[[:space:]]+-u[[:space:]]+names\.txt[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You’ve completed the 'sort' command lesson!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
