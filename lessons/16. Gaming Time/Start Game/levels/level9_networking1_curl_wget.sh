#!/bin/bash
set -euo pipefail

# Load input handler
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/utils/input.sh"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

LEVEL=9
LEVEL_NAME="Networking I — Use curl or wget to retrieve secrets"
LEVEL_DIR="/tmp/mr_linux_networking_$RANDOM"
mkdir -p "$LEVEL_DIR"

FLAG="net_master_1337"
SECRET_PATH="super/secret/endpoint"
PORT=$((RANDOM % 1000 + 8000))  # random port 8000–8999
SERVER_FILE="$LEVEL_DIR/server.py"

# Create a Python web server
cat <<EOF > "$SERVER_FILE"
import http.server
import socketserver

PORT = $PORT
class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/$SECRET_PATH":
            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()
            self.wfile.write(b"$FLAG")
        else:
            self.send_response(404)
            self.end_headers()

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()
EOF

# Start server in background
python3 "$SERVER_FILE" &
SERVER_PID=$!
sleep 1  # Give the server time to start

# Prompt
echo -e "${BOLD}${CYAN}🌐 Level 9: Networking I${RESET}"
echo -e "A secret is being served from a local web server."
echo -e "But it's hiding at an unusual path!"
echo
echo -e "🔎 Use ${YELLOW}curl${RESET} or ${YELLOW}wget${RESET} to retrieve the flag from:"
echo -e "  ${YELLOW}http://localhost:$PORT/$SECRET_PATH${RESET}"
echo
echo -e "💡 Example:"
echo -e "  curl http://localhost:$PORT/$SECRET_PATH"
echo

# Player input
ask_and_check "Paste the secret from the endpoint:" "$FLAG"

# Done
kill $SERVER_PID 2>/dev/null || true
rm -rf "$LEVEL_DIR"

echo -e "${GREEN}🚀 Well done! Your networking skills are top-tier.${RESET}"
