#!/bin/bash

LEVEL_DIR="/tmp/mr_linux_level13"
FLAG_FILE="$LEVEL_DIR/flag.txt"
SCRIPT_FILE="$LEVEL_DIR/give_flag.sh"

mkdir -p "$LEVEL_DIR"
rm -f "$FLAG_FILE"

# Create the cron-triggered script
cat <<EOF > "$SCRIPT_FILE"
#!/bin/bash
/bin/echo "FLAG-L13-CRON-SCHEDULED-SUCCESS" > "$FLAG_FILE"
EOF
chmod +x "$SCRIPT_FILE"

clear
echo -e "⏰ \033[1;34mLevel 13: Cron Commando\033[0m\n"
echo -e "You're now the master of time. It's time to prove it.\n"
echo -e "🧠 Your mission:"
echo -e "  - Run this script every minute via crontab:"
echo -e "      \033[33m$SCRIPT_FILE\033[0m\n"
echo -e "📍 When successful, this file will appear with a flag:"
echo -e "      \033[33m$FLAG_FILE\033[0m\n"
echo -e "🎯 Use \033[1mcrontab -e\033[0m to add the cronjob."
echo -e "⚠️  Use absolute paths, and make sure the syntax is valid!\n"
read -p "🔧 Press Enter to launch crontab..."

# Launch crontab editor
crontab -e
chmod +x $SCRIPT_FILE
echo -e "\n⏳ Waiting for cron to run and create the flag...\n"

# Wait loop — check every 5 seconds up to 90 seconds
for i in {1..18}; do
    if [[ -f "$FLAG_FILE" ]]; then
        USER_FLAG=$(cat "$FLAG_FILE")
        EXPECTED_FLAG="FLAG-L13-CRON-SCHEDULED-SUCCESS"
        if [[ "$USER_FLAG" == "$EXPECTED_FLAG" ]]; then
            echo -e "\n🎉 \033[32mBravo! You’ve bent time to your will.\033[0m"
            echo -e "🏁 Flag accepted: \033[33m$USER_FLAG\033[0m"
            sleep 5
            return 0 2>/dev/null || exit 0
        else
            echo -e "\n❌ \033[31mFlag found but incorrect. Check your script output!\033[0m"
            break
        fi
    fi
    echo -n "⌛ Still waiting..."
    sleep 5
    echo " checking again."
done

echo -e "\n❌ \033[31mNo flag found. Cronjob probably didn’t run correctly.\033[0m"
echo -e "🔍 Make sure your cronjob runs this:\n  \033[33m$SCRIPT_FILE\033[0m"
echo -e "📁 And check: \033[33m$FLAG_FILE\033[0m\n"

sleep 5
return 0 2>/dev/null || exit 0

