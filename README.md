# Docker-centos-7-systemd-tomcat

Base image for fast create app-containers

* Systemd enables by official documentation: https://hub.docker.com/_/centos/
  * Also look at
    - https://rhatdan.wordpress.com/2014/04/30/running-systemd-within-a-docker-container/
    - https://maci0.wordpress.com/2014/07/23/run-systemd-in-an-unprivileged-docker-container/ (https://github.com/maci0/docker-systemd-unpriv/blob/master/Dockerfile)
* Based on latest CentOs 7 image
* Include next main packages:
  * `systemd` as service
  * `tomcat` 8 run as service.
* By default exposed port `8080`

## Built nesting dockerized apps

Example of `Dockerfile` for raw `war` files:

    FROM taskdata/docker-centos-7-systemd-tomcat
    MAINTAINER Pavel Alexeev
    COPY *.war /var/lib/tomcat/webapps/

If you are using rpm (recommended):

    FROM taskdata/docker-centos-7-systemd-tomcat
    MAINTAINER Pavel Alexeev
    COPY *.rpm /
    RUN yum install -y /*.rpm \
        && yum clean all

## Run and use built app

Unfortunately to run it in un-privileged mode you must provide volume `/sys/fs/cgroup` from host. F.e.:

    docker run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name lesegais docreg.some.host/lesegais:latest

Then you may access you application.