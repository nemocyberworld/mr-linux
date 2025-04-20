#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}⚖️ Lesson: Conditional Statements in Bash${RESET}"
echo
echo "Let's teach your scripts how to make decisions!"
pause

# ========================
# Basic if/else
# ========================
clear
echo -e "${CYAN}${BOLD}📍 Basic if/else Statement${RESET}"
echo
echo "Syntax:"
echo -e "${BOLD}if [ condition ]; then${RESET}"
echo -e "    commands"
echo -e "${BOLD}else${RESET}"
echo -e "    other commands"
echo -e "${BOLD}fi${RESET}"
pause

read -rp "Try this: num=5 → " try1
eval "$try1"
pause

read -rp "Now type: if [ \$num -gt 3 ]; then echo \"Big\"; else echo \"Small\"; fi → " try2
eval "$try2"
pause

# ========================
# elif usage
# ========================
clear
echo -e "${CYAN}${BOLD}🧬 if / elif / else Chain${RESET}"
echo
echo "Multiple conditions? Use elif!"
echo
echo -e "${BOLD}if [ condition1 ]; then ... elif [ condition2 ]; then ... else ... fi${RESET}"
pause

cat <<'EOF'
Try this script:
read -p "Enter a number: " x
if [ $x -lt 0 ]; then
    echo "Negative"
elif [ $x -eq 0 ]; then
    echo "Zero"
else
    echo "Positive"
fi
EOF
pause

# ========================
# Test Conditions
# ========================
clear
echo -e "${CYAN}${BOLD}🔍 Test Conditions${RESET}"
echo
echo -e "${BOLD}[ ]${RESET} is the traditional test command"
echo -e "${BOLD}[[ ]]${RESET} is more modern and safer in scripts"
echo -e "${BOLD}(( ))${RESET} is great for arithmetic expressions"
pause

echo -e "${YELLOW}Examples:${RESET}"
echo '[ "$name" = "Alice" ]   → string comparison'
echo '[[ $file == *.txt ]]    → pattern matching'
echo '(( x > 5 ))             → math comparison'
pause

# ========================
# case statement
# ========================
clear
echo -e "${CYAN}${BOLD}🔀 case Statement${RESET}"
echo
echo "A cleaner way to handle many conditions:"
echo
echo -e "${BOLD}case \$var in${RESET}"
echo -e "  pattern1) commands ;;"
echo -e "  pattern2) commands ;;"
echo -e "  *) default ;;"
echo -e "${BOLD}esac${RESET}"
pause

cat <<'EOF'
Try this:
read -p "Pick a fruit: " fruit
case $fruit in
    apple) echo "Apples are red!" ;;
    banana) echo "Bananas are yellow!" ;;
    *) echo "Unknown fruit!" ;;
esac
EOF
pause

# ========================
# TASKS
# ========================
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
                eval "$user_cmd" || echo -e "${RED}⚠️ It ran but might not have worked as expected.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Nope, try again.${RESET}"
        fi
    done
    pause
    clear
}

# === TASKS ===

# Task 1: if/else with [ ]
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Enter a number for x: " x
x="${x:-0}"  # Optional: default to 0 if nothing entered

ask_and_check \
    "Use if/else to check if a number is 10" \
    "Try: if [ \$x -eq 10 ]; then echo Yes; else echo No; fi" \
    "^if[[:space:]]+\[\[?[[:space:]]*\\\$x[[:space:]]+-eq[[:space:]]+10[[:space:]]*\]?\]?[[:space:]]*;[[:space:]]*then[[:space:]]*echo[[:space:]]+Yes;[[:space:]]*else[[:space:]]*echo[[:space:]]+No;[[:space:]]*fi\$"

# Task 2: arithmetic test (( ))
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Enter a number for x: " x
x="${x:-0}"  # Optional: default to 0 if nothing entered

ask_and_check \
    "Use arithmetic test: (( x > 5 ))" \
    "Try: if (( x > 5 )); then echo High; else echo Low; fi" \
    "^if[[:space:]]+\(\([[:space:]]*x[[:space:]]*>[[:space:]]*5[[:space:]]*\)\);[[:space:]]*then[[:space:]]*echo[[:space:]]+High;[[:space:]]*else[[:space:]]*echo[[:space:]]+Low;[[:space:]]*fi\$"

# Task 3: case statement
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Type your Answer as yes/no: " ans

ask_and_check \
    "Use case to handle 'yes', 'no', or other" \
    "Try: case \$ans in yes) echo Yes;; no) echo No;; *) echo Maybe;; esac" \
    "^case[[:space:]]+\\\$ans[[:space:]]+in[[:space:]]+yes\\)[[:space:]]*echo[[:space:]]+Yes;;[[:space:]]+no\\)[[:space:]]*echo[[:space:]]+No;;[[:space:]]+\\*\\)[[:space:]]*echo[[:space:]]+Maybe;;[[:space:]]+esac\$"

# Task 4: if with elif chain
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Enter your score (0-100): " score
score="${score:-0}"

ask_and_check \
    "Use if/elif/else to grade score" \
    "Try: if (( score >= 90 )); then echo A; elif (( score >= 80 )); then echo B; else echo C; fi" \
    "^if[[:space:]]+\(\([[:space:]]*score[[:space:]]*>=?[[:space:]]*90[[:space:]]*\)\);[[:space:]]*then[[:space:]]*echo[[:space:]]+A;[[:space:]]*elif[[:space:]]+\(\([[:space:]]*score[[:space:]]*>=?[[:space:]]*80[[:space:]]*\)\);[[:space:]]*then[[:space:]]*echo[[:space:]]+B;[[:space:]]*else[[:space:]]*echo[[:space:]]+C;[[:space:]]*fi\$"

# Task 5: string comparison with [[ ]]
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Enter your name: " name

ask_and_check \
    "Use [[ ]] to test string equality" \
    "Try: if [[ \$name == Alice ]]; then echo Hi Alice; else echo Who are you?; fi" \
    "^if[[:space:]]+\[\[[[:space:]]*\\\$name[[:space:]]*==[[:space:]]*Alice[[:space:]]*\]\];[[:space:]]*then[[:space:]]*echo[[:space:]]+Hi[[:space:]]+Alice;[[:space:]]*else[[:space:]]*echo[[:space:]]+Who[[:space:]]+are[[:space:]]+you\\?;[[:space:]]*fi\$"

# Task 6: Check if a number is even or odd using modulo
echo -e "${CYAN}${BOLD}🔀 Taking input for next task${RESET}"
read -p "Enter a number to check even/odd: " num
num="${num:-0}"

ask_and_check \
    "Check if a number is even or odd" \
    "Try: if (( num % 2 == 0 )); then echo Even; else echo Odd; fi" \
    "^if[[:space:]]+\(\([[:space:]]*num[[:space:]]*%[[:space:]]*2[[:space:]]*==[[:space:]]*0[[:space:]]*\)\);[[:space:]]*then[[:space:]]*echo[[:space:]]+Even;[[:space:]]*else[[:space:]]*echo[[:space:]]+Odd;[[:space:]]*fi\$"

# ========================
# Wrap-up
# ========================
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've learned how to use conditionals in Bash!${RESET}"
echo
echo -e "${BOLD}- if, elif, else${RESET}"
echo -e "${BOLD}- Test conditions: [ ], [[ ]], (( ))${RESET}"
echo -e "${BOLD}- case statements for multi-branch logic${RESET}"
echo
echo -e "Next up: ${YELLOW}Loops${RESET} — make your scripts repeat themselves!"
pause
