#!/bin/sh
##################################################################################################
#
# Script Requirements
#
# Programs:
#   wget
#
##################################################################################################

##################################################################################################
#
# Setup variables
#
# HOST           -     host name
# HOST_IP        -     command to get host ip address
# CURRENT_IP     -     command to get actual ip address
# CACHE          -     cache file to store ip address
# FREE_DNS_HASH  -     freedns hash
# FREE_DNS_URL   -     freedns url
#
##################################################################################################

HOST=<YOUR_HOST_NAME>
HOST_IP=`ping -c1 -n $HOST | head -n1 | sed "s/.*(\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)).*/\1/g"`
CURRENT_IP=`wget -qO- icanhazip.com`
CACHE=/tmp/freends.cache
FREEDNS_HASH=<YOUR_FREEDNS_HASH>
FREEDNS_API_URL="https://freedns.afraid.org/dynamic/update.php?${FREEDNS_HASH}"

##################################################################################################

if [ ! -f ${CACHE} ]; then
	echo "CACHE_IP=${HOST_IP}" > ${CACHE}
	source ${CACHE}
else
	source ${CACHE}
fi

if [ "${CURRENT_IP}" != "${CACHE_IP}" ]; then
	wget -O- "${FREEDNS_API_URL}"
	echo "CACHE_IP=${CURRENT_IP}" > ${CACHE}
fi