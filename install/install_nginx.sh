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

Setup_User(){
        echo "Add User Nginx. Please wait.................."
	useradd -u 1111 -g nginx -s /sbin/nologin -M nginx

}

Update_Depend(){
	echo "Install Depend software. Please wait........."
	yum -y install gcc zlib zlib-devel pcre pcre-devel openssl openssl-devel
	if [ $? -eq 0 ] 
         then
                 action "Success to install Depend " /bin/true
        else
                 action "Fail to install Depend" /bin/false
                 exit
        fi  
}

Install_Nginx(){
        echo "Install Nginx. Please wait.................."
	cd ${Soft_Path}	
	#wget https://nginx.org/download/nginx-1.18.0.tar.gz 
	tar -zxvf  nginx-1.18.0.tar.gz 
	cd nginx-1.18.0/
	./configure --user=nginx --group=nginx --prefix=/app/nginx-1.18.0 --with-http_stub_status_module --with-http_ssl_module
	make;make install
	if [ $? -eq 0 ] 
         then
                 action "Success to install Nginx " /bin/true
        else
                 action "Fail to install Nginx" /bin/false
                 exit
        fi  

	ln -s ${App_Path}/nginx-1.18.0  ${App_Path}/nginx
	echo 'export PATH=${App_Path}/nginx/sbin:$PATH'>>/etc/profile
	source /etc/profile
}

Setup_daemon(){
        echo "Setup daemon. Please wait...................."
	cp ${Script_Path}/nginx.service /etc/systemd/system/nginx.service
	systemctl daemon-reload
  	systemctl enable mysqld
	systemctl start mysqld
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
	Setup_User
	echo -e "------------------------------------------------------------------- \n"
	Update_Depend
	echo -e "------------------------------------------------------------------- \n"   	
	Install_Nginx
	echo -e "------------------------------------------------------------------- \n"   
	Setup_daemon
}
main 
