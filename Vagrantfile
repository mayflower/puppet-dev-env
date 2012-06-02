# -*- mode: ruby -*-
# vi: set ft=ruby :

mocked_nodes = ENV['VAGRANT_NODES'] ? ENV['VAGRANT_NODES'].split(',') : ['node']

Vagrant::Config.run do |config|
  config.vm.box = "base-precise"
  config.vm.box_url = "http://mirror.dmz.muc.mayflower.de/vagrant/base-precise.box"
  # config.vm.boot_mode = :gui
  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged

  # config.vm.forward_port 8140, 8140
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  
  config.dns.tld = 'dev'
  VagrantDNS::Config.logger = Logger.new('debug_dns.log')

  config.vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

  config.vm.define :master do |master|
    master.vm.host_name     = 'puppet.dev'   # FIXME: this shouldn't include the tld
    master.vm.forward_port  8140, 8140
    master.vm.forward_port  22, 20022

    master.vm.network :hostonly, '192.168.172.2'

    shared_folders = [
      'manifests',
      'modules',
      'templates',
      'files'
    ]
    
    shared_folders.each do |folder|
      master.vm.share_folder "puppet-#{folder}", "/puppet_#{folder}", "./#{folder}"
    end
    
    master.vm.provision :puppet do |puppet|
      puppet.options        = ['--verbose']
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "nodes/node_vagrant_master.pp"
    end
  end

  ##  Hackety, hack.
  mocked_nodes.each_with_index do |host,index|
    index += 5

    config.vm.define host do |config|
      config.vm.host_name     = "#{host.to_s}.dev"  # FIXME: this shouldn't include the tld

      config.vm.provision :puppet_server do |puppet|
        puppet.options        = ['--verbose']
        puppet.puppet_server  = 'puppet'
      end

      config.vm.network :hostonly, "192.168.172.#{index.to_s}"  # FIXME: hackhackhack
    end
  end
end
