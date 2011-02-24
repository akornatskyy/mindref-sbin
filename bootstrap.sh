#!/bin/sh

# Switch to testing
cat <<EOF > /etc/apt/sources.list
deb http://ftp.us.debian.org/debian/ testing main
deb http://security.debian.org/ testing/updates main
EOF

# Make full update/upgrade
apt-get -qq update
apt-get -yqq dist-upgrade

# Install packages
apt-get -yqq install mercurial htop && apt-get clean

# Grab settings
hg clone https://bitbucket.org/akorn/mindref-etc /usr/local/etc
hg clone https://bitbucket.org/akorn/mindref-sbin /usr/local/sbin

# Apply all settings
PATH=/usr/local/etc:$PATH
apply-bash
apply-cron
apply-vim
