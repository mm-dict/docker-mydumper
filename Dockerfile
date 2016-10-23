FROM alpine:edge
MAINTAINER Dao Hoang Son <daohoangson@gmail.com>

ENV LIB_PACKAGES="glib-dev mariadb-dev zlib-dev pcre-dev libressl-dev"
ENV BUILD_PACKAGES="cmake build-base"
ENV BUILD_PATH="/src/mydumper-src/"

COPY mydumper-0.9.1.tar.gz /src/mydumper.tar.gz

RUN	apk add --no-cache --update $LIB_PACKAGES $BUILD_PACKAGES \
	&& mkdir $BUILD_PATH \
	&& tar -xvf /src/mydumper.tar.gz -C $BUILD_PATH \
	&& cd $BUILD_PATH/mydumper* \
	&& cmake . \
	&& make \
	&& mv ./mydumper /usr/bin/. \
	&& mv ./myloader /usr/bin/. \
	&& rm -rf BUILD_PATH \
	&& apk del $BUILD_PACKAGES \
	&& (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

CMD ["mydumper"]