#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🆔 Lesson: Checking User Identity with 'id'${RESET}"
echo
echo "The 'id' command displays the current or specified user's UID, GID, and group memberships."
pause

# Setup
TMPDIR="$HOME/.mr_linux_id_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Section: Help and Examples
clear
echo -e "${CYAN}${BOLD}📚 id Command Options and Examples${RESET}"

declare -A EXAMPLES
EXAMPLES["id"]="Show your UID, GID, and groups"
EXAMPLES["id -u"]="Show only your UID"
EXAMPLES["id -g"]="Show only your GID"
EXAMPLES["id -G"]="Show all your group IDs"
EXAMPLES["id -un"]="Show your username"
EXAMPLES["id -gn"]="Show your group name"
EXAMPLES["id -G -n"]="Show all group names"
EXAMPLES["id root"]="Show UID, GID, and groups of user 'root'"

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
    "Show your user ID (UID) only" \
    "Use the -u option" \
    '^id[[:space:]]+-u$' \
    "Correct! That's how you show your UID."

# Task 2
ask_and_check \
    "Show your group ID (GID) only" \
    "Use the -g option" \
    '^id[[:space:]]+-g$' \
    "Nice! That's the correct way to view your GID."

# Task 3
ask_and_check \
    "Display all of your group IDs" \
    "Use the -G option" \
    '^id[[:space:]]+-G$' \
    "Awesome! That lists your group memberships."

# Task 4
ask_and_check \
    "Show your username using the id command" \
    "Use the -un options together" \
    '^id[[:space:]]+-un$' \
    "Perfect! You've shown the username correctly."

# Task 5
ask_and_check \
    "Show UID, GID, and groups of the root user" \
    "Just specify the username after 'id'" \
    '^id[[:space:]]+root$' \
    "Well done! That's how you check info for another user."

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've mastered the basics of 'id'!${RESET}"
echo "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
