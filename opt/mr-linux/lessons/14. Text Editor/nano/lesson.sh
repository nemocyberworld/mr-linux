#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'nano' Editor — Full Guide${RESET}"
echo
echo "'nano' is a beginner-friendly terminal-based text editor. Perfect for quick edits!"
pause

# Step 1: Setup
echo -e "${BOLD}📦 Setting up a practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_nano_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
echo -e "Line 1\nLine 2\nLine 3\nSearch this line\nAnother line\n" > sample.txt
touch newfile.txt
pause

# Step 2: Intro Commands
clear
echo -e "${CYAN}${BOLD}📚 Basic 'nano' Commands:${RESET}"

declare -A NANO_USAGE
NANO_USAGE["nano filename"]="Open or create a file"
NANO_USAGE["Ctrl + G"]="Display help menu"
NANO_USAGE["Ctrl + O"]="Write (save) file"
NANO_USAGE["Ctrl + X"]="Exit editor"
NANO_USAGE["Ctrl + K"]="Cut a line"
NANO_USAGE["Ctrl + U"]="Paste a line"
NANO_USAGE["Ctrl + W"]="Search text"
NANO_USAGE["Ctrl + _"]="Go to specific line"

for tip in "${!NANO_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${NANO_USAGE[$tip]}${RESET}"
    echo -e "${BOLD}➡️  Shortcut/Command: $tip${RESET}"
    sleep 1
    pause
done

# Step 3: Helper
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

# Step 4: Tasks

ask_and_check \
    "Open sample.txt in nano" \
    "Try: nano sample.txt" \
    '^nano[[:space:]]+sample\.txt[[:space:]]*$' \
    true

echo -e "${BOLD}✍️ Now edit the file manually inside nano:${RESET}"
echo -e "1. Add a line that says: 'This is nano in action!'"
echo -e "2. Save (Ctrl + O), press Enter, then exit (Ctrl + X)"
read -rp "Press Enter when done..."
pause

clear
echo -e "${CYAN}${BOLD}🔍 Verifying your edit...${RESET}"
grep -q "This is nano in action!" sample.txt && echo -e "${GREEN}✅ Edit verified!${RESET}" || echo -e "${RED}❌ Text not found! Try again.${RESET}"
pause

ask_and_check \
    "Create and edit a new file named notes.txt" \
    "Try: nano notes.txt" \
    '^nano[[:space:]]+notes\.txt[[:space:]]*$' \
    true

echo -e "${BOLD}✍️ Inside nano:${RESET}"
echo -e "1. Add at least 2 lines of text"
echo -e "2. Use Ctrl + K to cut one line"
echo -e "3. Use Ctrl + U to paste it back"
echo -e "4. Save and exit"
read -rp "Press Enter when you're done..."
pause

# Step 5: Search Task
ask_and_check \
    "Open sample.txt and search for the word 'Search'" \
    "Hint: Use Ctrl + W inside nano" \
    '^nano[[:space:]]+sample\.txt[[:space:]]*$' \
    true

echo -e "${BOLD}🔍 In nano, press Ctrl + W and type: Search"
echo -e "Then hit Enter to jump to the line."
read -rp "Press Enter when done searching..."
pause

# Step 6: .nanorc and Highlighting
clear
echo -e "${CYAN}${BOLD}🌈 BONUS: Syntax Highlighting with .nanorc${RESET}"
echo
echo "You can enable syntax highlighting by creating a ~/.nanorc file."
pause

cat > "$TMPDIR/.nanorc" <<EOF
syntax "bash" "\.sh$"
color brightgreen "echo"
color brightblue "nano"
color red "exit"
EOF

export NANORC="$TMPDIR/.nanorc"
echo -e '#!/bin/bash\necho "hello"\nexit 0' > script.sh

ask_and_check \
    "Open script.sh with nano to see highlighting" \
    "Try: nano script.sh" \
    '^nano[[:space:]]+script\.sh[[:space:]]*$' \
    true

echo -e "${BOLD}👀 You should see colors for 'echo' and 'exit'.${RESET}"
read -rp "Press Enter when done..."
pause

# Step 7: Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the advanced 'nano' lesson! Amazing work!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
