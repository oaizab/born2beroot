#!/bin/bash

Architecture=`uname -a`
CPU=`lscpu | grep 'CPU(s):' | cut -d ':' -f2 | tr -d ' ' | awk "NR==1 {print}"`
vCPU=`cat /proc/cpuinfo | grep 'cpu cores' | cut -d ':' -f2 | tr -d ' ' | awk "NR==1 {print}"`
Mem=`free -m | awk 'NR==2 {printf "%s/%sMB (%.2f%%)",$3,$2,$3*100/$2}'`
Disk=`df -h | grep "root" | awk '{printf "%d/%s  (%s)",$3,$2,$5}'`
load=`top -bn1 | grep %Cpu | awk '{printf "%.2f%%", $2 + $4}'`
Boot=`who -b | awk '{print $3 " " $4}'`
LVM=`lsblk | grep lvm &> /dev/null && echo -n "yes" || echo -n "no"`
TCP=`netstat -an | grep tcp | grep ESTABLISHED | wc -l`
nUser=`who | awk '{print $1}' | sort -u | wc -l`
IP=`hostname -I`
MAC=`ip a | grep ether | awk '{print $2}'`
SUDO=`wc -l /var/log/sudo/sudo.log | cut -d ' ' -f1 | awk '{print $1 "/2"}' | bc`

wall "#Architecture: $Architecture
#CPU physical : $CPU
#vCPU : $vCPU
#Memoru Usage: $Mem
#Disk Usage: $Disk
#CPU load: $load
#Last boot: $Boot
#LVM use: $LVM
#Connextions TCP : $TCP ESTABLISHED
#User log: $nUser
#Network: IP $IP ($MAC)
#Sudo : $SUDO cmd"
