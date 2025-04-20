#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level14"
SCRIPT_FILE="$LEVEL_DIR/validate_args.sh"
FLAG_FILE="$LEVEL_DIR/flag.txt"
SECRET_ARGS=("red" "green" "blue")

mkdir -p "$LEVEL_DIR"
rm -f "$FLAG_FILE"

# Hide the actual args inside the script but make them easy to see for learners
cat <<EOF > "$SCRIPT_FILE"
#!/bin/bash

FLAG_FILE="/tmp/mr_linux_level14/flag.txt"

# 👀 These are the expected arguments
EXPECTED_1="red"
EXPECTED_2="green"
EXPECTED_3="blue"

if [[ "\$#" -ne 3 ]]; then
    echo "❌ You must provide exactly 3 arguments." >&2
    exit 1
fi

if [[ "\$1" == "\$EXPECTED_1" && "\$2" == "\$EXPECTED_2" && "\$3" == "\$EXPECTED_3" ]]; then
    echo "✅ Correct arguments!"
    echo "FLAG-L14-ARGS-KING" > "\$FLAG_FILE"
else
    echo "❌ Wrong arguments. Try again."
fi
EOF

chmod +x "$SCRIPT_FILE"

clear
echo -e "🧩 \033[1;34mLevel 14: Argument Arena\033[0m\n"
echo -e "Let’s see how well you can follow the clues.\n"
echo -e "🧠 Your mission:"
echo -e "  - Open and inspect the script at:"
echo -e "      \033[36m$SCRIPT_FILE\033[0m"
echo -e "  - Figure out the correct arguments by reading the script."
echo -e "  - Then run it with the correct three arguments to get the flag!\n"
echo -e "💡 Tips:"
echo -e "  - Use \033[1mcat $SCRIPT_FILE\033[0m to view the script."
echo -e "  - Look for how it uses \$1, \$2, etc. and the expected values."
echo -e "  - When successful, the flag will appear at:"
echo -e "      \033[33m$FLAG_FILE\033[0m\n"

read -p "🎯 Press Enter once you've read the script and tried it out..."

if [[ -f "$FLAG_FILE" ]]; then
    echo -e "\n🎉 \033[32mBoom! You nailed the arguments.\033[0m"
    echo -e "🏁 Flag: \033[33m$(cat "$FLAG_FILE")\033[0m"
    return 0 2>/dev/null || exit 0
else
    echo -e "\n❌ \033[31mStill no flag.\033[0m Did you read the script and pass the right arguments?"
    echo -e "Try again:\n  \033[36m$SCRIPT_FILE clor1 color2 color3\033[0m"
    return 0 2>/dev/null || exit 0
fi
