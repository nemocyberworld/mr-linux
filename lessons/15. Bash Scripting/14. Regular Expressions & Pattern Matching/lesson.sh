#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔍 Welcome to Regex Rodeo!${RESET}"
echo
echo "Giddy up! Today we’re wrangling patterns with 🧵 regular expressions and wild Bash matching tricks!"
pause

ask_and_check() {
    local title="$1"
    local expected_hint="$2"
    local expected_code="$3"
    local expected_output="$4"

    echo -e "${YELLOW}${BOLD}🤔 $title${RESET}"
    echo "$expected_hint"
    echo

    local user_input
    if [[ "$expected_code" == *$'\n'* ]]; then
        echo -e "${CYAN}(Type your code, then press Ctrl+D when done)${RESET}"
        user_input="$(</dev/stdin)"
    else
        read -rp "> " user_input
    fi

    # Normalize inputs
    local cleaned_user cleaned_expected
    cleaned_user=$(echo "$user_input" | sed 's/[[:space:]]\+$//' | sed '/^$/d')
    cleaned_expected=$(echo "$expected_code" | sed 's/[[:space:]]\+$//' | sed '/^$/d')

    if diff -u <(echo "$cleaned_user") <(echo "$cleaned_expected") >/dev/null; then
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}🎯 Yeehaw! That’s a match!${RESET}"
            else
                echo -e "${RED}❌ Hmm, your output was '$output', but we wanted '$expected_output'. Try again!${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Nailed it!${RESET}"
        fi
    else
        echo -e "${RED}❌ Nope! Let’s lasso the right syntax.${RESET}"
        echo "Expected something like:"
        echo "$expected_code"
    fi
    pause
}

# === GREP FUN ===
clear
echo -e "${CYAN}${BOLD}🧹 Filtering with grep${RESET}"
echo
echo "Let's clean out lines we don't want and keep the goodies using grep!"
pause

echo -e "Creating a tasty text file..."
echo -e "apple\nbanana\ncherry\napricot\nblueberry" > data.txt

ask_and_check \
  "Grab the goodies that start with 'a'" \
  "Hint: grep \"^a\" data.txt" \
  'grep "^a" data.txt' \
  $'apple\napricot'

ask_and_check \
  "Find the ones that end in a sweet 'y'" \
  "Hint: grep \"y$\" data.txt" \
  'grep "y$" data.txt' \
  $'cherry\nblueberry'

# === [[ =~ ]] — Bash Regex Magic ===
clear
echo -e "${CYAN}${BOLD}🔮 Pattern prophecy with [[ =~ ]]${RESET}"
echo
echo "Bash can do a little regex magic right in conditionals using [[ =~ ]] ✨"
pause

ask_and_check \
  "Check if 'hello' starts with h and ends with o" \
  "Try this sorcery:
word='hello'
[[ \$word =~ ^h.*o$ ]] && echo 'Match'" \
  "word='hello'
[[ \$word =~ ^h.*o$ ]] && echo 'Match'" \
  "Match"

# === case Craze ===
clear
echo -e "${CYAN}${BOLD}🎭 Pattern matching with case${RESET}"
echo
echo "Want to match words without regex headaches? Enter the friendly land of case!"
pause

ask_and_check \
  "React to fruits like a pattern whisperer 🍎🍌" \
  "Try:
fruit='apple'
case \$fruit in
  a*) echo 'Starts with a';;
  b*) echo 'Starts with b';;
esac" \
  "fruit='apple'
case \$fruit in
  a*) echo 'Starts with a';;
  b*) echo 'Starts with b';;
esac" \
  "Starts with a"

# === Wild Globs & Stars ===
clear
echo -e "${CYAN}${BOLD}🌟 Wildcards and Globbing Galaxy${RESET}"
echo
echo "* = all the things! ? = just one thing! [a-c] = pick a letter range!"
pause

mkdir -p testfiles
touch testfiles/file1.txt testfiles/file2.txt testfiles/data.csv testfiles/log.txt

ask_and_check \
  "Show me the .txt stuff" \
  "Try: ls testfiles/*.txt" \
  "ls testfiles/*.txt"

ask_and_check \
  "Only files that start with 'file' please!" \
  "Try: ls testfiles/file*" \
  "ls testfiles/file*"

# === WRAP-UP ===
clear
echo -e "${GREEN}${BOLD}🏁 Whoa there, partner! You did it!${RESET}"
echo
echo "🚀 You now know how to:"
echo "  - Use grep to filter files like a regex cowboy 🤠"
echo "  - Do conditional regex magic with [[ =~ ]] 🔮"
echo "  - Pattern match elegantly with case 🎭"
echo "  - Navigate file stars and mystery characters with globbing 🌌"
echo
echo -e "${CYAN}${BOLD}Keep on matching, Bash Wrangler! 🤠🐚${RESET}"
pause
