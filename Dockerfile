FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine318

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOSBOX_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="tiorac"

# title
ENV TITLE=DOSBox

# add local files
COPY /root /

RUN \
  echo "**** install packages ****" && \
  if [ -z ${DOSBOX_VERSION+x} ]; then \
    DOSBOX_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.18/community/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:dosbox$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add --no-cache \
    dosbox==${DOSBOX_VERSION} && \
  sed -i 's|</applications>|  <application title="DOSBox" type="normal">\n    <maximized>yes</maximized>\n  </application>\n</applications>|' /etc/xdg/openbox/rc.xml && \
  chmod +x /app/startdosbox.sh && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# ports and volumes
EXPOSE 3000

VOLUME /config