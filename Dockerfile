FROM ubuntu:16.04

MAINTAINER ludovic.claude@chuv.ch

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

########################################################################################################################
# Install build requirements
########################################################################################################################

RUN apt-get update \
    && apt-get install -y sudo shellcheck python-pip git libffi-dev curl  python-pexpect python3-pexpect software-properties-common \
    && apt-get install -y --no-install-recommends expect \
    && add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) multiverse" \
    && apt-get update \
    && perl -p -i -e 's/%sudo\s*ALL=\(ALL:ALL\) ALL/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers \
    && addgroup tester \
    && adduser --quiet --system --disabled-password --group tester \
    && adduser tester sudo \
    && pip install pre-commit==1.3.0 ansible-lint \
    && mkdir -p /home/tester/Desktop \
    && chmod -R u+rwX /home/tester/Desktop \
    && export GOSU_VERSION=1.10 \
    && GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
    && GOSU_DOWNLOAD_SIG="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
    && GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4" \
    && (gpg --keyserver pgp.mit.edu --recv-keys $GOSU_DOWNLOAD_KEY || gpg --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys $GOSU_DOWNLOAD_KEY) \
    && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
    && curl -sSL "$GOSU_DOWNLOAD_URL" > gosu-amd64 \
    && curl -sSL "$GOSU_DOWNLOAD_SIG" > gosu-amd64.asc \
    && gpg --verify gosu-amd64.asc \
    && rm -f gosu-amd64.asc \
    && mv gosu-amd64 /usr/bin/gosu \
    && chmod +x /usr/bin/gosu \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/{cache,log}/* \
    && mkdir -p /var/cache/apt/archives/partial \
    && echo -n > /var/lib/apt/extended_states

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="hbpmip/ubuntu-for-ci" \
      org.label-schema.description="Ubuntu for continuous integration build" \
      org.label-schema.url="https://github.com/HBPMedical/ubuntu-for-ci" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/HBPMedical/ubuntu-for-ci" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="$VERSION" \
      org.label-schema.vendor="LREN CHUV" \
      org.label-schema.license="Apache2.0" \
      org.label-schema.docker.dockerfile="Dockerfile" \
      org.label-schema.schema-version="1.0"
