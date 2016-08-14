#
# Cookbook Name:: devopssvn
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "subversion"

subversion "https://svn.persistent.co.in/svn/DevOps_Compt/niloday_tamhankar/webapp.war" do
  repository "https://svn.persistent.co.in/svn/DevOps_Compt/*******/"
  destination "/root/******"
  svn_username "*******************"
  svn_password "***********"
  action :export
end

remote_file "Move WAR to webapps" do 
  source "file:///root/niloday_tamhankar/webapp.war" 
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
