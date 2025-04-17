#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: tshark — Terminal-based Packet Analyzer${RESET}"
echo
echo "'tshark' is the CLI version of Wireshark. It allows capturing and analyzing network traffic directly in the terminal."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of tshark${RESET}"
echo -e "${BOLD}➡️  tshark [OPTIONS]${RESET}"
echo
echo "tshark captures and displays packets from a live interface or a saved capture file."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'tshark' Commands:${RESET}"

declare -A TSHARK_USAGE
TSHARK_USAGE["tshark -i eth0"]="Capture packets from eth0"
TSHARK_USAGE["tshark -i eth0 -c 10"]="Capture 10 packets from eth0"
TSHARK_USAGE["tshark -r file.pcap"]="Read packets from a pcap file"
TSHARK_USAGE["tshark -Y \"http.request\""]="Display only HTTP request packets"
TSHARK_USAGE["tshark -i eth0 -f 'port 80'"]="Capture only traffic on port 80"
TSHARK_USAGE["tshark -T fields -e ip.src -e ip.dst"]="Extract source and destination IPs"

for cmd in "${!TSHARK_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TSHARK_USAGE[$cmd]}${RESET}"
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
    "Capture 10 packets from interface eth0." \
    "Use: tshark -i eth0 -c 10" \
    "^tshark[[:space:]]+-i[[:space:]]+eth0[[:space:]]+-c[[:space:]]+10[[:space:]]*$"

ask_and_check \
    "Read packets from a file named file.pcap." \
    "Use: tshark -r file.pcap" \
    "^tshark[[:space:]]+-r[[:space:]]+file\.pcap[[:space:]]*$"

ask_and_check \
    "Display only HTTP request packets from eth0." \
    "Use: tshark -i eth0 -Y \"http.request\"" \
    "^tshark[[:space:]]+-i[[:space:]]+eth0[[:space:]]+-Y[[:space:]]+\"http\.request\"[[:space:]]*$"

ask_and_check \
    "Capture only traffic on port 80 from eth0." \
    "Use: tshark -i eth0 -f 'port 80'" \
    "^tshark[[:space:]]+-i[[:space:]]+eth0[[:space:]]+-f[[:space:]]+'port 80'[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'tshark' Tool${RESET}"
echo -e "📊 You've learned how to capture, filter, and analyze packets with tshark!"
pause
