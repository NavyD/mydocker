# syntax=docker/dockerfile:1 # buildkit

# [Gfriends Inputer 一键导入工具](https://github.com/gfriends/gfriends-inputer)
# warn: Cannot run on alpine platform
FROM --platform=$TARGETPLATFORM python:3.9-slim

ENV PROJECT_DIR="/gfriends-inputer"
RUN set -eu; \
    export DEBIAN_FRONTEND="noninteractive"; \
    ver="v3.03"; \
    apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* && \
    mkdir -p $PROJECT_DIR && \
    wget -O- "https://github.com/gfriends/gfriends-inputer/archive/${ver}.tar.gz" | \
    tar xz -C $PROJECT_DIR --strip-components 1
# RUN set -eu; \
#     tag="v3.03"; \
#     tmpfile="$(mktemp)"; \
#     wget -O "$tmpfile" "https://github.com/gfriends/gfriends-inputer/releases/download/$tag/Gfriends-Inputer-Linux-$tag.zip" && \
#     mkdir -p /gfriends-inputer && \
#     unzip $tmpfile -d /gfriends-inputer && \
#     chmod +x "/gfriends-inputer/Gfriends Inputer" && \
#     rm -rf $tmpfile
WORKDIR ${PROJECT_DIR}
RUN set -eu; \
    pip3 install -r requirements.txt && \
    # [AttributeError: partially initialized module 'cv2' has no attribute 'gapi_wip_gst_GStreamerPipeline' (most likely due to a circular import)](https://stackoverflow.com/a/72757694/8566831)
    pip uninstall -y opencv-python && \
    pip uninstall -y opencv-contrib-python && \
    pip uninstall -y opencv-contrib-python-headless && \
    pip install opencv-python-headless==4.5.5.64 && \
    # check and generate config.ini in cur dir
    python3 "./Gfriends Inputer.py"
ENV CONFIG_PATH="${PROJECT_DIR}/config.ini"
VOLUME [ "/data" ]
RUN pip3 install crudini && \
    crudini --version && \
    crudini --set --existing "${CONFIG_PATH}" '下载设置' 'Download_Path' /data

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
