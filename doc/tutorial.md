#Setting up a quick dev environment with Vagrant and Chef
##Intro
> Vagrant provides easy to configure, reproducible, and portable work environments built on top of industry-standard technology and controlled by a single consistent workflow to help maximize the productivity and flexibility of you and your team.

The objective of this tutorial is to setup all the tools needed to 
get a php dev environment using vagrant and the cookbooks found in this 
repository.

##Requirements
###The following software is required: 
 - [Git](http://git-scm.com/downloads).
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
 - [Vagrant](http://downloads.vagrantup.com/) **(DO NOT USE VERSION 1.3.3 as it will not work use version 1.3.2 or 1.3.4 and up)**.

###Other requirements:
 - Open an account at GitHub.com if you don't have one already. 

##Installation
For the sake of organization create a directory called lamp-development in your 
home directory (or the directory of your choose). 
Once the software above has been correctly installed you will need to clone the 
repository inside the new lamp-development directory (for Windows use Git Bash):

```
> cd ~/
> mkdir lamp-development
> cd lamp-development
> git clone git@github.com:onema/vagrant-lamp-development.git vagrant
```

Copy the Vagrantfile inside vagrant to the lamp-development directory

``` 
> cp vagrant/Vagrantfile Vagrantfile
```

Now we'll need to make some small modifications to the Vagrantfile
 1) Update the chef.cookbooks_path to point to the cookbooks inside the vagrant directory:
``` chef.cookbooks_path = "vagrant/cookbooks"```
 2) NFS is enabled by default, if you don't need it comment it out, and uncomment the following line:
```config.vm.synced_folder "~/Sites", "/vagrant"```  NFS folders do not work on windows so it can be disabled.
 3) Set the synced_folder to your projects directory. In this example I have placed all my projects in 
```~/Sites``` but this directory can be any directory in the host computer. NOTE AT THIS POINT THE SHARED DIRECTORY IN THE GUEST MACHINE MUST BE ```vagrant```.
 4) Set the system base memory to your preference, I do not recommend using less than 512:
```vb.customize ["modifyvm", :id, "--memory", "512"]```

The full vagrant file sample for ***Mac*** can be found below:   

```
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "localhost"

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "vagrant/cookbooks"
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
``` 

For windows the configuration is very similar, make sure to update the paths correctly and disable NFS:

```
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "localhost"

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "vagrant/cookbooks"
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
  config.vm.synced_folder "c:/Sites", "/vagrant"
  
  ##########################################################################
  # NFS 
  # Enable if you have performance issues with large projects. 
  # see the following links for more info:
  # http://forum.symfony-project.org/viewtopic.php?t=52241&p=167041#p147056
  # http://docs.vagrantup.com/v2/synced-folders/nfs.html
  # http://www.phase2technology.com/blog/vagrant-and-nfs/
  ###########################################################################
  # Host-Only networking required for nfs shares
  #config.vm.network "private_network", ip: "192.168.50.4"
  #config.vm.synced_folder "c:/Sites", "/vagrant", nfs: true


  config.vm.provider :virtualbox do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end
end
``` 
Note that in this example I'm pointing the project directory to ```c:/Sites/```, 
and therefore it needs to be changed to point to the correct projects directory.

Back in the terminal or GitBash run the following command to get started:

```
> vagrant up --provision
```

The initial setup process can take up to 45 min depending on your Internet connection.

To access the VM via the terminal use the ```vagrant ssh``` command. 

Once you are done using the VM, you can put it to sleep by using the ```vagrant suspend``` command.
The vm will be shutdown if the computer is turned off, but it can be restarted using
the ```vagrant up``` coommand. 

###Modify/Create hosts file
The article "[How do I modify my hosts file?](http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file)" 
will have all the information you need to create and/or modify the hosts file and add the following lines if it doesn't contain them already:
```
127.0.0.1       localhost
::1             localhost
127.0.0.1       symfony.web

```
 

##Usage
###Web Access
To access the VM through a web browser visit the localhost through port 8080 
```http://localhost:8080``` This will be the default webroot and it contains all 
the files you have in the ```~/Sites``` directory. 

Create a new file to test it out. In the terminal type:
```
> touch index.php
```
Modify the index.php to contain something like 

```
<?php echo phpinfo();
```
Now open a web browser and visit the page ```http://localhost:8080```

**I recommend using vhost to point to every project in the Sites directory.**

###Resolving date timezone issues
By default the the php.ini value ```date.timezone``` is not set and Symfony will yell at you for not having it set. 
in your vm edit the php.ini file:

```
> sudo nano /etc/php5/apache2/php.ini 
``` 
Search for the line: 
```
;date.timezone=
```
Replace it with:
```
date.timezone = America/Los_Angeles
```
Restart apache:
```
> sudo service apache2 restart
```



###PHP MyAdmin
The main cookbook installs mysql and phpmyadmin out of the box. To have access to 
PHPMyAdmin and MySQL visit the following site on your web browser: ```http://localhost:8080/phpmyadmin```
You can access the PHPMyAdmin interface using username:root password:root. MySQL 
can also be accessed from the terminal using ```mysql -u root -proot``` (this is after you have accessed the vm via ```vagrant ssh```)

###MongoDB
MongoDB also comes out of the box unless it was commented out in the Vagrantfile. Access it through the terminal using the ```mongo``` command.

##Installing Symfony2

Composer has been also pre-installed and it can be used right away. to install symfony go to the vagrant directory and 
follow the instructions in "[Installing and Configuring Symfony](http://symfony.com/doc/current/book/installation.html)"

```
> composer create-project symfony/framework-standard-edition symfony
> composer install
```

To test Symfony visit the following page in the web browser ```http://symfony.web:8080/app_dev.php```
Notice that this site has it's own domain as long as the symfony project has been 
created in the Sites directory under the name ```symfony```. This is because I have 
conveniently added the vhost configuration in the Vagrantfile.

##Creating additional Vhosts
To add more vhost pointing to different directories, append as many more entries in the 
vhost array in the Vagrantfile. 

```
        :devproject => {
            :name => "devproject",
            :host => "dev.project.com", 
            :aliases => ["devproject"],
            :docroot => "/devproject/public"
        }
```

##Compatibility
That's it, I have tested this setup in Mac OS 10.8.5 and Windows 8 using gitbash.
