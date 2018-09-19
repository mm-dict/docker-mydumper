FROM alpine:3.7
MAINTAINER Dao Hoang Son <daohoangson@gmail.com>

ARG MYDUMPER_VERSION

RUN  export LIB_PACKAGES='glib mariadb-client-libs pcre' \
  && export BUILD_PACKAGES='glib-dev mariadb-dev zlib-dev pcre-dev libressl-dev cmake build-base' \
  \
  && apk add --no-cache --update $LIB_PACKAGES $BUILD_PACKAGES \
  && cd /tmp \
  && wget "https://github.com/maxbube/mydumper/archive/v${MYDUMPER_VERSION}.tar.gz" -O mydumper.tar.gz \
  && tar -xzf mydumper.tar.gz \
  && cd mydumper* \
  \
  && cmake . \
  && make \
  && make install \
  \
  && apk del $BUILD_PACKAGES \
  && (rm -rf /tmp/* 2>/dev/null || true) \
  && (rm -rf /var/cache/apk/* 2>/dev/null || true)

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["-V"]
