#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔧 Lesson: Bash Functions${RESET}"
echo
echo "Functions let you organize reusable chunks of code. They're super useful in larger scripts!"
pause

# === Defining and Calling Functions ===
clear
echo -e "${CYAN}${BOLD}📌 Defining and Calling Functions${RESET}"
echo
echo "Define a function like this:"
echo -e "${BOLD}say_hello() { echo \"Hello!\"; }${RESET}"
echo "Then call it like this:"
echo -e "${BOLD}say_hello${RESET}"
pause

read -rp "Try: say_hello() { echo \"Hello!\"; } → " def_func
eval "$def_func"
read -rp "Now call it: say_hello → " call_func
eval "$call_func"
pause

# === Function Arguments ===
clear
echo -e "${CYAN}${BOLD}📦 Function Arguments${RESET}"
echo
echo "Use \$1, \$2, etc., inside the function to access arguments."
echo
echo "Example:"
echo -e "${BOLD}greet() { echo \"Hello, \$1!\"; }${RESET}"
echo -e "${BOLD}greet Alice${RESET} → Hello, Alice"
pause

read -rp "Try: greet() { echo \"Hello, \$1!\"; } → " def_greet
eval "$def_greet"
read -rp "Now call it: greet Bob → " call_greet
eval "$call_greet"
pause

# === Return Values ===
clear
echo -e "${CYAN}${BOLD}🎯 Return Values${RESET}"
echo
echo "Use return codes (0–255) or use 'echo' to return strings."
echo
echo "Example with echo:"
echo -e "${BOLD}add() { echo \$((\$1 + \$2)); }${RESET}"
echo -e "${BOLD}result=\$(add 3 5)${RESET}"
echo -e "${BOLD}echo \$result${RESET} → 8"
pause

read -rp "Try: add() { echo \$((\$1 + \$2)); } → " def_add
eval "$def_add"
read -rp "Now: result=\$(add 4 6); echo \$result → " try_add
eval "$try_add"
pause

# === TASKS ===
ask_and_check \
    "Define a function that prints Hello World" \
    "Try: hello() { echo Hello World; }" \
    "^hello\\(\\)[[:space:]]*\\{[[:space:]]*echo[[:space:]]+Hello[[:space:]]+World;?[[:space:]]*\\}$"

ask_and_check \
    "Call the hello function you just defined" \
    "Try: hello" \
    "^hello\$"

ask_and_check \
    "Define a function 'double' that prints double the input" \
    "Try: double() { echo \$(( \$1 * 2 )); }" \
    '^double\(\)\s*\{\s*echo\s*\$\(\(\s*\$1\s*\*\s*2\s*\)\);\s*\}$'

double() { echo $(( $1 * 2 )); }
ask_and_check \
    "Call double function with 4 as input" \
    "Try: double 4" \
    "^double[[:space:]]+4\$" \
    "8"

ask_and_check \
    "Define a function 'is_even' that returns 0 if number is even, 1 otherwise" \
    "Try: is_even() { (( \$1 % 2 == 0 )) && return 0 || return 1; }" \
    "^is_even\\(\\)[[:space:]]*\\{[[:space:]]*\\(\\([[:space:]]*\\\$1[[:space:]]*%[[:space:]]*2[[:space:]]*==[[:space:]]*0[[:space:]]*\\)\\)[[:space:]]*&&[[:space:]]*return[[:space:]]*0[[:space:]]*\\|\\|[[:space:]]*return[[:space:]]*1;?[[:space:]]*\\}$"

eval "is_even() { (( \$1 % 2 == 0 )) && return 0 || return 1; }"
ask_and_check \
    "Use is_even with 3 and check return code" \
    "Try: is_even 3; echo \$?" \
    "^is_even[[:space:]]+3;[[:space:]]*echo[[:space:]]+\\\$\\?\$" \
    "1"


# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve mastered Bash functions!${RESET}"
echo
echo -e "Functions make your scripts modular and reusable. Use them to clean up repeated code!"
pause
