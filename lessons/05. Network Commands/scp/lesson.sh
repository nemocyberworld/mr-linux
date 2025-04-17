#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Lesson: scp — Secure Copy Over SSH${RESET}"
echo
echo "'scp' allows secure file copying between hosts over SSH. It's useful for transferring files to/from remote systems."
pause

# Step 1: Basic Syntax
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Basic Syntax of scp${RESET}"
echo -e "${BOLD}➡️  scp [OPTIONS] source destination${RESET}"
echo
echo "🔸 You can copy files locally, to remote systems, or from remote systems securely."
pause

# Step 2: Common Examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'scp' Commands:${RESET}"

declare -A SCP_USAGE
SCP_USAGE["scp file.txt user@192.168.1.10:/home/user/"]="Copy file.txt to a remote host"
SCP_USAGE["scp user@192.168.1.10:/home/user/file.txt ./"]="Copy file from a remote host to the current directory"
SCP_USAGE["scp -r myfolder user@192.168.1.10:/home/user/"]="Recursively copy a folder to a remote host"
SCP_USAGE["scp -P 2222 file.txt user@192.168.1.10:/home/user/"]="Use custom SSH port (2222) for file transfer"
SCP_USAGE["scp file1.txt file2.txt user@host:/path"]="Copy multiple files to a remote host"

for cmd in "${!SCP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${SCP_USAGE[$cmd]}${RESET}"
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
    "Copy 'myfile.txt' to user@192.168.1.50:/home/user/" \
    "Use: scp myfile.txt user@192.168.1.50:/home/user/" \
    "^scp[[:space:]]+myfile\.txt[[:space:]]+user@192\.168\.1\.50:/home/user/?[[:space:]]*$"

ask_and_check \
    "Copy 'project/' folder recursively to user@host:/var/www/" \
    "Use: scp -r project user@host:/var/www/" \
    "^scp[[:space:]]+-r[[:space:]]+project[[:space:]]+user@host:/var/www/?[[:space:]]*$"

ask_and_check \
    "Copy 'report.pdf' from user@host:/home/user/ to current directory" \
    "Use: scp user@host:/home/user/report.pdf ./" \
    "^scp[[:space:]]+user@host:/home/user/report\.pdf[[:space:]]+\./[[:space:]]*$"

ask_and_check \
    "Use port 2222 to copy 'test.txt' to a remote host" \
    "Use: scp -P 2222 test.txt user@host:/home/user/" \
    "^scp[[:space:]]+-P[[:space:]]*2222[[:space:]]+test\.txt[[:space:]]+user@host:/home/user/?[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: 'scp' Command${RESET}"
echo -e "📁 You now know how to securely transfer files and directories between systems using SSH."
pause
