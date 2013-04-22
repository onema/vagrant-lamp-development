require "berkshelf/vagrant"

Vagrant::Config.run do |config|
  ["precise64", "lucid64"].each do |box|
    config.vm.define box do |config|
      config.vm.box = box
      config.vm.box_url = "http://files.vagrantup.com/#{box}.box"
    end
  end

  config.vm.provision :shell, :inline => <<-BASH
    (test -e /etc/init.d/memcached && /etc/init.d/memcached stop) || test 1 # stop memcached so we can make sure it is started
  BASH

  config.ssh.forward_agent = true

  config.vm.provision :chef_solo do |chef|
    # chef.log_level = :debug
    chef.json = {
      :minitest => {:verbose => false}
    }
    chef.run_list = [
      "minitest-handler",
      "recipe[memcached]",
    ]
  end
end
