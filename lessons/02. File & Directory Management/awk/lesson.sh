#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📘 Lesson: The 'awk' Command — Pattern Scanning & Processing${RESET}"
echo
echo "'awk' is a powerful text-processing tool that works with columns and patterns in text files."
pause

# Step 1: Setup practice environment
TMPDIR="$HOME/.mr_linux_awk_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create test file
cat <<EOF > employees.txt
Name Age Department
Alice 30 HR
Bob 25 IT
Carol 35 Finance
Dave 28 IT
Eve 40 HR
EOF

pause

# Step 2: Show file content
clear
echo -e "${YELLOW}${BOLD}📄 File: employees.txt${RESET}"
cat employees.txt
pause

# Step 3: Explain options with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'awk' Examples:${RESET}"

declare -A AWK_USAGE
AWK_USAGE["awk '{print \$1}' employees.txt"]="Print first column (Names)"
AWK_USAGE["awk '{print \$2}' employees.txt"]="Print second column (Ages)"
AWK_USAGE["awk '{print \$1, \$3}' employees.txt"]="Print name and department"
AWK_USAGE["awk '\$2 > 30 {print \$1}' employees.txt"]="Print names where age > 30"
AWK_USAGE["awk '/IT/ {print \$1}' employees.txt"]="Print names in IT department"
AWK_USAGE["awk 'NR > 1 {print \$1}' employees.txt"]="Skip header and print names"

for cmd in "${!AWK_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${AWK_USAGE[$cmd]}${RESET}"
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
    "Print the first column (Names) from 'employees.txt'" \
    "Use: awk '{print \$1}' employees.txt" \
    "^awk[[:space:]]+'?\{print[[:space:]]*\\\$1\}'?[[:space:]]+employees\.txt[[:space:]]*$"

ask_and_check \
    "Print names and departments only" \
    "Use: awk '{print \$1, \$3}' employees.txt" \
    "^awk[[:space:]]+'?\{print[[:space:]]*\\\$1,[[:space:]]*\\\$3\}'?[[:space:]]+employees\.txt[[:space:]]*$"

ask_and_check \
    "Print names of employees older than 30" \
    "Use: awk '\$2 > 30 {print \$1}' employees.txt" \
    "^awk[[:space:]]+'?\\\$2[[:space:]]*>[[:space:]]*30[[:space:]]*\{print[[:space:]]*\\\$1\}'?[[:space:]]+employees\.txt[[:space:]]*$"

ask_and_check \
    "Skip the header and print only the names" \
    "Use: awk 'NR > 1 {print \$1}' employees.txt" \
    "^awk[[:space:]]+'?NR[[:space:]]*>[[:space:]]*1[[:space:]]*\{print[[:space:]]*\\\$1\}'?[[:space:]]+employees\.txt[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'awk' lesson successfully!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
