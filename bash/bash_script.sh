#!/bin/bash
#This is for system name

hostname=`hostname`
domain=`hostname -d`

if [ -n $hostname ]
then
	echo "The system name is $(hostname)"
else
	echo "There is no hostname"
fi

if [ -z $domain ]
then
	echo "There is no domain name"
else
	echo "The domain name is $domain"
fi


echo "

"
echo "IP address(es) for this host by interface(s) as below:"

a=`ip r show 2>STERR | grep "src" | sed q | cut -d " " -f 2`

if [ -z $a ]
then
        echo "The network is not configured"
else
        echo "$(ip r show | grep "src" | cut -d " " -f 3,12)"
fi



name=`cat /etc/os-release | head -n 2 | grep "NAME" | cut -d "=" -f 2 | cut -d '"' -f 2`
echo "The system name is $name"


os=`cat /etc/os-release | head -n 2 | grep "VERSION" | cut -d "=" -f 2 | cut -d '"' -f 2 | cut -d " " -f 1`
echo "The OS version is $os"




echo "The CPU description is following:"
cpu=`lscpu | grep "Model name" | cut -d ":" -f 2 `

echo ${cpu}

echo "The memory installed information is following:"
mem=`free -h | grep "Mem" | awk '{print $2}'`
echo "The total memory is $mem"




echo "Disks     Available"
echo `df -h /dev/sd* | grep "/dev/s*" | awk '{print $1,$4}'`



b=`lpstat -p 2>STERR | grep "printer" | cut -d " " -f 2`
if [ -z $b ]
then
	echo "There is no configured printers"
else
	echo "The configured printers are:" ; echo `lpstat -p | grep "printer" | cut -d " " -f 2`
fi
