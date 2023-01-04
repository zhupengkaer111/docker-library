# Dockerfile - CentOS 8 - RPM version
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="centos"
ARG RESTY_IMAGE_TAG="8"

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG}

LABEL maintainer="Evan Wies <evan@neomantra.net>"

ARG RESTY_IMAGE_BASE="centos"
ARG RESTY_IMAGE_TAG="8"
ARG RESTY_YUM_REPO="https://openresty.org/package/centos/openresty.repo"
ARG RESTY_RPM_FLAVOR=""
ARG RESTY_RPM_VERSION="1.19.9.1-1"
ARG RESTY_TAR_VERSION="1.19.9.1"
ARG RESTY_RPM_DIST="el8"
ARG RESTY_RPM_ARCH="x86_64"
ARG UNISMART_NGINX_NAME=uni-openresty
ARG UNISMART_NGINX_GROUP=uni-openresty
ARG UNISMART_ROOT_NAME=root
ARG UNISMART_ROOT_GROUP=root
ARG UNISMART_NGINX_UID=3003
ARG UNISMART_NGINX_GID=3003
ARG UNISMART_WORKDIR="/nginx_workdir"

LABEL resty_image_base="${RESTY_IMAGE_BASE}"
LABEL resty_image_tag="${RESTY_IMAGE_TAG}"
LABEL resty_yum_repo="${RESTY_YUM_REPO}"
LABEL resty_rpm_flavor="${RESTY_RPM_FLAVOR}"
LABEL resty_rpm_version="${RESTY_RPM_VERSION}"
LABEL resty_rpm_dist="${RESTY_RPM_DIST}"
LABEL resty_rpm_arch="${RESTY_RPM_ARCH}"

RUN  find /etc/yum.repos.d -name 'CentOS-Linux-*' -exec sed -i 's/mirrorlist/#mirrorlist/g' {} \; \
    && find /etc/yum.repos.d -name 'CentOS-Linux-*' -exec sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' {} \; \
    && groupadd -g $UNISMART_NGINX_GID $UNISMART_NGINX_NAME \
    &&	useradd -m -u $UNISMART_NGINX_UID -g $UNISMART_NGINX_GID -G $UNISMART_ROOT_GROUP -s /sbin/nologin $UNISMART_NGINX_NAME \
    &&	yum install -y yum-utils \
    &&	yum-config-manager --add-repo ${RESTY_YUM_REPO} \
    &&	yum install -y \
	gcc \
	gcc-c++ \
	zlib-devel \
	pcre-devel \
	openssl-devel \
	readline-devel \
        openresty-opm-${RESTY_RPM_VERSION}.${RESTY_RPM_DIST} \
	gettext \
        passwd \
        net-tools \
        logrotate &> /dev/null
COPY openresty-${RESTY_TAR_VERSION}.tar.gz /tmp/
RUN cd	/tmp \
    &&	tar xvf openresty-${RESTY_TAR_VERSION}.tar.gz \
    &&	cd openresty-${RESTY_TAR_VERSION} \
    &&	./configure --prefix=/usr/local/openresty \
    	--user=nginx --group=nginx \
    	--with-http_ssl_module \
    	--with-http_flv_module \
    	--with-http_stub_status_module \
    	--with-pcre \
	--with-http_realip_module \
	--with-http_v2_module \
    &&	make build \
    &&	make install \
    &&	cd /tmp \
    &&	rm -rf openresty-${RESTY_TAR_VERSION} openresty-${RESTY_TAR_VERSION}.tar.gz \
    &&	yum clean all \
    &&	mkdir -p /var/run/openresty \
    &&	ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    &&	ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log \
    &&	yum remove -y gcc \
	gcc-c++ \
    &&	rm -rf /usr/bin/readelf \
    &&	yum update -y \
    &&	yum -y install vixie-cron crontabs \
    &&	yum clean all