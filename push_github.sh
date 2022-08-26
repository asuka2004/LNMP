#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 20:58
# Version     : V1.0
# Description :            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

	git add --all
	read -p "Pleaes input reason:" reason 
	git commit -m "$reason"
	git push origin master
