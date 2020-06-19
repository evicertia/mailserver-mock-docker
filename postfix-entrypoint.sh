#!/bin/bash

declare -r POSTFIX_CONF=/data/main.cf

# set config files with volumes.
if [ -f "${POSTFIX_CONF}" ];
then \
    rm -f /etc/postfix/main.cf
    ln -s "${POSTFIX_CONF}" /etc/postfix/main.cf
fi

# All maps and should be in directory /data/postfix_maps
for file in /data/postfix_maps/*; do
    cp -r $file /etc/postfix
done

# Map all files in Postfix configuration directory
postmap /etc/postfix/*

exec /usr/sbin/postfix -c /etc/postfix start