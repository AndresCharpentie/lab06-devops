# INFORME - Laboratorio DevOps Moderno con GitHub Actions y Azure DevOps

**Estudiante:** Andrés Charpentie  
**Materia:** Sistemas Operativos / DevOps  
**Laboratorio:** DevOps Moderno con GitHub Actions y Azure DevOps  
**Fecha:** Completar fecha  

---

## 1. Introducción

En este laboratorio se implementó un flujo DevOps básico pero funcional, parecido a un entorno real de trabajo.  
El objetivo fue automatizar el proceso desde el código fuente hasta el despliegue de una aplicación en una máquina virtual Ubuntu en Azure.

Para esto se creó una aplicación dummy en NodeJS Express, se subió el código a un repositorio GitHub y se configuraron pipelines de integración continua y despliegue continuo usando GitHub Actions.

La aplicación expone dos endpoints:

- `/` devuelve el mensaje `Hola Mundo DevOps`.
- `/health` devuelve un estado `200 OK`, usado para validar que el servicio esté funcionando.

---

## 2. Investigación Pre-Lab

### ¿Qué es DevOps?

DevOps es una forma de trabajo que une desarrollo de software y operaciones.  
Su objetivo es mejorar la entrega de software mediante automatización, colaboración, pruebas continuas y despliegues más rápidos y controlados.

### Diferencia entre CI y CD

CI significa Integración Continua. Consiste en validar automáticamente el código cada vez que se realiza un cambio, ejecutando pruebas y verificaciones.

CD significa Entrega o Despliegue Continuo. Consiste en automatizar la preparación y publicación del software en un ambiente real o de prueba.

### Beneficios de la automatización

La automatización reduce errores manuales, acelera los despliegues, permite detectar fallos antes y deja un registro claro de qué se ejecutó y cuándo.

### ¿Qué es un pipeline?

Un pipeline es una secuencia automatizada de pasos.  
Por ejemplo: descargar código, instalar dependencias, ejecutar pruebas, empaquetar y desplegar.

### ¿Qué es Infrastructure as Code?

Infrastructure as Code es la práctica de definir infraestructura mediante archivos de configuración o código, en lugar de configurarla manualmente desde una interfaz gráfica.

### ¿Qué es un despliegue automatizado?

Es el proceso mediante el cual una aplicación se publica en un servidor de forma automática, sin tener que copiar archivos o reiniciar servicios manualmente.

---

## 3. Investigación de plataformas

| Plataforma | Características principales |
|---|---|
| GitHub Actions | Permite crear workflows CI/CD integrados directamente con repositorios GitHub. |
| Azure DevOps Pipelines | Plataforma empresarial de Microsoft para automatizar builds, pruebas y despliegues. |
| GitLab CI/CD | Solución integrada dentro de GitLab para automatizar el ciclo DevOps. |
| Bitbucket Pipelines | Servicio CI/CD integrado con Bitbucket y el ecosistema Atlassian. |

---

## 4. Investigación técnica base

### YAML

YAML es un formato de texto usado para escribir archivos de configuración de forma clara y estructurada.

### Runner o agente

Un runner es la máquina que ejecuta los pasos del pipeline. Puede ser hospedado por GitHub, Azure o propio.

### Workflow

Un workflow es el archivo que define cuándo se ejecuta el pipeline y qué pasos debe realizar.

### Artifact

Un artifact es un archivo generado por el pipeline, como un paquete ZIP o TAR, que puede guardarse y usarse en otro paso.

### SSH

SSH es un protocolo seguro para conectarse remotamente a un servidor Linux.

### Deployment

Un deployment es el proceso de publicar una aplicación en un ambiente de ejecución.

### Secreto o variable segura

Un secreto es una variable protegida que guarda información sensible, como claves SSH, usuarios o contraseñas.

---

## 5. Desarrollo del laboratorio

### 5.1 Creación del repositorio

Se creó un repositorio GitHub para almacenar el código fuente, los pipelines, los scripts y la documentación.

Estructura utilizada:

```text
app/
scripts/
.github/workflows/
pipeline/
README.md
INFORME.md
evidencias/
```

### 5.2 Aplicación base

Se desarrolló una API mínima con NodeJS Express.

La aplicación responde:

```text
Hola Mundo DevOps
```

en el endpoint `/`.

También se agregó el endpoint `/health`, que devuelve un estado 200 OK.

### 5.3 Pruebas automáticas

Se configuraron pruebas básicas usando Jest y Supertest.

Las pruebas validan:

