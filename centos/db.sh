#!/usr/bin/env bash

echo "#############################################################################################"
echo "##################################### Prepare db VM #########################################"

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update

yum -y install mysql-server

# Enable `mysql` autologin for `root` linux user
touch ~/.my.cnf
chmod 0640 ~/.my.cnf
echo -e '[client]
user=root
password=PASS' > ~/.my.cnf

# Verify mysql installation
mysql --execute='SHOW PROCESSLIST;' > /dev/null || (echo 'Error! MySQL command failed' && exit 1)

echo "Done!"
exit 0
