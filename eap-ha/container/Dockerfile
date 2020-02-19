FROM registry.access.redhat.com/ubi8/ubi:8.1-397

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0" \
    JAVA_VENDOR="openjdk" \
    JAVA_VERSION="1.8.0" \
    JBOSS_EAP_VERSION="7.2.0.GA" \
    JBOSS_HOME="/opt/eap" \
    LAUNCH_JBOSS_IN_BACKGROUND="true" \
    PRODUCT_VERSION="7.2.0.GA"

USER root

COPY jboss-eap-7.2.6.tar.gz /

RUN yum install -y java-1.8.0-openjdk-devel hostname \
    && yum clean all \
    && tar xzf jboss-eap-7.2.6.tar.gz -C /opt \
    && mv /opt/jboss-eap-7.2 /opt/eap \
    && groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/eap -s /sbin/nologin -c "JBoss user" jboss \
    && rm /jboss-eap-7.2.6.tar.gz

COPY standalone-ha.xml /opt/eap/standalone/configuration/
COPY echo.war /opt/eap/standalone/deployments/
COPY openshift-launch.sh /opt/eap/bin/

RUN chown -R jboss:0 /opt/eap \
    && chmod -R g+rwx /opt/eap

USER jboss
WORKDIR /opt/eap
CMD ["/opt/eap/bin/openshift-launch.sh"]

EXPOSE 8080 8443
