#!/bin/bash

hostname=`hostname -s`
domain=`hostname -d`

if [ ! -z $domain ]; then
    domain=.$domain
fi

#cat <<EOF > /etc/hostname
#$hostname$domain
#EOF

if [ -z "`cat /etc/dhcp/dhclient.conf | grep '^send host-name'`" ]; then
    cat <<EOF >> /etc/dhcp/dhclient.conf
send host-name "$hostname";
EOF
fi

cat <<EOF > /etc/hosts
127.0.0.1   localhost   $hostname$domain
EOF

echo net.ipv6.conf.all.disable_ipv6=1 >\
$rootfs/etc/sysctl.d/disableipv6.conf
exit 0
dhclient -v -r
apt-get -y purge network-manager avahi-daemon

hostname -F /etc/hostname
dhclient -v

