# vim:set ft=dockerfile:
FROM java:8-jre

RUN	wget -q -O - https://github.com/kairosdb/kairosdb/releases/download/v1.3.0-beta1/kairosdb-1.3.0-0.1beta.tar.gz | tar xz -C /opt
COPY	kairosdb.docker.sh /opt/kairosdb/bin/kairosdb.docker.sh
COPY	kairosdb.logback.xml /opt/kairosdb/conf/logging/logback.xml

VOLUME /opt/kairosdb/conf
EXPOSE 8080 4242
CMD ["/opt/kairosdb/bin/kairosdb.docker.sh"]
