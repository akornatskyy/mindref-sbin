#!/bin/sh

domain=`hostname -d`
mail=root@$domain
msg=Test

if [ ! -z "$2" ]; then
    mail=$1; msg=$2
    if ! echo $mail | grep -q "$domain"; then
        mail=$mail@$domain
    fi
else
    if [ ! -z "$1" ]; then msg=$1; fi
fi

# strip whitespace at the end of message
msg=`echo "$msg" | sed 's/ *$//g'`

echo $msg | mail -s "$msg" $mail
echo $msg | wall
