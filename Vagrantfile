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
    if ! type docker >/dev/null; then
      echo "installing Docker"
      curl -sL https://get.docker.io/ | sh
      curl -sL https://raw.githubusercontent.com/dotcloud/docker/master/contrib/completion/bash/docker > /etc/bash_completion.d/docker
      adduser vagrant docker
    else
      echo "upgrading Docker"
      apt-get update
      apt-get -y install lxc-docker
    fi

    if ! type pip >/dev/null; then
      echo "installing pip"
      curl -sL https://bootstrap.pypa.io/get-pip.py | python
    fi

    echo "upgrading docker-compose"
    pip install -U docker-compose
    
    echo "installing docker-compose command completion"
     curl -sL https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

    ## add color support for cygwin term
    sed -i 's/xterm-color) color_prompt=yes;;/xterm-color|cygwin) color_prompt=yes;;/' /home/vagrant/.bashrc

    ## liquidshell
    curl -sL http://goo.gl/klY2oO | sudo -u vagrant -i bash

    ## cd /vagrant at login
    grep -qE '^cd /vagrant$' /home/vagrant/.bashrc || echo 'cd /vagrant' >> /home/vagrant/.bashrc

  SCRIPT
end
