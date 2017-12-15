#!/bin/bash

# one-time script to get a kata's dir out of the storer volume.

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"

readonly ID=${1:-D451E3147C}
readonly ID2=${ID:0:2}  # D4
readonly ID8=${ID:2:8}  # 51E3147C
readonly CONTAINER_NAME=cyber-dojo-katas-DATA-CONTAINER
readonly VOLUME_PATH=/usr/src/cyber-dojo/katas

docker run --rm \
  --volumes-from ${CONTAINER_NAME}:ro \
  --volume ${MY_DIR}:/get:rw \
  alpine:latest \
  tar -zcf /get/get_${ID2}${ID8}.tgz -C ${VOLUME_PATH}/${ID2} ${ID8}

mkdir ${MY_DIR}/${ID2}
mv ${MY_DIR}/get_${ID2}${ID8}.tgz ${ID2}
cd ${MY_DIR}/${ID2}
tar -xf get_${ID2}${ID8}.tgz
rm ${MY_DIR}/${ID2}/get_${ID2}${ID8}.tgz
