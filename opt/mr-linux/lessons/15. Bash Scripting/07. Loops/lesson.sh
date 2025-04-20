#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔁 Lesson: Loops in Bash${RESET}"
echo
echo "Loops let you repeat things — perfect for automation, iteration, and control!"
pause

# === for loop ===
clear
echo -e "${CYAN}${BOLD}🔄 for Loop${RESET}"
echo
echo "Use a for loop to repeat over a list of values:"
echo
echo -e "${BOLD}for i in 1 2 3; do echo \$i; done${RESET}"
pause

read -rp "Try it! Type the command above → " try_for
eval "$try_for"
pause

# === while loop ===
clear
echo -e "${CYAN}${BOLD}⏳ while Loop${RESET}"
echo
echo "The while loop runs as long as a condition is true:"
echo
echo -e "${BOLD}x=1${RESET}"
echo -e "${BOLD}while [ \$x -le 3 ]; do echo \$x; ((x++)); done${RESET}"
pause

read -rp "Try it! Type the commands above in one line → " try_while
eval "$try_while"
pause

# === until loop ===
clear
echo -e "${CYAN}${BOLD}📉 until Loop${RESET}"
echo
echo "The until loop runs until the condition becomes true:"
echo
echo -e "${BOLD}x=1${RESET}"
echo -e "${BOLD}until [ \$x -gt 3 ]; do echo \$x; ((x++)); done${RESET}"
pause

read -rp "Try it! Type the commands above in one line → " try_until
eval "$try_until"
pause

# === break & continue ===
clear
echo -e "${CYAN}${BOLD}🎮 break & continue${RESET}"
echo
echo -e "${BOLD}break${RESET} exits the loop early."
echo -e "${BOLD}continue${RESET} skips the rest of this iteration."
echo
echo -e "Example:"
echo -e "${BOLD}for i in {1..5}; do [[ \$i -eq 3 ]] && continue; echo \$i; done${RESET}"
pause

read -rp "Try skipping number 3: → " try_continue
eval "$try_continue"
pause

read -rp "Now break at 3: for i in {1..5}; do [[ \$i -eq 3 ]] && break; echo \$i; done → " try_break
eval "$try_break"
pause

# === TASKS ===
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

ask_and_check \
    "Print numbers 1 to 3 using a for loop" \
    "Try: for i in 1 2 3; do echo \$i; done" \
    "^for[[:space:]]+i[[:space:]]+in[[:space:]]+1[[:space:]]+2[[:space:]]+3;[[:space:]]+do[[:space:]]+echo[[:space:]]+\\\$i;[[:space:]]+done\$"

ask_and_check \
    "Print numbers 1 to 3 using a while loop" \
    "Try: x=1; while [ \$x -le 3 ]; do echo \$x; ((x++)); done" \
    "^x=1;[[:space:]]*while[[:space:]]+\[[[:space:]]*\\\$x[[:space:]]+-le[[:space:]]+3[[:space:]]*\];[[:space:]]*do[[:space:]]*echo[[:space:]]+\\\$x;[[:space:]]*\(\(x\+\+\)\);[[:space:]]*done\$"

ask_and_check \
    "Use until to stop when x > 3" \
    "Try: x=1; until [ \$x -gt 3 ]; do echo \$x; ((x++)); done" \
    "^x=1;[[:space:]]*until[[:space:]]+\[[[:space:]]*\\\$x[[:space:]]+-gt[[:space:]]+3[[:space:]]*\];[[:space:]]*do[[:space:]]*echo[[:space:]]+\\\$x;[[:space:]]*\(\(x\+\+\)\);[[:space:]]*done\$"

ask_and_check \
    "Use break to stop loop at 3" \
    "Try: for i in {1..5}; do [[ \$i -eq 3 ]] && break; echo \$i; done" \
    "^for[[:space:]]+i[[:space:]]+in[[:space:]]+\{1\.\.5\};[[:space:]]+do[[:space:]]+\[\[[[:space:]]*\\\$i[[:space:]]+-eq[[:space:]]+3[[:space:]]*\]\][[:space:]]+&&[[:space:]]+break;[[:space:]]+echo[[:space:]]+\\\$i;[[:space:]]+done\$"

ask_and_check \
    "Use continue to skip number 3" \
    "Try: for i in {1..5}; do [[ \$i -eq 3 ]] && continue; echo \$i; done" \
    "^for[[:space:]]+i[[:space:]]+in[[:space:]]+\{1\.\.5\};[[:space:]]+do[[:space:]]+\[\[[[:space:]]*\\\$i[[:space:]]+-eq[[:space:]]+3[[:space:]]*\]\][[:space:]]+&&[[:space:]]+continue;[[:space:]]+echo[[:space:]]+\\\$i;[[:space:]]+done\$"

ask_and_check \
    "Print even numbers from 2 to 10 using a for loop" \
    "Try: for i in {2..10..2}; do echo \$i; done" \
    "^for[[:space:]]+i[[:space:]]+in[[:space:]]+\{2\.\.10\.\.2\};[[:space:]]+do[[:space:]]+echo[[:space:]]+\\\$i;[[:space:]]+done\$"

ask_and_check \
    "Print numbers 1 to 3 using a C-style for loop" \
    "Try: for ((i=1; i<=3; i++)); do echo \$i; done" \
    "^for[[:space:]]+\(\([[:space:]]*i=1;[[:space:]]*i<=3;[[:space:]]*i\+\+[[:space:]]*\)\);[[:space:]]*do[[:space:]]*echo[[:space:]]+\\\$i;[[:space:]]*done\$"

ask_and_check \
    "Print numbers 1 to 5, skip 2 and stop at 4 using continue and break" \
    "Try: for i in {1..5}; do [[ \$i -eq 2 ]] && continue; [[ \$i -eq 4 ]] && break; echo \$i; done" \
    "^for[[:space:]]+i[[:space:]]+in[[:space:]]+\{1\.\.5\};[[:space:]]+do[[:space:]]+\[\[[[:space:]]*\\\$i[[:space:]]+-eq[[:space:]]+2[[:space:]]*\]\][[:space:]]+&&[[:space:]]+continue;[[:space:]]+\[\[[[:space:]]*\\\$i[[:space:]]+-eq[[:space:]]+4[[:space:]]*\]\][[:space:]]+&&[[:space:]]+break;[[:space:]]+echo[[:space:]]+\\\$i;[[:space:]]+done\$"


# === Wrap-up ===
echo
echo -e "${GREEN}${BOLD}🎉 Loop mastery unlocked!${RESET}"
echo
echo -e "You now know how to use ${BOLD}for${RESET}, ${BOLD}while${RESET}, ${BOLD}until${RESET}, as well as ${BOLD}break${RESET} and ${BOLD}continue${RESET}."
echo -e "Next lesson: ${YELLOW}Functions${RESET} — write reusable commands!"
pause
