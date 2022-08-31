#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 18:11
# Version     : V1.0
# Description : Monitor Nginx            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool/software
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}
Script_Path=/tool/script
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Cron_Path=/var/spool/cron/root

if [ `grep "Nginx" ${Cron_Path}|wc -l` -lt 1 ] 
 then
        echo "#Monitor Nginx" >>/var/spool/cron/root
        echo "*/5 * * * * /bin/sh  ${Script_Path}/monitor_nginx.sh>/dev/null 2>&1" >>/var/spool/cron/root
else
        echo "Nothing ">/dev/null 2>&1    
fi

counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" -eq "0" ] 
 then
	/usr/bin/systemctl stop keepalived 
	echo 'NGINX Server is dead..Please fix this Nginx'
else
	/usr/bin/systemctl start keepalived
	echo "Everything is normal"
fi
