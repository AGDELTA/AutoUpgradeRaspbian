# AutoUpgradeRaspbian
Auto upgrade raspbian on raspberry pi 3

Configure:

Into Script, define variable

If not use proxy

- fproxy=0 

else

- fproxy=1

And if use proxy, configure into script the variables:
  
- proxy_pro="http"  #http/https
- proxy_ip="180.113.65.240"  #IP o hostname of proxy-server
- proxy_port="23128" #Port of listen on proxy-server

Execute:

- sudo ./autoupgraderaspbian.sh

```
# ./auto-update2.sh 
RPI UPDATE BRANCH master
  Mar  6 2019 14:44:12 
  Copyright (c) 2012 Broadcom 
  version b403ee6ed819f9ac7a96834ac437b6cfdd4512ad (clean) (release) (start_cd) 
  Linux 4.19.27-v7+ armv7l GNU/Linux
Existe Salida a Internet...
Actualizando repositorios...
Repositorios actualizados.
Actualizando paquetes...
Preconfigurando paquetes ...
(Leyendo la base de datos ... 275956 ficheros o directorios instalados actualmente.)
Preparando para desempaquetar .../rpi-chromium-mods_20190312_armhf.deb ...
Desempaquetando rpi-chromium-mods (20190312) sobre (20190218) ...
Preparando para desempaquetar .../raspi-copies-and-fills_0.10_armhf.deb ...
Desempaquetando raspi-copies-and-fills (0.10) sobre (0.6) ...
Preparando para desempaquetar .../wiringpi_2.50_armhf.deb ...
Desempaquetando wiringpi (2.50) sobre (2.46) ...
Configurando rpi-chromium-mods (20190312) ...
Configurando raspi-copies-and-fills (0.10) ...
Procesando disparadores para libc-bin (2.24-11+deb9u4) ...
Procesando disparadores para man-db (2.7.6.1-2) ...
Configurando wiringpi (2.50) ...
Paquetes actualizados.
Actualizando KERNEL...
 *** Raspberry Pi firmware updater by Hexxeh, enhanced by AndrewS and Dom
 *** Performing self-update
 *** Relaunching after update
 *** Raspberry Pi firmware updater by Hexxeh, enhanced by AndrewS and Dom
 *** Your firmware is already up to date
Salida del RPI-UPDATE: 0.
KERNEL actualizado.
Limpiando el sistema...
Sistema actualizado y listo.
#
```
