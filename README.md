# AutoUpgradeRaspbian
Auto upgrade raspbian on raspberry pi 3

Configure:

Into Script, define variable

If not use proxy

- fproxy=0 

else

- fproxy=1

And if use proxy, configure into script the variables:

  #http/https
	proxy_pro="http"
  #IP o hostname of proxy-server
	proxy_ip="180.113.65.240"
  #Port of listen on proxy-server
	proxy_port="23128"

Execute:

- sudo ./autoupgraderaspbian.sh

