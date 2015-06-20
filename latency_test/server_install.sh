#!/bin/bash
####created by jmbarros at tech4it.com.br                             ##### 
####free to distributing, just give me some credits, okay ? :)        #####
###########################################################################

yum -y install wget qperf
cd ~
wget https://raw.githubusercontent.com/jmbarros/latency_test/master/check_process.sh
chmod +x /root/check_process.sh
echo "*/5  *  *  *  * root /root/check_process.sh" >> /etc/crontab
/etc/init.d/crond restart