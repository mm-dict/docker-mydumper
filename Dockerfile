FROM alpine:3.9

ENV MYDUMPER_VERSION="0.9.5"

RUN  export LIB_PACKAGES='glib mariadb-connector-c-dev mariadb-connector-c pcre' \
  && export BUILD_PACKAGES='glib-dev mariadb-dev zlib-dev pcre-dev libressl-dev cmake build-base' \
  \
  && apk add --no-cache --update $LIB_PACKAGES $BUILD_PACKAGES \
  && cd /tmp \
  && wget https://github.com/maxbube/mydumper/archive/v${MYDUMPER_VERSION}.tar.gz -O mydumper.tar.gz \
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

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]