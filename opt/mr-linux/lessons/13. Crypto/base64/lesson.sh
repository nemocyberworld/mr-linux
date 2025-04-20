#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'base64' — Encode and Decode Files or Text${RESET}"
echo
echo "'base64' encodes or decodes data using the Base64 encoding scheme. It's useful for transmitting binary data in text format."
pause

# Step 1: Setup
echo -e "${BOLD}📦 Setting up practice files...${RESET}"
TMPDIR="$HOME/.mr_linux_base64_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "secret_password_123" > password.txt
pause

# Step 2: Encode a file
clear
echo -e "${CYAN}${BOLD}🔐 Encode a file to Base64${RESET}"
echo -e "➡️  Example: base64 password.txt"
base64 password.txt
pause

# Step 3: Save encoded output
clear
echo -e "${CYAN}${BOLD}📥 Save encoded text to a file${RESET}"
base64 password.txt > encoded.txt
echo -e "✅ Saved to encoded.txt"
pause

# Step 4: Decode base64 file
clear
echo -e "${CYAN}${BOLD}🔓 Decode base64 back to original text${RESET}"
base64 -d encoded.txt
pause

# Step 5: Save decoded content
base64 -d encoded.txt > decoded.txt
echo -e "${GREEN}✅ Decoded content saved to decoded.txt${RESET}"
echo -e "📄 Contents of decoded.txt:"
cat decoded.txt
pause

# Step 6: Task Checker
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-false}"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 7: Interactive Tasks
ask_and_check \
    "Base64-encode 'password.txt'" \
    "Try: base64 password.txt" \
    '^base64[[:space:]]+password\.txt[[:space:]]*$'

ask_and_check \
    "Save the encoded output to a file 'safe.txt'" \
    "Try: base64 password.txt > safe.txt" \
    '^base64[[:space:]]+password\.txt[[:space:]]+>[[:space:]]+safe\.txt[[:space:]]*$'

ask_and_check \
    "Decode the file 'safe.txt' back to original" \
    "Try: base64 -d safe.txt" \
    '^base64[[:space:]]+-d[[:space:]]+safe\.txt[[:space:]]*$'

ask_and_check \
    "Decode 'safe.txt' and save it to 'output.txt'" \
    "Try: base64 -d safe.txt > output.txt" \
    '^base64[[:space:]]+-d[[:space:]]+safe\.txt[[:space:]]+>[[:space:]]+output\.txt[[:space:]]*$'

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'base64' lesson! Great job!${RESET}"
echo -e "🧹 Cleaning up practice files..."
rm -rf "$TMPDIR"
pause
