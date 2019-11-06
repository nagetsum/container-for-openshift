FROM ubi8-minimal:8.0

LABEL maintainer=norito.agetsuma@gmail.com \
      io.openshift.tags="logstash,logging" \
      io.openshift.expose-services="8080:9600" \
      io.k8s.description="Logstash base on RHEL8 ubi-minimal" \
      io.k8s.display-name="Logstash - OSS only for OpenShift" \
      name="Logstash" \
      summary="Logstash - OSS only container for OpenShift" \
      version="7.4.1"

ENV LOGSTASH_BINARY_FILENAME=logstash-oss-7.4.1 \
    LOGSTASH_HOME=/opt/logstash-7.4.1 \
    USER_NAME=logstash \
    USER_UID=1001

ADD binary/$LOGSTASH_BINARY_FILENAME.tar.gz /opt/
COPY conf/http-pipeline.conf ${LOGSTASH_HOME}/http-pipeline.conf
COPY bin/uid_entrypoint /uid_entrypoint 

RUN microdnf install java-11-openjdk-devel procps-ng && \
    microdnf clean all && \
    useradd -u ${USER_UID} -r -g 0 -d ${LOGSTASH_HOME} -s /sbin/nologin ${USER_NAME} && \
    chmod -R g+rw ${LOGSTASH_HOME} /etc/passwd && \
    chown -R ${USER_NAME}:0 ${LOGSTASH_HOME} && \
    chmod ug+x /uid_entrypoint

USER ${USER_UID}
WORKDIR ${LOGSTASH_HOME}

EXPOSE 8080 9600
ENTRYPOINT [ "/uid_entrypoint" ]
CMD ["bin/logstash", "-f", "http-pipeline.conf"]
