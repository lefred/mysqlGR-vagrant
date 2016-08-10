Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.vm.define :mysql1 do |mysql1_config|
        mysql1_config.vm.box = "lefred14/centos7_64"
        mysql1_config.vm.hostname = "mysql1"
        #mysql1_config.ssh.max_tries = 100
        mysql1_config.vm.provider :virtualbox do |mysql1_vb|
                mysql1_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
                #mysql1_vb.gui = true
        end
        mysql1_config.vm.network :private_network, ip: "192.168.90.2"
        mysql1_config.vm.network :forwarded_port, guest: 22, host: 1234
        mysql1_config.vm.provision :puppet do |mysql1_puppet|
                #mysql1_puppet.pp_path = "/tmp/vagrant-puppet"
                mysql1_puppet.environment_path     = "puppet"
                mysql1_puppet.environment          = "development"
                mysql1_puppet.manifests_path = "puppet/environments/development/manifests"
                mysql1_puppet.module_path = "puppet/environments/development/modules"
                mysql1_puppet.hiera_config_path = "hiera.yaml"

                mysql1_puppet.manifest_file = "site.pp"
                mysql1_puppet.options = "--verbose --debug"
        end
  end
  config.vm.define :mysql2 do |mysql2_config|
        mysql2_config.vm.box = "lefred14/centos7_64"
        mysql2_config.vm.hostname = "mysql2"
        #mysql2_config.ssh.max_tries = 100
        #mysql1_config.vm.boot_mode = :gui
        mysql2_config.vm.provider :virtualbox do |mysql2_vb|
                mysql2_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
        end
        mysql2_config.vm.network :private_network, ip: "192.168.90.3"
        mysql2_config.vm.provision :puppet do |mysql2_puppet|
                #mysql2_puppet.pp_path = "/tmp/vagrant-puppet"
                mysql2_puppet.environment_path     = "puppet"
                mysql2_puppet.environment          = "development"
                mysql2_puppet.manifests_path = "puppet/environments/development/manifests"
                mysql2_puppet.module_path = "puppet/environments/development/modules"
                mysql2_puppet.manifest_file = "site.pp"
                mysql2_puppet.options = "--verbose"
		mysql2_puppet.hiera_config_path = "hiera.yaml"
        end
  end
  config.vm.define :mysql3 do |mysql3_config|
        mysql3_config.vm.box = "lefred14/centos7_64"
        mysql3_config.vm.hostname = "mysql3"
        #mysql3_config.ssh.max_tries = 100
        #mysql1_config.vm.boot_mode = :gui
        mysql3_config.vm.provider :virtualbox do |mysql3_vb|
                mysql3_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
        end
        mysql3_config.vm.network :private_network, ip: "192.168.90.4"
        mysql3_config.vm.provision :puppet do |mysql3_puppet|
                #mysql3_puppet.pp_path = "/tmp/vagrant-puppet"
                mysql3_puppet.environment_path     = "puppet"
                mysql3_puppet.environment          = "development"
                mysql3_puppet.manifests_path = "puppet/environments/development/manifests"
                mysql3_puppet.module_path = "puppet/environments/development/modules"
                mysql3_puppet.manifest_file = "site.pp"
                mysql3_puppet.options = "--verbose"
		mysql3_puppet.hiera_config_path = "hiera.yaml"
        end
  end
#  config.vm.define :mysql4 do |mysql4_config|
#        mysql4_config.vm.box = "lefred14/centos7_64"
#        mysql4_config.vm.hostname = "mysql4"
#        mysql4_config.vm.provider :virtualbox do |mysql4_vb|
#                mysql4_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
#        end
#        mysql4_config.vm.network :private_network, ip: "192.168.90.5"
#        mysql4_config.vm.provision :puppet do |mysql4_puppet|
#                mysql4_puppet.environment_path     = "puppet"
#                mysql4_puppet.environment          = "development"
#                mysql4_puppet.manifests_path = "puppet/environments/development/manifests"
#                mysql4_puppet.module_path = "puppet/environments/development/modules"
#                mysql4_puppet.manifest_file = "site.pp"
#                mysql4_puppet.options = "--verbose"
#		mysql4_puppet.hiera_config_path = "hiera.yaml"
#        end
#  end
end

