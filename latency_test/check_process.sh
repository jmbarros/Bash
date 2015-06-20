#!/bin/bash
####created by jmbarros at tech4it.com.br                              ##### 
####free to distributing, just give me some credits, okay ? :)         #####
###########################################################################

if [ "$(pidof qperf)" ]
        then
        # process was found
        pid=`pidof qperf`
        echo $pid
        echo "Saindo...Encontrado Processo: $pid"
        exit

        else
        # process not found
        echo "Processo não encontrado... Subindo serviço qperf"
        qperf &
fi