#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📍 Lesson: The 'pwd' Command — Print Working Directory${RESET}"
echo
echo "'pwd' stands for 'Print Working Directory'. It displays the full path of the current directory you're in."
pause

# Step 1: Setup practice environment
echo -e "${BOLD}📦 Creating practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_pwd_practice"
mkdir -p "$TMPDIR/dir1/dir2"
cd "$TMPDIR/dir1/dir2" || exit 1
pause

# Step 2: Show directory structure
clear
echo -e "${YELLOW}${BOLD}📁 Practice environment structure:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Explain pwd with examples
clear
echo -e "${CYAN}${BOLD}📚 'pwd' Command Usage and Examples:${RESET}"
echo
echo -e "${YELLOW}💬 Show the current working directory:${RESET}"
echo -e "${BOLD}➡️  Example: pwd${RESET}"
pause

echo
echo -e "${YELLOW}💬 Using 'pwd' inside a nested folder:${RESET}"
echo -e "${BOLD}➡️  Example: cd $TMPDIR/dir1/dir2 && pwd${RESET}"
pause

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
    "Print your current working directory" \
    "Use: pwd" \
    '^pwd[[:space:]]*$'

ask_and_check \
    "Navigate into dir1/dir2 and print the path" \
    "Use: cd dir1/dir2 && pwd (start from TMPDIR)" \
    '^cd[[:space:]]+dir1/dir2[[:space:]]*&&[[:space:]]*pwd[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great! You've completed the 'pwd' lesson!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
