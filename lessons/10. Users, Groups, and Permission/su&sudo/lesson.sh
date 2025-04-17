#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Lesson: Using 'su' and 'sudo' for Privilege Escalation${RESET}"
echo
echo "'su' and 'sudo' allow users to execute commands with elevated privileges."
echo "'su' switches to another user, usually root."
echo "'sudo' runs a single command as another user, commonly root."
pause

# Setup
TMPDIR="$HOME/.mr_linux_su_sudo_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Section: Help and Examples
clear
echo -e "${CYAN}${BOLD}📚 su and sudo Command Options and Examples${RESET}"

declare -A EXAMPLES
EXAMPLES["su"]="Switch to root user"
EXAMPLES["su -"]="Switch to root and load root's environment"
EXAMPLES["su username"]="Switch to another user"
EXAMPLES["sudo command"]="Run a command as root"
EXAMPLES["sudo -u username command"]="Run a command as a specific user"
EXAMPLES["sudo -i"]="Get an interactive root shell (like su -)"
EXAMPLES["sudo -l"]="List your allowed sudo commands"
EXAMPLES["sudoedit /etc/somefile"]="Safely edit a file as root"

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

# Tasks

ask_and_check \
    "Switch to the root user" \
    "Use 'su' with no arguments" \
    '^su$' \
    "Correct! That switches to root (you'll need the root password)."

ask_and_check \
    "Switch to root and load root's environment" \
    "Use 'su -'" \
    '^su[[:space:]]+-$' \
    "Great! That gives you a root login shell."

ask_and_check \
    "Switch to user 'bob'" \
    "Use 'su bob'" \
    '^su[[:space:]]+bob$' \
    "Perfect! That switches to another user."

ask_and_check \
    "Run 'apt update' as root using sudo" \
    "Prefix with sudo" \
    '^sudo[[:space:]]+apt[[:space:]]+update$' \
    "Nice! That's a safe way to run privileged commands."

ask_and_check \
    "Run 'ls /root' as user 'bob' using sudo" \
    "Use sudo with -u" \
    '^sudo[[:space:]]+-u[[:space:]]+bob[[:space:]]+ls[[:space:]]+/root$' \
    "Awesome! You ran a command as another user."

ask_and_check \
    "List all sudo commands you're allowed to run" \
    "Use sudo -l" \
    '^sudo[[:space:]]+-l$' \
    "Excellent! You can check your privileges this way."

ask_and_check \
    "Start an interactive root shell using sudo" \
    "Use sudo with -i" \
    '^sudo[[:space:]]+-i$' \
    "Perfect! You now have a root login shell using sudo."

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You’ve learned to use 'su' and 'sudo' safely and effectively!${RESET}"
echo "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
