#!/bin/bash

fproxy=0

# FORMATOS
yellow='\033[1;33m'
nc='\033[0m'

if [ ! -n "$1" ] ; then tipo_rpi=master ; else tipo_rpi="$1" ; fi
printf "${yellow}RPI UPDATE BRANCH $tipo_rpi${nc}\n"
while read -r line
do
        printf "${yellow} $line ${nc}\n"
done< <(vcgencmd version)


####Si utilizas proxy
if [ $fproxy -eq 1 ]
then
	printf "${yellow}Configurando acceso mediante proxy...${nc}\n"
	proxy_pro="http"
	proxy_ip=180.113.65.240
	proxy_port=23128
	export http_proxy="$proxy_pro""://""$proxy_ip:$proxy_port"
	export ftp_proxy="$proxy_pro""://""$proxy_ip:$proxy_port"
	export https_proxy="$proxy_pro""://""$proxy_ip:$proxy_port"
	export no_proxy=localhost,127.0.0.0/8


	if [ -f "/etc/apt/apt.conf" ]
        then
		printf "${yellow}Configurando APT mediante proxy...${nc}\n"
		cat <<EOF > /etc/apt/apt.conf
Acquire::http::Proxy "http*://$proxy_ip:$proxy_port";
Acquire::https::Proxy "https://$proxy_ip:$proxy_port";
Acquire::ftp::Proxy "ftp://$proxy_ip:$proxy_port";
Acquire::socks::proxy "socks://$proxy_ip:$proxy_port/";
EOF
	fi
fi
####


func_ping()
{
V_SERVER_RMT="$1"
ping "$V_SERVER_RMT" -c 1 | tail -2 | head -1 | awk '{ print $1 $4}'
}

func_testws()
{
curl --connect-timeout 5 -sL -w "%{http_code}\\n" "http://www.google.com/" -o /dev/null
}


if [ $(func_testws) -ne 200 ] ; then printf "${yellow}[ERROR] - No hay Salida a Internet...${nc}\n" ; exit
else printf "${yellow}Existe Salida a Internet...${nc}\n" ; fi 
 
#REPOSITORIOS
printf "${yellow}Actualizando repositorios...${nc}\n"
sudo apt-get -qq update
printf "${yellow}Repositorios actualizados.${nc}\n"
 
#PAQUETES
printf "${yellow}Actualizando paquetes...${nc}\n"
sudo apt-get -qq upgrade -y
printf "${yellow}Paquetes actualizados.${nc}\n"
 
#KERNEL
####Si utilizas proxy
if [ $fproxy -eq 1 ]
then
        printf "${yellow}Configurando acceso mediante proxy...${nc}\n"
	git config --global http.proxy $http_proxy
	git config --global --get http.proxy
	git config --global https.proxy $http_proxy
	git config --global --get https.proxy
	#git config --global --unset http.proxy
fi
####

printf "${yellow}Actualizando KERNEL...${nc}\n"
sudo apt-get -qq dist-upgrade -y

if [ $(curl -si https://api.github.com/users/whatever | grep -wc "^Status: 403 Forbidden") -eq 1 ]
then
	curl -si https://api.github.com/users/whatever | grep -Ei "^Status|^X-RateLimit-Limit|^X-RateLimit-Remaining|^X-RateLimit-Reset" | while read -r line
	do
		printf "${yellow}$line ${nc}\n"
	done
	printf "${yellow}Viendo API Github fecha de caducidad  ${nc} $(date -d @$(curl -si https://api.github.com/users/whatever | grep "^X-" | grep "X-RateLimit-Reset" | awk '{ print $2}'))\n"
elif [ $(curl -si https://api.github.com/users/whatever | grep -wc "^Status: 200 OK") -eq 1 ]
then
        #sudo rpi-update
        sudo BRANCH=$tipo_rpi rpi-update
        exitstatus=$?
        printf "${yellow}Salida del RPI-UPDATE: $exitstatus.${nc}\n"
        if [ $exitstatus -eq 1 ]
        then
                #rpi-update
                BRANCH=$tipo_rpi rpi-update
        fi
        printf "${yellow}KERNEL actualizado.${nc}\n"
else
	printf "${yellow}Estado del Respositorio del KERNEL sin identificar ${nc}\n"
	curl -si https://api.github.com/users/whatever | grep -Ei "^Status|^X-RateLimit-Limit|^X-RateLimit-Remaining|^X-RateLimit-Reset" | while read -r line
        do
                printf "${yellow}$line ${nc}\n"
        done
        printf "${yellow}Viendo API Github fecha de caducidad  ${nc} $(date -d @$(curl -si https://api.github.com/users/whatever | grep "^X-" | grep "X-RateLimit-Reset" | awk '{ print $2}'))\n"
fi
 
#LIMPIEZA
printf "${yellow}Limpiando el sistema...${nc}\n"
sudo apt-get -qq autoclean
sudo apt-get -qq autoremove -y
sudo apt-get -qq clean
 
printf "${yellow}Sistema actualizado y listo.${nc}\n"
