#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'vim' Editor — Extended Guide${RESET}"
echo
echo "'vim' is a modal editor: normal, insert, visual, and command modes each have their own power."
pause

# Setup
echo -e "${BOLD}📦 Setting up a practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_vim_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
echo -e "line one\nline two\nline three\nsearch me\ncopy this\npaste below\nfinal line" > main.txt
touch empty.txt
pause

# Overview Commands
clear
echo -e "${CYAN}${BOLD}📚 vim Basics Refresher:${RESET}"

declare -A VIM_CMDS
VIM_CMDS["vim filename"]="Open file"
VIM_CMDS["i / a / o"]="Enter INSERT mode (beginning, after, or new line)"
VIM_CMDS["Esc"]="Return to NORMAL mode"
VIM_CMDS[":w / :q / :wq"]="Save, quit, or save & quit"
VIM_CMDS["dd / yy / p"]="Delete line, yank (copy), paste"
VIM_CMDS["/word"]="Search for word"
VIM_CMDS["n / N"]="Next/previous match"
VIM_CMDS["G / gg / :NUM"]="Jump to last, first, or a line"
VIM_CMDS["v / V / Ctrl+v"]="Visual: char, line, or block mode"
VIM_CMDS[":set nu / paste / ignorecase"]="Temporary settings"
VIM_CMDS["~/.vimrc"]="Permanent configuration"

for key in "${!VIM_CMDS[@]}"; do
    echo -e "${YELLOW}💬 ${VIM_CMDS[$key]}${RESET}"
    echo -e "${BOLD}➡️  $key${RESET}"
    pause
done

# Interactive helper
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
                eval "$user_cmd" || echo -e "${RED}⚠️ May not have executed correctly.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Try again.${RESET}"
        fi
    done
    pause
    clear
}

# Tasks
ask_and_check \
    "Open main.txt in vim" \
    "Try: vim main.txt" \
    '^vim[[:space:]]+main\.txt[[:space:]]*$' \
    true

echo -e "${BOLD}✍️ Inside vim:${RESET}"
echo -e "1. Press '/' then type: search"
echo -e "2. Use 'n' to jump forward"
echo -e "3. Use ':5' to jump to line 5"
read -rp "Press Enter when you're done..."
pause

ask_and_check \
    "Open empty.txt and enter INSERT mode" \
    "Try: vim empty.txt" \
    '^vim[[:space:]]+empty\.txt[[:space:]]*$' \
    true

echo -e "Inside vim:"
echo -e "1. Type 'i' to enter INSERT mode"
echo -e "2. Write a few lines"
echo -e "3. Press ESC then type :wq to save and quit"
read -rp "Press Enter when you're done..."
pause

ask_and_check \
    "Delete the last line of main.txt using vim" \
    "Try: vim main.txt" \
    '^vim[[:space:]]+main\.txt[[:space:]]*$' \
    true

echo -e "Once inside:"
echo -e "1. Press G to go to the last line"
echo -e "2. Type 'dd' to delete it"
echo -e "3. Save with ':wq'"
read -rp "Press Enter when done..."
pause

# ✨ Visual mode tasks
ask_and_check \
    "Use VISUAL MODE to copy and paste a line" \
    "Try: vim main.txt" \
    '^vim[[:space:]]+main\.txt[[:space:]]*$' \
    true

echo -e "${BOLD}In vim:${RESET}"
echo -e "1. Use '/' to search for 'copy this'"
echo -e "2. Use 'V' (uppercase) to start linewise selection"
echo -e "3. Press 'y' to yank (copy)"
echo -e "4. Move to where you want it and press 'p' to paste"
read -rp "Press Enter when you're done..."
pause

ask_and_check \
    "Use BLOCK VISUAL MODE (Ctrl+v) to edit a column" \
    "Try: vim main.txt" \
    '^vim[[:space:]]+main\.txt[[:space:]]*$' \
    true

echo -e "Try this advanced move:"
echo -e "1. Move to the start of a column of words"
echo -e "2. Press Ctrl+v to enter block visual"
echo -e "3. Use arrow keys to select multiple lines"
echo -e "4. Press 'I', type something, then ESC twice"
read -rp "Press Enter when you're done..."
pause

# 🛠️ .vimrc Config
clear
echo -e "${CYAN}${BOLD}🛠️ Customizing vim with ~/.vimrc${RESET}"
pause

cat > "$TMPDIR/.vimrc" <<EOF
" Basic usability
set number
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set ignorecase
set smartcase
colorscheme desert
EOF

export VIMINIT="source $TMPDIR/.vimrc"

ask_and_check \
    "Test out your vim config (line numbers, colors, indenting)" \
    "Try: vim main.txt" \
    '^vim[[:space:]]+main\.txt[[:space:]]*$' \
    true

echo -e "You should see:"
echo -e "✔️ Line numbers"
echo -e "✔️ Syntax highlighting"
echo -e "✔️ Proper auto-indenting"
echo -e "✔️ 'desert' colorscheme"
read -rp "Press Enter when confirmed..."
pause

# Clean up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome job — you've finished the full 'vim' lesson!${RESET}"
echo -e "🧹 Cleaning up practice files..."
rm -rf "$TMPDIR"
pause
