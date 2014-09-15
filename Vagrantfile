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

  config.vm.provision :shell, :path => "bootstrap.sh"
end
