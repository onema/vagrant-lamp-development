# Some neat package 
%w{ debconf git-core htop screen curl vim }.each do |a_package|
  package a_package
end

include_recipe "apt"
include_recipe "build-essential"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "memcached"
include_recipe "php"
include_recipe "php::module_apc"
include_recipe "php::module_curl"
include_recipe "php::module_mysql"
include_recipe "php::module_gd"
include_recipe "php::module_memcache"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "composer"

# get phpmyadmin conf
cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end
bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end
package "phpmyadmin"

# install the mongodb pecl
php_pear "mongo" do
  action :install
end


s = "localhost"
site = {
  :name => s,
  :host => "#{s}", 
  :aliases => ["dev.#{s}.web", "dev.#{s}-static.web"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/"
end  

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} >> /etc/hosts"
end

if node[:lamp][:install][:xdebug]
	include_recipe "vagrant_main::xdebug"
end

# Add an admin user to mysql
execute "add-admin-user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE USER 'myadmin'@'localhost' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'localhost' WITH GRANT OPTION;" +
      "CREATE USER 'myadmin'@'%' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'%' WITH GRANT OPTION;\" " +
      "mysql"
  action :run
  only_if { `/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -N -e \"SELECT COUNT(*) FROM user where user='myadmin' and host='localhost'"`.to_i == 0 }
  ignore_failure true
end

# Create Databases
#execute "add-groutopics-db" do
#    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" + 
#            "CREATE SCHEMA IF NOT EXISTS `test_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;\""
#            #"CREATE SCHEMA IF NOT EXISTS `a3s` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;\""
#    action :run
#    ignore_failure true
#end
