#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}👤 Lesson: User and Group Management in Linux${RESET}"
echo
echo "In this lesson, you'll learn how to manage users and groups using CLI tools."
pause

# Setup environment
TMPDIR="$HOME/.mr_linux_user_mgmt"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Show commands
clear
echo -e "${CYAN}${BOLD}📚 Commands and Examples:${RESET}"
declare -A EXAMPLES
EXAMPLES["useradd devuser"]="Add a new user using 'useradd'"
EXAMPLES["useradd -m -s /bin/bash anotheruser"]="Add a user with home directory and shell"
EXAMPLES["passwd devuser"]="Set password for the user"
EXAMPLES["usermod -aG sudo devuser"]="Add user to 'sudo' group"
EXAMPLES["groupadd developers"]="Create a new group"
EXAMPLES["groupdel developers"]="Delete a group"
EXAMPLES["usermod -G devops devuser"]="Assign user to 'devops' group (replaces existing)"
EXAMPLES["userdel devuser"]="Remove a user"
EXAMPLES["userdel -r devuser"]="Remove user and their home directory"
EXAMPLES["groups devuser"]="List groups a user belongs to"
EXAMPLES["id devuser"]="Show UID, GID, groups of a user"

for cmd in "${!EXAMPLES[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${EXAMPLES[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Function for checking commands
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

# Interactive tasks (portable)
ask_and_check "Add a new user named 'devuser'" "Use: useradd devuser" '^useradd[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Add a user named 'opsuser' with a home directory and bash shell" "Use: useradd -m -s /bin/bash opsuser" '^useradd[[:space:]]+-m[[:space:]]+-s[[:space:]]+/bin/bash[[:space:]]+opsuser[[:space:]]*$'
ask_and_check "Set a password for the user 'devuser'" "Use: passwd devuser" '^passwd[[:space:]]+devuser[[:space:]]*$' true
ask_and_check "Add 'devuser' to the 'sudo' group" "Use: usermod -aG sudo devuser" '^usermod[[:space:]]+-aG[[:space:]]+sudo[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Create a new group called 'developers'" "Use: groupadd developers" '^groupadd[[:space:]]+developers[[:space:]]*$'
ask_and_check "Assign 'devuser' to the 'developers' group (overwrite existing groups)" "Use: usermod -G developers devuser" '^usermod[[:space:]]+-G[[:space:]]+developers[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Delete the 'developers' group" "Use: groupdel developers" '^groupdel[[:space:]]+developers[[:space:]]*$'
ask_and_check "List groups of 'devuser'" "Use: groups devuser" '^groups[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Display UID, GID and groups of 'devuser'" "Use: id devuser" '^id[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Delete 'devuser' and remove their home directory" "Use: userdel -r devuser" '^userdel[[:space:]]+-r[[:space:]]+devuser[[:space:]]*$'
ask_and_check "Create a user called 'tempuser' with UID 1500" "Use: useradd -u 1500 tempuser" '^useradd[[:space:]]+-u[[:space:]]+1500[[:space:]]+tempuser[[:space:]]*$'
ask_and_check "Create a group called 'qa' with GID 2020" "Use: groupadd -g 2020 qa" '^groupadd[[:space:]]+-g[[:space:]]+2020[[:space:]]+qa[[:space:]]*$'
ask_and_check "Rename the user 'tempuser' to 'finaluser'" "Use: usermod -l finaluser tempuser" '^usermod[[:space:]]+-l[[:space:]]+finaluser[[:space:]]+tempuser[[:space:]]*$'
ask_and_check "Rename the group 'qa' to 'testers'" "Use: groupmod -n testers qa" '^groupmod[[:space:]]+-n[[:space:]]+testers[[:space:]]+qa[[:space:]]*$'
ask_and_check "Lock the 'finaluser' account" "Use: usermod -L finaluser" '^usermod[[:space:]]+-L[[:space:]]+finaluser[[:space:]]*$'
ask_and_check "Unlock the 'finaluser' account" "Use: usermod -U finaluser" '^usermod[[:space:]]+-U[[:space:]]+finaluser[[:space:]]*$'
ask_and_check "Set 'finaluser' password to expire in 7 days" "Use: chage -M 7 finaluser" '^chage[[:space:]]+-M[[:space:]]+7[[:space:]]+finaluser[[:space:]]*$'
ask_and_check "Set account expiration for 'finaluser' to 2025-12-31" "Use: chage -E 2025-12-31 finaluser" '^chage[[:space:]]+-E[[:space:]]+2025-12-31[[:space:]]+finaluser[[:space:]]*$'
ask_and_check "Show details about password expiration for 'finaluser'" "Use: chage -l finaluser" '^chage[[:space:]]+-l[[:space:]]+finaluser[[:space:]]*$'
ask_and_check "View the '/etc/passwd' file content" "Use: cat /etc/passwd" '^cat[[:space:]]+/etc/passwd[[:space:]]*$' true
ask_and_check "View the '/etc/group' file content" "Use: cat /etc/group" '^cat[[:space:]]+/etc/group[[:space:]]*$' true
ask_and_check "Create a user 'multiuser' with home directory, shell, and specific UID 2500" "Use: useradd -m -s /bin/bash -u 2500 multiuser" '^useradd[[:space:]]+-m[[:space:]]+-s[[:space:]]+/bin/bash[[:space:]]+-u[[:space:]]+2500[[:space:]]+multiuser[[:space:]]*$'

# Cleanup
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the User Management lesson! Awesome job!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
