# AriaNg, a modern web frontend making aria2 easier to use. https://github.com/mayswind/AriaNg
ARG ARIANG_VERSION=1.3.2
# Yet Another Clash Dashboard https://github.com/haishanh/yacd
ARG YACD_VERSION=0.3.8
ARG WEBSITE_DIR=/var/www

FROM debian:11-slim as builder

ARG ARIANG_VERSION
ARG YACD_VERSION
ARG WEBSITE_DIR

ENV APT_MIRROR=http://mirrors.ustc.edu.cn \
    DEBIAN_FRONTEND=noninteractive \
    WEBSITE_DIR_YACD=${WEBSITE_DIR}/yacd/public \
    WEBSITE_DIR_ARIANG=${WEBSITE_DIR}/ariang/public

RUN set -eu; \
    sed -ri "s@^([^#]*)http[s]?://[^/\.]+(\.[^/\.]+)+@\1${APT_MIRROR}@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y unzip curl xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p "${WEBSITE_DIR}"

RUN set -eu; \
    # install ariang
    mkdir -p "${WEBSITE_DIR_ARIANG}" && \
    curl -m 10 -o ariang.zip -L "https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip" && \
    unzip ariang.zip -d "${WEBSITE_DIR_ARIANG}" && \
    rm ariang.zip && \
    \
    # install yacd
    mkdir -p "${WEBSITE_DIR_YACD}" && \
    curl -m 10 -L "https://github.com/haishanh/yacd/releases/download/v${YACD_VERSION}/yacd.tar.xz" | \
    tar -xJf - --strip-components 1 -C "${WEBSITE_DIR_YACD}"

FROM nginx:1.23-alpine
ARG WEBSITE_DIR
COPY --from=builder "${WEBSITE_DIR}" "${WEBSITE_DIR}"
