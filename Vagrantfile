# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "base-precise"
  config.vm.box_url = "http://mirror.dmz.muc.mayflower.de/vagrant/base-precise.box"
  # config.vm.boot_mode = :gui
  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged

  # config.vm.forward_port 8140, 8140
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "nodes/node_vagrant_master.pp"
  end
  
  config.vm.define :master do |master|
    master.vm.host_name     = 'puppet'
    master.vm.forward_port  8140, 8140
    master.vm.forward_port  22, 20022
    
    node.vm.network :hostonly, '192.168.172.2'
  end
  
  config.vm.define :node do |node|
    node.vm.host_name       = 'node'
    node.vm.forward_port    = 22, 20122
    
    node.vm.provision :puppet_server do |puppet|
      puppet.options        = ['--verbose']
      puppet.puppet_server  = '192.168.172.2'
    end

    node.vm.network :hostonly, '192.168.172.3'
  end
end
