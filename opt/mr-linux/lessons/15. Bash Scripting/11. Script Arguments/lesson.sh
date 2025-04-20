#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📘 Lesson: Script Arguments in Bash${RESET}"
echo
echo "When you run a Bash script, you can pass arguments to it from the command line."
echo "Let's learn how to access and manipulate them."
pause

# === Script Name and Positional Arguments ===
clear
echo -e "${CYAN}${BOLD}🔢 \$0 and \$1, \$2...${RESET}"
echo
echo -e "When you run a script like this: ${BOLD}./myscript.sh apple banana${RESET}"
echo -e "- \$0 is the script name: ./myscript.sh"
echo -e "- \$1 is the first argument: apple"
echo -e "- \$2 is the second argument: banana"
pause

# === $# and $@ / $* ===
clear
echo -e "${CYAN}${BOLD}📦 \$#, \$@, and \$*${RESET}"
echo
echo -e "- ${BOLD}\$#${RESET} is the number of arguments."
echo -e "- ${BOLD}\$@${RESET} expands to all arguments as separate words."
echo -e "- ${BOLD}\$*${RESET} expands to all arguments as a single word (with spaces)."
pause

# === shift ===
clear
echo -e "${CYAN}${BOLD}➡️  shift command${RESET}"
echo
echo "Use shift to move positional parameters left."
echo "Each time you call shift, \$1 is discarded and \$2 becomes \$1, etc."
pause

# === Practice Script ===
clear
echo -e "${CYAN}${BOLD}🛠️  Practice Script Example${RESET}"
echo
cat <<'EOF'
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "All args (\$@): $@"
echo "All args (\$*): $*"
echo "Number of args: $#"

echo "Shifting..."
shift
echo "Now first argument: $1"
EOF
echo
echo -e "Save it as ${BOLD}args_demo.sh${RESET}, make it executable, then run:"
echo -e "${BOLD}./args_demo.sh red green blue${RESET}"
pause

# === TASKS ===
ask_and_check \
    "Print the name of the script (use \$0)" \
    "Try: echo \$0" \
    "^echo[[:space:]]+\\\$0\$"

ask_and_check \
    "Print all arguments separately using \$@" \
    "Try: for arg in \"\$@\"; do echo \$arg; done" \
    "^for[[:space:]]+arg[[:space:]]+in[[:space:]]+\"\\\$@\";[[:space:]]+do[[:space:]]+echo[[:space:]]+\\\$arg;[[:space:]]+done\$"

ask_and_check \
    "Print total number of arguments" \
    "Try: echo \$#" \
    "^echo[[:space:]]+\\\$#\$"

ask_and_check \
    "Use shift and print new \$1" \
    "Try: shift; echo \$1" \
    "^shift;[[:space:]]*echo[[:space:]]+\\\$1\$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve mastered script arguments in Bash!${RESET}"
echo
echo "Use them to write more dynamic and flexible scripts!"
pause
