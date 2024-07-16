#!/bin/bash
sudo systemctl restart docker
docker run --rm -e MYSQL_ALLOW_EMPTY_PASSWORD=1 -p 3306:3306 mysql:8.0.38
