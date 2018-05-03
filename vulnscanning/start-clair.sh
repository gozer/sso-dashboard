#!/bin/bash

BEFORE_IMAGE="arminc\/clair-db:TODAYS_DATE"
DATE=`date +%m-%d-%Y`
AFTER_IMAGE="arminc\/clair-db:${DATE}"

sed s/$BEFORE_IMAGE/$AFTER_IMAGE/g docker-compose.yml.template > docker-compose.yml

docker-compose up -d postgres

sleep 3

docker-compose up

curl -sL https://github.com/arminc/clair-scanner/releases/download/v8/clair-scanner_linux_amd64 -o clair-scanner

chmod +x clair-scanner

clair-scanner --clair=${CLAIR} --ip $(hostname -i) ansible_web
