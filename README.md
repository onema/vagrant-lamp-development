# Vagrantfile and Chef Recipes for LAMP Development

Ubuntu 12.04 (precise64) Vagrant setup for development. The intention of this repo is to have a single general purpose development environment for multiple projects, although it can be used to run a single project.
Software installed includes
* Apache    - 2.2.22
* PHP       - 5.3.10
* MySQL     - 5.5.28
* MongoDB   - 2.4.2
* Xdebug    - 2.1.0
* Memcached - 1.4.13
* Redis     - 2.6.12


## Requirements

* VirtualBox - Free virtualization software [Downloads](https://www.virtualbox.org/wiki/Downloads)
* Vagrant (Tested with Vagrant v 1.2.1)- Tool for working with virtualbox images [Vagrant Home](https://www.vagrantup.com), click on 'download now link'
* Git - Source Control Management [Downloads](http://git-scm.com/downloads)

## Contributing
The vision for this repo is to have a development environment that can be fully setup by modifying the Vagranfile.
It is currently a work in progress and I will continue to update it adding more custom functionality and options to the Vagrantfile. Code contributions and any fixes/improvements are welcome :)

# Quick Start 
* [Configuration](#configuration)
* [Start the VM](#start-the-vm)
* [Open your web browser and try it out!](#open-your-web-browser-and-try-it-out)
* [PHPMyAdmin](#phpmyadmin)
* [Creating Custom Vhosts](#creating-custom-vhosts)
* [XDebug](#xdebug)

##Configuration
You can set up a development virtual machine for any of your development projects. All you need to do is copy the vagrant file to the location of your choise and change the following values:

###chef.cookbooks_path:

If you decided to copy the Vagrant file to a location right outside of this repository (recommended), update the cookbooks_path to point to the cookbooks in the repo. 

```
example:

/vagrant/
/vagrant/Vagrantfile                            # This is the copy of the Vagrant file and the one you will be making changes to
/vagrant/vagrant-lamp-development/
/vagrant/vagrant-lamp-development/Vagrantfile   # This is the original Vagrant file, copy it and put it in the location of your choice
/vagrant/vagrant-lamp-development/cookbooks/
/vagrant/vagrant-lamp-development/cookbooks/...

```
For this example the chef.cookbooks_path would be:
```ruby
chef.cookbooks_path = "vagrant-lamp-development/cookbooks"
```

###config.vm.synced_folder:
```ruby
config.vm.synced_folder "~/Sites", "/vagrant"
```
Point the vagrant root to the directory containing all your web projects. In this case "~/Sites" is the location the development directory in the local machine. 


##Start the VM

Simply run

```
$ vagrant up
```

The setup can take up to 30 minutes initally depending on your computer and internet speed. Once you are done with vagrant use the following command to save the state of the VM :

```
$ vagrant suspend
```

and restore it using:

```
$ vagrant resume
```

##Open your web browser and try it out!
        
Visit the followign URLs:
```
http://localhost:8080/project01/public/index.php

http://localhost:8080/my-website/public/

http://localhost:8080/symfony/web/app_dev.php/
```

Where project01, my-website and symfony are directories within the vagrant-root. 


##PHPMyAdmin 
PHPMyAdmin is installed by default and you can access it by visiting

[http://localhost:8080/phpmyadmin/](http://localhost:8080/phpmyadmin/)
```
Username: root
Password: root
```
##Creating Custom Vhosts:

Using the provided json array you can automatically set vhost from the Vagrantfile. You can add any number of vhost like this:

```ruby
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
        },
        :mywebsite => {
            :name => "mywebsite",
            :host => "mywebsite.web", 
            :aliases => ["mywebsite"],
            :docroot => "/my-website/public"
        }
     },
     
       
```

Just provide the ```name```, ```host```, any ```alias```, and the ```document root```. The document root is not the full path, but the path from the vagrant-root. The recipe will add the vhost, and append an entry for each domain to the list of hosts ***in the VM***.

It is important to remember to add a an entry to your hosts file ***(in the development machine)***, that way when you visit the page

```
mywebsite.web:8080
```

it will be routed correctly.

## XDebug
To enable xdebug you will need to map in the IDE the local files to the server files. There are several resources online that describe this process including:

http://pietervogelaar.nl/php-xdebug-netbeans-vagrant/

http://walkah.net/blog/debugging-php-with-vagrant/

http://tiger-fish.com/blog/drupal-debugging-code-inside-vagrant-instance-using-xdebug

Other than mapping you shouldn't need to change the xdebug configuration.


# Using Vagrant

Vagrant is [very well documented](http://vagrantup.com/v1/docs/index.html) but here are a few common commands:

* `vagrant up` starts the virtual machine and provisions it
* `vagrant suspend` will essentially put the machine to 'sleep' with `vagrant resume` waking it back up
* `vagrant halt` attempts a graceful shutdown of the machine and will need to be brought back with `vagrant up`
* `vagrant ssh` gives you shell access to the virtual machine


##### Virtual Machine Specifications #####
