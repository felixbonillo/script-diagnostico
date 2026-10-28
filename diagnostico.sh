#!/bin/bash

set -euo pipefail

#Valores por defecto

LOG_FILE="/var/log/diagnostico_felix.log"
UMBRAL_DISCO=80
PUNTO_MONTAJE="/"

date_actual=$(date "+%F %T")
memoria_actual=$(free -h | awk 'BEGIN{printf "%-6s %8s %8s %10s\n","Tipo","Total","Usado","Disponible"} /^Mem:/{printf "%-6s %8s %8s %10s\n",$1,$2,$3,$7}')
disk_actual=$(df -h "$PUNTO_MONTAJE" | awk 'BEGIN{printf "%-45s %6s %6s %6s %5s\n","Sistema","Tam","Usado","Disp","Uso%"} NR==2{printf "%-45s %6s %6s %6s %5s\n",$1,$2,$3,$4,$5}')

user_list=$(who)

porcentaje=$(df -h "$PUNTO_MONTAJE" | awk 'NR==2 {print $5}' | cut -d '%' -f 1)

#Definicion de colores
	if [[ -t 1 ]]; then 
	RED=$'\e[31m'; GREEN=$'\e[32m'; RESET=$'\e[0m'
else 
	RED=''; GREEN=''; RESET=''
fi

#Funcion para imprimir en pantalla y guardar
imprimir() {
	echo -e "$1" | tee -a "$LOG_FILE"
}
clear

imprimir "================================================="
imprimir "---REPORTE DE DIAGNOSTICO--- $date_actual"
imprimir "================================================="

imprimir "---Memoria Ram---"
imprimir "$memoria_actual"

imprimir "----------------------------------"

imprimir "---Uso del disco---"
imprimir "$disk_actual"

imprimir "----------------------------------"

imprimir "---Usuarios Conectados---"
imprimir "$user_list"

imprimir "----------------------------------"

imprimir "---Salud del disco---"

if (( porcentaje >= UMBRAL_DISCO )); then 
	    imprimir "${RED}¡ADVERTENCIA! Disco al $porcentaje%${RESET}"
    else
	    imprimir "${GREEN}Sistema Saludable!${RESET}"
fi

