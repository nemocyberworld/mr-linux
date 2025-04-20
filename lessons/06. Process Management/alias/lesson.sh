#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'alias' — Create Shell Shortcuts${RESET}"
echo
echo "'alias' lets you define shortcuts for commands in your shell. Great for customizing and saving time."
pause

# Step 1: Show how alias works
clear
echo -e "${CYAN}${BOLD}📘 Syntax:${RESET}"
echo -e "${BOLD}alias name='command_to_run'${RESET}"
echo "Example: alias ll='ls -l'"
pause

# Step 2: Create some example aliases
clear
echo -e "${YELLOW}${BOLD}⚙️ Creating example aliases...${RESET}"
alias ll='ls -l'
alias gs='git status'
alias ..='cd ..'

echo -e "✅ Created: ll='ls -l'"
echo -e "✅ Created: gs='git status'"
echo -e "✅ Created: ..='cd ..'"
echo
echo -e "${YELLOW}⚠️ Note: These aliases are temporary and will be gone when you close the terminal.${RESET}"
pause

# Step 3: Show alias in action
clear
echo -e "${CYAN}${BOLD}🧪 Testing an alias:${RESET}"
echo "➡️ Running: ll"
shopt -s expand_aliases
ll
pause

# Step 4: List aliases
clear
echo -e "${CYAN}${BOLD}📋 Listing all aliases:${RESET}"
echo "➡️ Run the 'alias' command to see what's set:"
alias
pause

# Step 5: Make aliases permanent
clear
echo -e "${CYAN}${BOLD}📝 Making Aliases Permanent:${RESET}"
echo "To keep aliases after reboot, add them to:"
echo -e "${YELLOW}~/.bashrc${RESET} or ${YELLOW}~/.bash_aliases${RESET} (if sourced)"
echo
echo -e "Example: echo \"alias ll='ls -l'\" >> ~/.bashrc"
pause

# Step 6: Remove an alias
clear
echo -e "${CYAN}${BOLD}❌ Removing an alias:${RESET}"
echo -e "${BOLD}unalias name${RESET}"
echo "Example: unalias ll"
pause

# Step 7: Task Checker
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

# Step 8: Interactive Tasks
ask_and_check \
    "Create an alias 'll' for 'ls -l'" \
    "Try: alias ll='ls -l'" \
    "^alias[[:space:]]+ll='ls[[:space:]]+-l'\$"

ask_and_check \
    "List all currently defined aliases" \
    "Try: alias" \
    "^alias[[:space:]]*\$"

ask_and_check \
    "Remove the 'll' alias" \
    "Try: unalias ll" \
    "^unalias[[:space:]]+ll\$"

ask_and_check \
    "Make the alias permanent by appending to .bashrc" \
    "Try: echo \"alias ll='ls -l'\" >> ~/.bashrc" \
    "^echo[[:space:]]+\"alias[[:space:]]+ll='ls[[:space:]]+-l'\"[[:space:]]+>>[[:space:]]+~/.bashrc\$"

ask_and_check \
    "Create a new alias 'upd' for 'sudo apt update'" \
    "Try: alias upd='sudo apt update'" \
    "^alias[[:space:]]+upd='sudo[[:space:]]+apt[[:space:]]+update'\$"

ask_and_check \
    "Save your new alias permanently" \
    "Try: echo \"alias upd='sudo apt update'\" >> ~/.bashrc" \
    "^echo[[:space:]]+\"alias[[:space:]]+upd='sudo[[:space:]]+apt[[:space:]]+update'\"[[:space:]]+>>[[:space:]]+~/.bashrc\$"

# Bonus Task
ask_and_check \
    "Create your own alias and save it permanently to ~/.bashrc" \
    "You can define anything useful to you!" \
    '^echo[[:space:]]+"alias[[:space:]]+[a-zA-Z0-9_]+=.*"[[:space:]]+>>[[:space:]]+~/.bashrc\$' \
    true

# Step 9: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'alias' lesson! Great job customizing your shell.${RESET}"
echo
echo -e "💡 Remember to reload your shell or run ${YELLOW}source ~/.bashrc${RESET} to activate saved aliases."
pause
