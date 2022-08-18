#!/bin/bash
# Author      : Kung
# Build       : 2022-04-20 22:45
# Version     : V1.0
# Description : Resist DDOS           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

file=$1
while true
do
	awk '{print $1}' $1 | grep -v "^$" | sort | uniq -c >/root/tmp/tmp.log
 	exec</root/tmp/tmp.log
 	while read line
  	do
		ip=`echo $line|awk '{print $1}'`
		count=`echo $line|awk '{print $2}'`
		
		if [ $count -gt 50 ]
		 then
		firewall-cmd --add-rich-rule "rule family="ipv4" source address="$ip" port port="80" protocol="tcp"  reject"
		echo "$line is dropped">>/root/tmp/droplist_$(date +F%).log
		fi
  	done
  	sleep 20
done
