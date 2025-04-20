#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: The 'wget' Command — Download from the Web${RESET}"
echo
echo "'wget' is a non-interactive command-line tool used to download files from the web over HTTP, HTTPS, and FTP."
pause

# Step 1: Explanation
clear
echo -e "${CYAN}${BOLD}🧰 What does 'wget' do?${RESET}"
echo
echo "'wget' retrieves content from web servers and saves it to your local system. It's useful for downloading files, web pages, or even entire sites."
pause

# Step 2: Create a practice directory
PRACTICE_DIR="$SCRIPT_DIR/practice/wget_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit
echo -e "${YELLOW}📁 Created practice directory at: $PRACTICE_DIR${RESET}"
pause

# Step 3: Show all common options and examples
clear
echo -e "${CYAN}${BOLD}📘 Common 'wget' Options and Examples:${RESET}"

declare -A WGET_USAGE
WGET_USAGE["wget http://example.com/file.txt"]="Download a file from a URL"
WGET_USAGE["wget -O custom_name.txt http://example.com/file.txt"]="Save as a custom filename"
WGET_USAGE["wget -c http://example.com/file.txt"]="Continue an interrupted download"
WGET_USAGE["wget -q http://example.com/file.txt"]="Download quietly (no output)"
WGET_USAGE["wget -r http://example.com/"]="Recursively download an entire site"
WGET_USAGE["wget --limit-rate=200k http://example.com/file.txt"]="Limit download speed"

for cmd in "${!WGET_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${WGET_USAGE[$cmd]}${RESET}"
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
    "Download a file from the internet" \
    "Use: wget http://example.com" \
    '^wget[[:space:]]+http://example\.com[[:space:]]*$'

ask_and_check \
    "Download and save as 'myfile.html'" \
    "Use: wget -O myfile.html http://example.com" \
    '^wget[[:space:]]+-O[[:space:]]+myfile\.html[[:space:]]+http://example\.com[[:space:]]*$'

ask_and_check \
    "Continue a download if it's interrupted" \
    "Use: wget -c http://example.com" \
    '^wget[[:space:]]+-c[[:space:]]+http://example\.com[[:space:]]*$'

ask_and_check \
    "Download quietly (no output)" \
    "Use: wget -q http://example.com" \
    '^wget[[:space:]]+-q[[:space:]]+http://example\.com[[:space:]]*$'

# Step 6: Cleanup and wrap-up
echo -e "${CYAN}🧹 Cleaning up downloaded files...${RESET}"
rm -f "$PRACTICE_DIR"/*
pause

echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'wget' command lesson!${RESET}"
pause
