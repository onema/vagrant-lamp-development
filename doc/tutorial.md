#Setting up a quick dev environment with Vagrant and Chef
##Intro
> Vagrant provides easy to configure, reproducible, and portable work environments built on top of industry-standard technology and controlled by a single consistent workflow to help maximize the productivity and flexibility of you and your team.

The objective of this tutorial is to setup all the tools needed to 
get a php dev environment using vagrant and the cookbooks found in this 
repository.

##Requirements
###The following software is required: 
 - [Git](http://git-scm.com/downloads).
 - [Open an account at GitHub.com](https://github.com) if you don't have one already, it's free! 
 - [Create an SSH key in GitHub](https://help.github.com/articles/generating-ssh-keys)
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
 - [Vagrant](http://downloads.vagrantup.com/) **(DO NOT USE VERSION 1.3.3 as it will not work use version 1.3.2 or 1.3.4 and up)**.



##Installation
For the sake of organization create a directory called lamp-development in your 
home directory (or the directory of your choose). 
Once the software above has been correctly installed you will need to clone the 
repository inside the new lamp-development directory (for Windows use Git Bash):

```
cd ~/
mkdir lamp-development
cd lamp-development
git clone git@github.com:onema/vagrant-lamp-development.git vagrant
```

Copy the Vagrantfile inside vagrant to the lamp-development directory

``` 
cp vagrant/Vagrantfile Vagrantfile
```

Now we'll need to make some small modifications to the Vagrantfile:

 1. Update the chef.cookbooks_path to point to the cookbooks inside the vagrant directory:
``` chef.cookbooks_path = "vagrant/cookbooks"```
 2. **For Windows users only:** comment the NFS lines out, and uncomment the following line:
```config.vm.synced_folder "~/Sites", "/vagrant"```  
NFS folders do not work on windows so it can be disabled.
 3. Set the ```synced_folder``` to your projects directory. In this example I have placed all my projects in 
```~/Sites``` but this directory can be any directory in the host computer. NOTE: THE SHARED DIRECTORY IN THE GUEST MACHINE MUST BE ```vagrant```.
 4. Set the system base memory to your preference, **I do not recommend using less than 512**:
```vb.customize ["modifyvm", :id, "--memory", "512"]```

Those are all the updates you need to make in the Vagrantfile for this project. 
See the sample Vagrantfile for Mac and Windows below.

[Sample for Mac](Vagrantfile-mac.md)


[Sample file for Windows](Vagrantfile-windows.md)


###Start the VM
In the terminal type the following command, this will download the Base Box, and provision 
it using Chef. 
```
vagrant up --provision
```

The initial setup process can take up to 45 min depending on your Internet connection. 
The Base Box download and provisioning of the new VM happen only once as long as you keep the VM that was created. 
**Restarting the VM or adding new recipes will not take as long.**

###Modify/Create hosts file
The article "[How do I modify my hosts file?](http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file)" 
will have all the information you need to create and/or modify the hosts file and add the following lines if it doesn't contain them already:
```
127.0.0.1       localhost
::1             localhost
127.0.0.1       symfony.web

```
 

##Usage
###SSH
To access the VM via the terminal use the following command:
```
vagrant ssh
``` 

Once you are done using the VM, you can put it to sleep:
```
vagrant suspend
``` 

The vm will be shutdown if the computer is turned off, but it can be restarted:
```
vagrant up
``` 

To reset/reboot the VM:
```
vagrant reload 
```

To run new recipes, or after new vhost have been added:
```
vagrant provision
```

###Web Access
To access the VM through a web browser visit the localhost through port 8080 
```
http://localhost:8080
``` 

This will be the default webroot and points to the ```~/Sites``` directory.  

Create a new file to test it out. In the terminal type:
```
touch index.php
```
Modify the index.php to contain something like 

```
<?php 
echo phpinfo();
```
Now open a web browser and visit the page ```http://localhost:8080```

**I recommend using vhost to point to every project in the Sites directory.**
See the section [Creating additional Vhosts](tutorial.md#creating-additional-vhosts)
for more info.

####THAT IS IT! YOU ARE OFFICIALLY DONE WITH THE TUTORIAL! 
Great! A phpinfo page, big deal, Now what?
[<< README](../README.md) | [Set up your first project >>](symfony-setup.md).

##Additional information
###Resolving date timezone issues
By default the the php.ini value ```date.timezone``` is not set and Symfony 
will yell at you for not having it set. 
SSH into the VM usign ```vagrant ssh``` and edit the php.ini file:

```
sudo nano /etc/php5/apache2/php.ini 
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
sudo service apache2 restart
```

###PHP MyAdmin
The main cookbook installs mysql and phpmyadmin out of the box. To have access to 
PHPMyAdmin and MySQL visit the following site on your web browser: ```http://localhost:8080/phpmyadmin```
You can access the PHPMyAdmin interface using username:root password:root. MySQL 
can also be accessed from the terminal using ```mysql -u root -proot``` (this is after you have accessed the vm via ```vagrant ssh```)

###MongoDB
MongoDB also comes out of the box unless it was commented out in the Vagrantfile. Access it through the terminal using the ```mongo``` command.

