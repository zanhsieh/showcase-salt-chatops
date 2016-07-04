#!/usr/bin/env bash

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"

# use the latest stable Salt from repo.saltstack.com
yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm

yum clean expire-cache
yum -y update

yum -y install rsync salt-minion

mkdir -p /etc/salt/minion.d
echo 'master: saltmaster' > /etc/salt/minion.d/master.conf

systemctl restart salt-minion

echo "Done!"
exit 0
