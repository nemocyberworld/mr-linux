#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/utils/input.sh"

echo -e "${BOLD}${CYAN}🌐 Level 10: Networking II - Netcat Ninja${RESET}"
echo -e "A mysterious service is running on localhost... silently waiting on port 9009."
echo -e "Your mission: Connect using ${YELLOW}nc${RESET} and extract the secret message."
echo
echo -e "💡 Hint: Use something like:"
echo -e "    ${GREEN}nc localhost 9009${RESET}"
echo

# Level setup
LEVEL_DIR="/tmp/mr_linux_level9"
SECRET="netcat_unleashed_9090"
PORT=9009

rm -rf "$LEVEL_DIR"
mkdir -p "$LEVEL_DIR"

# Write the message to be served
echo -e "Welcome, traveler. You've found the secret service.\nThe flag is: ${SECRET}" > "$LEVEL_DIR/response.txt"

# Start a background Netcat listener that sends the file content
nc_server() {
    while true; do
        cat "$LEVEL_DIR/response.txt" | nc -l -p $PORT -q 1 > /dev/null 2>&1
    done
}

# Start it in the background if not already running
if ! lsof -i:$PORT >/dev/null 2>&1; then
    nc_server &
    NC_PID=$!
    echo $NC_PID > "$LEVEL_DIR/nc.pid"
fi

# Ask the user for the flag
ask_and_check "Paste the secret from nc localhost $PORT:" "$SECRET"

# Cleanup background server
if [[ -f "$LEVEL_DIR/nc.pid" ]]; then
    kill "$(cat "$LEVEL_DIR/nc.pid")" 2>/dev/null || true
    rm -f "$LEVEL_DIR/nc.pid"
fi

echo -e "${GREEN}🎯 Netcat mastery complete! You're now whispering in sockets.${RESET}"
