#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}✂️ Lesson: The 'cut' Command — Extracting Fields from Text${RESET}"
echo
echo "'cut' is used to extract sections from each line of input. You can cut by character, byte, or field."
pause

# Step 1: Setup practice environment
TMPDIR="$HOME/.mr_linux_cut_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create sample file
cat <<EOF > data.csv
Name,Age,Location
Alice,30,New York
Bob,25,California
Carol,35,Texas
EOF

pause

# Step 2: Show file content
clear
echo -e "${YELLOW}${BOLD}📄 File: data.csv${RESET}"
cat data.csv
pause

# Step 3: Explain options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'cut' Command Options and Examples:${RESET}"

declare -A CUT_USAGE
CUT_USAGE["cut -d',' -f1 data.csv"]="Cut first field using ',' as delimiter (Names)"
CUT_USAGE["cut -d',' -f2 data.csv"]="Cut second field (Ages)"
CUT_USAGE["cut -d',' -f3 data.csv"]="Cut third field (Location)"
CUT_USAGE["cut -d',' -f1,3 data.csv"]="Cut multiple fields (Name and Location)"
CUT_USAGE["cut -c1-5 data.csv"]="Cut the first 5 characters from each line"

for cmd in "${!CUT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CUT_USAGE[$cmd]}${RESET}"
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
    "Cut the first field (Name) from 'data.csv'" \
    "Use: cut -d',' -f1 data.csv" \
    '^cut[[:space:]]+-d[[:space:]]*['"'"']?,['"'"']?[[:space:]]+-f[[:space:]]*1[[:space:]]+data\.csv[[:space:]]*$'

ask_and_check \
    "Cut the second field (Age) from 'data.csv'" \
    "Use: cut -d',' -f2 data.csv" \
    '^cut[[:space:]]+-d[[:space:]]*['"'"']?,['"'"']?[[:space:]]+-f[[:space:]]*2[[:space:]]+data\.csv[[:space:]]*$'

ask_and_check \
    "Cut the first and third fields (Name and Location)" \
    "Use: cut -d',' -f1,3 data.csv" \
    '^cut[[:space:]]+-d[[:space:]]*['"'"']?,['"'"']?[[:space:]]+-f[[:space:]]*1,3[[:space:]]+data\.csv[[:space:]]*$'

ask_and_check \
    "Cut first 5 characters of each line in 'data.csv'" \
    "Use: cut -c1-5 data.csv" \
    '^cut[[:space:]]+-c[[:space:]]*1-5[[:space:]]+data\.csv[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You’ve completed the 'cut' command lesson!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
