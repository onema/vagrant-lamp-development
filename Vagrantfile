Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "localhost"

  config.vm.provision "chef_solo"  do |chef|
    chef.cookbooks_path = "cookbooks"    
    chef.add_recipe "vagrant_main"

    #####################################
    # MONGODB
    # https://github.com/edelight/chef-cookbooks
    #####################################
    chef.add_recipe "mongodb::10gen_repo"
    chef.add_recipe "mongodb::default"

    #####################################
    # REDIS
    # https://github.com/phlipper/chef-redis
    #####################################
    chef.add_recipe "redis"

    chef.json.merge!({
      :mysql => {
        :server_root_password => "root",
        :server_debian_password => "root",
        :server_repl_password => "root"
      },
      #####################################
      # YOU WILL NEED TO ADD THESE DOMAINS 
      # TO THE LIST OF HOSTS IN YOUR LOCAL 
      # ENVIRONMENT FOR THESE TO BE PROPERLY 
      # ROUTED
      #####################################
      :vhost => {
        :localhost => {
            :name => "localhost",
            :host => "localhost", 
            :aliases => ["localhost.web", "dev.localhost-static.web"],
            :docroot => ""
        },
        :symfony => {
            :name => "symfony",
            :host => "symfony.web", 
            :aliases => ["symfony"],
            :docroot => "/symfony/web"
        }
      }
    })
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 3307
  
  ##########################################################################
  # UNCOMMENT IF NFS IS DISABLED
  ##########################################################################
  #config.vm.synced_folder "~/Sites", "/vagrant"
  
  ##########################################################################
  # NFS 
  # Enable if you have performance issues with large projects. 
  # see the following links for more info:
  # http://forum.symfony-project.org/viewtopic.php?t=52241&p=167041#p147056
  # http://docs.vagrantup.com/v2/synced-folders/nfs.html
  # http://www.phase2technology.com/blog/vagrant-and-nfs/
  ###########################################################################
  # Host-Only networking required for nfs shares
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.synced_folder "~/Sites", "/vagrant", nfs: true


  config.vm.provider :virtualbox do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end
end

