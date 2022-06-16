#!/bin/bash

SUPERVISORPATH="/usr/bin/supervisord"

# Map DNS server
if [ -n "${DNSSERVER}" ]
then \
	echo "Setting DNS server to ${DNSSERVER}"
	if ! [[ "${DNSSERVER}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
		DNSSERVER=$(getent hosts "${DNSSERVER}" | awk '{ print $1 }')
		[ -z "${DNSSERVER}" ] && print_error "Unable to resolve DNSSERVER address." && exit 254
	fi
	TMPFILE=$(mktemp /tmp/resolv.XXXXXX)
	sed -e '/^nameserver .*/d' /etc/resolv.conf > ${TMPFILE}
	echo "nameserver ${DNSSERVER}" >> ${TMPFILE}
	cat ${TMPFILE} > /etc/resolv.conf
fi

exec ${SUPERVISORPATH} -n -e debug -c /etc/supervisord.conf