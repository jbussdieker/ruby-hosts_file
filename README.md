# HostsFile

[![Build Status](https://travis-ci.org/jbussdieker/ruby-hosts_file.png?branch=master)](https://travis-ci.org/jbussdieker/ruby-hosts_file)
[![Code Climate](https://codeclimate.com/github/jbussdieker/ruby-hosts_file.png)](https://codeclimate.com/github/jbussdieker/ruby-hosts_file)
[![Gem Version](https://badge.fury.io/rb/hosts_file.png)](http://badge.fury.io/rb/hosts_file)

Basic library for reading hosts file entries.

## Usage

    require 'hosts_file'

    hosts = HostsFile.read("/etc/hosts")
    hosts.collect {|host| host.ip}
    hosts.collect {|host| host.name}
    hosts.collect {|host| host.aliases}
    hosts.find {|host| host.hostname == "somehost"}
    hosts.find {|host| host.ip == "1.1.1.1"}
