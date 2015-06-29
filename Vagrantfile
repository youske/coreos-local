# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'fileutils'
require 'ipaddr'

VAGRANTFILE_API_VERSION = "2"

MACHINES = File.join(File.dirname(__FILE__), "machines.rb")
if File.exist?(MACHINES)
  require MACHINES
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.ssh.insert_key = false
  config.vm.box_url = $env_config[:general][:box_url]
  config.vm.box = $env_config[:general][:box]
#  config.vm.box_version = $env_config[:general][:box_version]
  config.vm.box_check_update = $env_config[:general][:box_update]
  count=0
  $env_config[:roles].each do |it|
    if !it[:active] then
      next
    end
    config.vm.define it[:name] do |node|
      node.vm.hostname = it[:name]

      node.vm.provider "virtualbox" do |vb|
        vb.gui=false
        vb.cpus=it[:cpus]
        vb.memory=it[:memory]
        vb.check_guest_additions=false
        #vb.functional_vboxsf=false
      end

      ipnum = IPAddr.new( $env_config[:general][:private_ipaddr] ).to_i + count
      node.vm.network :private_network, ip: IPAddr.new(ipnum, Socket::AF_INET).to_s, virtualbox__intnet: $env_config[:general][:intnet]

      docker_tcp = $env_config[:general][:docker_expose_tcp]
      if docker_tcp
        node.vm.network "forwarded_port", guest: docker_tcp, host: (docker_tcp + count), auto_correct: true
      end

      it[:bind_ports].each do |ports|
        node.vm.network "forwarded_port", guest: ports[0], host: ports[1], auto_correct: true
      end

      it[:mount].each do |mnt|
      #  node.vm.synced_folder mnt[0], mnt[1]
      end

      boot = File.join( File.dirname(__FILE__), it[:bootstrap_path] )
      if File.exist?(boot)
        node.vm.provision "shell" do |sh|
          sh.path = it[:bootstrap_path]
          sh.args = it[:name]
        end
      end

      count += (1 << 0)

    end
  end

end
