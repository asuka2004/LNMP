# Nginx 學習筆記  

作業環境  OS: CentOS 7.9    Web: Nginx 1.18

採用編譯的方式，官網載點 https://nginx.org/download/nginx-1.18.0.tar.gz

### Install Nginx

1.安裝腳本 install_nginx.sh

2.常駐服務  nginx.service 

3.Nginx設定檔  nginx.conf

### Install Keepalived 

1.安裝及設定keepalived腳本 install_keepalived.sh

2.keepalived & nginx 設定檔   nginx-25.conf nginx-26.conf Keepalived-25.conf keepalived-26.conf，讓Nginx變成HA架構

### Monitor Keepalived+Nginx Script
    
1.監控腳本 monitor_nginx.sh，只要偵測到Nginx掛掉，停止Keepalived，VIP移到另一台Nginx

2.加入排程 crontab.txt

3.定時分割log檔 cut_nginxlog.sh

4.IP連線數過多就封鎖 resist_ddos.sh

5.監控keepalived是否正常 monitor_splitbrain.sh

