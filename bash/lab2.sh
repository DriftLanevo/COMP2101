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
