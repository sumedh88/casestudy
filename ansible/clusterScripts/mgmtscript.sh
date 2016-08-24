#!/bin/bash

cd mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64
cp bin/ndb_mgm* /usr/local/bin
cd /usr/local/bin
chmod +x ndb_mgm*
mkdir /var/lib/mysql-cluster