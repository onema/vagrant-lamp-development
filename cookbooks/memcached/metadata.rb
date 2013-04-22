name              "memcached"
maintainer        "Hector Castro"
maintainer_email  "hectcastro@gmail.com"
license           "Apache 2.0"
description       "Installs and configures memcached."
version           "0.2.0"
recipe            "memcached", "Installs and configures memcached"

#depends "logrotate"

%w{ centos redhat ubuntu }.each do |os|
    supports os
end
