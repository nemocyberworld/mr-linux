#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}⚙️ Lesson: Command Substitution & Arithmetic${RESET}"
echo
echo "Learn how to run commands within other commands, and perform arithmetic in Bash!"
pause

# === Command Substitution ===
clear
echo -e "${CYAN}${BOLD}🔁 Command Substitution${RESET}"
echo
echo "Use \$(command) or backticks \`command\` to insert the output of a command into another command."
echo
echo "Example:"
echo -e "${BOLD}echo \"Today is \$(date)\"${RESET}"
pause

ask_and_check \
    "Use command substitution to show current directory" \
    "Try: echo \"You are in: \$(pwd)\"" \
    '^echo[[:space:]]+"You are in:[[:space:]]*\$\(pwd\)"$'

ask_and_check \
    "Use backticks instead of \$() to print date" \
    "Try: echo \"Date: \`date\`\"" \
    "^echo[[:space:]]+\"Date:[[:space:]]*\`date\`\"$"

# === Arithmetic ===
clear
echo -e "${CYAN}${BOLD}➕ Arithmetic Operations${RESET}"
echo
echo "Use \$(( )) for integer arithmetic."
echo
echo "Example:"
echo -e "${BOLD}echo \$(( 3 + 5 ))${RESET} → 8"
pause

ask_and_check \
    "Add 7 and 6 using arithmetic" \
    "Try: echo \$(( 7 + 6 ))" \
    "^echo[[:space:]]+\\$\\(\\([[:space:]]*7[[:space:]]*\\+[[:space:]]*6[[:space:]]*\\)\\)$"

ask_and_check \
    "Multiply 4 and 5 using arithmetic" \
    "Try: echo \$(( 4 * 5 ))" \
    "^echo[[:space:]]+\\$\\(\\([[:space:]]*4[[:space:]]*\\*[[:space:]]*5[[:space:]]*\\)\\)$"

# === Combine Command Substitution + Arithmetic ===
clear
echo -e "${CYAN}${BOLD}🎯 Combine Substitution & Arithmetic${RESET}"
echo
echo "You can combine them like this:"
echo -e "${BOLD}files=\$(ls | wc -l); echo \"Total: \$(( files + 10 ))\"${RESET}"
pause

ask_and_check \
    "Count files and add 2 to the count" \
    "Try: count=\$(ls | wc -l); echo \$(( count + 2 ))" \
    "^count=\\$\\(ls[[:space:]]*\\|[[:space:]]*wc[[:space:]]*-l\\);[[:space:]]*echo[[:space:]]+\\$\\(\\([[:space:]]*count[[:space:]]*\\+[[:space:]]*2[[:space:]]*\\)\\)$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job!${RESET}"
echo "You've learned how to:"
echo -e "- Use \$(command) and backticks to embed commands"
echo -e "- Perform arithmetic using \$(( ))"
echo -e "- Combine both for powerful one-liners"
pause
