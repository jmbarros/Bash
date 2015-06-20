#!/usr/bin/python
import sys
import os
import subprocess
from prettytable import PrettyTable
import csv
##############################################################
### to use => curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
#####

sites = 6

site1 = '173.193.250.X'
name1 = 'SL - Washington'

site2 = '169.57.9.X'
name2 = 'SL - Mexico 1'

site3 = '184.173.31.X'
name3 = 'SL - Houston 2'

site4 = '174.37.63.X'
name4 = 'SL - Dallas'

site5 = '54.68.112.X'
name5 = 'AWS - US/West'

site6 = '54.94.219.X'
name6 = 'AWS - BR/SP'

site7 = '192.168.1.X'
name7 = 'site'
site8 = '192.168.1.X'
name8 = 'site'

###
####################################################################################################################
site0 = ''
name0 = ''
t = (site0, site1, site2, site3, site4, site5, site6, site7, site8)
n = (name0, name1, name2, name3, name4, name5, name6, name7, name8)
table = PrettyTable(["Site Name", "Site Server", "Latency IP", "Latency ICMP"])
table.padding_width = 1
table.format = True
index = 1
ip = ""
while (index <= sites):
        ip = t[index]
        name = n[index]
        print 'Connecting to the site:', name
#       print 'The ip is:', ip
        c_qperf = subprocess.Popen(['qperf', '-v', '-t', '60', ip, 'tcp_lat'], stdout=subprocess.PIPE)
        grep = subprocess.Popen(['grep', 'latency'], stdin = c_qperf.stdout, stdout = subprocess.PIPE)
        awk = subprocess.Popen(['awk', '{print $3 $4}'], stdin = grep.stdout, stdout = subprocess.PIPE)
        qperf = awk.communicate()[0]
#       print qperf
        c_ping = subprocess.Popen(['ping', '-c','5', ip], stdout=subprocess.PIPE)
        grep_p = subprocess.Popen(['grep', 'rtt'], stdin = c_ping.stdout, stdout = subprocess.PIPE)
        awk_p = subprocess.Popen(['awk', '{print $4 "/" $5}'], stdin = grep_p.stdout, stdout = subprocess.PIPE)
        cut_p = subprocess.Popen(['cut', '-d/', '-f', '1,5'], stdin = awk_p.stdout, stdout = subprocess.PIPE)
        ping = cut_p.communicate()[0]
#       print ping
        table.add_row([name, ip, qperf, ping])
        index = index + 1

#print table >> '/reports/export.txt'

tabstring = table.get_html_string(attributes = {"class": "foo"})

output=open("/reports/export.html","w")
output.write("                          Latency Test"+"\n")
output.write(tabstring)
output.close()