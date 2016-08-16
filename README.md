# mysqlGR-vagrant
Vagrant and Puppet environment for MySQL Community Group Replication


This Vagrant environment requires vagrant-hostmanager plugin.

The purpose of this environment is to setup a MySQL Group of 3 members, CentOS 7 x86_64 for testing.

It also includes a puppet module that can be used as base for a Group Replication deployment out of Vagrant.

More info on GR: http://lefred.be/content/mysql-group-replication-beta-0-8-is-out/

This environment is using hiera, this is how you can configure a node:

```
---
classes:
    - mysqlgr

    mysqlgr::mysql_serverid:    1
    mysqlgr::mysql_root_password:   fred
    mysqlgr::group_seeds:       "192.168.90.2:3406,192.168.90.3:3406,192.168.90.4:3406"
    mysqlgr::bootstrap:     true
    mysqlgr::mysql_bind_interface:  eth1
    mysqlgr::use_ssl:       true
```
