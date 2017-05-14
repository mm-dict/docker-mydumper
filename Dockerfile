FROM alpine:3.5
MAINTAINER Dao Hoang Son <daohoangson@gmail.com>

ARG MYDUMPER_VERSION

COPY mydumper-0.9.1.tar.gz /src/mydumper.tar.gz

RUN  export LIB_PACKAGES='glib mariadb-client-libs pcre' \
  && export BUILD_PACKAGES='glib-dev mariadb-dev zlib-dev pcre-dev libressl-dev cmake build-base' \
  \
  && apk add --no-cache --update $LIB_PACKAGES $BUILD_PACKAGES \
  && mkdir -p /src/mydumper-src \
  && cd $_ \
  && tar -xvf /src/mydumper.tar.gz -C . \
  && cd mydumper* \
  \
  && cmake . \
  && make \
  && make install \
  \
  && apk del $BUILD_PACKAGES \
  && rm -rf /src/mydumper* \
  && (rm -rf /tmp/* 2>/dev/null || true) \
  && (rm -rf /var/cache/apk/* 2>/dev/null || true)

ENTRYPOINT ["mydumper"]
CMD ["-V"]
