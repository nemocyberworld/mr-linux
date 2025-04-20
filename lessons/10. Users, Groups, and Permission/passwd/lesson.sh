#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Lesson: Managing Passwords with 'passwd'${RESET}"
echo
echo "'passwd' is used to change user account passwords and manage password policies."
pause

# Setup
TMPDIR="$HOME/.mr_linux_passwd_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Section: Help and Examples
clear
echo -e "${CYAN}${BOLD}📚 passwd Command Options and Examples${RESET}"

declare -A EXAMPLES
EXAMPLES["passwd"]="Change your own password"
EXAMPLES["sudo passwd username"]="Change password for another user (as root)"
EXAMPLES["passwd -l username"]="Lock a user's account"
EXAMPLES["passwd -u username"]="Unlock a user's account"
EXAMPLES["passwd -e username"]="Force password change at next login"
EXAMPLES["passwd -n 3 username"]="Set minimum password age (days)"
EXAMPLES["passwd -x 90 username"]="Set maximum password age (days)"
EXAMPLES["passwd -w 7 username"]="Set warning period before password expires"

for cmd in "${!EXAMPLES[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${EXAMPLES[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Section: Interactive Tasks
ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Task 1
ask_and_check \
    "Change your own password" \
    "Just run the command without arguments" \
    '^passwd$' \
    "Correct! That's how you update your own password."

# Task 2
ask_and_check \
    "Change password for user 'testuser' as root" \
    "Prefix with 'sudo'" \
    '^sudo[[:space:]]+passwd[[:space:]]+testuser$' \
    "Nice! That changes another user's password."

# Task 3
ask_and_check \
    "Lock the account of user 'bob'" \
    "Use -l (lowercase L)" \
    '^passwd[[:space:]]+-l[[:space:]]+bob$' \
    "Great! You locked the user's account."

# Task 4
ask_and_check \
    "Unlock the account of user 'bob'" \
    "Use -u to unlock" \
    '^passwd[[:space:]]+-u[[:space:]]+bob$' \
    "Awesome! Account unlocked."

# Task 5
ask_and_check \
    "Force user 'bob' to change password at next login" \
    "Use -e for expire" \
    '^passwd[[:space:]]+-e[[:space:]]+bob$' \
    "Perfect! That forces a password reset on login."

# Task 6
ask_and_check \
    "Set minimum password age to 3 days for user 'bob'" \
    "Use -n with number of days" \
    '^passwd[[:space:]]+-n[[:space:]]+3[[:space:]]+bob$' \
    "Correct! Password can’t be changed before 3 days."

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You've mastered 'passwd' command basics!${RESET}"
echo "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
