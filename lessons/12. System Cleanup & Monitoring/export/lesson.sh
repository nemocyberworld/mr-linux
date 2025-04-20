#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'export' — Set Environment Variables${RESET}"
echo
echo "'export' sets environment variables in your shell and makes them available to subprocesses (like scripts or programs you run)."
pause

# Step 1: Syntax
clear
echo -e "${CYAN}${BOLD}📘 Syntax:${RESET}"
echo -e "${BOLD}export VARIABLE=value${RESET}"
echo "Example:"
echo -e "➡️  export MY_VAR=hello"
pause

# Step 2: Use it in shell
clear
echo -e "${YELLOW}${BOLD}⚙️ Setting and using an environment variable...${RESET}"
export MY_NAME="MrLinux"
echo "✅ Exported MY_NAME=MrLinux"
echo "🧪 Let's print it:"
echo "echo \$MY_NAME"
echo "$MY_NAME"
pause

# Step 3: See exported variables
clear
echo -e "${CYAN}${BOLD}📋 Listing environment variables:${RESET}"
echo "Use ${BOLD}printenv${RESET} or ${BOLD}env${RESET} to list them."
echo
echo "Try: printenv | grep MY_NAME"
printenv | grep MY_NAME
pause

# Step 4: Use variable in a subprocess
clear
echo -e "${CYAN}${BOLD}🔁 Variables in subprocesses:${RESET}"
echo "When exported, variables are available in subprocesses."
echo
echo "Try: bash -c 'echo \$MY_NAME'"
bash -c 'echo $MY_NAME'
pause

# Step 5: Unset variable
clear
echo -e "${CYAN}${BOLD}❌ Unsetting a variable:${RESET}"
echo "Use: unset VARIABLE"
echo "Example: unset MY_NAME"
unset MY_NAME
echo
echo "echo \$MY_NAME"
echo "$MY_NAME"
pause

# Step 6: Task Checker
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

# Step 7: Interactive Tasks
ask_and_check \
    "Export a variable USERNAME with value admin" \
    "Try: export USERNAME=admin" \
    "^export[[:space:]]+USERNAME=admin\$"

ask_and_check \
    "Print the USERNAME variable using echo" \
    "Try: echo \$USERNAME" \
    "^echo[[:space:]]+\\\$USERNAME\$"

ask_and_check \
    "Use bash to print the USERNAME in a subprocess" \
    "Try: bash -c 'echo \$USERNAME'" \
    "^bash[[:space:]]+-c[[:space:]]+'echo[[:space:]]+\\\$USERNAME'\$"

ask_and_check \
    "Unset the variable USERNAME" \
    "Try: unset USERNAME" \
    "^unset[[:space:]]+USERNAME\$"

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'export' lesson!${RESET}"
echo -e "💡 Tip: Add exports to your ~/.bashrc if you want them permanent for every shell session."
pause
