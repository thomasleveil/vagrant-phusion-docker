#!/bin/bash

## install docker
if ! groups vagrant | grep -q docker; then
	echo "installing Docker"
	curl -s https://get.docker.com/ | sh
else
	echo "upgrading Docker"
	apt-get update
	apt-get -y install lxc-docker
fi
curl -sL https://raw.githubusercontent.com/dotcloud/docker/master/contrib/completion/bash/docker > /etc/bash_completion.d/docker
adduser vagrant docker

## install pip and fig
curl -sL https://bootstrap.pypa.io/get-pip.py | python
pip install fig

## add color support for cygwin term
sed -i 's/xterm-color) color_prompt=yes;;/xterm-color|cygwin) color_prompt=yes;;/' /home/vagrant/.bashrc

## liquidshell
curl -sL http://goo.gl/klY2oO | sudo -u vagrant -i bash
