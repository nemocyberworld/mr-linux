# #!/bin/bash

# echo -e "${BOLD}${YELLOW}Level 2: Hidden Secrets${RESET}"

# # Create a hidden directory and file with a secret inside
# HIDDEN_DIR="$TMP_DIR/.hidden_stuff"
# HIDDEN_FILE="$HIDDEN_DIR/.invisible_secret"
# mkdir -p "$HIDDEN_DIR"
# SECRET="level2_secret_$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)"
# echo "$SECRET" > "$HIDDEN_FILE"

# echo "Somewhere in the temp directory lies a hidden file."
# echo "Your mission: Find the hidden secret and enter it below!"
# pause

# read -rp "> " user_input

# if [[ "$user_input" == "$SECRET" ]]; then
#     echo -e "${GREEN}✅ Correct! You're getting sneakier.${RESET}"
# else
#     echo -e "${RED}❌ Nope, that’s not it. Use your inner ninja powers and try again!${RESET}"
#     exit 1
# fi
#!/bin/bash
LEVEL_TMP_DIR=$(mktemp -d /tmp/mr_linux_game_XXXX)
SECRET_FILE="$LEVEL_TMP_DIR/.hidden_secret"
SECRET_VALUE="superhidden$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)"

echo "$SECRET_VALUE" > "$SECRET_FILE"

clear
echo "Level 2: Hidden Secrets"
echo "Somewhere in the temp directory lies a hidden file."
echo "Your mission: Find the hidden secret and enter it below!"
pause

while true; do
  read -rp "> " user_input
  if [[ "$user_input" == "$SECRET_VALUE" ]]; then
    echo -e "${GREEN}🎉 Correct! Well done!${RESET}"
    break
  else
    echo -e "${RED}❌ Nope, that’s not it. Use your inner ninja powers and try again!${RESET}"
    read -rp "Try again? (Y to retry / Q to quit level): " retry_choice
    case "$retry_choice" in
      [Qq]) echo "Exiting level early..."; break ;;
    esac
  fi
done

rm -rf "$LEVEL_TMP_DIR"
