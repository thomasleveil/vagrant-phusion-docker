#!/bin/bash

# set up APT mirrors
if [[ $(grep -c "deb mirror://" /etc/apt/sources.list) -eq 0 ]]; then
	echo "setting up APT mirrors"
	ed -s /etc/apt/sources.list <<-EOF
		0a
		deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
		deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
		deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
		deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse
		.
		w
		EOF
fi

## install docker
if [[ $(groups vagrant | grep -q docker) -ne 0 ]]; then
	echo "installing Docker"
	curl -sL https://get.docker.io/ | sh
	curl -sL https://raw.githubusercontent.com/dotcloud/docker/master/contrib/completion/bash/docker > /etc/bash_completion.d/docker
	adduser vagrant docker
else
	echo "upgrading Docker"
	apt-get update
	apt-get -y install docker
fi


## add color support for cygwin term
sed -i 's/xterm-color) color_prompt=yes;;/xterm-color|cygwin) color_prompt=yes;;/' /home/vagrant/.bashrc
