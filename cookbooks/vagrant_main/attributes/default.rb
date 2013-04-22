#
# Cookbook Name:: lamp
# Attributes:: lamp
#
# Copyright 2011, Dave Widmer
#
# Licensed under the MIT license
#

default[:lamp][:server_name] = "localhost"
default[:lamp][:docroot] = "/vagrant/"
default[:lamp][:xdebug][:path] = "/usr/lib/php5/20090626/"
default[:lamp][:webgrind][:dir] = "/var/www/webgrind"
default[:lamp][:webgrind][:url] = "/webgrind"

# Installation flags
default[:lamp][:install][:xdebug] = true
default[:lamp][:install][:phpmyadmin] = true
default[:lamp][:install][:mcrypt] = true
default[:lamp][:install][:webgrind] = true


case node["platform"]
when "centos", "redhat", "fedora"
  default['php']['conf_dir']      = '/etc'
  default['php']['ext_conf_dir']  = '/etc/php.d'
  default['php']['fpm_user']      = 'nobody'
  default['php']['fpm_group']     = 'nobody'
  default['php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
when "debian", "ubuntu"
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
else
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
end