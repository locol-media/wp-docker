#!/bin/bash

export CONTAINER_REGISTRY=locolmedia
export CONTAINER_NAME=sample_container


sudo docker run -d --name wp-docker \
      -p 80:8080 \
       --restart unless-stopped \
      ${CONTAINER_REGISTRY}/${CONTAINER_NAME}:latest \