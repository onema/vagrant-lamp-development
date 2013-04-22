Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "localhost"
  #config.vm.network :hostonly, "192.168.50.4"


  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    
    chef.add_recipe "vagrant_main"


    # https://github.com/edelight/chef-cookbooks
    chef.add_recipe "mongodb::10gen_repo"
    chef.add_recipe "mongodb::default"

    # https://github.com/phlipper/chef-redis
    chef.add_recipe "redis"

    chef.json.merge!({
      :mysql => {
        :server_root_password => "root",
        :server_debian_password => "root",
        :server_repl_password => "root"
      },
      :vhost => {
        :localhost => {
            :name => "localhost",
            :host => "localhost", 
            :aliases => ["localhost.web", "dev.localhost-static.web"],
            :docroot => ""
        },
        :alleluuapi => {
            :name => "alleluu-api",
            :host => "alleluu.api", 
            :aliases => ["alleluu.web"],
            :docroot => "/a3s-API/public"
        }
      }
    })
  end

  config.vm.forward_port 80, 8080
  config.vm.forward_port 3306, 3307
  
  config.vm.share_folder "vagrant-root", "/vagrant", "~/Sites", :extra => 'dmode=777,fmode=777'#, :nfs => true
end