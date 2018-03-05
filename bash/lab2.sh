#!/bin/bash

# Define the variable hostname
hostname=$(hostname)

# print out the weekday only
weekday=$(date +%A)


# Create an array variable named titles
titles=("Strong" "Super" "Boss" "Hot" "Drunk" "Maker")

# Create a variable named title_index to use RANDOM to get a number between RANDOM and titles
title_index=$((RANDOM % ${#titles[@]}))

# Use the value in title_index, put into titles array to get other output stored in title
title=${titles[$title_index]}

# Store my name in variable myname
myname=Zech 

# Combine all the variables together to display the followings
welcome_message="Welcome to planet $hostname $title $myname.
Today is $weekday.
"
#Use cowsay program to display the content of welcome_meesage
echo $welcome_message | cowsay -f dragon


################################################################
host=`hostname`
domain=`hostname -d`
if [ -n $host ]
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

echo "The memory installed information is listed below:"
mem=`free -h | grep "Mem" | awk '{print $2}'` 
echo "The total memory is $mem"

echo "The available disk space on attached physical drives information include the following:"
echo "  Disk(s)       Available"
echo `df -h /dev/sd* | grep /dev/ | awk '{print $1}'` " " " " " " `df -h /dev/sd* | grep /dev/ | awk '{print $4}'`

b=`lpstat -p 2>STERR | grep "printer" | cut -d " " -f 2`
if [ -z $b ]
then
        echo "There is no configured printer"
else
        echo "The configured printer(s) is( are):" ; echo `lpstat -p | grep "printer" | cut -d " " -f 2`
fi

