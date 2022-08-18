#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 18:11
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" -eq "0" ] 
 then
	/usr/bin/systemctl stop keepalived 
	echo 'NGINX Server is dead..Please fix this Nginx'
else
	/usr/bin/systemctl start keepalived
	echo "Everything is normal"
fi
