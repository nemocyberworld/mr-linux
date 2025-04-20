#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'lsof' — List Open Files${RESET}"
echo
echo -e "${YELLOW}lsof${RESET} stands for “List Open Files”. In Linux, everything is a file — including devices, sockets, directories, and regular files."
echo "This command helps you find out which files are open and what processes are using them."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}lsof [options] [file|PID|command]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🔍 Common Options:${RESET}"

echo -e "${YELLOW}List all open files:${RESET}"
echo -e "  ${GREEN}lsof${RESET}"

echo -e "\n${YELLOW}List open files by a specific user:${RESET}"
echo -e "  ${GREEN}lsof -u username${RESET}"

echo -e "\n${YELLOW}List files opened by a specific process ID:${RESET}"
echo -e "  ${GREEN}lsof -p PID${RESET}"

echo -e "\n${YELLOW}List all open Internet (network) connections:${RESET}"
echo -e "  ${GREEN}lsof -i${RESET}"

echo -e "\n${YELLOW}Find which process is using a specific file:${RESET}"
echo -e "  ${GREEN}lsof /path/to/file${RESET}"

pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_lsof_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

touch testfile.txt
gedit testfile.txt >/dev/null 2>&1 &  # open in background for file-lock test
sleep 1

ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧪 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Not quite. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Show all open files on the system" \
    "Basic usage of the command." \
    '^lsof\s*$' \
    "Nice! That lists all open files by all processes."

ask_and_check \
    "Show open files by the current user" \
    "Use -u with your username." \
    "^lsof\s+-u\s+$(whoami)\s*$" \
    "Excellent! You filtered by user."

ask_and_check \
    "List open files related to Internet/network" \
    "Look for a flag that implies networking." \
    '^lsof\s+-i\s*$' \
    "Great! You're seeing network connections."

ask_and_check \
    "Find the process using 'testfile.txt'" \
    "Give the filename as an argument." \
    '^lsof\s+testfile\.txt\s*$' \
    "Perfect! That shows which process is using the file."

PID=$(pgrep gedit | head -n1)
ask_and_check \
    "Show files opened by process ID $PID" \
    "Use -p followed by the PID." \
    "^lsof\s+-p\s+$PID\s*$" \
    "Well done! That lists open files for a process."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
kill "$PID" &>/dev/null
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo -e "You've learned how to use ${YELLOW}lsof${RESET} to explore open files and connections."
pause
