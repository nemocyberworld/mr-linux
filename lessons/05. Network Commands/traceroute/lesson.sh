#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📡 Lesson: The 'traceroute' Command — Trace Network Paths${RESET}"
echo
echo "'traceroute' shows the path that packets take to a network host. It's useful for diagnosing routing issues or understanding the network route."
pause

# Step 1: Basic usage intro
clear
echo -e "${CYAN}${BOLD}🔍 What does 'traceroute' do?${RESET}"
echo
echo "It sends packets with increasing Time-To-Live (TTL) values and listens for ICMP 'Time Exceeded' replies."
echo "This reveals each hop a packet goes through to reach the destination."
pause

# Step 2: Practice doesn't need setup for traceroute
clear
echo -e "${YELLOW}${BOLD}🌐 You don't need files or folders to practice 'traceroute'!${RESET}"
echo "It works directly with network destinations."
pause

# Step 3: Show all common options and examples
clear
echo -e "${CYAN}${BOLD}📘 Useful 'traceroute' Options and Examples:${RESET}"

declare -A TRACEROUTE_USAGE
TRACEROUTE_USAGE["traceroute google.com"]="Trace route to a domain"
TRACEROUTE_USAGE["traceroute -n google.com"]="Do not resolve hostnames (faster)"
TRACEROUTE_USAGE["traceroute -I google.com"]="Use ICMP echo instead of UDP (like 'ping')"
TRACEROUTE_USAGE["traceroute -T google.com"]="Use TCP packets instead of UDP"
TRACEROUTE_USAGE["traceroute -m 5 google.com"]="Limit the max number of hops to 5"
TRACEROUTE_USAGE["traceroute -p 80 google.com"]="Set destination port (useful for TCP/UDP)"

for cmd in "${!TRACEROUTE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TRACEROUTE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checker
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
            eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive Tasks
ask_and_check \
    "Trace the route to 'google.com'" \
    "Try: traceroute google.com" \
    '^traceroute[[:space:]]+google\.com[[:space:]]*$'

ask_and_check \
    "Trace without resolving hostnames (faster)" \
    "Try: traceroute -n google.com" \
    '^traceroute[[:space:]]+-n[[:space:]]+google\.com[[:space:]]*$'

ask_and_check \
    "Use ICMP echo instead of UDP" \
    "Try: traceroute -I google.com" \
    '^traceroute[[:space:]]+-I[[:space:]]+google\.com[[:space:]]*$'

ask_and_check \
    "Limit maximum hops to 5" \
    "Try: traceroute -m 5 google.com" \
    '^traceroute[[:space:]]+-m[[:space:]]*5[[:space:]]+google\.com[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You've mastered the basics of 'traceroute'!${RESET}"
pause
