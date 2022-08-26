# Nginx 學習筆記  

作業環境  OS: CentOS 7.9    Web: Nginx 1.18

採用編譯的方式，官網載點 https://nginx.org/download/nginx-1.22.0.tar.gz

### Install Nginx

安裝依賴包  yum -y install  gcc  zlib  zlib-devel  pcre pcre-devel openssl openssl-devel

下載安裝包  wget https://nginx.org/download/nginx-1.22.0.tar.gz

解壓縮並開始編譯  tar zxvf  nginx-1.22.0.tar.gz

./configure  --user=nginx --group=nginx --prefix=/app/nginx-1.22.0 --with-http_stub_status_module --with-http_ssl_module

make;make install

新增常駐服務  nginx.service 

Nginx設定檔  nginx.conf

### Install Keepalived 

安裝keepalived及依賴包  yum install -y keepalived openssl-devel libnl libnl-devel  libnfnetlink-devel

LVS架構如下圖，前面兩台Nginx+LVS+Keepalived，反向代理到後端，後端一台Java跑不同Port，兼做兩台

可以參照 nginx-25.conf nginx-26.conf Keepalived-25.conf keepalived-26.conf  VIP是192.168.88.27 

![lvs](https://user-images.githubusercontent.com/37530440/185299345-e976f848-97b7-498a-a8de-d313720f8571.png)


### Monitor LVS+Keepalived+Nginx Script
    
腳本內容，只要偵測到Nginx掛掉，變會停止Keepalived，移到另一台正常Nginx

加入排程

echo "Monitor Nginx" >>/var/spool/cron/root

echo */5 * * * * /use/bin/sh -x /root/project/Nginx/monitor/monitor_nginx.sh >>/var/spool/cron/root

