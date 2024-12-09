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
        jasper \
        tini \
        openjdk8-jre;
COPY --from=build /opt/dcraw/bin/* /bin/
COPY --chmod=0755 start-picapport.sh /usr/scripts/
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION


ENV PICAPPORT_PORT=8080
ENV DTRACE=WARNING
ENV XMS=256m
ENV XMX=1024m

RUN mkdir -p /opt/picapport/.picapport/plugins 
COPY --from=build /opt/picapport/picapport-headless.jar /opt/picapport/picapport-headless.jar
COPY --from=build /opt/picapport/plugins/* /opt/picapportplugins/
COPY --from=build /opt/picapport/add-ons/* /opt/picapportgroovy/
COPY apache-groovy-binary-*.zip /opt/picapportgroovy/
WORKDIR /opt/picapport
EXPOSE ${PICAPPORT_PORT}
# client.theme.color=#34568B
# client.theme.darktheme=true
# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
ARG APP="picapport"
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    ${APP}
RUN chown -hR picapport /opt/picapport/.picapport
RUN chown -hR picapport /srv
USER ${APP}

ENTRYPOINT ["tini", "--" ]
CMD ["/usr/scripts/start-picapport.sh"]
HEALTHCHECK  \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PICAPPORT_PORT}/ || exit 1
#  --interval=5m --timeout=3s
