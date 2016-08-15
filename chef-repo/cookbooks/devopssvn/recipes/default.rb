#
# Cookbook Name:: devopssvn
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "subversion"

execute 'svnrepodir' do
  command '/bin/mkdir /root/niloday_tamhankar'
end

subversion "https://svn.persistent.co.in/svn/DevOps_Compt/niloday_tamhankar/webapp.war" do
  repository "https://svn.persistent.co.in/svn/DevOps_Compt/niloday_tamhankar/"
  destination "/root/niloday_tamhankar"
  svn_username "niloday_tamhankar"
  svn_password "August1816"
  action :force_export
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
