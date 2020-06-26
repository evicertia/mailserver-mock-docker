#!/bin/bash

[ -z "$(grep 'imap' /etc/inetd.conf)" ] && echo -e 'imap    stream    tcp    nowait    root    /usr/sbin/imapd imapd' >> /etc/inetd.conf
# User for IMAP mailbox
adduser --disabled-password herma || :
echo "$IMAPUSER:$IMAPPASS" | chpasswd

exec /usr/sbin/inetd