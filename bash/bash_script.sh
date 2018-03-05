#!/bin/bash
#	########################################################
#	#             Student Name: Zech Zou                   #
#	#	      Student Number: 200347348        	       #
#	#             Instrcutor: Dennis Simpson               #
#	########################################################
#
#
#	This is the script to display system information summary
#	Include accept a command line option for each item
#	The Script will only output the information requested
#	The output of this script is human readable
#	The section titles and spacing make it easy to read
#
#	Ths script will provide the following information:
#   	- System name with domain name if it has one
# 	- IP addresses for this host by interface, leave out locahost
#         loopback network
#       - OS version and name
#	- CPU description
#	- Memory installed
#	- Available disk space on attached physical drives
#	- List of printers configured
#
#	                     # Message for Instructor #
#	Enlish is not my first language, I tried my best to explain the commands
#	and my thought in comments, but it may not express well. I don't know
#	`awk` and `sed` very well, instead I learned how to use `cut`. So you may
#	find a lot of `cut` in my script. 
#
#	Thank you for teaching us the shell script, I learned a lot from this 
#	assignment and ready to explore more about scripting!

function hostname-domainname {
echo "
-----------------------------------------
|       Hostname and Domainname         |
-----------------------------------------"
#Define two variables: host and domain by the command hostname and hostname -d
host=`hostname`
domain=`hostname -d`

#Use if command to determine action taken or not taken.
#[ -n $host ] will test if the string length which got from variable equals to zero.
#If it does not equal to zero, then it is true, which means if command will take the first action.
#If it equals to zero, then it is false, which means if command will second action.
if [ -n $host ]
then
	echo "The system name is $(hostname)"
else
	echo "There is no hostname"
fi #use fi to end if command

#[ -z $host ] will test if the string length which got from variable equals to zero.
#If it equals to zero, then it is true, which means if command will take the first action.
#If it does not equal to zero, then it is false, which means if command will second action.
if [ -z $domain ]
then
	echo "There is no domain name"
else
	echo "The domain name is $domain"
fi #use fi to end if command
} #use } to end functioin command

function network {
echo "
-----------------------------------------
|         Network Configuration         |
-----------------------------------------"
echo "IP address(es) for this host by interface(s) can been seen in the following:"

# Use a long command to define variable a and test the string length if eauals to zero
# ip r show will give you the configured network information
# 2>STERR is used to put error into standard output in case of that happen
# use first pipe to grep keyword "src"
# use second pipe and sed command to get the first line of output
# use third pipe and cut command which takes space as DELIM, print the 2nd character
a=`ip r show 2>STERR | grep "src" | sed q | cut -d " " -f 2`

if [ -z $a ] # please refer the comment above about [ -z $a ] and if command
then
        echo "The network is not configured"
else
# use second pipe to grep keyword "src" from the result that get from ip r show
# use third pipe and cut command which takes space as DELIM, print the 2nd and 12th characters
        echo "$(ip r show | grep "src" | cut -d " " -f 3,12)"
fi
}


function osname-version {
echo "
-----------------------------------------
|          OS Name and Version          |
-----------------------------------------"
# use grep to get keyword and use cut command with different DELIM to print the result
name=`cat /etc/os-release | head -n 2 | grep "NAME" | cut -d "=" -f 2 | cut -d '"' -f 2`
echo "The system name is $name"

os=`cat /etc/os-release | head -n 2 | grep "VERSION" | cut -d "=" -f 2 | cut -d '"' -f 2 | cut -d " " -f 1`
echo "The OS version is $os"
}

function cpu {
echo "
-----------------------------------------
|           CPU Information             |
-----------------------------------------"
echo "The CPU description is following:"
cpu=`lscpu | grep "Model name" | cut -d ":" -f 2 ` # please refer to comment above about grep and cut
echo ${cpu}
}


function memory {
echo "
-----------------------------------------
|          Memory Information           |
-----------------------------------------"
echo "The memory installed information is listed below:"
mem=`free -h | grep "Mem" | awk '{print $2}'` # use awk command to print out the 2nd column character
echo "The total memory is $mem"
}


function disk {
echo "
-----------------------------------------
|           Disk Information            |
-----------------------------------------"
echo "The available disk space on attached physical drives information include the following:"
echo "  Disk(s)       Available"
echo `df -h /dev/sd* | grep /dev/ | awk '{print $1}'` " " " " " " `df -h /dev/sd* | grep /dev/ | awk '{print $4}'`
}


function printer {
echo "
-----------------------------------------
|          Printer Information          |
-----------------------------------------"
b=`lpstat -p 2>STERR | grep "printer" | cut -d " " -f 2`
if [ -z $b ]
then
	echo "There is no configured printer"
else
	echo "The configured printer(s) is( are):" ; echo `lpstat -p | grep "printer" | cut -d " " -f 2`
fi
}

function HELP {
echo "
-----------------------------------------
|           Script Help Menue           |
-----------------------------------------"
echo "
	system information summary help menue
	-s	System name with domain name if it has one
	-n	IP addresses for this host by interface, leave out localhost
		loopback network
	-o	OS version and name
	-c	CPU description
	-m	Memory installed
	-d	Available disk space on attached physical drives
	-p	List of printers configured
	-h	help menue
	"
}
# $# means the number of arguments
# [ $# -eq 0 ] means test if the number of arguments equal to 0
# if you don't type option(argument) then execute the function part, which will print out all the information
if [ $# -eq 0 ]; then 
	hostname-domainname
	network
	osname-version
	cpu
	memory
	disk
	printer
fi

while (($#)); do
	if [ $1 == "-s" ]; then # if the first argument is -s, then take the below function, run it
	   hostname-domainname
      elif [ $1 == "-n" ]; then
           network
      elif [ $1 == "-o" ]; then
           osname-version
      elif [ $1 == "-c" ]; then
           cpu
      elif [ $1 == "-m" ]; then
           memory
      elif [ $1 == "-d" ]; then
           disk
      elif [ $1 == "-p" ]; then
           printer
      elif [ $1 == "-h" ]; then
	   HELP

	fi
	shift # after get the result, go back to the begining
done # end the loop condition

