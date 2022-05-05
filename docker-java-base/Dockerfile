FROM centos:centos7
RUN yum install -y java-1.8.0-openjdk-1.8.0.292.b10-1.el7_9.x86_64 \
	glibc-common-2.17-325.el7_9.x86_64 \
	libxml2-2.9.1-6.el7.5.i686 \
	zlib-1.2.7-18.el7.x86_64 \
	bzip2-libs-1.0.6-13.el7.i686 \
	xz-libs-5.2.2-1.el7.i686 \
    &&	yum clean all \
    &&	yum install -y glibc-2.17-324.el7_9.i686 \
    &&	yum update -y \
    &&	yum clean all \
    &&	rm -rf /usr/bin/readelf &> /dev/null