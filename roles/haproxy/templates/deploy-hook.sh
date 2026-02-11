#!/bin/bash

DOMAIN="$LEGO_CERT_DOMAIN"
PEM_FILE="$LEGO_CERT_PEM_PATH"
DEST="{{ haproxy_cert_path }}/$DOMAIN.pem"

echo "Copying $PEM_FILE to $DEST..."
cp "$PEM_FILE" "$DEST"
chmod 644 "$DEST"
echo "Copied $DOMAIN PEM to $DEST"

if ! haproxy -c -f /etc/haproxy/haproxy.cfg; then
    echo "HAProxy configuration test failed! Aborting reload."
    exit 1
fi
echo "Reloading HAProxy..."
systemctl reload haproxy
echo "HAProxy successfully reloaded with new certificate for $DOMAIN"
