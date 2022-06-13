FROM alpine:latest

ARG BUILD_DATE

# first, a bit about this container
LABEL build_info="cturra/docker-ntp build-date:- ${BUILD_DATE}"
LABEL maintainer="Chris Turra <cturra@gmail.com>"
LABEL documentation="https://github.com/cturra/docker-ntp"

# install chrony
RUN apk add --no-cache chrony; \
    apk update; \
    rm -rf /var/lib/apk/*;