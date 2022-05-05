FROM centos:centos7
ADD Centos-7.repo /etc/yum.repos.d
RUN groupadd -g 3000 business \
    &&	useradd -u 3000 -g business -s /sbin/nologin business \
    &&	mkdir /home/workdir -p \
    &&	yum update -y \
    &&	yum install -y java-1.8.0-openjdk-1.8.0.292.b10-1.el7_9.x86_64 \
	glibc-common-2.17-325.el7_9.x86_64 \
	libxml2-2.9.1-6.el7.5.i686 \
	zlib-1.2.7-18.el7.x86_64 \
	bzip2-libs-1.0.6-13.el7.i686 \
	xz-libs-5.2.2-1.el7.i686 \
    &&	yum clean all \
    &&	yum install -y glibc-2.17-324.el7_9.i686 \
    &&	yum clean all \
    &&	rm -rf /usr/bin/readelf &> /dev/null


RUN cd /home/workdir \
    && mkdir config/product -p \
    &&	chown business:unismart /home/workdir -R \
    &&	chmod 550 /home/workdir -R \
    &&	echo 'Asia/Shanghai' > /etc/timezone


ARG workdir=/home/workdir
WORKDIR ${workdir}

ADD *.jar /home/workdir/all-boot-application.jar
EXPOSE 8077

USER business

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/urandom -Xms2048m -Xmx2048m -Xmn1024m -Xss256k -XX:PermSize=256m -XX:MaxPermSize=256m -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+UseCMSCompactAtFullCollection -XX:+CMSParallelRemarkEnabled -XX:CMSInitiatingOccupancyFraction=70 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5280","-jar","all-boot-application.jar"]
