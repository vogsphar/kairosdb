# vim:set ft=dockerfile:
FROM java:8-jre

ARG SRC
RUN	wget -q -O - ${SRC} | tar xz -C /opt
COPY	kairosdb.docker.sh /opt/kairosdb/conf/kairosdb.docker.sh
COPY	kairosdb.logback.xml /opt/kairosdb/conf/logging/logback.xml

VOLUME /conf
EXPOSE 8080 4242
CMD ["/opt/kairosdb/conf/kairosdb.docker.sh"]
