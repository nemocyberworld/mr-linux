#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: curl — Command Line Data Transfer Tool${RESET}"
echo
echo "'curl' is a powerful tool used to transfer data from or to a server using supported protocols like HTTP, HTTPS, FTP, and more."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Usage of curl${RESET}"
echo -e "${BOLD}➡️ Command: curl https://example.com${RESET}"
echo "This downloads the contents of the URL and prints it to your terminal."
pause

# Step 2: Common Options
clear
echo -e "${CYAN}${BOLD}📚 Common 'curl' Options:${RESET}"

declare -A CURL_USAGE
CURL_USAGE["curl -O URL"]="Download file with the original name"
CURL_USAGE["curl -o file URL"]="Download file and save it as 'file'"
CURL_USAGE["curl -L URL"]="Follow redirects"
CURL_USAGE["curl -I URL"]="Fetch HTTP headers only"
CURL_USAGE["curl -X METHOD URL"]="Send a custom HTTP request"
CURL_USAGE["curl -d data URL"]="Send POST data"
CURL_USAGE["curl -H 'Header: value' URL"]="Add a custom header"

for cmd in "${!CURL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CURL_USAGE[$cmd]}${RESET}"
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
    "Download the webpage content at https://example.com" \
    "Try: curl https://example.com" \
    "^curl[[:space:]]+https://example\.com[[:space:]]*$"

ask_and_check \
    "Download a file from a URL and save it using its original name" \
    "Try: curl -O https://example.com/file.txt" \
    "^curl[[:space:]]+-O[[:space:]]+https://.+\.txt[[:space:]]*$"

ask_and_check \
    "Download a file and save it as 'myfile.txt'" \
    "Try: curl -o myfile.txt https://example.com/file.txt" \
    "^curl[[:space:]]+-o[[:space:]]+myfile\.txt[[:space:]]+https://.+\.txt[[:space:]]*$"

ask_and_check \
    "Follow redirects when accessing a URL" \
    "Try: curl -L https://short.url" \
    "^curl[[:space:]]+-L[[:space:]]+https://.+[[:space:]]*$"

ask_and_check \
    "Fetch only the HTTP headers from a website" \
    "Try: curl -I https://example.com" \
    "^curl[[:space:]]+-I[[:space:]]+https://example\.com[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'curl' lesson.${RESET}"
echo -e "🧠 You now know how to retrieve, download, and inspect web content using 'curl'."
pause
