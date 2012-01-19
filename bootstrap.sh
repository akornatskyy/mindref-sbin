#!/bin/sh

# Switch to testing
cat <<EOF > /etc/apt/sources.list

deb http://ftp.debian.org/debian/ testing main contrib non-free
deb-src http://ftp.debian.org/debian/ testing main contrib non-free

deb http://security.debian.org/ testing/updates main contrib non-free
deb-src http://security.debian.org/ testing/updates main contrib non-free
EOF

# Make full update/upgrade
apt-get -q update
apt-get -yq dist-upgrade

# Install packages
apt-get -yq install mercurial htop && apt-get clean

# Install bitbucket.org fingerprint
cat <<EOF > ~/.hgrc
[hostfingerprints]
bitbucket.org = 24:9c:45:8b:9c:aa:ba:55:4e:01:6d:58:ff:e4:28:7d:2a:14:ae:3b
[ui]
#username = Firstname Lastname <user@email.com>
EOF

# Grab settings
hg clone https://bitbucket.org/akorn/mindref-etc /usr/local/etc
hg clone https://bitbucket.org/akorn/mindref-sbin /usr/local/sbin

# Apply all settings
PATH=/usr/local/etc:$PATH
apply-bash
apply-vim
