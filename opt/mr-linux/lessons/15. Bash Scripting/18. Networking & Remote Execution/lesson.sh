#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: Networking & Remote Execution${RESET}"
echo
echo "In this lesson, we'll fetch data from the web, copy files across machines, and execute remote commands like a true terminal ninja."
pause

ask_and_check() {
    local title="$1"
    local expected_hint="$2"
    local expected_code="$3"
    local expected_output="$4"  # Optional

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected_hint"
    echo

    local user_input
    if [[ "$expected_code" == *$'\n'* ]]; then
        echo -e "${CYAN}(Enter your input. Press Ctrl+D when done)${RESET}"
        user_input="$(</dev/stdin)"
    else
        read -rp "> " user_input
    fi

    local cleaned_user
    local cleaned_expected
    cleaned_user=$(echo "$user_input" | sed 's/[[:space:]]\+$//' | sed '/^$/d')
    cleaned_expected=$(echo "$expected_code" | sed 's/[[:space:]]\+$//' | sed '/^$/d')

    if diff -u <(echo "$cleaned_user") <(echo "$cleaned_expected") >/dev/null; then
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}✅ Correct!${RESET}"
            else
                echo -e "${RED}❌ Output incorrect. Got: '$output', expected: '$expected_output'${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Correct!${RESET}"
        fi
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like:"
        echo "$expected_code"
    fi
    pause
}

# === curl ===
clear
echo -e "${CYAN}${BOLD}📥 Downloading with curl${RESET}"
echo
echo "curl is your command-line browser. It fetches content from URLs like a spider with a keyboard."
pause

ask_and_check \
  "Download a webpage with curl" \
  "Try: curl https://example.com" \
  "curl https://example.com"

# === wget ===
clear
echo -e "${CYAN}${BOLD}📦 Downloading with wget${RESET}"
echo
echo "wget is another powerful downloader. It's non-interactive and great for scripts!"
pause

ask_and_check \
  "Download a file with wget" \
  "Try: wget https://example.com/index.html" \
  "wget https://example.com/index.html"

# === scp ===
clear
echo -e "${CYAN}${BOLD}🚀 Secure Copy with scp${RESET}"
echo
echo "scp lets you securely copy files between machines. Think of it as teleportation for your files."
pause

ask_and_check \
  "Copy local file to remote host" \
  "Try: scp myfile.txt user@host:/path/to/destination/" \
  "scp myfile.txt user@host:/path/to/destination/"

# === ssh ===
clear
echo -e "${CYAN}${BOLD}🔐 Remote Execution with ssh${RESET}"
echo
echo "ssh lets you securely log into remote machines and run commands. It's like remote mind control—but legal."
pause

ask_and_check \
  "Run uptime on a remote machine via ssh" \
  "Try: ssh user@host uptime" \
  "ssh user@host uptime"

# === Bonus: ssh with a script ===
ask_and_check \
  "Run multiple commands remotely" \
  "Try:
ssh user@host << 'EOF'
echo \"Hello from afar!\"
uname -a
EOF" \
  "ssh user@host << 'EOF'
echo \"Hello from afar!\"
uname -a
EOF"

# === Wrap-up ===
clear
echo -e "${GREEN}${BOLD}🎉 You’re now network-savvy with Bash!${RESET}"
echo
echo "✅ curl and wget for grabbing web content"
echo "✅ scp for secure file transfers"
echo "✅ ssh for remote command execution"
echo
echo "You now have the power to control distant machines like a sysadmin sorcerer."
pause
