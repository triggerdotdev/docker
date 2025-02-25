#!/bin/sh

if [ "$1" = "--help" ]; then
    echo "Usage: $0 [domain]"
    echo "Exposes local server on port \$PORT (default 3040) via ngrok."
    echo "If domain is provided, uses that domain."
    exit 0
fi

domain=$1
port=${PORT:-3040}

if ! command -v ngrok >/dev/null 2>&1; then
    echo "Please install ngrok: https://ngrok.com/download"
    exit 1
fi

if ! nc -z localhost "$port" > /dev/null 2>&1; then
    echo "Warning: No server is listening on port $port. Ngrok might not work as expected."
fi

echo "Starting ngrok on port $port..."
if [ -n "$domain" ]; then
    ngrok http --domain="$domain" "$port"
else
    ngrok http "$port"
fi
