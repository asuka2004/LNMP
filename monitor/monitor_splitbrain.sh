#!/bin/bash
# Author      : Kung
# Build       : 2022-08-31 13:52
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
App_Path=/app/
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool/software
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}
Script_Path=/tool/script
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}

Cron_Path=/var/spool/cron/root
if [ `grep "Nginx" ${Cron_Path}|wc -l` -lt 1 ] 
 then
        echo "#Monitor Nginx" >>/var/spool/cron/root
        echo "*/5 * * * * /bin/sh  ${Script_Path}/monitor_splitbrain.sh>/dev/null 2>&1" >>/var/spool/cron/root
else
        echo "Nothing ">/dev/null 2>&1    
fi

LVS_VIP=192.168.88.33
LVS_IP=192.168.88.31

while true
do
	ping -c 2 -w 3 ${LVS_IP} &>/dev/null
	if [ $? -eq 0 -a 'ip addr| grep "$LVS_IP"|wc -l' -eq 1 ]
	 then
		echo "Warning!! HA is split brain!!"
	else
		echo "Everything is ok!!!"
	fi
done
