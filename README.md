# Nginx 學習筆記  

作業環境  OS: CentOS 7.9    Web:  Nginx 1.22

採用編譯的方式  官網載點 https://nginx.org/download/nginx-1.22.0.tar.gz

### Install Nginx

安裝依賴包  yum -y install  gcc  zlib  zlib-devel  pcre pcre-devel openssl openssl-devel

下載安裝包  wget https://nginx.org/download/nginx-1.22.0.tar.gz

解壓縮並開始編譯   
tar zxvf  nginx-1.22.0.tar.gz

./configure  - -user=nginx - -group=nginx - -prefix=/app/nginx-1.22.0 - - with-http_stub_status_module - -with-http_ssl_module

make ;make install

新增常駐服務  cp nginx.service  /lib/systemd/system/nginx.service ; systemctl daemon-reload



### Install Keepalived 
    

### Monitor DB Script
    
1.執行monitor_mysql，監控Mysql 

2.加入排程，指令如下

echo "Monitor DB" >>/var/spool/cron/root

echo */5 * * * * /use/bin/sh -x /root/project/Mysql/monitor/monitor_db.sh >>/var/spool/cron/root

