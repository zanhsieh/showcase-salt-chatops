#!/usr/bin/env bash
set -e

echo "#############################################################################################"
echo "############################# Prepare StackStorm and Salt ###################################"


apt-get update -y
apt-get install -y g++ libssl-dev swig

#  Acquire and export st2 auth token to run commands without authentication
export ST2_AUTH_TOKEN=`st2 auth -t testu -p testp `

# Download salt integration pack
st2 run packs.download packs=salt

# Setup virtualenv for salt
st2 run packs.setup_virtualenv packs=salt

# Overwrite config.yaml
rsync -avz /vagrant/chatops/opt/stackstorm/packs/salt/ /opt/stackstorm/packs/salt/

# Register all actions contained in the pack:
st2 run packs.load register=all

# cowsay via ChatOps
apt-get install -y cowsay

st2 action list --pack=salt

st2 run salt.runner_manage.up

echo "Done!"
exit 0
