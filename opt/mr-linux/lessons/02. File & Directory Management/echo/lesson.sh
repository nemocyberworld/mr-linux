#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🗣️ Lesson: The 'echo' Command — Display Messages in the Terminal${RESET}"
echo
echo "'echo' is used to print text or variables to the terminal. It's often used in scripts and debugging."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Creating a sandbox for practice...${RESET}"
TMPDIR="$HOME/.mr_linux_echo_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Directory Overview
clear
echo -e "${YELLOW}${BOLD}📁 Working directory is ready. Let's begin.${RESET}"
ls -la "$TMPDIR"
pause

# Step 3: Explain 'echo' options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'echo' Command Options and Examples:${RESET}"

declare -A ECHO_USAGE
ECHO_USAGE["echo Hello World"]="Basic usage to print text"
ECHO_USAGE["echo -n 'No newline'"]="Print without a newline"
ECHO_USAGE["echo -e 'Line1\\nLine2'"]="Enable interpretation of backslash escapes (like newline)"
ECHO_USAGE["echo \$HOME"]="Print environment variable"
ECHO_USAGE["echo \"Hello \$USER\""]="Use variables inside quoted string"
ECHO_USAGE["echo \"Today is \$(date)\""]="Run command inside echo using \$()"

for cmd in "${!ECHO_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${ECHO_USAGE[$cmd]}${RESET}"
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
    "Print 'Hello World' to the terminal" \
    "Try: echo Hello World" \
    '^echo[[:space:]]+Hello[[:space:]]+World[[:space:]]*$'

ask_and_check \
    "Print text without a newline at the end" \
    "Use the -n option" \
    '^echo[[:space:]]+-n[[:space:]]+[\"\']?No[[:space:]]newline[\"\']?[[:space:]]*$'

ask_and_check \
    "Print two lines using newline character" \
    "Use -e and \\n like: echo -e 'Line1\\nLine2'" \
    '^echo[[:space:]]+-e[[:space:]]+[\"\']?Line1\\nLine2[\"\']?[[:space:]]*$'

ask_and_check \
    "Print the current user using \$USER" \
    "Try: echo \$USER" \
    '^echo[[:space:]]+\$USER[[:space:]]*$'

ask_and_check \
    "Print today's date using command substitution" \
    "Use: echo \"Today is \$(date)\"" \
    '^echo[[:space:]]+"?Today[[:space:]]+is[[:space:]]+\$\(date\)"?[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You’ve completed the 'echo' lesson!${RESET}"
echo -e "🧹 Cleaning up practice directory..."
rm -rf "$TMPDIR"
pause
