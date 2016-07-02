#!/usr/bin/env bash

echo "#############################################################################################"
echo "##################################### Prepare web VM ########################################"

yum install epel-release
yum -y update
yum -y install nginx

systemctl start nginx

echo "Done!"
exit 0
