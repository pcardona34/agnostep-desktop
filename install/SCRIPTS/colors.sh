#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Display title and messages
### with colors
################################

COLORS="YES"

###########################
### Title (yellow-orange)
### $1: title text
function title()
{
printf "\n \033[22;33m=== $1 ===\033[0m \n\n"
}

##########################
### Alert (red)
### $1: message
function alert()
{
printf "\n \033[22;31m=== Alert! ===\033[0m \n"
printf "\033[22;31m [E] ${1} \033[0m \n\n"
}

##########################
### Warning (magenta)
### $1: message
function warning()
{
printf "\n \033[22;35m=== Warning! ===\033[0m \n"
printf "\033[22;35m /!\ ${1} \033[0m \n\n"
}


##########################
### Info (fg)
### $1: message
function info()
{
printf "\n === Info === \n"
printf "(i) ${1} \n\n"
}

##########################
### cli (fg)
### $1: commande
function cli()
{
printf "\n\t ${1} \n\n"
}


###########################
### ok (green)
function ok()
{
printf "\033[22;32m${1}\033[0m.\n"
}



#########################
### Test

function testing()
{
title "Mon Titre"
alert "This is an alert!"
warning "This is a warning!"
info "This is an info."
printf "This is "
ok "good"
}

##########################
### titulo (yellow bold)
### you must set before:
#### STR: the string to show
#### LOG: the log path
function titulo
{
clear
TITLE="=== $STR ==="
yellowb=`tput bold setaf 3`
reset=`tput sgr 0`
echo -e "\n${yellowb} $TITLE ${reset}\n"
echo $TITLE >> $LOG
sleep 3
}

##########################
### subtitulo (bold)
### you must set before:
#### STR: the string to show
#### LOG: the log path
function subtitulo
{
TITLE="*** $STR ***"
bold=`tput bold`
reset=`tput sgr 0`
echo -e "\n${bold} $TITLE ${reset}\n"
echo $TITLE >> $LOG
}

#########################

#testing


