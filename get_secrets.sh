#!/bin/bash

az login --identity --allow-no-subscriptions > /dev/null 2>&1

DB_PASSWORD=$(az keyvault secret show --vault-name meowVault --name DBPASSWORD --query value -o tsv)

FLASK_SECRET_KEY=$(az keyvault secret show --vault-name meowVault --name FLASKSECRETKEY --query value -o tsv)

ENV_FILE="/opt/meow/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Erreur : fichier .env introuvable à $ENV_FILE"
  exit 1
fi

sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" "$ENV_FILE"
sed -i "s|^FLASK_SECRET_KEY=.*|FLASK_SECRET_KEY=${FLASK_SECRET_KEY}|" "$ENV_FILE"
