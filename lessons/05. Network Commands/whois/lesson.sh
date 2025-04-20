#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌍 Lesson: The 'whois' Command — Domain Information Lookup${RESET}"
echo
echo "'whois' is a command-line utility that retrieves domain registration and ownership information from public WHOIS databases."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}🔎 What does 'whois' do?${RESET}"
echo
echo "It allows you to find out who owns a domain name, when it was registered, when it expires, and which company registered it."
pause

# Step 2: Create a practice directory
PRACTICE_DIR="$SCRIPT_DIR/practice/whois_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit
echo -e "${YELLOW}📁 Practice directory created: $PRACTICE_DIR${RESET}"
pause

# Step 3: Show all common options and examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'whois' Usage Examples:${RESET}"

declare -A WHOIS_USAGE
WHOIS_USAGE["whois example.com"]="Lookup information for example.com"
WHOIS_USAGE["whois google.com"]="See registrar, name servers, and expiry date"
WHOIS_USAGE["whois -h whois.verisign-grs.com example.com"]="Query a specific WHOIS server"
WHOIS_USAGE["whois -H example.com"]="Disable extra legal disclaimers (may not work on all systems)"

for cmd in "${!WHOIS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WHOIS_USAGE[$cmd]}${RESET}"
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
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive Tasks
ask_and_check \
    "Perform a WHOIS lookup on 'example.com'" \
    "Use: whois example.com" \
    '^whois[[:space:]]+example\.com[[:space:]]*$'

ask_and_check \
    "Perform a WHOIS lookup on 'google.com'" \
    "Use: whois google.com" \
    '^whois[[:space:]]+google\.com[[:space:]]*$'

ask_and_check \
    "Use a specific WHOIS server to look up 'example.com'" \
    "Use: whois -h whois.verisign-grs.com example.com" \
    '^whois[[:space:]]+-h[[:space:]]+whois\.verisign-grs\.com[[:space:]]+example\.com[[:space:]]*$'

# Step 6: Cleanup and wrap-up
echo -e "${CYAN}🧹 No cleanup needed for whois commands.${RESET}"
pause

echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'whois' command lesson!${RESET}"
pause
