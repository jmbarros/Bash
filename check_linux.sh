#!/bin/bash
#script created by jmbarros at tech4it dot com dot br
#script de coleta de logs
#declare var
hostname=`hostname`
report=/root/$hostname"_report.txt"
con=/root/$hostname"_consolidado.csv"
###################################################################################

echo "##############################################################" > $report
echo "#                                                            #" >> $report
echo "#                      DISK PARTITION                        #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
df -h >> $report
echo "##############################################################" >> $report
mount >> $report
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                        OS VERSION                          #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
cat /etc/*-release >> $report
echo "##############################################################" >> $report
uname -a >> $report
echo "##############################################################" >> $report
cat /etc/issue >> $report
ver1=`cat /etc/*-release`
ver2=`uname -a`
ver3=`cat /etc/issue`
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                CPU STATUS / IS VIRTUAL?                    #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
lscpu >> $report
echo "##############################################################" >> $report
dmidecode -t system |grep Manufacturer >> $report
dmidecode -t system |grep Product >> $report
dmidecode -t system |grep Serial >> $report
cpu1=`lscpu |grep "CPU(s):" |awk 'NR==1'`
cpu2=`lscpu |grep "Core(s) per socket"`
cpu3=`dmidecode -t system |grep Manufacturer`
cpu4=`dmidecode -t system |grep Product`
cpu5=`dmidecode -t system |grep Serial`
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                     MEM STATUS   (Gb)                      #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
cat /proc/meminfo |awk 'NR==1' >>$report
cat /proc/meminfo |awk 'NR==2' >>$report
mem1=`cat /proc/meminfo |awk 'NR==1'`
mem2=`cat /proc/meminfo |awk 'NR==2'`
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                    IP CONFIGURATION                        #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
#ifconfig >> $report
ifconfig |grep "inet addr" |awk '{print $2}' >> $report
ifconfig |grep "inet addr" |awk '{print $4}' >> $report
echo "Router:"`route |grep default | awk '{print $2}'` >> $report
ip1=`ifconfig |grep "inet addr" |awk '{print $2}'` 
sub1=`ifconfig |grep "inet addr" |awk '{print $4}'`
gw1="Router:"`route |grep default | awk '{print $2}'`
echo $ver1";"$ver2";"$ver3";"$cpu1";"$cpu2";"$cpu3";"$cpu4";"$cpu5";"$mem1";"$mem2";"$ip1";"$sub1";"$gw1";" > $con
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                    NETWORK STATUS                          #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
netstat -vrn  >> $report
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                        STORAGE                             #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
cat /proc/scsi/scsi >> $report
echo "##############################################################" >> $report
echo "#                                                            #" >> $report
echo "#                      APPLICATIONS                          #" >> $report
echo "#                                                            #" >> $report
echo "##############################################################" >> $report
rpm -qa >> $report
echo "Script Executado com Sucesso"
echo "##############################################################"
cat $report
