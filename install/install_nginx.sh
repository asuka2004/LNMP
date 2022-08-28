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

Check_User(){
	if [ $UID -ne 0 ]
	 then
		echo "You are not supper user.Please use root"
		exit 1;
	fi	
}

Update_Depend(){
	yum -y install gcc zlib zlib-devel pcre pcre-devel openssl openssl-devel
}

Install_Nginx(){
	cd ${Soft_Path}	
	wget https://nginx.org/download/nginx-1.18.0.tar.gz 
	useradd nginx -u 1111 -s /sbin/nologin -M
	tar -zxvf  nginx-1.18.0.tar.gz 
	cd nginx-1.18.0/
	./configure --user=nginx --group=nginx --prefix=/app/nginx-1.18.0 --with-http_stub_status_module --with-http_ssl_module
	make;make install
	ln -s ${App_Path}/nginx-1.18.0  ${App_Path}/nginx
	echo 'export PATH="${App_Path}/nginx/sbin:$PATH"'>>/etc/profile

}

Setup_daemon(){
	cp ${Soft_Path}/nginx.service /etc/systemd/system/nginx.service
	systemctl daemon-reload
  	systemctl enable mysqld
	systemctl start mysqld
}

main(){
	Check_User
	Update_Depend	
	Install_Nginx
	Setup_daemon
}
main 
