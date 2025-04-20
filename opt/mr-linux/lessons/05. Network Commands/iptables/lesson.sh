#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🛡️ Lesson: iptables — Linux Firewall Tool${RESET}"
echo
echo "'iptables' is a user-space utility program that allows a system administrator to configure the IP packet filter rules of the Linux kernel firewall."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of iptables${RESET}"
echo -e "${BOLD}➡️  iptables [-t table] COMMAND chain [options]${RESET}"
echo "Examples of tables: filter (default), nat, mangle, raw"
echo "Examples of chains: INPUT, OUTPUT, FORWARD"
pause

# Step 2: Common Commands
clear
echo -e "${CYAN}${BOLD}📚 Common 'iptables' Commands:${RESET}"

declare -A IPTABLES_USAGE
IPTABLES_USAGE["iptables -L"]="List all rules"
IPTABLES_USAGE["iptables -F"]="Flush all rules"
IPTABLES_USAGE["iptables -A INPUT -p tcp --dport 22 -j ACCEPT"]="Allow incoming SSH traffic"
IPTABLES_USAGE["iptables -A INPUT -p tcp --dport 80 -j DROP"]="Drop incoming HTTP traffic"
IPTABLES_USAGE["iptables -D INPUT -p tcp --dport 22 -j ACCEPT"]="Delete a specific rule"
IPTABLES_USAGE["iptables -P INPUT DROP"]="Set default policy to DROP for incoming traffic"

for cmd in "${!IPTABLES_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${IPTABLES_USAGE[$cmd]}${RESET}"
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
    "List all current iptables rules" \
    "Use the -L option" \
    "^iptables[[:space:]]+-L[[:space:]]*$"

ask_and_check \
    "Flush (delete) all rules from all chains" \
    "Use the -F option" \
    "^iptables[[:space:]]+-F[[:space:]]*$"

ask_and_check \
    "Allow SSH traffic (port 22) on INPUT chain" \
    "Use -A INPUT -p tcp --dport 22 -j ACCEPT" \
    "^iptables[[:space:]]+-A[[:space:]]+INPUT[[:space:]]+-p[[:space:]]+tcp[[:space:]]+--dport[[:space:]]+22[[:space:]]+-j[[:space:]]+ACCEPT[[:space:]]*$"

ask_and_check \
    "Set default INPUT policy to DROP" \
    "Use -P INPUT DROP" \
    "^iptables[[:space:]]+-P[[:space:]]+INPUT[[:space:]]+DROP[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'iptables' command lesson.${RESET}"
echo -e "🧱 You now know how to inspect, add, and remove firewall rules safely!"
pause
