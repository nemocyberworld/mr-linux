#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: dig — DNS Lookup Tool${RESET}"
echo
echo "'dig' (Domain Information Groper) is a network administration command-line tool for querying Domain Name System (DNS) name servers."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Usage of dig${RESET}"
echo -e "${BOLD}➡️ Command: dig example.com${RESET}"
echo "This fetches DNS records for the domain 'example.com'."
pause

# Step 2: Common Options
clear
echo -e "${CYAN}${BOLD}📚 Common 'dig' Options:${RESET}"

declare -A DIG_USAGE
DIG_USAGE["dig example.com"]="Query A record for domain"
DIG_USAGE["dig example.com MX"]="Get mail server (MX) records"
DIG_USAGE["dig example.com NS"]="Get name servers (NS)"
DIG_USAGE["dig example.com ANY"]="Get all available DNS records"
DIG_USAGE["dig @8.8.8.8 example.com"]="Use a specific DNS server (Google)"
DIG_USAGE["dig +short example.com"]="Get a short, clean output"
DIG_USAGE["dig -x IP"]="Reverse lookup for an IP address"

for cmd in "${!DIG_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${DIG_USAGE[$cmd]}${RESET}"
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
    "Query A record for the domain example.com" \
    "Try: dig example.com" \
    "^dig[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Get mail server (MX) records for example.com" \
    "Try: dig example.com MX" \
    "^dig[[:space:]]+example\.com[[:space:]]+MX[[:space:]]*$"

ask_and_check \
    "Use Google DNS to query example.com" \
    "Try: dig @8.8.8.8 example.com" \
    "^dig[[:space:]]+@8\.8\.8\.8[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Get a short output for example.com" \
    "Try: dig +short example.com" \
    "^dig[[:space:]]+\+short[[:space:]]+example\.com[[:space:]]*$"

ask_and_check \
    "Perform a reverse DNS lookup on 8.8.8.8" \
    "Try: dig -x 8.8.8.8" \
    "^dig[[:space:]]+-x[[:space:]]+8\.8\.8\.8[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'dig' lesson.${RESET}"
echo -e "🧠 You can now confidently query DNS records and troubleshoot DNS-related issues!"
pause
