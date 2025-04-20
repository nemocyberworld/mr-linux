#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧾 Lesson: Basic Commands & Syntax — Let’s Speak Bash!${RESET}"
echo
echo "Welcome back, Scripter! 🎩 Today we’re diving into:"
echo -e "• ${YELLOW}echo${RESET} and ${YELLOW}printf${RESET}"
echo -e "• Comments (because even code needs to talk to us)"
echo -e "• Exit statuses and the mighty \$? 🔢"
pause

# Step 1: Say Hello (Again) — echo
clear
echo -e "${CYAN}${BOLD}🗣️ Say it with echo:${RESET}"
echo
echo -e "${BOLD}echo \"Hello, Bash!\"${RESET}"
echo "This prints a line of text to the terminal."
echo
echo "Try it now:"
echo
echo -e "${GREEN}echo \"Hello, world!\"${RESET}"
pause

# Step 2: Say it Fancy — printf
clear
echo -e "${CYAN}${BOLD}💅 Make it Pretty with printf:${RESET}"
echo
echo "Unlike echo, printf gives you formatting powers."
echo -e "${BOLD}printf \"Name: %s\\nAge: %d\\n\" \"Alice\" 25${RESET}"
echo "Outputs:"
printf "Name: %s\nAge: %d\n" "Alice" 25
pause

# Step 3: Comment, Comment, Comment
clear
echo -e "${CYAN}${BOLD}💬 Comment Your Code:${RESET}"
echo
echo -e "Use the ${BOLD}#${RESET} symbol to leave notes for yourself (or future-you)."
echo "The shell ignores anything after # on a line."
echo
echo -e "${BOLD}# This is a comment${RESET}"
echo -e "${BOLD}echo \"Doing something important\"  # Another comment${RESET}"
pause

# Step 4: Exit Status — Check If It Worked
clear
echo -e "${CYAN}${BOLD}📦 Exit Status and \$?${RESET}"
echo
echo "Every command has an exit code. 0 = success, anything else = error."
echo "You can check the last command’s exit status using:"
echo -e "${BOLD}echo \$?${RESET}"
echo
echo "Try running:"
echo -e "${GREEN}ls /nonexistent${RESET} (which will fail)"
pause
ls /nonexistent
echo -e "Now check the exit code with: ${YELLOW}echo \$?${RESET}"
pause
echo $?
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

# Step 6: Interactive Tasks
ask_and_check \
    "Print 'Welcome to Bash!' using echo" \
    "Try: echo \"Welcome to Bash!\"" \
    "^echo[[:space:]]+\"Welcome[[:space:]]+to[[:space:]]+Bash!\"$"

ask_and_check \
    "Add a comment in a script file called notes.sh" \
    "Try: echo \"# This is a comment\" > notes.sh" \
    "^echo[[:space:]]+\"# This is a comment\"[[:space:]]+> notes\\.sh$"

ask_and_check \
    "Run a failing command, then check its exit status" \
    "Try: ls /doesnotexist; echo \$?" \
    "^ls[[:space:]]+/doesnotexist[[:space:]]*;[[:space:]]*echo[[:space:]]+\\$\\?$"

ask_and_check \
    "Write an inline comment after a command" \
    "Try: echo Hello # Greeting" \
    "^echo[[:space:]]+Hello[[:space:]]+#.*$"

ask_and_check \
    "Check the exit status of echo" \
    "Try: echo hi; echo \$?" \
    "^echo[[:space:]]+hi[[:space:]]*;[[:space:]]*echo[[:space:]]+\\$\\?$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 That’s a wrap on Bash Basics!${RESET}"
echo -e "You've just covered some of the most important building blocks in scripting."
echo -e "💬 echo & printf  🧠 comments  ✅ checking success"
echo
echo -e "Next up: ${YELLOW}Variables and Data${RESET} — let’s store some secrets! 🔐"
pause
