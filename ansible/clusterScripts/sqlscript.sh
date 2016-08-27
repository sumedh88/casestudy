#!/bin/bash

<<<<<<< HEAD
ln -s /usr/local/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 /usr/local/mysql
ln -s /usr/local/mysql/bin/mysql /usr/local/bin/mysql
=======
cp -r mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 /usr/local/
ln -s /usr/local/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 /usr/local/mysql
>>>>>>> dfaebcf1e156de199270127dbd023c844a850ac4
cd /usr/local/mysql
scripts/mysql_install_db --user=mysql
chown -R root .
chown -R mysql data
<<<<<<< HEAD
chgrp -R mysql .
cp support-files/mysql.server /etc/init.d
chmod +x /etc/init.d/mysql.server
update-rc.d mysql.server defaults
=======
chgrp -R mysql .
>>>>>>> dfaebcf1e156de199270127dbd023c844a850ac4
