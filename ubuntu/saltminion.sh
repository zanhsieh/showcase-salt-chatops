#!/usr/bin/env bash
set -e

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"

# use the latest stable Salt from repo.saltstack.com
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list

apt-get -y update
apt-get -y install rsync salt-minion

mkdir -p /etc/salt/minion.d
echo 'master: saltmaster' > /etc/salt/minion.d/master.conf

service salt-minion restart

echo "Done!"
exit 0
