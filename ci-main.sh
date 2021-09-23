#!/usr/bin/env bash
set -e

echo "Style check."
# pip install flake8 && flake8 zabbix-ldap.conf  # Not ready yet

echo "Build and push docker container to Dockerhub."
release=latest
tag="uvoo/ldap-to-zabbix-sync:$release"
docker build --tag $tag .
echo $DOCKERHUB_TOKEN | docker login --username $DOCKERHUB_USERNAME --password-stdin
docker push $tag 
docker logout
