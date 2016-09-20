# https://hub.docker.com/_/centos/
FROM centos:7
MAINTAINER Pavel Alexeev

# Systemd enable by official documentation: https://hub.docker.com/_/centos/
# https://rhatdan.wordpress.com/2014/04/30/running-systemd-within-a-docker-container/
# https://maci0.wordpress.com/2014/07/23/run-systemd-in-an-unprivileged-docker-container/ (https://github.com/maci0/docker-systemd-unpriv/blob/master/Dockerfile)
ADD https://raw.githubusercontent.com/maci0/docker-systemd-unpriv/master/dbus.service /etc/systemd/system/dbus.service

ENV container docker
RUN yum -y install systemd systemd-libs dbus && \
    systemctl mask dev-mqueue.mount dev-hugepages.mount systemd-remount-fs.service sys-kernel-config.mount \
        sys-kernel-debug.mount sys-fs-fuse-connections.mount display-manager.service graphical.target systemd-logind.service && \
    yum -y install tomcat mutlitail && \
        systemctl enable tomcat && \
        systemctl enable dbus.service && \
    yum clean all

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

#? CMD ["/usr/lib/systemd/systemd"]
CMD ["/usr/sbin/init"]

EXPOSE 8080

## Separate install command to allow layers caching
#COPY *.rpm /
#RUN yum install -y /*.rpm \
#	&& yum clean all
