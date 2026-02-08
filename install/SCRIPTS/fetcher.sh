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
### Fetcher
################################

function fetch
{
URL=$1
if [ -z "$URL" ];then
	printf "You must give an URL as arg."
	exit 1
fi

PROTOCOL=$(echo $URL | awk -F: '{print $1}')
TRURL=$(echo $URL | awk -F: '{print $2}')

echo "Protocol: $PROTOCOL"
wget --quiet --spider $URL
RET=$?

if [ $RET -eq 0 ];then
	wget --quiet --progress=bar --show-progress -- $URL
else
	case "$PROTOCOL" in
	"http")
		PROTO=https;;
	"https")
		PROTO=http;;
	esac
	wget --quiet --progress=bar --show-progress -- ${PROTO}:$TRURL
fi
}

### Testing
### fetch http://download.savannah.nongnu.org/releases/gnustep-nonfsf/HighlighterKit-0.1.3.tar.gz
