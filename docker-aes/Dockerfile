FROM centos:centos7

RUN yum install -y java-1.8.0-openjdk-1.8.0.292.b10-1.el7_9.x86_64; \
    yum update -y; \
    yum clean all
ADD *.jar /aes.jar
WORKDIR /
