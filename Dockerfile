FROM graviteeio/java:8
MAINTAINER Gravitee Team <http://gravitee.io>

ARG GRAVITEEAM_VERSION=0
ENV GRAVITEEAM_HOME /opt/graviteeio-am-management-api

# Update to get support for Zip/Unzip, nc and wget
RUN apk add --update zip unzip netcat-openbsd wget

RUN wget --no-check-certificate -O /tmp/gravitee-am-management-api-standalone-${GRAVITEEAM_VERSION}.zip https://download.gravitee.io/graviteeio-am/components/gravitee-am-management-api/gravitee-am-management-api-standalone-${GRAVITEEAM_VERSION}.zip \
    && unzip /tmp/gravitee-am-management-api-standalone-${GRAVITEEAM_VERSION}.zip -d /tmp/ \
    && mv /tmp/gravitee-am-management-api-standalone-${GRAVITEEAM_VERSION} /opt/graviteeio-am-management-api \
    && rm -rf /tmp/*

RUN addgroup -g 1000 gravitee \
    && adduser -D -u 1000 -G gravitee -h ${GRAVITEEAM_HOME} gravitee \
    && chown -R gravitee:gravitee ${GRAVITEEAM_HOME}

USER 1000

WORKDIR ${GRAVITEEAM_HOME}

EXPOSE 8093
VOLUME ["/opt/graviteeio-am-management-api/logs"]
CMD ["./bin/gravitee"]
