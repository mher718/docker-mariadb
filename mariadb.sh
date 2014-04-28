#!/usr/bin/env bash

if [ -f ~/.docker_containers ]; then
    . ~/.docker_containers
fi

function initial {

mariadb_id=`docker run -d -p 3306 -e MYSQL_ROOT_PASSWORD=passw0rd mariadb`

grep -sv ' mariadb=' ~/.docker_containers > 1; mv 1 ~/.docker_containers
echo "export mariadb='$mariadb_id'" >> ~/.docker_containers
. ~/.docker_containers
}

case $1 in
   start)
      docker start $mariadb
      ;;
   stop)
      docker stop $mariadb
      ;;
   restart)
      docker restart $mariadb
      ;;
   init)
     initial
     ;;
   *)
     echo "$0 [init|start|stop|restart]"
    ;;
esac
