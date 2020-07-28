#!/bin/bash
while :
do
  echo "`date` `docker container stats --no-stream ngnix | grep ngnix`" > /var/log/docker-nginx.log
  sleep 10
done