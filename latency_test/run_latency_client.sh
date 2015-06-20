#!/bin/bash
####created by jmbarros at tech4it.com.br                              ##### 
####free to distributing, just give me some credits, okay ? :)         #####
###########################################################################


date=`date +%Y-%m-%d:%H:%M`
info=`date +%H:%M:%S" | "%d/%m/%Y`
/root/latency.py &

wait
cp -f /reports/export.html /reports/$date.txt &

wait
mv -f /reports/export.html /var/www/html/index.html &

wait
echo ""
echo "Update at "$info >> /var/www/html/index.html