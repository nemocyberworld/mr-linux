#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔧 Lesson: The 'tee' Command — Output to Terminal and File Simultaneously${RESET}"
echo
echo "'tee' reads from standard input and writes to standard output **and** files at the same time."
echo "Useful for saving command output while still viewing it live."
pause

# Step 1: Setup practice directory
TMPDIR="$HOME/.mr_linux_tee_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Show example scenario
clear
echo -e "${YELLOW}${BOLD}🧪 Let's create a file using 'tee' from echo output:${RESET}"
echo -e "${BOLD}➡️  Command: echo 'Hello from tee!' | tee hello.txt${RESET}"
pause
echo 'Hello from tee!' | tee hello.txt
echo
echo -e "${BOLD}📄 Contents of hello.txt:${RESET}"
cat hello.txt
pause

# Step 3: Show 'tee' options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'tee' Options and Examples:${RESET}"

declare -A TEE_USAGE
TEE_USAGE["echo 'log this' | tee logfile.txt"]="Write echo output to screen and file"
TEE_USAGE["echo 'append this' | tee -a logfile.txt"]="Append instead of overwriting"
TEE_USAGE["ls -l | tee files.txt"]="Save output of commands like 'ls'"
TEE_USAGE["cat /etc/passwd | tee passwd_copy.txt | grep root"]="Chain 'tee' with other commands"

for cmd in "${!TEE_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TEE_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Interactive Task Function
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
                eval "$user_cmd"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Tasks
ask_and_check \
    "Use tee to write 'Hello Mr Linux' into a file named mr.txt and display it" \
    "Try: echo 'Hello Mr Linux' | tee mr.txt" \
    "^echo[[:space:]]+'Hello[[:space:]]Mr[[:space:]]Linux'[[:space:]]*\|[[:space:]]*tee[[:space:]]+mr\.txt[[:space:]]*$"

ask_and_check \
    "Append 'Another line' to the same file using tee" \
    "Try: echo 'Another line' | tee -a mr.txt" \
    "^echo[[:space:]]+'Another[[:space:]]line'[[:space:]]*\|[[:space:]]*tee[[:space:]]+-a[[:space:]]+mr\.txt[[:space:]]*$"

ask_and_check \
    "List current directory with ls and write the output to ls_output.txt using tee" \
    "Try: ls | tee ls_output.txt" \
    "^ls[[:space:]]*\|[[:space:]]*tee[[:space:]]+ls_output\.txt[[:space:]]*$"

ask_and_check \
    "Read /etc/passwd, write to tee_passwd.txt, then search for 'bash' using grep in one line" \
    "Try: cat /etc/passwd | tee tee_passwd.txt | grep bash" \
    "^cat[[:space:]]+/etc/passwd[[:space:]]*\|[[:space:]]*tee[[:space:]]+tee_passwd\.txt[[:space:]]*\|[[:space:]]*grep[[:space:]]+bash[[:space:]]*$"

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've finished the 'tee' command lesson.${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause
