#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎓 Welcome to Bash Scripting 101 — Let's Write Some Code!${RESET}"
echo
echo "This is your first step into the world of scripting with Bash — your shell's Swiss Army knife."
echo "We're going to learn what Bash is, how to run a script, and what that mysterious '#!/bin/bash' is all about!"
pause

# Step 1: What is Bash?
clear
echo -e "${CYAN}${BOLD}🤔 What is Bash?${RESET}"
echo -e "Bash stands for: ${BOLD}Bourne Again SHell${RESET}."
echo "It's a command processor and scripting language used in almost all Linux distros."
echo "You're likely using it every day in your terminal — and now you're going to write your own commands!"
pause

# Step 2: Write Your First Script
clear
echo -e "${CYAN}${BOLD}✍️ Let's Write a Simple Script${RESET}"
TMPDIR="$HOME/.mr_linux_bash_intro"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

cat << 'EOF' > hello.sh
#!/bin/bash
echo "👋 Hello, Bash World!"
EOF

echo -e "✅ Script created at ${YELLOW}$TMPDIR/hello.sh${RESET}"
pause

# Step 3: The Shebang
clear
echo -e "${CYAN}${BOLD}📢 What’s This? → #!/bin/bash${RESET}"
echo
echo -e "This line at the top of your script is called the ${BOLD}shebang${RESET}."
echo "It tells the system to use Bash to interpret the script."
echo "Without it, your system might try using the wrong interpreter!"
pause

# Step 4: Make it Executable
clear
echo -e "${CYAN}${BOLD}🔧 Time to Run the Script!${RESET}"
echo
echo "First, we give it execution permission:"
echo -e "${BOLD}chmod +x hello.sh${RESET}"
chmod +x hello.sh
pause

# Step 5: Run It!
echo -e "${CYAN}${BOLD}🚀 Let's Execute It!${RESET}"
echo "Now, run it like this:"
echo -e "${BOLD}./hello.sh${RESET}"
pause
./hello.sh
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
            echo -e "${RED}❌ Not quite. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# Step 7: Interactive Tasks
ask_and_check \
    "Create a Bash script named 'greet.sh'" \
    "Use nano greet.sh and start it with #!/bin/bash" \
    "^nano[[:space:]]+greet\.sh\$"

ask_and_check \
    "Add a line to print 'Hello Scripter!'" \
    "Try: echo \"echo 'Hello Scripter!'\" >> greet.sh" \
    "^echo[[:space:]]+\"echo[[:space:]]+'Hello Scripter!'\"[[:space:]]+>>[[:space:]]+greet\.sh\$"

ask_and_check \
    "Make your script executable" \
    "Try: chmod +x greet.sh" \
    "^chmod[[:space:]]+\+x[[:space:]]+greet\.sh\$"

ask_and_check \
    "Run your script!" \
    "Try: ./greet.sh" \
    "^\.\/greet\.sh\$"

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Congratulations, Scripter!${RESET}"
echo -e "You've written and run your first Bash script. That’s a big deal!"
echo -e "Next up: variables, logic, loops, and functions — oh my! 🌀"
echo
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
