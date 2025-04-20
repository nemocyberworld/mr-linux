#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: netstat — Network Statistics Utility${RESET}"
echo
echo "'netstat' is a legacy tool used to display network connections, routing tables, interface stats, masquerade connections, and multicast memberships."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Show Active Connections${RESET}"
echo -e "${BOLD}➡️ Command: netstat -tunap${RESET}"
echo "This command shows all TCP/UDP connections along with the PID/program using the connection."
pause

# Step 2: Common Options
clear
echo -e "${CYAN}${BOLD}📚 Common 'netstat' Options:${RESET}"

declare -A NETSTAT_USAGE
NETSTAT_USAGE["netstat -t"]="Show TCP connections"
NETSTAT_USAGE["netstat -u"]="Show UDP connections"
NETSTAT_USAGE["netstat -n"]="Show numerical addresses instead of resolving hostnames"
NETSTAT_USAGE["netstat -a"]="Show all listening and non-listening sockets"
NETSTAT_USAGE["netstat -p"]="Show PID and program name"
NETSTAT_USAGE["netstat -r"]="Display the kernel routing table"
NETSTAT_USAGE["netstat -i"]="Display a table of all network interfaces"
NETSTAT_USAGE["netstat -s"]="Display summary statistics for each protocol"

for cmd in "${!NETSTAT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${NETSTAT_USAGE[$cmd]}${RESET}"
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
    "Show all active TCP connections" \
    "Try: netstat -t" \
    "^netstat[[:space:]]+-t[[:space:]]*$"

ask_and_check \
    "Show routing table" \
    "Try: netstat -r" \
    "^netstat[[:space:]]+-r[[:space:]]*$"

ask_and_check \
    "Show all listening and non-listening sockets" \
    "Try: netstat -a" \
    "^netstat[[:space:]]+-a[[:space:]]*$"

ask_and_check \
    "Display all active connections with programs (TCP/UDP, numerical, PID info)" \
    "Try: netstat -tunap" \
    "^netstat[[:space:]]+-tunap[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'netstat' command lesson.${RESET}"
echo -e "🔍 Now you can inspect your network connections with confidence!"
pause
