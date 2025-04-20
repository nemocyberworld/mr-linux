#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

ask_and_check_multiline() {
    local title="$1"
    local expected="$2"
    local regex="$3"

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected"
    echo -e "${CYAN}(Enter your input. Press Ctrl+D when done)${RESET}"

    local user_input
    user_input="$(</dev/stdin)"
    local trimmed_input
    trimmed_input="$(echo "$user_input" | sed 's/[[:space:]]*$//')"

    if [[ "$trimmed_input" =~ $regex ]]; then
        echo -e "${GREEN}✅ Correct!${RESET}"
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like: $expected"
    fi
    pause
}

ask_and_check() {
    local title="$1"
    local expected="$2"
    local regex="$3"
    local expected_output="$4"

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected"
    echo
    read -rp "> " user_input

    if [[ "$user_input" =~ $regex ]]; then
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}✅ Correct!${RESET}"
            else
                echo -e "${RED}❌ Output was incorrect. Got: '$output' Expected: '$expected_output'${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Correct!${RESET}"
        fi
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like: $expected"
    fi
    pause
}

clear
echo -e "${CYAN}${BOLD}🔧 Lesson: Standard Input/Output & Redirection${RESET}"
pause

# > and >>
clear
echo -e "${CYAN}${BOLD}📤 Output Redirection${RESET}"
echo "'>' writes to a file (overwrite)."
echo "'>>' appends to a file."
pause

ask_and_check \
    "Redirect output to a file using '>'" \
    "Try: echo Hello > hello.txt" \
    "^echo[[:space:]]+Hello[[:space:]]+>[[:space:]]*hello\.txt$"

ask_and_check \
    "Append to a file using '>>'" \
    "Try: echo World >> hello.txt" \
    "^echo[[:space:]]+World[[:space:]]+>>[[:space:]]*hello\.txt$"

# <
clear
echo -e "${CYAN}${BOLD}📥 Input Redirection${RESET}"
echo "'<' sends file content into a command."
pause

echo -e "Apple\nBanana\nCherry" > fruits.txt

ask_and_check \
    "Use input redirection with cat" \
    "Try: cat < fruits.txt" \
    "^cat[[:space:]]+<[[:space:]]*fruits\.txt$"

# Here-docs
clear
echo -e "${CYAN}${BOLD}📜 Here-Documents (<<)${RESET}"
echo "Here-docs feed multi-line input."
pause

ask_and_check_multiline \
    "Use a here-doc to print 2 lines" \
    "Try:
cat <<EOF
Hi
Bye
EOF" \
    $'^cat[[:space:]]+<<EOF$.*^Hi$.*^Bye$.*^EOF$'

# <<< here-string
clear
echo -e "${CYAN}${BOLD}🔹 Here-Strings (<<<)${RESET}"
echo "'<<<' passes string input to command."
pause

ask_and_check \
    "Use a here-string to feed input" \
    "Try: grep Banana <<< 'Apple Banana Cherry'" \
    "^grep[[:space:]]+Banana[[:space:]]+<<<[[:space:]]+'.*Apple.*Banana.*Cherry.*'\$"

# 2> and &>
clear
echo -e "${CYAN}${BOLD}❗ Error Redirection${RESET}"
pause

ask_and_check \
    "Redirect stderr to a file" \
    "Try: ls nofile 2> error.txt" \
    "^ls[[:space:]]+nofile[[:space:]]+2>[[:space:]]*error\.txt\$"

ask_and_check \
    "Redirect stdout and stderr to a file" \
    "Try: ls nofile &> all_output.txt" \
    "^ls[[:space:]]+nofile[[:space:]]+&>[[:space:]]*all_output\.txt\$"

# Piping
clear
echo -e "${CYAN}${BOLD}🔗 Piping${RESET}"
echo "'|' sends output from one command to another."
pause

ask_and_check \
    "Use piping to count files/dirs" \
    "Try: ls | wc -l" \
    "^ls[[:space:]]*\\|[[:space:]]*wc[[:space:]]+-l\$"

# End
echo
echo -e "${GREEN}${BOLD}🎉 You've mastered I/O redirection and piping!${RESET}"
pause
