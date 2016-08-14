#!/bin/bash
svnUser=%1
svnPasswd=%2
warFile='webapp.war'
proxyuser=%3
proxypassword=%4

#Script to be called with command lines as 1- SVN UserName 2- SVN Users password 3 - ProxyUserName 4 - Proxy Password

#Sync with SVN repo
svn co --username $svnUser --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert  https://svn.persistent.co.in/svn/DevOps_Compt/$svnUser/ .

#Determine if the WAR file is pre-existing in the SVN repo.  If the file pre-existed in repo following command would return M
svn status | awk '$2 == "webapp.war" {print $1}'

fileStatus=`svn status | awk '$2 == "readme.txt" {print $1}'`

if [ $fileStatus != 'M' ] 
	then
	svn add --username $svnUser --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert warFile #Add the new file to SVN
else
    svn update --username $svnUser --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert #Update the existing file to SVN
	fi

svn commit --username $svnUser --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert -m "Ready for TEST" #Commit the file to SVN

#Run the Web Server container in TEST environment
#sudo docker  run -td -p 8022:22 -p 8088:8080  --name websrvTEST sumedh1988/ubuntussh:14.04
webSrvCont=$(sudo docker run -td -e ROOT_PASS="pass" -p 8022:22 -p 8088:8080 --name websrvTEST sumedh1988/ubuntussh:14.04)
#Retrieve the server IP address
webIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${webSrvCont})

#Run the database server container in TEST environment
dbSrvCont=$(sudo docker run -td -e ROOT_PASS="pass"  -p 8023:22 -p 8306:3306 --name dbsrvTEST sumedh1988/ubuntussh:14.04)
#Retrieve the server IP address
dbIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${dbSrvCont})

#Save current dir
pushd
#Change to ansible workspace
cd $ANSIBLE_WORKSPACE
echo "[WebServer]" > hosts
echo $webIP  "ansible_ssh_pass=pass" >> hosts
echo "" >> hosts
 echo "[DbServer]" >> hosts
echo $dbIP  "ansible_ssh_pass=pass" >> hosts

#following env variable disables host key checking - when not using key based authentication
export ANSIBLE_HOST_KEY_CHECKING=False

#Update the tomcat.yml
e.g. sed -i -e 's/--proxyuser--/$proxyuser/g' ./tomcat.yml
e.g. sed -i -e 's/--proxypassword--/$proxypassword/g' ./tomcat.yml

#Run Ansible Playbook for WEB Server host to Install Tomact
ansible-playbook -i hosts -u root tomcat.yml  --extra-vars "hosts=$webIP"

#Run Ansible Playbook for DB Server host to Install MySQL (this playbook should also enable remote login for the user)
ansible-playbook -i hosts -u root mysql.yml --extra-vars "hosts=$dbIP"

#Change to CHEF REPO workspace
cd $CHEF_REPO_WORKSPACE

#Run knife bootstrap command to bootstrap the websrvTEST server as a node
knife bootstrap $webIP -x root -P pass --sudo -N websrvTEST -r 'recipe[devopssvn]' --bootstrap-proxy http://$proxyuser:$proxypassword@ptproxy.persistent.co.in:8080

#Now execute UI automation tests
#TODO - run UI automation tests

#Go back to earlier CWD
popd

#Check results
returnVal=100
if [ result is <= 9 ] then 
	returnVal=0
#Following is required to force svn to identify the file as changed 
#svn propset svn:executable ON  --username $svnUser  --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert --force warFile

#TODO: Push war to svn with comment as "READY for STAGE"
#svn commit --username $svnUser --password $svnPasswd --no-auth-cache --non-interactive --trust-server-cert -m "Ready for STAGE" #Commit the file to SVN
fi

#kill docker containers
#sudo docker kill websrvTEST dbsrvTEST
#remove docker containers
#sudo docker rm websrvTEST dbsrvTEST

return returnVal
