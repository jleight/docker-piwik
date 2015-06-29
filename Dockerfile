FROM jleight/nginx-php
MAINTAINER Jonathon Leight <jonathon.leight@jleight.com>

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    php5-cli \
    php5-curl \
    php5-gd \
    php5-geoip \
    php5-ldap \
    php5-mysql \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

ENV APP_HOME    /opt/piwik
ENV APP_DATA    /var/opt/piwik
ENV APP_VERSION 2.13.1
ENV APP_BASEURL http://builds.piwik.org
ENV APP_PKGNAME piwik-${APP_VERSION}.tar.gz
ENV APP_URL     ${APP_BASEURL}/${APP_PKGNAME}

RUN set -x \
  && curl -kL "${APP_URL}" | tar -xz -C /tmp \
  && mv /tmp/piwik "${APP_HOME}" \
  && rm -rf /tmp/* \
  && mkdir -p "${APP_HOME}/tmp" "${APP_DATA}" \
  && chmod -R 755 "${APP_HOME}/tmp" \
  && chown -R nginx:nginx "${APP_HOME}" "${APP_DATA}" \
  && mv "${APP_HOME}/config" "${APP_HOME}/defaults" \
  && ln -s "${APP_DATA}" "${APP_HOME}/config"

ADD nginx-service.sh /etc/service/nginx/run

VOLUME ["/var/opt/piwik"]
