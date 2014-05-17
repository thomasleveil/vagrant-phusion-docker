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

apt-get update

## install docker
apt-get install -y docker.io
adduser vagrant docker

## alias docker.io to docker
ln -sf /usr/bin/docker.io /usr/local/bin/docker
if [[ $(egrep -c '^complete -F _docker docker$' /etc/bash_completion.d/docker.io) -eq 0 ]]; then
	echo "complete -F _docker docker" >> /etc/bash_completion.d/docker.io
fi

## add color support for cygwin term
sed -i 's/xterm-color) color_prompt=yes;;/xterm-color|cygwin) color_prompt=yes;;/' /home/vagrant/.bashrc
