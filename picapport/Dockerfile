FROM alpine:latest AS build

COPY --chmod=0755 build-dcraw.sh /usr/scripts/
COPY --chmod=0755 add-buildpackages.sh /usr/scripts/
COPY --chmod=0755 get-piccaport.sh /usr/scripts/
RUN  /usr/scripts/add-buildpackages.sh
RUN  /usr/scripts/build-dcraw.sh 
RUN  /usr/scripts/get-piccaport.sh

FROM alpine:latest
RUN apk upgrade && \
    apk update && \
    apk add --no-cache \
        libjpeg-turbo \
        libjpeg-turbo-utils \
        lcms2 \
        exiftool \
        jasper;
COPY --from=build /opt/dcraw/bin/* /bin/

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION

ENV PICAPPORT_PORT=8080
ENV DTRACE=WARNING
ENV XMS=256m
ENV XMX=1024m

RUN apk add --update --no-cache tini openjdk8-jre && \
    mkdir -p /opt/picapport/.picapport/plugins && \
    printf "%s\n%s\n%s\n" "server.port=$PICAPPORT_PORT" "robot.root.0.path=/srv/photos" "foto.jpg.usecache=2" "plugin.shadow.path=/srv/picapportshadowfiles"> /opt/picapport/.picapport/picapport.properties
COPY --from=build /opt/picapport/picapport-headless.jar /opt/picapport/picapport-headless.jar
COPY --from=build /opt/picapport/plugins/* /opt/picapport/.picapport/plugins/
COPY --from=build /opt/picapport/add-ons/* /opt/picapport/.picapport/groovy/
COPY apache-groovy-binary-*.zip /opt/picapport/.picapport/groovy/
WORKDIR /opt/picapport
EXPOSE ${PICAPPORT_PORT}

ENTRYPOINT tini -- java -Xms$XMS -Xmx$XMX -DTRACE=$DTRACE -Duser.home=/opt/picapport -jar picapport-headless.jar
HEALTHCHECK  \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PICAPPORT_PORT}/ || exit 1
#  --interval=5m --timeout=3s