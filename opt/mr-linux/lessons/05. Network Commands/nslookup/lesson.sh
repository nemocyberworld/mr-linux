#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔎 Lesson: nslookup — Query Internet Name Servers${RESET}"
echo
echo "'nslookup' is a network administration command-line tool for querying the Domain Name System (DNS) to obtain domain name or IP address mapping, or other DNS records."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of nslookup${RESET}"
echo -e "${BOLD}➡️  nslookup [OPTION] [domain-name]${RESET}"
echo
echo "🔸 You can use it interactively or with single commands."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'nslookup' Commands:${RESET}"

declare -A NSLOOKUP_USAGE
NSLOOKUP_USAGE["nslookup google.com"]="Basic DNS lookup for google.com"
NSLOOKUP_USAGE["nslookup"]="Enter interactive mode"
NSLOOKUP_USAGE["server 8.8.8.8"]="Set DNS server in interactive mode"
NSLOOKUP_USAGE["set type=MX"]="Set query type to MX (Mail Exchange)"
NSLOOKUP_USAGE["nslookup -type=NS example.com"]="Query NS (Name Server) records for example.com"

for cmd in "${!NSLOOKUP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${NSLOOKUP_USAGE[$cmd]}${RESET}"
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
    "Query the IP address of 'example.com'" \
    "Use: nslookup example.com" \
    "^nslookup[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Query the name servers for 'example.com'" \
    "Use: nslookup -type=NS example.com" \
    "^nslookup[[:space:]]+-type=NS[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Set the query type to MX in interactive mode" \
    "Command: set type=MX" \
    "^set[[:space:]]+type=MX[[:space:]]*$"

ask_and_check \
    "Set Google's DNS server (8.8.8.8) in interactive mode" \
    "Command: server 8.8.8.8" \
    "^server[[:space:]]+8\.8\.8\.8[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great work! You've completed the 'nslookup' command lesson.${RESET}"
echo -e "🧠 You're now capable of using DNS lookups to resolve domain names, find MX records, and test DNS servers!"
pause
