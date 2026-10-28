# 🐧 Script de Diagnóstico de Sistema (Linux)

![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![AlmaLinux](https://img.shields.io/badge/AlmaLinux-0F4266?style=for-the-badge&logo=almalinux&logoColor=white)

Un script de automatización en Bash diseñado para administradores de sistemas y entusiastas de DevOps. Recopila métricas vitales del sistema, genera alertas de salud y mantiene un registro histórico para su posterior auditoría.

## ✨ Características

- **Reporte en tiempo real:** Muestra fecha, uso de RAM, uso de disco y usuarios conectados.
- **Alertas inteligentes:** Comprueba el porcentaje de uso del disco y emite una advertencia visual (rojo/verde) si supera un umbral configurable (por defecto 80%).
- **Registro persistente:** Guarda cada ejecución en `/var/log/diagnostico_felix.log` para análisis histórico.
- **Diseño adaptable:** Los colores solo se muestran en terminales interactivas. Si se redirige a un archivo, el log queda limpio en texto plano.
- **Configurable:** Permite cambiar el umbral de alerta y la ruta del log mediante variables de entorno.

## 🛠️ Requisitos

- Un sistema operativo Linux (probado en **AlmaLinux 9**).
- Bash (versión 4.0 o superior).
- Utilidades estándar: `awk`, `df`, `free`, `who`, `tee`.

## 🚀 Instalación y Uso

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/felixbonillo/script-diagnostico.git
   cd script-diagnostico

2. **Da permisos de ejecucion al script:**
   ```bash
   chmod +x diagnostico.sh

3. ** Ejecuta el script con privilegios de superusuario (necesario para escribir en /var/log/):
   ```bash
   sudo ./diagnostico.sh

   **Configuracion adicional 
   ```bash
   #Cambiar el umbral de la alerta al 90%
   UMBRAL_DISCO=90 ./diagnostico.sh

   #Guardar el log en una ruta diferente
   LOG_FILE=./mi_log_personal.log ./diagnostico.sh

**Ejemplo de salida
=================================================
---REPORTE DE DIAGNOSTICO--- 2026-10-28 03:50:29
=================================================
---Memoria Ram---
Tipo      Total    Usado Disponible
Mem:       11Gi    2.4Gi      9.0Gi
----------------------------------
---Uso del disco---
Sistema                                          Tam  Usado   Disp  Uso%
/dev/mapper/almalinux_desktop--ledkfhr-root      40G   5.6G    35G   14%
----------------------------------
---Usuarios Conectados---
felixbonillo tty2         2026-10-28 03:45 (local)
felixbonillo pts/2        2026-10-28 04:37
----------------------------------
---Salud del disco---
 Sistema Saludable!

**Lo que aprendi haciendo este proyecto
    Manejo de variables y funciones en Bash.

    Uso de awk y cut para parsear la salida de comandos del sistema.

    Implementación de condicionales con (( )) para lógica aritmética.

    Redirección de salida con tee para escribir en pantalla y en un archivo simultáneamente.

    Buenas prácticas: set -euo pipefail y detección de terminal interactiva ([[ -t 1 ]]).
