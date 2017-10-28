#!/bin/bash

groupadd asterisk
useradd -d /var/lib/asterisk -g asterisk asterisk

prompt=""
while [ "$prompt" != "y" ]
do
echo "Edit /etc/default/asterisk and uncomment AST_USER and AST_GROUP records. Type \"y\" and press [Enter] when you're done."
read prompt
done

chown -R asterisk:asterisk /var/spool/asterisk /var/run/asterisk /etc/asterisk /var{lib,log}/asterisk /usr/lib/asterisk
