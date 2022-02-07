#!/bin/bash

set -e -u -o pipefail
ROOTDIR=$(cd "$(dirname "$0")" && pwd)
: ${IMAGE_NAME:=ghcr.io/hyperledgendary/hlfsupport-in-a-box:main}

mkdir -p ${ROOTDIR}/_cfg

if [ ! -f cfg.env ]; then
  echo "Please ensure a cfg.env file is present"
  exit 1
fi

# If you want to adjust or develop the scripts used, then adjust the workspace mount point
# Use "-v ${ROOTDIR}:/workspace/" to mount the whole directory

# attach these to the host network so it's easier for networking and map in the kubeconfig location
# docker run --env-file cfg.env -it --network=host -v /var/run/docker.sock:/var/run/docker.sock  -v ${ROOTDIR}/_cfg:/workspace/_cfg ${IMAGE_NAME} network

docker run --env-file cfg.env -it --network=host --entrypoint bash -v /var/run/docker.sock:/var/run/docker.sock  -v ${ROOTDIR}/_cfg:/workspace/_cfg ${IMAGE_NAME} 
