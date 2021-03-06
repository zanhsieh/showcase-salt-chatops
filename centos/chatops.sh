#!/usr/bin/env bash

yum -y install nmap

# Moved this check here out of Vagrantfile so it's only executed on provisioning
if [[ "$HUBOT_SLACK_TOKEN" != "xoxb"* ]]
 then 
    echo "Error! HUBOT_SLACK_TOKEN is required."
    echo "Please specify it in your environment, e.g.:"
    echo "export HUBOT_SLACK_TOKEN=xoxb-5187818172-I7wLh4oqzhAScwXZtPcHyxCu"
    exit 1
fi

export ST2_AUTH_TOKEN=`st2 auth -t testu -p testp `

echo "#############################################################################################"
echo "############################ Configure Hubot and StackStorm #################################"

# Configure Hubot to use Slack
sed -i "s~# export HUBOT_ADAPTER=slack~export HUBOT_ADAPTER=slack~" /opt/stackstorm/chatops/st2chatops.env

# Will use name 'hubot' by default, unless changed in env
sed -i "s~export HUBOT_NAME=hubot~export HUBOT_NAME=${HUBOT_NAME}~" /opt/stackstorm/chatops/st2chatops.env

# Token must be set. Vagrant will terminate if token unset
sed -i "s/.*export HUBOT_SLACK_TOKEN.*/export HUBOT_SLACK_TOKEN=${HUBOT_SLACK_TOKEN}/" /opt/stackstorm/chatops/st2chatops.env

# Start Chatops
st2ctl restart st2chatops

# Wait 30 seconds for Hubot to start
# Note that /var/log/st2/st2chatops.log does not exist in CentOS 7. See:
# https://github.com/StackStorm/st2-packages/issues/300
for i in {1..30}; do
    ACTIONEXIT=`$(nmap -Pn -p8081 127.0.0.1 | awk "\\$1 ~ /8081/ {print \\$2}" | grep open); echo $?`
    #ACTIONEXIT=`grep -q 'Slack client now connected' /var/log/st2/st2chatops.log 2> /dev/null; echo $?`
    if [ ${ACTIONEXIT} -eq 0 ]; then
        break
    fi
    sleep 1
done

# Verify if Chatops is up and running
if [ ${ACTIONEXIT} -eq 0 ]; then
    st2 run chatops.post_message channel=general message='Ready for ChatOps!``` Brought to you by: http://stackstorm.com/ For available commands type: ```!help' > /dev/null
    echo " "
    echo "#############################################################################################"
    echo "###################################### All Done! ############################################"
    echo " "
    echo "Your bot should be online in Slack now. Your first ChatOps command:"
    echo "!help"
    echo " "
    echo " "
    echo "Visit:"
    echo "https://chatops/ - for StackStorm control panel"
    echo " "
    exit 0
else
    echo " "
    echo "#############################################################################################"
    echo "####################################### ERROR! ##############################################"
    echo " "
    echo "Something went wrong, hubot failed to start"
    echo "Check /var/log/st2/st2chatops.log for more info"
    echo " "
    exit 2
fi
