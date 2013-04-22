# Grouptopics w/ Vagrant

A basic Ubuntu 10.04 Vagrant setup for [Grouptopics](https://github.com/sdphp/grouptopics.org) and PHP 5.4.

## Requirements

* VirtualBox - Free virtualization software [Downloads](https://www.virtualbox.org/wiki/Downloads)
* Vagrant - Tool for working with virtualbox images [Vagrant Home](https://www.vagrantup.com), click on 'download now link'
* Git - Source Control Management [Downloads](http://git-scm.com/downloads)

## Quick Start - Using Vagrant

You can set up a development virtual machine running Grouptopics by following these simple instructions.

1. Install requirements. (Note: these are not required by grouptopics itself, but are required for this quick start guide.)
   - VirtualBox (https://www.virtualbox.org/) (versions 4.0 and 4.1 are currently supported)
   - Ruby (http://www.ruby-lang.org/)
   - Vagrant (http://vagrantup.com/)

2. Clone repository to any location and fetch required submodules (containing Puppet manifests).

        git clone https://github.com/sdphp/grouptopics.org
        cd grouptopics

3. Start the process by running Vagrant.

        vagrant up

4. Add hostname to /etc/hosts.

        echo "127.0.0.1 dev.gt " | sudo tee -a /etc/hosts

5. Browse to the newly provisioned development copy of grouptopics.

        open http://dev.gt:8080

### Using Vagrant

Vagrant is [very well documented](http://vagrantup.com/v1/docs/index.html) but here are a few common commands:

* `vagrant up` starts the virtual machine and provisions it
* `vagrant suspend` will essentially put the machine to 'sleep' with `vagrant resume` waking it back up
* `vagrant halt` attempts a graceful shutdown of the machine and will need to be brought back with `vagrant up`
* `vagrant ssh` gives you shell access to the virtual machine


##### Virtual Machine Specifications #####

* OS     - Ubuntu 11.04
* Apache - 2.2.22
* PHP    - 5.3.2
* MySQL  - 5.5.28

Phpmyadmin is available [http://dev.gt:8080/phpmyadmin/](http://dev.gt:8080/phpmyadmin/). User `root`, Password `root`
