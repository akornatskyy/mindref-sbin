#!/bin/bash

hostname=`hostname -s`
domain=`hostname -d`

if [ -z $domain ]; then
    echo "Unknown domain"
    exit 1
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
127.0.0.1   localhost
127.0.0.1   $hostname.$domain   $hostname
EOF

echo net.ipv6.conf.all.disable_ipv6=1 >\
$rootfs/etc/sysctl.d/disableipv6.conf

update-rc.d avahi-daemon disable
dhclient -v -r
apt-get -y purge network-manager

hostname -F /etc/hostname
dhclient -v

