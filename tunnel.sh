#!/bin/sh

domain=$1
port=3040

if ! command -v ngrok >/dev/null 2>&1; then
    echo "Please install ngrok: https://ngrok.com/download"
    exit 1
fi

if [ -n "$domain" ]; then
    ngrok http --domain="$domain" "$port"
else
    ngrok http "$port"
fi
