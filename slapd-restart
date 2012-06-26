#!/bin/sh

# Restart slapd daemon if it has open more than 512 files
if [ `pidof slapd | xargs lsof -a -p | wc -l` -gt 512 ]
then
    /etc/init.d/slapd restart
fi
