FROM ubuntu:14.04
MAINTAINER Sumedh <sumedh_surlekar@persistent.com>

ENV http_proxy "http://:8080"
ENV https_proxy "https:/:8080"
ENV no_proxy "localhost,127.0.0.1,10.51.237.155,hj-ibmibm4486,local.home"

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:pass' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 8080
EXPOSE 3306
CMD ["/usr/sbin/sshd", "-D"]

