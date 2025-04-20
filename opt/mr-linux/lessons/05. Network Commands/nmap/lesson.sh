#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: nmap — Network Mapper Tool${RESET}"
echo
echo "'nmap' is a powerful network scanning tool used to discover hosts, services, and vulnerabilities on a network."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of nmap${RESET}"
echo -e "${BOLD}➡️  nmap [OPTIONS] [TARGETS]${RESET}"
echo
echo "You can scan a single IP, a range, or entire subnets."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'nmap' Commands:${RESET}"

declare -A NMAP_USAGE
NMAP_USAGE["nmap 192.168.1.1"]="Scan a single host"
NMAP_USAGE["nmap 192.168.1.1-20"]="Scan a range of IPs"
NMAP_USAGE["nmap -sP 192.168.1.0/24"]="Ping scan a subnet"
NMAP_USAGE["nmap -p 80 192.168.1.1"]="Scan port 80"
NMAP_USAGE["nmap -p 1-1000 192.168.1.1"]="Scan port range 1–1000"
NMAP_USAGE["nmap -sS 192.168.1.1"]="TCP SYN scan (stealth scan)"
NMAP_USAGE["nmap -O 192.168.1.1"]="Detect OS"
NMAP_USAGE["nmap -A 192.168.1.1"]="Aggressive scan: OS, services, scripts, and traceroute"
NMAP_USAGE["nmap -sV 192.168.1.1"]="Detect service versions"

for cmd in "${!NMAP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${NMAP_USAGE[$cmd]}${RESET}"
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
    "Scan a single host (192.168.1.1)." \
    "Use: nmap 192.168.1.1" \
    "^nmap[[:space:]]+192\.168\.1\.1[[:space:]]*$"

ask_and_check \
    "Perform a ping scan on 192.168.1.0/24 subnet." \
    "Use: nmap -sP 192.168.1.0/24" \
    "^nmap[[:space:]]+-sP[[:space:]]+192\.168\.1\.0/24[[:space:]]*$"

ask_and_check \
    "Scan ports 1 to 1000 on 192.168.1.1." \
    "Use: nmap -p 1-1000 192.168.1.1" \
    "^nmap[[:space:]]+-p[[:space:]]+1-1000[[:space:]]+192\.168\.1\.1[[:space:]]*$"

ask_and_check \
    "Perform a TCP SYN scan on 192.168.1.1." \
    "Use: nmap -sS 192.168.1.1" \
    "^nmap[[:space:]]+-sS[[:space:]]+192\.168\.1\.1[[:space:]]*$"

ask_and_check \
    "Perform an aggressive scan on 192.168.1.1." \
    "Use: nmap -A 192.168.1.1" \
    "^nmap[[:space:]]+-A[[:space:]]+192\.168\.1\.1[[:space:]]*$"

ask_and_check \
    "Detect operating system of 192.168.1.1." \
    "Use: nmap -O 192.168.1.1" \
    "^nmap[[:space:]]+-O[[:space:]]+192\.168\.1\.1[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'nmap' Tool${RESET}"
echo -e "📡 You've learned how to scan hosts, ports, and detect services/OS using Nmap!"
pause
