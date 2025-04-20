#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'trap' — Handle Signals in Bash Scripts${RESET}"
echo
echo "'trap' allows you to catch signals (like Ctrl+C) and execute custom code when they occur. This is useful for clean-up operations, logging, and preventing interruption."
pause

# Step 1: Create a trap demo script
echo -e "${BOLD}📦 Creating a demo trap script...${RESET}"
TMPDIR="$HOME/.mr_linux_trap_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

cat << 'EOF' > trap_example.sh
#!/bin/bash
trap 'echo -e "\n🔒 Ctrl+C is disabled. Cleaning up..."; exit' SIGINT

echo "Script is running. Press Ctrl+C to trigger trap..."
while true; do
    sleep 1
done
EOF

chmod +x trap_example.sh
pause

# Step 2: Run and test the trap script
clear
echo -e "${CYAN}${BOLD}⚙️ Try running the script and pressing Ctrl+C${RESET}"
echo -e "➡️  Example: ./trap_example.sh"
pause

# Step 3: Use trap to clean up temporary files
clear
echo -e "${CYAN}${BOLD}🧹 Trap cleanup example${RESET}"
cat << 'EOF' > trap_cleanup.sh
#!/bin/bash
TMPFILE=$(mktemp)
echo "Temp file: $TMPFILE"
trap 'echo "🧹 Cleaning up..."; rm -f "$TMPFILE"; exit' EXIT

echo "Sleeping... Hit Ctrl+C or let it finish."
sleep 10
EOF

chmod +x trap_cleanup.sh
echo -e "➡️  Example: ./trap_cleanup.sh"
pause

# Step 4: Task Checker
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

# Step 5: Interactive Tasks
ask_and_check \
    "Run the trap_example.sh script and observe what happens when you press Ctrl+C" \
    "Try: ./trap_example.sh (Then hit Ctrl+C)" \
    '^\.\/trap_example\.sh[[:space:]]*$' \
    true

ask_and_check \
    "Run the cleanup script and confirm it removes the temp file" \
    "Try: ./trap_cleanup.sh" \
    '^\.\/trap_cleanup\.sh[[:space:]]*$' \
    true

# Step 6: Bonus Info
clear
echo -e "${CYAN}${BOLD}💡 Common Signals You Can Trap:${RESET}"
echo -e "- SIGINT (2): Ctrl+C"
echo -e "- SIGTERM (15): Termination request"
echo -e "- SIGHUP (1): Terminal closed"
echo -e "- EXIT: Runs on any exit (end of script, signal, error)"
pause

# Step 7: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'trap' lesson! Nice job!${RESET}"
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
