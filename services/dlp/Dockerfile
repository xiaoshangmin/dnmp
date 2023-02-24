# https://github.com/gissehel/docker-youtube-dlp
FROM alpine:3.17.2

LABEL  maintainer="shangminxiao@gmail.com"

ARG LUX_VERSION=0.16.0

WORKDIR /downloads

RUN set -x \
 && apk add --no-cache ca-certificates curl ffmpeg python3 py-pip \
 # Install youtube-dlp
 && curl -Lo /usr/local/bin/dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
 && chmod a+rx /usr/local/bin/dlp \
 #Install lux
 && curl -Lo lux.tar.gz "https://github.com/iawia002/lux/releases/download/v${LUX_VERSION}/lux_${LUX_VERSION}_Linux_64-bit.tar.gz" \
 && tar xvf lux.tar.gz \
 && mv lux /usr/local/bin/lux \
 && chmod a+rx /usr/local/bin/lux \
 && rm -rf lux.tar.gz \
 # Install you-get
 && pip3 install you-get \
    # Clean-up
 && apk del curl \
    # Create directory to hold downloads.
#  && mkdir /downloads \
 && chmod a+rw /downloads \
    # Basic check it works.
 && mkdir -p /.cache \
 && chmod 777 /.cache

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

VOLUME ["/downloads"]

# ENTRYPOINT ["dlp"]
# CMD ["--help"]