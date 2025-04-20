#!/bin/bash

echo -e "${BOLD}${YELLOW}Level 1: Permissions Challenge${RESET}"

# Create the secret file
mkdir -p "$TMP_DIR"
SECRET="swordfish"
echo "$SECRET" > "$TMP_DIR/secret_file"
chmod 000 "$TMP_DIR/secret_file"

echo "There's a secret file at: $TMP_DIR/secret_file"
echo "You must find a way to read it. Use a new terminal if needed."
pause

echo -e "\nType the secret word from the file to proceed:"
read -rp "> " user_input

if [[ "$user_input" == "$SECRET" ]]; then
    echo -e "${GREEN}✅ Nice job!${RESET}"
else
    echo -e "${RED}❌ Nope! That's not the secret. Try again later.${RESET}"
    exit 1
fi
