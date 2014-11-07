FROM centos:centos6

RUN yum install -y http://ftp.osuosl.org/pub/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
RUN rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
RUN yum update -y
RUN yum clean all
