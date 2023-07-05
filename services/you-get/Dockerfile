FROM python:3.11.4-alpine3.18

RUN set -xe \
    && apk update \
    && apk add --no-cache ca-certificates ffmpeg openssl mpv \
    && pip3 install you-get \
    && mkdir -p /download

# Try to run it so we know it works
RUN you-get --version

WORKDIR /download

# ENTRYPOINT ["you-get"]
# CMD ["--help"]