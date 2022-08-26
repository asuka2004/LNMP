# Nginx 學習筆記  

作業環境  OS: CentOS 7.9    Web: Nginx 1.18

採用編譯的方式，官網載點 https://nginx.org/download/nginx-1.22.0.tar.gz

### Install Nginx

安裝腳本 install_nginx.sh

新增常駐服務  nginx.service 

Nginx設定檔  nginx.conf

### Install Keepalived 

安裝keepalived及依賴包， yum install -y keepalived openssl-devel libnl libnl-devel  libnfnetlink-devel

LVS架構如下圖，前面兩台Nginx+LVS+Keepalived，反向代理到後端，後端一台Java跑不同Port，兼做兩台

可以參照 nginx-25.conf nginx-26.conf Keepalived-25.conf keepalived-26.conf  VIP是192.168.88.27 

![lvs](https://user-images.githubusercontent.com/37530440/185299345-e976f848-97b7-498a-a8de-d313720f8571.png)

### Monitor LVS+Keepalived+Nginx Script
    
監控腳本 monitor_nginx.sh，只要偵測到Nginx掛掉，變會停止Keepalived，移到另一台正常Nginx

加入排程 crontab.txt

定時分割log檔 cut_nginxlog.sh

分析log檔resist_ddos.sh，IP達到數量便封鎖 

