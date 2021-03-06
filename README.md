# mysqlGR-vagrant
Vagrant and Puppet environment for MySQL Community Group Replication


This Vagrant environment requires vagrant-hostmanager plugin.

The purpose of this environment is to setup a MySQL Group of 3 members, CentOS 7 x86_64 for testing.

It also includes a puppet module that can be used as base for a Group Replication deployment out of Vagrant.

More info on GR & InnoDB Cluster:

- http://lefred.be/content/mysql-group-replication-beta-0-8-is-out/
- http://lefred.be/content/mysql-innodb-cluster-automated-installation-with-puppet/

This environment is using hiera, this is how you can configure a group and the nodes:

common.yaml
-----------

```
---
classes:
    - getridoflocaldomain

innodbcluster::mysql_root_password: >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEAhqKUTXZ/4L8/aL3XARMfDBEI+s5HPshPg9BI
    o0PdwllAr+Qqo4+zsZR0T7d8whatD0jfGHCwUlT+x0ujdSLAOflPjDPCVXsw
    chpOd8ghwcDdg/Xr88RexfycD5JJOAD49kwb4EN4dggp+uAXhTr73Mj0PATC
    eJyVtEf8LiLAnFLKAKHmol5GSlEeePiO3RjXaxhkmQgfUpmLp6Oe1PSW035g
    2SDYhby59hTo+fYBV6ltSU/kRtLGCrHZ9PAZ/9KO3sMhugXRiIH4u1Wyyb+V
    FLfovstrb8zmcbk5yb/KD0lDM8Elas0lrnpk8MxwNfKw+hB299JFp8ldAtUk
    ODIieTA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBJEeoyzHtW/WGpbiUz
    gcXTgBAnb1gGrBZAfAiv/ztwuZ9z]
innodbcluster::mysql_bind_interface:    eth1
innodbcluster::cluster_name: mycluster
innodbcluster::grant::user: root
innodbcluster::grant::password: >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEAhqKUTXZ/4L8/aL3XARMfDBEI+s5HPshPg9BI
    o0PdwllAr+Qqo4+zsZR0T7d8whatD0jfGHCwUlT+x0ujdSLAOflPjDPCVXsw
    chpOd8ghwcDdg/Xr88RexfycD5JJOAD49kwb4EN4dggp+uAXhTr73Mj0PATC
    eJyVtEf8LiLAnFLKAKHmol5GSlEeePiO3RjXaxhkmQgfUpmLp6Oe1PSW035g
    2SDYhby59hTo+fYBV6ltSU/kRtLGCrHZ9PAZ/9KO3sMhugXRiIH4u1Wyyb+V
    FLfovstrb8zmcbk5yb/KD0lDM8Elas0lrnpk8MxwNfKw+hB299JFp8ldAtUk
    ODIieTA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBJEeoyzHtW/WGpbiUz
    gcXTgBAnb1gGrBZAfAiv/ztwuZ9z]
innodbcluster::seed: mysql1
```

mysql1.yaml
-----------
```
---
classes:
    - innodbcluster

innodbcluster::mysql_serverid:  1
```

mysql2.yaml
-----------
```
---
classes:
    - innodbcluster

innodbcluster::mysql_serverid:  2
```

mysql3.yaml
-----------
```
---
classes:
    - innodbcluster

innodbcluster::mysql_serverid:  3
```
