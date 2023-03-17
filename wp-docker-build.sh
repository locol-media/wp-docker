#!/bin/bash

export UPLOAD_SIZE=8M
export CONTAINER_REGISTRY=locolmedia
export CONTAINER_NAME=sample_container
export CONTAINER_TAG=NOW

export WORK_DIR=work

TIMESTAMP=`date +%y%m%d%H%M`

if [ "$CONTAINER_TAG" = "NOW" ]
 then
   export CONTAINER_TAG=$TIMESTAMP
 fi

sudo docker build \
 --build-arg UPLOAD_SIZE=${UPLOAD_SIZE} \
 --build-arg APACHE_SERVER_ADMIN=admin@dummyaccount.com \
 --build-arg WORDPRESS_FILES=${WORK_DIR}/tempwpfiles/ \
 -t ${CONTAINER_REGISTRY}/${CONTAINER_NAME}:latest \
 -t ${CONTAINER_REGISTRY}/${CONTAINER_NAME}:${CONTAINER_TAG} \
 . 

sudo docker push ${CONTAINER_REGISTRY}/${CONTAINER_NAME} -a