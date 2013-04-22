# Vagrantfile and Chef Recipes for LAMP Development

Ubuntu 12.04 Vagrant setup for development.

## Requirements

* VirtualBox - Free virtualization software [Downloads](https://www.virtualbox.org/wiki/Downloads)
* Vagrant (Tested with Vagrant v 1.2.1)- Tool for working with virtualbox images [Vagrant Home](https://www.vagrantup.com), click on 'download now link'
* Git - Source Control Management [Downloads](http://git-scm.com/downloads)

## Quick Start 
The inital intention of this repo is to have a single general purpose development environment for multiple projects, although it can be used to run a single project. 

You can set up a development virtual machine for any of your development projects. All you need to do is point the vagrant-root to your local development directory. To do this modify the following conf.vm.shared_folder:
```ruby
config.vm.share_folder "vagrant-root", "/vagrant", "~/Sites", :extra => 'dmode=777,fmode=777'#, :nfs => true
```
Where "~/Sites" is the location the development directory in your local machine. 

Start the VM by running Vagrant.

        vagrant up
        
Now open your web browser and visit the followign URLs:

http://localhost:8080/project01/public/index.php

http://localhost:8080/project02/web/index.php

http://localhost:8080/symfony/web/app_dev.php/


Where project01, project02 and symfony are the directory names of the projects I'm currently working on, so change these accordingly. 

PHPMyAdmin is installed and you can access it by visiting

[http://localhost:8080/phpmyadmin/](http://localhost:8080/phpmyadmin/)

        
### Using Vagrant

Vagrant is [very well documented](http://vagrantup.com/v1/docs/index.html) but here are a few common commands:

* `vagrant up` starts the virtual machine and provisions it
* `vagrant suspend` will essentially put the machine to 'sleep' with `vagrant resume` waking it back up
* `vagrant halt` attempts a graceful shutdown of the machine and will need to be brought back with `vagrant up`
* `vagrant ssh` gives you shell access to the virtual machine


##### Virtual Machine Specifications #####

* OS        - Ubuntu 12.04 (precise64)
* Apache    - 2.2.22
* PHP       - 5.3.10
* MySQL     - 5.5.28
* MongoDB   - 2.4.2
* Xdebug    - 2.1.0
* Memcached - 1.4.13
* Redis     - 2.6.12
Phpmyadmin is available [http://localhost:8080/phpmyadmin/](http://localhost:8080/phpmyadmin/). User `root`, Password `root`
