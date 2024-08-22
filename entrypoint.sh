#!/bin/bash

echo "Start entrypoint file"

if [ -f /vault/secrets/secrets.env ]; then
    touch .env && cp -rf /vault/secrets/secrets.env /var/www/html/.env
fi
if [ -f /vault/secrets/test-secrets.env ]; then
    touch .env && cp -rf /vault/secrets/test-secrets.env /var/www/html/.env
fi

chmod 766 /var/www/html/probe-check.sh

echo "jupyter notebook"
jupyter notebook

echo "End entrypoint"
while :; do
sleep 300
done
