#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level19"
SCRIPT_FILE="$LEVEL_DIR/fix_me.sh"
FLAG_FILE="$LEVEL_DIR/flag.txt"

mkdir -p "$LEVEL_DIR"
rm -f "$SCRIPT_FILE" "$FLAG_FILE"

FLAG_CONTENT="FLAG-L19-FUNCTION-FIXED"

# Create the broken script
cat <<'EOF' > "$SCRIPT_FILE"
#!/bin/bash
set -u  # Treat unset variables as an error

FLAG_FILE="/tmp/mr_linux_level19/flag.txt"

# 🔧 Function definitions (one is broken!)
greet() {
    echo "Welcome to the Bash Function Repair Shop!"
}

# 🧩 Your mission: Fix this broken function!
calculate_sum() {
    local a="${1:-}"
    local b="${2:-}"

    # Basic input check
    if [[ -z "$a" || -z "$b" ]]; then
        echo "❌ Error: Missing arguments to calculate_sum" >&2
        return 1
    fi

    echo $((a * b))
}

# ✅ Final function (called only if sum == 42)
unlock_flag() {
    echo "Well done! Here's your flag..." > "$FLAG_FILE"
    echo "FLAG-L19-FUNCTION-FIXED" >> "$FLAG_FILE"
}

# 🚀 Script flow
greet
read -p "Enter first number: " num1
read -p "Enter second number: " num2

sum=$(calculate_sum "$num1" "$num2") || exit 1

echo "Sum is: $sum"

if [[ "$sum" -eq 42 ]]; then
    unlock_flag
else
    echo "❌ Sum is not the magic number. Try again!"
fi
EOF

chmod +x "$SCRIPT_FILE"

# Launch instructions
clear
echo -e "🧠 \033[1;34mLevel 19: Scripting Functions\033[0m\n"
echo -e "🎯 Your challenge:"
echo -e "  - Open and edit the script: \033[36m$SCRIPT_FILE\033[0m"
echo -e "  - Fix the broken function: \033[33mcalculate_sum()\033[0m"
echo -e "  - Make sure it takes two arguments and returns their sum"
echo -e "  - When the sum is exactly 42, the flag will be unlocked!\n"
echo -e "💡 Hint:"
echo -e "  - Use arithmetic like: \033[36mresult=\$((a + b))\033[0m"
echo -e "  - Then: \033[36mecho \"\$result\"\033[0m to return it"
echo -e "  - Avoid crashing with \033[31mset -u\033[0m by safely handling arguments\n"

read -p "🛠️ Fix the script, then press Enter to run it..."

# Let them run the fixed script
"$SCRIPT_FILE"

# Check result
if [[ -f "$FLAG_FILE" ]] && grep -q "$FLAG_CONTENT" "$FLAG_FILE"; then
    echo -e "\n🎉 \033[32mVictory! You repaired the function and earned the flag.\033[0m"
    echo -e "🏁 Flag: \033[33m$(cat "$FLAG_FILE")\033[0m"
else
    echo -e "\n❌ \033[31mNo flag yet! Double-check your function and try again.\033[0m"
fi
