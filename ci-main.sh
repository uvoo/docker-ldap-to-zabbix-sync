#!/usr/bin/env bash
set -e

echo "Style check."
# pip install flake8 && flake8 zabbix-ldap.conf  # Not ready yet

apt-get install -y gettext-base
envsubst < zabbix-ldap.conf.envsubst > zabbix-ldap.conf

echo "Build and push docker container to Dockerhub."
release=latest
docker build --tag uvoo/ldap-to-zabbix-sync :$release .
echo $DOCKERHUB_TOKEN | docker login --username $DOCKERHUB_USERNAME --password-stdin
docker push uvoo/ldap-to-zabbix-sync :$release
docker logout
