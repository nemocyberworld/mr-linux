#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Lesson: Permission Management in Linux${RESET}"
echo
echo "Learn how to manage file and directory permissions with chmod, chown, and chgrp."
pause

# Setup
TMPDIR="$HOME/.mr_linux_permissions"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

touch file1.sh
mkdir dir1
echo "echo Hello" > file1.sh
chmod 644 file1.sh

# Section: Help and Examples
clear
echo -e "${CYAN}${BOLD}📚 File Permission Examples${RESET}"

declare -A EXAMPLES
EXAMPLES["ls -l"]="Shows file permissions"
EXAMPLES["chmod +x file1.sh"]="Adds execute permission"
EXAMPLES["chmod 755 file1.sh"]="Sets full permission for owner, read+execute for group/others"
EXAMPLES["chown root file1.sh"]="Changes ownership to root"
EXAMPLES["chgrp developers file1.sh"]="Changes group to 'developers'"

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
            eval "$user_cmd"
            break
        else
            echo -e "${RED}❌ Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Tasks

ask_and_check \
    "View permissions of the current directory" \
    "Use ls -l" \
    '^ls[[:space:]]+-l$' \
    "Correct! You can now see the permission strings."

ask_and_check \
    "Make file1.sh executable" \
    "Use chmod +x file1.sh" \
    '^chmod[[:space:]]+\+x[[:space:]]+file1\.sh$' \
    "Well done! file1.sh is now executable."

ask_and_check \
    "Set file1.sh permissions to 755" \
    "Use numeric mode with chmod" \
    '^chmod[[:space:]]+755[[:space:]]+file1\.sh$' \
    "Nice! You now understand numeric permission modes."

ask_and_check \
    "Change the owner of file1.sh to root" \
    "Use chown root file1.sh (you may need sudo)" \
    '^(sudo[[:space:]]+)?chown[[:space:]]+root[[:space:]]+file1\.sh$' \
    "Ownership changed! You're mastering chown."

ask_and_check \
    "Change the group of file1.sh to 'staff'" \
    "Use chgrp staff file1.sh (you may need sudo)" \
    '^(sudo[[:space:]]+)?chgrp[[:space:]]+staff[[:space:]]+file1\.sh$' \
    "Group changed! You're now managing group access too."

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 You're now skilled at managing permissions in Linux!${RESET}"
echo "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
