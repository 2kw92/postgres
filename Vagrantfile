# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 256
    v.cpus = 1
  end

  config.vm.define "master" do |master|
    master.vm.network "private_network", ip: "192.168.50.1", virtualbox__intnet: "net1"
    master.vm.hostname = "master"
    master.vm.provision "shell", inline: <<-SHELL
      mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
    SHELL
    master.vm.provision "shell", path: "master.sh"
  end

  config.vm.define "slave" do |slave|
    slave.vm.network "private_network", ip: "192.168.50.2", virtualbox__intnet: "net1"
    slave.vm.hostname = "slave"
    slave.vm.provision "shell", inline: <<-SHELL
      mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
    SHELL
    slave.vm.provision "shell", path: "slave.sh"
  end


end
