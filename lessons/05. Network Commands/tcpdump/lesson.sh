#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📡 Lesson: tcpdump — Network Packet Capture Tool${RESET}"
echo
echo "'tcpdump' is a command-line packet analyzer. It captures and displays network traffic seen by your system's network interfaces."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of tcpdump${RESET}"
echo -e "${BOLD}➡️  tcpdump [OPTIONS] [FILTERS]${RESET}"
echo
echo "Filters help you capture only specific types of traffic (e.g., from certain IPs, ports, or protocols)."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'tcpdump' Commands:${RESET}"

declare -A TCPDUMP_USAGE
TCPDUMP_USAGE["tcpdump"]="Capture packets on default interface"
TCPDUMP_USAGE["tcpdump -i eth0"]="Capture packets on eth0"
TCPDUMP_USAGE["tcpdump -n"]="Don't resolve hostnames"
TCPDUMP_USAGE["tcpdump -nn"]="Don't resolve hostnames or ports"
TCPDUMP_USAGE["tcpdump port 80"]="Capture packets on port 80"
TCPDUMP_USAGE["tcpdump host 192.168.1.1"]="Capture traffic to/from a specific host"
TCPDUMP_USAGE["tcpdump -w capture.pcap"]="Write output to a file"
TCPDUMP_USAGE["tcpdump -r capture.pcap"]="Read packets from a file"

for cmd in "${!TCPDUMP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TCPDUMP_USAGE[$cmd]}${RESET}"
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
    "Capture packets on the eth0 interface." \
    "Use: tcpdump -i eth0" \
    "^tcpdump[[:space:]]+-i[[:space:]]+eth0[[:space:]]*$"

ask_and_check \
    "Capture traffic on TCP port 80." \
    "Use: tcpdump port 80" \
    "^tcpdump[[:space:]]+port[[:space:]]+80[[:space:]]*$"

ask_and_check \
    "Capture traffic to/from host 192.168.1.1." \
    "Use: tcpdump host 192.168.1.1" \
    "^tcpdump[[:space:]]+host[[:space:]]+192\.168\.1\.1[[:space:]]*$"

ask_and_check \
    "Don't resolve IP addresses or ports." \
    "Use: tcpdump -nn" \
    "^tcpdump[[:space:]]+-nn[[:space:]]*$"

ask_and_check \
    "Save captured traffic to a file named capture.pcap." \
    "Use: tcpdump -w capture.pcap" \
    "^tcpdump[[:space:]]+-w[[:space:]]+capture\.pcap[[:space:]]*$"

ask_and_check \
    "Read and analyze packets from capture.pcap." \
    "Use: tcpdump -r capture.pcap" \
    "^tcpdump[[:space:]]+-r[[:space:]]+capture\.pcap[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'tcpdump' Tool${RESET}"
echo -e "🔍 You've learned how to capture, filter, and analyze network traffic using tcpdump!"
pause
