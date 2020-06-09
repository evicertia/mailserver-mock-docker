#!/bin/bash

exec /usr/sbin/dnsmasq \
    ${DNSMASQ_CONF:+-C ${DNSMASQ_CONF}} \
    ${DNSMASQ_HOSTSFILE:+--addn-hosts=${DNSMASQ_HOSTSFILE}} \
    ${DNSMASQ_RESOLVFILE:+--resolv-file=${DNSMASQ_RESOLVFILE}}