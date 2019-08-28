# FROM jenkins/jenkins:lts
FROM jenkins/jenkins:2.176.2

LABEL maintainer Leonard Lee <sheeeng@gmail.com>

ARG DOCKER_VERSION=18.06.3~ce~3-0~debian

# https://github.com/hadolint/hadolint/wiki/DL4006#correct-code
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3002
USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes --no-install-recommends \
    apt-transport-https=1.4.9 \
    ca-certificates=20161130+nmu1+deb9u1 \
    curl=7.52.1-5+deb9u9 \
    gnupg2=2.1.18-8~deb9u4 \
    software-properties-common=0.96.20.2-1 \
    sudo=1.8.19p1-2.1 \
    && apt-get autoremove --assume-yes \
    && rm --recursive --force /var/lib/apt/lists/*

RUN curl \
    --fail \
    --silent \
    --show-error \
    --location https://download.docker.com/linux/debian/gpg \
    | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
    docker-ce="${DOCKER_VERSION}" \
    && apt-get autoremove --assume-yes \
    && rm --recursive --force /var/lib/apt/lists/*

ENV UID_JENKINS=1000
ENV GID_JENKINS=1000

COPY docker-entrypoint.sh /docker-entrypoint.sh

# User root is needed for docker-entrypoint.sh script.
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
