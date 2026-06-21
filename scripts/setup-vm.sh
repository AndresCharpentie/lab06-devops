#!/bin/bash
set -e

echo "Actualizando paquetes"
sudo apt update -y

echo "Instalando NodeJS, npm, unzip y curl"
sudo apt install -y nodejs npm unzip curl

echo "Instalando PM2 globalmente"
sudo npm install -g pm2

echo "Configurando PM2 para reinicio automático"
pm2 startup systemd -u "$USER" --hp "$HOME" || true

echo "VM preparada para recibir despliegues"
