#!/bin/bash
if [ "$1" == "" ]
then
    echo "INFORME UMA URL PARA PESQUISA"
else
	wget -O sitetmp -q $1
	grep "<a href=" sitetmp | cut -d "/" -f3 | cut -d '"' -f1 | grep "\." | sort -u > lista
    for url in $(cat lista);do host $url;done | grep "has address"
    rm sitetmp
    rm lista
fi
