#!/bin/bash
set -e

APP_NAME="devops-lab"
APP_DIR="/opt/devops-lab"
PACKAGE_DIR="/tmp/devops-package"

echo "Iniciando despliegue de $APP_NAME"

sudo mkdir -p "$APP_DIR"
sudo chown -R "$USER:$USER" "$APP_DIR"

rm -rf "$APP_DIR/app"
cp -r "$PACKAGE_DIR/app" "$APP_DIR/app"

cd "$APP_DIR/app"

echo "Instalando dependencias de producción"
npm install --omit=dev

echo "Reiniciando aplicación con PM2"
if pm2 describe "$APP_NAME" > /dev/null; then
  pm2 restart "$APP_NAME"
else
  pm2 start index.js --name "$APP_NAME"
fi

pm2 save

echo "Validando endpoint /health"
sleep 3
curl -f http://localhost:8080/health

echo "Despliegue finalizado correctamente"
