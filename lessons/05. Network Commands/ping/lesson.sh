#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📡 Lesson: ping — Check Network Connectivity${RESET}"
echo
echo "'ping' is a network diagnostic tool used to test the reachability of a host on an IP network and measure the round-trip time for messages."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of ping${RESET}"
echo -e "${BOLD}➡️  ping [OPTIONS] destination${RESET}"
echo
echo "🔸 Sends ICMP echo requests to the specified host and reports the response."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'ping' Commands:${RESET}"

declare -A PING_USAGE
PING_USAGE["ping google.com"]="Ping a domain to check if it's reachable"
PING_USAGE["ping -c 4 example.com"]="Send only 4 packets instead of continuous ping"
PING_USAGE["ping -i 2 example.com"]="Ping with 2 seconds interval between requests"
PING_USAGE["ping -t 10 example.com"]="(Linux: use '-w' instead) Timeout after 10 seconds"
PING_USAGE["ping -4 example.com"]="Force IPv4"
PING_USAGE["ping -6 example.com"]="Force IPv6"

for cmd in "${!PING_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${PING_USAGE[$cmd]}${RESET}"
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
    "Ping 'example.com' to test connectivity" \
    "Use: ping example.com" \
    "^ping[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Send 4 ICMP packets to 'example.com'" \
    "Use: ping -c 4 example.com" \
    "^ping[[:space:]]+-c[[:space:]]*4[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Ping with 2-second intervals to 'example.com'" \
    "Use: ping -i 2 example.com" \
    "^ping[[:space:]]+-i[[:space:]]*2[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Ping with IPv4 only" \
    "Use: ping -4 example.com" \
    "^ping[[:space:]]+-4[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Ping with IPv6 only" \
    "Use: ping -6 example.com" \
    "^ping[[:space:]]+-6[[:space:]]+example\.com[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'ping' Command${RESET}"
echo -e "🧠 You now know how to test network connectivity, control packet count, delay intervals, and force IP versions."
pause
