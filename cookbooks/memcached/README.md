# memcached [![Build Status](https://secure.travis-ci.org/hectcastro/chef-memcached.png?branch=master)](http://travis-ci.org/hectcastro/chef-memcached)

## Description

Installs and configures memcached.

## Requirements

### Platforms

* Ubuntu 10.04 (Lucid)
* Ubuntu 11.10 (Oneiric)
* Ubuntu 12.04 (Precise)
* CentOS 6.3
* RedHat 6.3

### Cookbooks

* logrotate

## Attributes

* `node["memcached"]["port"]` - Port to run memcached on.
* `node["memcached"]["listen"]` - IP for the daemon to bind to.
* `node["memcached"]["log_file"]` - Path to the memcached log file.
* `node["memcached"]["max_memory"]` - Maximum amount of memory to consume in
  megabytes.
* `node["memcached"]["max_connections"]` - Maximum number of ports to consume.
* `node["memcached"]["user"]` - User to run memcached as.
* `node["memcached"]["verbose"]` - Enable verbose logging.

## Recipes

* `recipe[memcached]` will install memcached.

## Usage

Currently only supports one instance of memcached per node.  Also, logging is
not supported on the RedHat family of distributions.
