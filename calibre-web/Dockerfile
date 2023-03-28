# [calibre-web电子书管理带ebook-convert转换，并集成calibre的calibre-server服务](https://github.com/gshang2017/docker/tree/master/calibre-web)
FROM johngong/calibre-web:0.6.20-5.44.0

# # [calibre-web-douban-api 新版calibre-web已经移除douban-api了，添加一个豆瓣api实现](https://github.com/fugary/calibre-web-douban-api)
ARG CALIBRE_WEB_DOUBAN_API_VERSION=1.1.2

RUN set -eu; \
    # 添加NewDouban插件 https://github.com/gshang2017/docker/blob/6004dd994eea4c0ecad51a09b1d5099f8581435a/calibre-web/Dockerfile#L56-L62
    wget -O /usr/local/calibre-web/app/cps/metadata_provider/NewDouban.py "https://github.com/fugary/calibre-web-douban-api/releases/download/v${CALIBRE_WEB_DOUBAN_API_VERSION}/NewDouban.py"
