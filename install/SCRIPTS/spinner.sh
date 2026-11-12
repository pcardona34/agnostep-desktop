#!/bin/bash

####################################################
### A G N o S t e p   Desktop  -  by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Spinner & Timer
################################

#############################################

#############################################
### Spinner
#############################################
###                 Howto
#############################################
### To use this function, you need to set
### some vars in the caller script:
### global: SPIN='/-\|'
### before any call: put the long process to bg
### with '&' and then set PID=$!
#############################################
###               Example
#############################################
#   SPIN='/-\|'
#   command &
#   PID=$!
#   spinner
#############################################

function spinner()
{
i=1
echo -n ' '
while [ -d /proc/$PID ]
do
	sleep 0.2
	printf "\b${SPIN:i++%${#SPIN}:1}"
done
}

### End of Spinner
#############################################


#############################################
### Timer
#############################################
### set: DELAY=x
### default: DELAY=5
### MSG="a message"
#############################################

function timer
{
i=${DELAY:-5}
THIS_MSG=${MSG:-Message was not set.}

printf " ${THIS_MSG} "
while [ $i -gt 0 ]
do
	sleep 1
	let i--
	printf "\b$i"
done
printf "\nGo!\n"

}
### End of Timer
##############################################
