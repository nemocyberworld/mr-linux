#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧑‍💻 Lesson: whoami – Know Your Identity${RESET}"
echo
echo "The 'whoami' command is a simple but powerful tool."
echo "It tells you the current user you are logged in as (effective user ID)."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${YELLOW}whoami${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Why use whoami?${RESET}"
echo
echo "You might use 'whoami' to:"
echo "- Confirm your current user identity"
echo "- Check if you’re running as root or another user"
echo "- Troubleshoot permission issues"
echo "- Verify identity after switching users with 'su' or 'sudo'"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧪 Try it out:${RESET}"
echo
echo -e "Run the command below:"
echo -e "${GREEN}whoami${RESET}"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_whoami_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your answer: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Try again!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Check the current logged-in user" \
    "Use a single-word command that prints your current username." \
    '^whoami$' \
    "Great! 'whoami' shows your effective user."

ask_and_check \
    "Switch to root and verify with whoami" \
    "Try: sudo su; then use whoami." \
    '^sudo su;?\s*whoami$' \
    "Awesome! This confirms you're now acting as root."

ask_and_check \
    "Combine whoami with echo to print a message" \
    "Example: echo You are \$(whoami)" \
    '^echo\s+You\s+are\s+\$?\(whoami\)$' \
    "Nice! You used command substitution correctly."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleanup${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo "You now know how to identify your current user with 'whoami'."
pause
