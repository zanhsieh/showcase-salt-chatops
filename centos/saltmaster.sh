#!/usr/bin/env bash

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"

# use the latest stable Salt from repo.saltstack.com
yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm

yum clean expire-cache
yum -y update
yum -y install rsync salt-master salt-api

rsync -avz /vagrant/saltmaster/etc/ /etc/

systemctl restart salt-master
systemctl restart salt-api

# create stackstorm user and set password
adduser stackstorm -U
echo "stackstorm:stackstorm" | chpasswd

echo "Done!"
exit 0
