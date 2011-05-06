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
bitbucket.org = 81:2b:08:90:dc:d3:71:ee:e0:7c:b4:75:ce:9b:6c:48:94:56:a1:fe
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
