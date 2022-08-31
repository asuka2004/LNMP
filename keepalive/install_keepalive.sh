#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 11:39
# Version     : V1.0
# Description : Install Mysql           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool/software
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}
Script_Path=/tool/script
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}

Check_User(){
	if [ $UID -ne 0 ]
	 then
		echo "You are not supper user.Please use root"
		exit 1;
	fi	
}

Install_Keepalived(){
        echo "Install Keepalived. Please wait.................."
	yum install keepalived -y	

	if [ $? -eq 0 ] 
         then
                 action "Success to install keepalived " /bin/true
        else
                 action "Fail to install keepalived" /bin/false
                 exit
        fi  
}

Setup_Env(){
	echo "Setup Env. Please wait.........................."
	echo 'net.ipv4.ip_nonlocal_bind=1'>>/etc/sysctl.conf
	sed -i '14s/KEEPALIVED_OPTIONS="-D"/KEEPALIVED_OPTIONS="-D -d -S 0"/g' /etc/sysconfig/keepalived
	sed -i '54s#*.info;mail.none;authpriv.none;cron.none                /var/log/messages#*.info;mail.none;authpriv.none;cron.none;local0.none                /var/log/messages#g' /etc/rsyslog.conf	
	echo '#Keepalived' >>/etc/rsyslog.conf
	echo 'local0.*		/var/log/keepalived.log' >>/etc/rsyslog.conf 
	systemctl restart rsyslog.service	
}

Setup_daemon(){
        echo "Setup daemon. Please wait...................."
  	systemctl enable keepalived 
	systemctl start keepalived
	if [ $? -eq 0 ] 
         then
                 action "Success to daemon " /bin/true
        else
                 action "Fail to daemon" /bin/false
                 exit
        fi  
}

main(){
	Check_User
	echo -e "------------------------------------------------------------------- \n"   
	Install_Keepalived
	echo -e "------------------------------------------------------------------- \n"
	Setup_Env
	echo -e "------------------------------------------------------------------- \n"   	
	Setup_daemon
	echo -e "------------------------------------------------------------------- \n"   
}
main 
