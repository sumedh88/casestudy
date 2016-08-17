#
# Cookbook Name:: devopssvn
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "subversion"


execute "Get war file" do
    command "/usr/bin/svn co --depth=immediates --username niloday_tamhankar --password August1816  --no-auth-cache --non-interactive --trust-server-cert  https://svn.persistent.co.in/svn/DevOps_Compt/niloday_tamhankar /root/"
end

remote_file "Move WAR to Tomcat" do 
  source "file:///root/webapp.war" 
  path "/opt/apache-tomcat-6.0.32/webapps/webapp.war"
  owner 'root'
  group 'root'
  mode 0777
end

execute "Stop Tomcat" do
  command "sh /opt/apache-tomcat-6.0.32/bin/shutdown.sh"
end

execute "Start Tomcat" do
  command "sh /opt/apache-tomcat-6.0.32/bin/startup.sh"
end
