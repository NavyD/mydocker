# Rest Server is a high performance HTTP server that implements restic's REST backend API. https://github.com/restic/rest-server
ARG RESTSERVER_VERSION=0.11.0
ARG BIN_PATH=/usr/local/bin/rest-server

FROM debian:11-slim as builder

ARG RESTSERVER_VERSION
ARG BIN_PATH

ARG TARGETARCH
ARG TARGETVARIANT
ARG TARGETOS

ENV APT_MIRROR=http://mirrors.ustc.edu.cn \
    DEBIAN_FRONTEND=noninteractive
RUN set -eu; \
    sed -ri "s@^([^#]*)http[s]?://[^/\.]+(\.[^/\.]+)+@\1${APT_MIRROR}@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN set -eu; \
    bin_dir="$(dirname ${BIN_PATH})" && \
    mkdir -p "$bin_dir" && \
    curl -L "https://github.com/restic/rest-server/releases/download/v${RESTSERVER_VERSION}/rest-server_${RESTSERVER_VERSION}_${TARGETOS}_${TARGETARCH}${TARGETVARIANT}.tar.gz" | \
    # extract to specify dir
    tar --strip-components 1 --wildcards -C "$bin_dir" -xzf - '*/rest-server' && \
    # mv error: xxx are the same file. -n: do not overwrite an existing file
    mv -n "$bin_dir/rest-server" ${BIN_PATH} && \
    chmod +x "${BIN_PATH}" && \
    # check version
    "${BIN_PATH}" --version | grep "${RESTSERVER_VERSION}"

FROM alpine:3.14
ARG BIN_PATH
COPY --from=builder ${BIN_PATH} ${BIN_PATH}
VOLUME /data

# ENTRYPOINT [ "rest-server", "--listen", "8000", "--path", "/data", "--append-only", "" ]
ENTRYPOINT [ "${BIN_PATH}" ]
