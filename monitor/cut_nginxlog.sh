#!/bin/bash
# Author      : Kung
# Build       : 2022-05-28 19:46
# Version     : V1.0
# Description : Cut Nginx log every day            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

DataFormat=`date +%Y%m%d -d -1day`
Basedir="/app/nginx"
Nginxlog="$Basedir/logs"

[ -d $Nginxlog ] && cd $Nginxlog || exit 1
[ -f access_www.log ] || exit 1
mv access_www.log ${DataFormat}_access_www.log

[ -f access_blog.log ] || exit 1
mv access_blog.log ${DataFormat}_access_blog.log

$Basedir/sbin/nginx -s reload



