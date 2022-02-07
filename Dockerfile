#
# SPDX-License-Identifier: Apache-2.0
#
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

# Build tools
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y --no-install-recommends install curl build-essential gcc gzip \
    python3.8 python3-distutils libpython3.8-dev software-properties-common zip unzip \
    git jq\       
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://get.docker.com/ | sh 
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

WORKDIR /workspace
RUN curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh \
    && ./install-fabric.sh binary samples

COPY scripts /workspace/scripts
# COPY utility /workspace/utility
# COPY playbooks /workspace/playbooks
COPY justfile /workspace/
# RUN . /root/.nvm/nvm.sh && npm --prefix /workspace/utility/ibp_hlf_versions install


ENTRYPOINT ["just"]