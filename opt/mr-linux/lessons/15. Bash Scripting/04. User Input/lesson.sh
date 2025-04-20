#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎙️ Lesson: User Input — Talk to Me, Bash!${RESET}"
echo
echo "Scripts get way cooler when they can talk to people! 🗣️"
echo -e "Let’s explore how to gather input using the ${YELLOW}read${RESET} command."
pause

# Step 1: Basic read
clear
echo -e "${CYAN}${BOLD}🧾 Basic Input with read:${RESET}"
echo
echo -e "Use ${BOLD}read variable_name${RESET} to ask the user for input."
echo
echo -e "${BOLD}read name${RESET}"
echo -e "${BOLD}echo \"Hello, \$name!\"${RESET}"
echo
echo "Try it:"
pause
read -rp "What's your name? " name
echo -e "Nice to meet you, ${GREEN}$name${RESET}!"
pause

# Step 2: Prompt while reading
clear
echo -e "${CYAN}${BOLD}📝 Prompt During read:${RESET}"
echo
echo -e "Use the ${BOLD}-p${RESET} flag to show a message before waiting for input:"
echo -e "${BOLD}read -p \"Enter your age: \" age${RESET}"
pause
read -p "Enter your age: " age
echo -e "You're ${YELLOW}$age${RESET} years wise!"
pause

# Step 3: Silent input (passwords!)
clear
echo -e "${CYAN}${BOLD}🔒 Silent Input (like passwords):${RESET}"
echo
echo -e "Use ${BOLD}-s${RESET} to hide the input while typing (great for passwords)."
echo -e "${BOLD}read -s -p \"Enter secret: \" secret${RESET}"
pause
read -s -p "Enter a secret: " secret
echo
echo "🤫 Got it! (But I'm not telling.)"
pause

# Step 4: Default Values
clear
echo -e "${CYAN}${BOLD}🧙 Default Values for Inputs:${RESET}"
echo
echo "You can assign a default using parameter expansion:"
echo -e "${BOLD}name=\${name:-Guest}${RESET}"
echo -e "This means: if \$name is empty, use 'Guest'."
pause
read -p "Enter your nickname (or press Enter): " nickname
nickname="${nickname:-Guest}"
echo -e "Welcome, ${GREEN}$nickname${RESET}!"
pause

# Step 5: TASK TIME!
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
            echo -e "${GREEN}✅ Nice job!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ The command ran but maybe not as expected.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Nope, give it another go.${RESET}"
        fi
    done
    pause
    clear
}

# Step 6: Interactive Tasks
ask_and_check \
    "Prompt the user for their favorite language" \
    "Try: read -p \"Favorite language? \" lang" \
    "^read[[:space:]]+-p[[:space:]]+\"Favorite language\?[[:space:]]*\"[[:space:]]+lang\$"

ask_and_check \
    "Ask for a secret without showing input" \
    "Try: read -s -p \"Enter password: \" pass" \
    "^read[[:space:]]+-s[[:space:]]+-p[[:space:]]+\"Enter password:[[:space:]]*\"[[:space:]]+pass\$"


ask_and_check \
    "Use a default value if nothing is entered" \
    "Try: nickname=\${nickname:-Guest}" \
    "^nickname=\\\$\{nickname:-Guest\}\$" \
    true

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You've mastered User Input!${RESET}"
echo -e "Now your scripts can actually talk to people!"
echo
echo -e "💬 ${BOLD}read${RESET} with prompts, secrets, and defaults. You're unstoppable!"
echo -e "Next up: ${YELLOW}Conditionals${RESET} — decision-making time! ⚖️"
pause
