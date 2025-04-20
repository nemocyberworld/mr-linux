#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧵 Lesson: Quoting & Escaping in Bash${RESET}"
echo
echo "Understanding how quotes and escape characters work is 🔑 to writing reliable scripts!"
pause

# Single vs Double Quotes
clear
echo -e "${CYAN}${BOLD}📌 Single vs Double Quotes${RESET}"
echo
echo "Use quotes to group words or prevent unexpected interpretation:"
echo
echo -e "${BOLD}Single quotes (''):${RESET} Everything inside is taken literally."
echo -e "${BOLD}Double quotes (\"\"):${RESET} Variables and some special characters get expanded."
echo
echo "Examples:"
echo -e "${BOLD}name=\"Alice\"${RESET}"
echo -e "${BOLD}echo 'Hello \$name'${RESET} → Hello \$name"
echo -e "${BOLD}echo \"Hello \$name\"${RESET} → Hello Alice"
pause

# Try It!
read -rp "Try it! Type: name=\"Alice\" → " try1
eval "$try1"
pause

read -rp "Now type: echo 'Hello \$name' → " try2
eval "$try2"
pause

read -rp "Finally: echo \"Hello \$name\" → " try3
eval "$try3"
pause

# Escaping Characters
clear
echo -e "${CYAN}${BOLD}🚧 Escape Characters${RESET}"
echo
echo "Sometimes you need to use special characters literally. Escape them with a backslash (\\):"
echo
echo -e "${BOLD}\\\$ → \$${RESET} (show a dollar sign)"
echo -e "${BOLD}\\\" → \"${RESET} (show a double quote inside double quotes)"
echo -e "${BOLD}\\\\ → \"${RESET} (show a backslash)"
pause

# Try escaping
read -rp "Try: echo \"This costs \$5\" → " try4
eval "$try4"
pause

# TASKS
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
                eval "$user_cmd" || echo -e "${RED}⚠️ It ran but might not have worked as expected.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Nope, try again.${RESET}"
        fi
    done
    pause
    clear
}

# Quoting & Escaping Tasks
ask_and_check \
    "Echo a literal dollar sign: Show the output: This costs \$5" \
    "Try: echo \"This costs \\\$5\"" \
    '^echo[[:space:]]+\"This[[:space:]]+costs[[:space:]]+\\\$5\"$'

ask_and_check \
    "Use single quotes to prevent variable expansion" \
    "Try: echo 'Hello \$USER'" \
    "^echo[[:space:]]+'Hello[[:space:]]+\\\$USER'\$"

ask_and_check \
    "Use double quotes to allow variable expansion" \
    "Try: echo \"Hello \$USER\"" \
    "^echo[[:space:]]+\"Hello[[:space:]]+\\\$USER\"$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve mastered quoting and escaping!${RESET}"
echo
echo -e "Use quotes wisely and escape when needed to control how Bash sees your commands."
echo -e "Next up: ${YELLOW}Conditionals${RESET} — let's add logic to our scripts!"
pause
