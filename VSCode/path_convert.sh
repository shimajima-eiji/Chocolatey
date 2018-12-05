#!/usr/bin/env sh
# [TODO] #4 move to replace.sh -> ../../utils/snippet/shell/replace.sh
set -u
path=$1
set +u

local="${2:-$(hostname)}"  # No need?
host="${3:-(hostname)}"  # No need?
pass="${4:-(pass)}"  # No need?

# replace path local tofile remote
path=$(echo ${path} | sed -e "s#^/mnt/c#~#g")
path=$(echo ${path} | sed -e "s#^/mnt/d#~#g")

# for result
echo "${path} ${local} ${host} ${pass}"
