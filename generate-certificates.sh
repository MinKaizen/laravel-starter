#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
ENV_FILE="$SCRIPT_DIR/.env"

if [[ -e "$ENV_FILE" ]]; then
  echo ".env file found. Continuing..."
else
  echo "ERROR: .env file does not exist. Aborting"
  exit 1
fi

source "$ENV_FILE"

echo "APP_URL: $APP_URL"

if [[ -z "$APP_URL" ]]; then
  echo "APP_URL is not set in .env file. Aborting"
  exit 1
else
  echo "APP_URL: $APP_URL"
fi

if echo "$APP_URL" | grep -qE '^https?://'; then
  echo "APP_URL looks like a valid url"
else
  echo "APP_URL is not a valid url. Aborting"
  exit 1
fi

# Extract the domain name from APP_URL
DOMAIN_NAME=$(echo "$APP_URL" | sed -E 's#https?://([^/]+).*#\1#')

# Check if DOMAIN_NAME is extracted
if [[ -z "$DOMAIN_NAME" ]]; then
  echo "Failed to extract domain name from APP_URL: $APP_URL"
  echo "Aborting"
  exit 1
fi

echo "DOMAIN_NAME: $DOMAIN_NAME"

if [[ -z "$VITE_CERTS_DIR" ]]; then
  echo "VITE_CERTS_DIR is not set in .env file. Aborting"
  exit 1
fi

CERTS_DIR="$SCRIPT_DIR/$VITE_CERTS_DIR"

# Check if the directory exists
if [[ ! -d "$CERTS_DIR" ]]; then
  echo "Creating directory: $CERTS_DIR"
  mkdir "$CERTS_DIR"  # Create the directory, including parent directories
else
  echo "Certs directory exists: $DIR"
fi

CERT_FILE="$CERTS_DIR/$DOMAIN_NAME.pem"
KEY_FILE="$CERTS_DIR/$DOMAIN_NAME-key.pem"

# Run mkcert with the extracted domain name
COMMAND="mkcert -cert-file $CERT_FILE -key-file $KEY_FILE $DOMAIN_NAME"
echo "Command: $COMMAND"
$($COMMAND)

# Exit with the status of the mkcert command
exit $?
