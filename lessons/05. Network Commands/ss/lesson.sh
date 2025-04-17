#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔌 Lesson: ss — Display Socket Statistics${RESET}"
echo
echo "'ss' is a utility to investigate sockets (network connections) on a Linux system. It's a modern replacement for 'netstat'."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of ss${RESET}"
echo -e "${BOLD}➡️  ss [OPTIONS]${RESET}"
echo
echo "You can use it to display TCP, UDP, UNIX socket connections, listen states, and more."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'ss' Commands:${RESET}"

declare -A SS_USAGE
SS_USAGE["ss"]="Display all sockets (default)"
SS_USAGE["ss -t"]="Display TCP connections"
SS_USAGE["ss -u"]="Display UDP connections"
SS_USAGE["ss -l"]="Display listening sockets"
SS_USAGE["ss -tuln"]="Show listening TCP and UDP sockets without resolving names"
SS_USAGE["ss -p"]="Show processes using sockets"
SS_USAGE["ss -s"]="Display summary statistics"

for cmd in "${!SS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${SS_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Tasks
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            echo -e "${CYAN}⚠️  This is a simulation. The actual command is not executed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Show all listening sockets." \
    "Use: ss -l" \
    "^ss[[:space:]]+-l[[:space:]]*$"

ask_and_check \
    "Display TCP connections only." \
    "Use: ss -t" \
    "^ss[[:space:]]+-t[[:space:]]*$"

ask_and_check \
    "Display UDP connections only." \
    "Use: ss -u" \
    "^ss[[:space:]]+-u[[:space:]]*$"

ask_and_check \
    "Show listening TCP and UDP sockets with numeric ports." \
    "Use: ss -tuln" \
    "^ss[[:space:]]+-tuln[[:space:]]*$"

ask_and_check \
    "Show which processes are using sockets." \
    "Use: ss -p" \
    "^ss[[:space:]]+-p[[:space:]]*$"

ask_and_check \
    "Display a summary of socket statistics." \
    "Use: ss -s" \
    "^ss[[:space:]]+-s[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'ss' Command${RESET}"
echo -e "📊 You now know how to inspect and monitor socket-level network connections with 'ss'."
pause
