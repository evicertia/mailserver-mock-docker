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
for file in /etc/postfix/*; do
    [ ! $file == /etc/postfix/postfix-files ] && [[ ! $file =~ cf ]] && [[ ! $file =~ \.db$ ]] && [ ! -d $file ] && postmap $file && echo "Mapping file $file"
done

exec /usr/sbin/postfix -c /etc/postfix start