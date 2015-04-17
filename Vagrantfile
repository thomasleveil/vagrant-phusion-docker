# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.hostname = "docker"
  config.vm.network "private_network", ip: "176.16.0.3"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  

  config.ssh.forward_agent = true

  config.vm.synced_folder "H:\\workspaces", "/workspaces"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SCRIPT
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

    ## install pip and docker-compose
    curl -sL https://bootstrap.pypa.io/get-pip.py | python
    pip install docker-compose

    ## add color support for cygwin term
    sed -i 's/xterm-color) color_prompt=yes;;/xterm-color|cygwin) color_prompt=yes;;/' /home/vagrant/.bashrc

    ## liquidshell
    curl -sL http://goo.gl/klY2oO | sudo -u vagrant -i bash

    echo "cd /vagrant" >> /home/vagrant/.bashrc

  SCRIPT
end
