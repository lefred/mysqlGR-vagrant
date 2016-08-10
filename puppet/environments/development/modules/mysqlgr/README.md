Puppet MySQL Group Replication Module
=====================================

This module is made for CentOS/RHEL (Yum based system) and allows to installi and bootstrap a Group of MySQL members.

Currently the last labs release (5.7.14) is available.

This is how to use it in the puppet manifest::

    node node1 {

        class {
            'mysqlgr':
                            mysql_serverid  => "1",
                            bootstrap       => True,
                            ensure          => "running";
        }

    }


List of supported parameters
-----------------------------

| Parameter      | Value                       |
| ---------------|-----------------------------|
| bootstrap      | To bootstrap the cluster    |


