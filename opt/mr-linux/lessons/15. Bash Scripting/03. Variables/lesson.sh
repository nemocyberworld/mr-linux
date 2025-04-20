#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧪 Lesson: Variables — Memory Magic in Bash!${RESET}"
echo
echo "Time to learn how Bash stores and recalls information 🧠💡"
echo -e "Today’s magic tricks:"
echo -e "• ${YELLOW}Declaring and using variables${RESET}"
echo -e "• ${YELLOW}Environment vs local variables${RESET}"
echo -e "• ${YELLOW}readonly${RESET} and ${YELLOW}unset${RESET}"
pause

# Step 1: Create Your First Variable
clear
echo -e "${CYAN}${BOLD}📦 Store Something — Declare a Variable${RESET}"
echo
echo "Variables are like boxes for storing data. Just use:"
echo -e "${BOLD}myname=\"Alice\"${RESET}"
echo "Then you can access it with \$myname:"
echo -e "${BOLD}echo \$myname${RESET}"
pause

# Step 2: Environment vs. Local
clear
echo -e "${CYAN}${BOLD}🌍 Environment vs Local Variables${RESET}"
echo
echo "🔒 Local variables exist only in the current shell."
echo "🌐 Environment variables can be inherited by child processes."
echo
echo -e "To create an environment variable, use: ${BOLD}export VAR=value${RESET}"
echo "Example:"
echo -e "${BOLD}export planet=\"Earth\"${RESET}"
echo -e "${BOLD}bash -c 'echo \$planet'${RESET}  # This works"
pause

# Step 3: Make It Immutable — readonly
clear
echo -e "${CYAN}${BOLD}🔐 Lock It Down — readonly${RESET}"
echo
echo -e "Use ${BOLD}readonly${RESET} to protect a variable:"
echo -e "${BOLD}readonly pi=3.14${RESET}"
echo "Now try changing it:"
echo -e "${BOLD}pi=4.0${RESET} ❌ (Bash won't allow it)"
pause

# Step 4: Poof! Gone — unset
clear
echo -e "${CYAN}${BOLD}🧹 Remove a Variable with unset${RESET}"
echo
echo "To completely remove a variable, use:"
echo -e "${BOLD}unset myname${RESET}"
echo -e "After that, ${BOLD}echo \$myname${RESET} will show nothing."
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
            echo -e "${GREEN}✅ Great work!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Oops! Try again.${RESET}"
        fi
    done
    pause
    clear
}

# Interactive Tasks
ask_and_check \
    "Create a variable called 'fruit' and set it to 'apple'" \
    "Try: fruit=\"apple\"" \
    "^fruit=\"apple\"\$"

ask_and_check \
    "Print the value of the 'fruit' variable" \
    "Try: echo \$fruit" \
    "^echo[[:space:]]+\\\$fruit\$"

ask_and_check \
    "Export a variable called 'animal' with value 'tiger'" \
    "Try: export animal=\"tiger\"" \
    "^export[[:space:]]+animal=\"tiger\"\$"

ask_and_check \
    "Make a variable 'version' read-only with value '1.0'" \
    "Try: readonly version=\"1.0\"" \
    "^readonly[[:space:]]+version=\"1.0\"\$"

ask_and_check \
    "Remove the 'fruit' variable" \
    "Try: unset fruit" \
    "^unset[[:space:]]+fruit\$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome work, Variable Wizard!${RESET}"
echo -e "You’ve learned to store data, lock it, share it, and wipe it out!"
echo -e "🔐 readonly   🌐 export   🧹 unset"
echo
echo -e "Next up: ${YELLOW}User Input & Arguments${RESET} — let’s make scripts listen! 👂"
pause
