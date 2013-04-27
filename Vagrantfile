Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "localhost"

  config.vm.provision :chef_solo do |chef|
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

  config.vm.forward_port 80, 8080
  config.vm.forward_port 3306, 3307
  
  config.vm.share_folder "vagrant-root", "/vagrant", "~/Sites", :extra => 'dmode=777,fmode=777'

  config.vm.customize ["modifyvm", :id, "--memory", 512]
end