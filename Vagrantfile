VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
  end
  
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end

  config.vm.hostname = 'vm'
  config.vm.box = 'centos/7'
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 4848, host: 4848
  config.vm.network "forwarded_port", guest: 5080, host: 5080 
  
  config.vm.network "private_network", ip: "192.168.33.11"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  
#  config.vm.provision :chef_solo do |chef|
#    #chef.cookbooks_path = '.'
#    chef.run_list = "recipe[#{File.basename(Dir::pwd)}::default]"
#    
#    chef.json = {
#      'java' => {
#        'install_flavor' => 'oracle',
#        'jdk_version' => 8,
#        'oracle' => {
#          'accept_oracle_download_terms' => true
#        }
#      }
#    }
#  end
#  
#  config.vm.provision "shell", inline: <<-SHELL
#    cd /usr/local/glassfish/glassfish/bin
#    sudo ./asadmin start-domain "domain1"
#  SHELL
end
