# vim:set ft=dockerfile:
FROM java:8-jre

RUN	wget -q -O - https://github.com/kairosdb/kairosdb/releases/download/v1.2.2/kairosdb-1.2.2-1.tar.gz | tar xz -C /opt
RUN wget -qO- https://github.com/Schemiii/logback-gelf/archive/v1.1.0-compiled.tar.gz | tar xvz --strip-components=2 -C /opt/kairosdb/lib/ logback-gelf-1.1.0-compiled/rel/logback-gelf-1.1.0.jar
COPY	kairosdb.docker.sh /opt/kairosdb/bin/kairosdb.docker.sh
COPY	kairosdb.logback.xml /opt/kairosdb/conf/logging/logback.xml

VOLUME /opt/kairosdb/conf
EXPOSE 8080 4242 8443
CMD ["/opt/kairosdb/bin/kairosdb.docker.sh"]
