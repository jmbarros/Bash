#!/bin/bash
ip=$1
port=$2
port_error=22
network=`grep network= ssh_switch.conf |awk -F "=" '{print $2}'`

echo $ip
echo $port
echo $network

if [ "$port" == "port_error" ] then;
	
########	exit	
	echo "exit cannot declare port 22"
	
else
	echo "i will do"
	#iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 446 -j DNAT  --to-destination 172.16.250.163:22
	#iptables -t nat -A POSTROUTING -d 172.16.250.163 -s 172.16.250.0/24 -p tcp --dport 22 -j SNAT --to 172.16.250.178:446

fi
