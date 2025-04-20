#!/bin/bash
set -euo pipefail

LEVEL_DIR="/tmp/mr_linux_level12"
SECRET_SCRIPT="$LEVEL_DIR/mytools/secret_script.sh"
EXPECTED_FLAG="env_path_mastery"
FLAG_FILE="$LEVEL_DIR/flag.txt"

# Clean slate
rm -rf "$LEVEL_DIR"
mkdir -p "$LEVEL_DIR/mytools"

# Create the secret script
echo "#!/bin/bash" > "$SECRET_SCRIPT"
echo "echo \"$EXPECTED_FLAG\" > \"$FLAG_FILE\"" >> "$SECRET_SCRIPT"
chmod +x "$SECRET_SCRIPT"
rm -f "$FLAG_FILE"

# Intro
clear
echo -e "🌿 \033[1mLevel 12: Environment Variables\033[0m\n"
echo -e "Your environment is powerful. Use it wisely!\n"
echo "📁 A secret script is hiding in: $LEVEL_DIR/mytools/"
echo "But it can't be run directly... unless it's in your \$PATH!\n"
echo "👉 Add that directory to your PATH using export."
echo "Then just run:"
echo "    secret_script.sh"
echo -e "\n🏁 The script will drop a flag. Your job: copy/paste that flag below to complete the level.\n"
read -rp "⚙️  Press Enter when ready to begin..."

# Create temporary rcfile to auto-exit when flag is generated
RCFILE=$(mktemp)
cat > "$RCFILE" <<EOF
PS1="env-level> "
PROMPT_COMMAND='
  if [[ -f "$FLAG_FILE" ]]; then
    echo -e "\n🚪 Exiting environment shell..."
    exit
  fi
'
EOF

# Launch temporary shell with custom prompt
bash --rcfile "$RCFILE"

# Ask for flag after exiting shell
clear
echo -e "\n🕵️  Paste the flag dropped by the script below:"
read -rp "🔑 Flag: " USER_FLAG

if [[ "$USER_FLAG" == "$EXPECTED_FLAG" ]]; then
  echo -e "\n🎉 \033[32mSuccess! You've mastered PATH manipulation!\033[0m"
  echo -e "🏁 Flag accepted: \033[33m$USER_FLAG\033[0m"
  return 0 2>/dev/null || exit 0
else
  echo -e "\n❌ \033[31mIncorrect flag. Did you run the script correctly?\033[0m"
  return 0 2>/dev/null || exit 0
fi
