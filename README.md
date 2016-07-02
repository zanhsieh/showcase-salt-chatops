Saltstack & ChatOps with Slack, Hubot and StackStorm - Vagrant demo
===========
> Part of tutorial: [Getting Started With StackStorm and SaltStack](https://stackstorm.com/2015/07/29/getting-started-with-stackstorm-and-saltstack/)

### Introduction
This is quick demonstration of the [StackStorm](http://stackstorm.com/) event-driven automation platform running with [Saltstack](http://saltstack.com/) configuration management tool and [Hubot](https://hubot.github.com/) ChatOps engine. The objective is to operate servers with Ansible directly from [Slack](http://slack.com/) chat.

It will get you up and running with `chatops` control VM with all St2 components prepared as well as Salt and Hubot configured.
Additionally, it installs 3 Ubuntu VMs: `saltmaster`, `web` server with nginx and `db` server with mysql.

As a result you should get 100% ready environment allowing you to execute [Salt commands module](https://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html) and run [Salt states](http://docs.ansible.com/playbooks.html) against VMs directly from your Slack chat. In this showcase we already crafted some simple, but useful real world ChatOps commands.

### Getting started

#### 1. Prepare Slack
* Create [slack.com](http://slack.com/) account if you don't have it yet.
* Navigate `Configure Integrations -> Filter -> Hubot` and generate Slack & Hubot API Token.

#### 2. Go to your favorite OS family and call vagrant up
Go to your favorite OS family, edit [`Vagrantfile`](Vagrantfile#L5) and add the just generated API token under `HUBOT_SLACK_TOKEN` constant, or just export it:
```sh
export HUBOT_SLACK_TOKEN=xoxb-1234-5678-91011-00e4dd
```

To provision the environment run:
```sh
vagrant up
```
Installation takes some time (st2 engine comes with Python, RabbitMQ, PostgreSQL, MongoDB, OpenStack Mistral).

#### 3. Try ChatOps
You should see your bot online in Slack and now you're ready to type some chat commands. Don't forget to invite your bot into the Slack channel: `/invite <your-bot-name>`. Your first ChatOps command is: 
```
!help
```

> Additionally check the results of performed commands in StackStorm control panel:  
https://www.chatops/
username: `testu`
password: `testp`

#### 4. Don't stop!
Try it, explore the internals. For configuration see: [`saltmaster.sh`](saltmaster.sh), [`salt.sh`](salt.sh), and [`chatops.sh`](chatops.sh) which are usual Vagrant shell provisioner scripts.
Integrate your custom workflows and deployment mechanisms, you'll see how your work becomes more efficient during time.

Feel the power of control center and may the force will be with you!

----
Stackstorm always ready to help, feel free to:
* ask questions on [IRC: #stackStorm on freenode.net](http://webchat.freenode.net/?channels=stackstorm) or [stackstorm public Slack](https://stackstorm.typeform.com/to/K76GRP)
* report bug, provide feature request or just give us a ✮ star at [GitHub st2](https://github.com/StackStorm/st2)
* share your st2 story, [email us](mailto:support@stackstorm.com)
