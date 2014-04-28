FROM ubuntu:latest
MAINTAINER Sergey Shkolin <sergey@shkolin.net.ua>

# Common
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y --force-yes python-software-properties

# install mariadb
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://download.nus.edu.sg/mirror/mariadb/repo/5.5/ubuntu precise main'
RUN apt-get update -qq
RUN apt-get install -y --force-yes mariadb-server

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

#VOLUME ["/var/lib/mysql"]
EXPOSE 3306
CMD ["/usr/local/bin/run"]
