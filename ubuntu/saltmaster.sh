#!/usr/bin/env bash
set -e

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"

# use the latest stable Salt from repo.saltstack.com
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list

apt-get -y update
apt-get -y install rsync salt-master salt-api

rsync -avz /vagrant/saltmaster/etc/ /etc/

service salt-master restart
service salt-api restart

# create stackstorm user and set password
adduser stackstorm --disabled-password --gecos ""
echo "stackstorm:stackstorm"|chpasswd

echo "Done!"
exit 0