- Que `/health` responda 200 OK.
- Que `/` devuelva el mensaje `Hola Mundo DevOps`.

### 5.4 Pipeline CI

El pipeline principal se configuró en:

```text
.github/workflows/ci-cd.yml
```

También se dejó un archivo `ci.yml` como referencia separada.

El pipeline de CI realiza la primera parte del proceso.

Este pipeline se ejecuta en cada push o pull request sobre la rama `main`.

Pasos realizados:

1. Descarga del código.
2. Instalación de NodeJS.
3. Instalación de dependencias.
4. Validación de sintaxis.
5. Ejecución de pruebas.
6. Empaquetado de la aplicación.
7. Publicación del artifact.

### 5.5 Pipeline CD

El pipeline de CD se encuentra dentro del mismo workflow principal:

```text
.github/workflows/ci-cd.yml
```

También se dejó un archivo `cd.yml` como referencia separada.

Este workflow se ejecuta cuando el CI termina correctamente.

Pasos realizados:

1. Preparación del paquete.
2. Conexión a la VM por SSH.
3. Copia del paquete al servidor.
4. Ejecución del script remoto de despliegue.
5. Reinicio de la aplicación con PM2.
6. Validación del endpoint `/health`.

### 5.6 Despliegue en Azure

Se creó una máquina virtual Ubuntu en Azure con IP pública.

Configuración principal:

- Sistema operativo: Ubuntu 24.04 LTS.
- Puertos permitidos: 22 y 8080.
- Acceso SSH habilitado.
- Aplicación ejecutándose en puerto 8080.

URL pública del servicio:

```text
http://COMPLETAR_IP_PUBLICA:8080/
http://COMPLETAR_IP_PUBLICA:8080/health
```

---

## 6. Problemas encontrados y soluciones

### Problema 1: permisos SSH

Al principio, el pipeline necesitaba conectarse a la VM por SSH.  
Para solucionarlo se agregaron los datos como secrets en GitHub:

- `AZURE_VM_HOST`
- `AZURE_VM_USER`
- `AZURE_VM_SSH_KEY`

### Problema 2: puerto 8080 no accesible

La aplicación funcionaba localmente en la VM, pero no era visible desde internet.  
La solución fue habilitar el puerto 8080 en el Network Security Group de Azure.

### Problema 3: mantener la aplicación ejecutándose

Si se ejecutaba con `node index.js`, al cerrar la terminal el proceso podía detenerse.  
Se solucionó usando PM2 para mantener el proceso activo y reiniciarlo automáticamente.

---

## 7. Reflexión técnica Post-Lab

### ¿Qué ventajas ofrece DevOps frente al despliegue manual?

DevOps permite automatizar tareas repetitivas, reducir errores humanos y tener despliegues más rápidos y controlados.

### ¿Qué problemas podrían ocurrir sin automatización?

Podrían copiarse archivos incorrectos, olvidarse pasos, desplegar código sin probar o no saber exactamente qué versión está en producción.

### ¿Qué parte del pipeline fue más compleja?

La parte más compleja fue el despliegue por SSH, porque requiere configurar secrets, permisos, conexión al servidor y reinicio del servicio.

### ¿Qué mejorarían en un ambiente empresarial real?

En un ambiente real se podría agregar Docker, monitoreo, logs centralizados, ambientes separados de desarrollo y producción, y aprobación manual antes de desplegar.

### ¿Qué riesgos de seguridad identificaron?

Los principales riesgos son exponer claves privadas, abrir puertos innecesarios y guardar datos sensibles directamente en el código.

### ¿Cómo escalarían esta solución?

Se podría escalar usando contenedores Docker, balanceadores de carga, Kubernetes o servicios administrados de Azure.

---

## 8. Conclusiones

El laboratorio permitió implementar un flujo DevOps completo: código, pruebas, artifact y despliegue automatizado en una VM Ubuntu.

La automatización con GitHub Actions facilita el trabajo porque cada cambio en el repositorio puede activar verificaciones automáticas y, si todo está correcto, desplegar la aplicación.

Este tipo de flujo mejora la calidad del software y se acerca a la forma en que trabajan equipos DevOps en entornos reales.

---

## 9. Evidencias sugeridas

Agregar capturas de:

1. Repositorio GitHub.
2. Estructura de archivos.
3. Pipeline CI ejecutado correctamente.
4. Artifact generado.
5. Secrets configurados sin mostrar valores.
6. VM Ubuntu en Azure.
7. Regla NSG puerto 8080.
8. Aplicación funcionando en navegador.
9. Endpoint `/health` funcionando.
