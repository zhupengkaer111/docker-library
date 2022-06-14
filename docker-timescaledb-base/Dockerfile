FROM timescale/timescaledb:2.7.0-pg13
RUN apk update --no-cache; \
    apk add --no-cache --virtual .fetch-deps \
            ca-certificates \
            git \
            openssl \
            openssl-dev \
            tar; \
    cd /home; \
    git clone https://github.com/pgaudit/pgaudit.git && \
    cd pgaudit && \
    apk add --no-cache --virtual .build-deps \
    		bison \
    		coreutils \
    		dpkg-dev dpkg \
    		flex \
    		gcc \
    		krb5-dev \
    		libc-dev \
    		libedit-dev \
    		libxml2-dev \
    		libxslt-dev \
    		linux-headers \
    		llvm-dev clang g++ \
    		make \
    		openldap-dev \
    		openssl-dev \
    		perl-dev \
    		perl-ipc-run \
    		perl-utils \
    		python3-dev \
    		tcl-dev \
    		util-linux-dev \
    		zlib-dev \
    		icu-dev; \
    make install USE_PGXS=1 PG_CONFIG=/usr/local/bin/pg_config; \
    apk del .fetch-deps .build-deps; \
    rm -rf /home/pgaudit;


