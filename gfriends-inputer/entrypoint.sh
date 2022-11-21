#!/usr/bin/env sh

set -eu

# update ini key value if env name has set
update_if() {
    name=$1
    sec=$2
    key=$3
    # get value by dynamic var name in posix sh
    value="$(eval "echo \"\${$name:-}\"")"
    if [ -n "$value" ] && [ "$(crudini --get "$CONFIG_PATH" "$sec" "$key")" != "$value" ]; then
        echo "updating $sec.$key to $value"
        crudini --set --existing "${CONFIG_PATH}" "$sec" "$key" "$value"
    fi
}

if [ ! -f "$CONFIG_PATH" ]; then
    echo "not found config in $CONFIG_PATH"
    exit 1
fi

update_if GF_HOST_API 媒体服务器 Host_API
update_if GF_HOST_URL 媒体服务器 Host_Url
# update_if GF_DOWNLOAD_PATH 下载设置 Download_Path

exec python3 "./Gfriends Inputer.py" "$@"
