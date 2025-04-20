#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"


clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'cat' Command — Full Guide${RESET}"
echo
echo "'cat' (concatenate) is used to display, join, and manipulate text files."
pause

# Step 1: Setup practice files
echo -e "${BOLD}📦 Creating practice files...${RESET}"
TMPDIR="$HOME/.mr_linux_cat_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
echo -e "Line 1\n\nLine 3\n\n\nLine 6" > file1.txt
echo -e "Hello from file 2" > file2.txt
> file3.txt
pause

# Step 2: Display files to remember
clear
echo -e "${YELLOW}${BOLD}📘 Files used in this lesson:${RESET}"
echo -e "📄 file1.txt — Contains multiple blank lines"
echo -e "📄 file2.txt — Simple single-line file"
echo -e "📄 file3.txt — Empty file"
pause

# cat --help
clear
echo -e "${CYAN}${BOLD}📁 Let's see available options in this tool:${RESET}"
echo -e "${YELLOW}${BOLD}📘 cat --help${RESET}"
cat --help
pause


# Step 3: Explain all options with examples
declare -A CAT_OPTIONS
CAT_OPTIONS["cat file1.txt"]="Basic usage: display content of a file"
CAT_OPTIONS["cat file1.txt file2.txt"]="Concatenate multiple files"
CAT_OPTIONS["cat -n file1.txt"]="Number all output lines"
CAT_OPTIONS["cat -b file1.txt"]="Number non-blank lines only"
CAT_OPTIONS["cat -s file1.txt"]="Squeeze multiple blank lines into one"
CAT_OPTIONS["cat -E file1.txt"]="Show end of each line with \$"
CAT_OPTIONS["cat -T file1.txt"]="Show tab characters as ^I"
CAT_OPTIONS["cat -A file1.txt"]="Show non-printing characters (same as -vET)"
CAT_OPTIONS["cat -v file1.txt"]="Show non-printing characters (except tab/newline)"

clear
echo -e "${CYAN}${BOLD}📚 All Useful Options in 'cat':${RESET}"
for cmd in "${!CAT_OPTIONS[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CAT_OPTIONS[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    eval "$cmd"
    pause
done

clear
echo -e "${MAGENTA}${BOLD}🧪 Let's test your understanding with some interactive tasks!${RESET}"
pause

# Step 4: Function to ask and validate commands
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct! Output:${RESET}"
            eval "$user_cmd"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Tasks (with flexible matching)
ask_and_check \
    "Display contents of a file using 'cat'" \
    "Try: cat file1.txt (any file is okay)" \
    '^cat[[:space:]]+[^[:space:]]+'

ask_and_check \
    "Combine two files into a third using > redirection" \
    "Try: cat file1.txt file2.txt > file3.txt" \
    '^cat[[:space:]]+[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]*>[[:space:]]*[^[:space:]]+'

ask_and_check \
    "Show line numbers using '-n'" \
    "Try: cat -n file1.txt" \
    '^cat[[:space:]]+-n[[:space:]]+[^[:space:]]+'

ask_and_check \
    "Number non-blank lines using '-b'" \
    "Try: cat -b file1.txt" \
    '^cat[[:space:]]+-b[[:space:]]+[^[:space:]]+'

ask_and_check \
    "Squeeze blank lines using '-s'" \
    "Try: cat -s file1.txt" \
    '^cat[[:space:]]+-s[[:space:]]+[^[:space:]]+'

ask_and_check \
    "Show end of lines using '-E'" \
    "Try: cat -E file1.txt" \
    '^cat[[:space:]]+-E[[:space:]]+[^[:space:]]+'

ask_and_check \
    "Display all hidden characters using '-A'" \
    "Try: cat -A file1.txt" \
    '^cat[[:space:]]+-A[[:space:]]+[^[:space:]]+'

# Done!
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'cat' lesson! Well done!${RESET}"
echo -e "🧹 Cleaning up temporary files..."
rm -rf "$TMPDIR"
pause