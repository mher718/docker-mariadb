FROM ubuntu:14.04
MAINTAINER Sergey Shkolin <sergey@shkolin.net.ua>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update ; \
    apt-get install -y --force-yes python-software-properties

# install mariadb
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db ; \
    add-apt-repository 'deb http://download.nus.edu.sg/mirror/mariadb/repo/5.5/ubuntu precise main' ; \
    apt-get update -qq ; \
    apt-get install -y --force-yes mariadb-server

ADD my.cnf /etc/mysql/my.cnf
RUN chmod 664 /etc/mysql/my.cnf
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 3306
CMD ["/usr/local/bin/run"]
