#!/bin/bash

<<<<<<< HEAD
cd /root/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64
=======
cd mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64
>>>>>>> dfaebcf1e156de199270127dbd023c844a850ac4
cp bin/ndbd /usr/local/bin
cd /usr/local/bin
chmod +x ndb*
mkdir -p /usr/local/mysql/data
