#!/usr/bin/env bash

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"

yum update -y
yum -y group install "Development Tools"
yum -y install openssl-devel swig

#  Acquire and export st2 auth token to run commands without authentication
export ST2_AUTH_TOKEN=`st2 auth -t testu -p testp `

# Download salt integration pack
st2 run packs.download packs=salt

# Setup virtualenv for salt
st2 run packs.setup_virtualenv packs=salt

# Overwrite config.yaml
cp -f /vagrant/chatops/opt/stackstorm/packs/salt/config.yaml /opt/stackstorm/packs/salt/config.yaml

# Register all actions contained in the pack:
st2 run packs.load register=all

# Install our custom pack with ansible ChatOps command aliases
#st2 run packs.install packs=st2-chatops-aliases repo_url=armab/st2-chatops-aliases

# Needed by salt-ssh
yum -y install sshpass

# cowsay via ChatOps
rpm -U http://www.melvilletheatre.com/articles/el7/cowsay-3.03-14.el7.centos.noarch.rpm

# Copy ansible config files from vagrant shared directory to '/etc/ansible'
#st2 run ansible.command_local module_name=synchronize args='src=/vagrant/ansible/ dest=/etc/ansible'
#chown -R root:root /etc/ansible
#chmod -R 755 /etc/ansible
#chmod 640 $(find /etc/ansible -type f)

st2 action list --pack=salt

st2 run salt.runner_manage.up

echo "Done!"
exit 0
