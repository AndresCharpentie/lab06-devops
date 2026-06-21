# Laboratorio DevOps Moderno con GitHub Actions y Azure VM

Proyecto dummy para practicar CI/CD usando GitHub Actions y una VM Ubuntu en Azure.

## Aplicación

La aplicación es una API NodeJS Express.

Endpoints:

- `/` responde: `Hola Mundo DevOps`
- `/health` responde HTTP 200 con JSON de estado

## Ejecución local

```bash
cd app
npm install
npm start
```

Probar:

```bash
curl http://localhost:8080/
curl http://localhost:8080/health
```

## Pruebas

```bash
cd app
npm test
```

## Pipeline recomendado para entregar rápido

Archivo:

```text
.github/workflows/ci-cd.yml
```

Este workflow tiene dos jobs:

- `ci`: valida, prueba, empaqueta y publica el artifact.
- `cd`: descarga el artifact y despliega en la VM por SSH.

También se incluyen archivos separados `ci.yml` y `cd.yml` como referencia.

## Pipeline CI

Archivo:

```text
.github/workflows/ci.yml
```

Realiza:

1. Checkout del código.
2. Instalación de NodeJS.
3. Instalación de dependencias.
4. Validación de sintaxis.
5. Ejecución de pruebas.
6. Empaquetado TAR.
7. Publicación del artifact.

## Pipeline CD

Archivo:

```text
.github/workflows/cd.yml
```

Realiza:

1. Se ejecuta cuando el CI termina correctamente.
2. Crea el paquete de despliegue.
3. Copia el paquete a la VM por SSH.
4. Ejecuta `scripts/deploy.sh`.
5. Valida el endpoint público `/health`.

## Secrets necesarios en GitHub

En GitHub:

`Settings → Secrets and variables → Actions → New repository secret`

Crear:

- `AZURE_VM_HOST`: IP pública de la VM.
- `AZURE_VM_USER`: usuario SSH de la VM.
- `AZURE_VM_SSH_KEY`: clave privada SSH.

## Preparar VM Ubuntu

En la VM:

```bash
chmod +x scripts/setup-vm.sh
bash scripts/setup-vm.sh
```

También se debe permitir el puerto `8080` en el NSG de Azure.

## URL pública

```text
http://IP_PUBLICA:8080/
http://IP_PUBLICA:8080/health
```
