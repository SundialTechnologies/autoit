FROM debian:buster-slim as wine-img

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install AutoIt
ARG AUTOIT_VERSION=v3.3.14.5
ADD https://www.autoitscript.com/autoit3/files/archive/autoit/autoit-${AUTOIT_VERSION}.zip /autoit.zip
RUN unzip -n -j  /autoit.zip 'install/Aut2Exe/*' -d '/autoit/'

FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps xvfb gosu x11vnc x11-utils fluxbox wmctrl nano \
    && rm -rf /var/lib/apt/lists/*

# Install some tools required for creating the image
# Install wine and related packages
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    wine \
    wine32 \
    osslsigncode \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=wine-img /autoit /autoit

COPY bootstrap.sh /
COPY entrypoint.sh /
RUN chmod +x /bootstrap.sh \
    && chmod +x /entrypoint.sh

WORKDIR /work
ENTRYPOINT ["/entrypoint.sh"]