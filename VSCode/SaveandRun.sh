#!/usr/bin/env sh
### TODO #3 use wssh.py for .py
cd $(dirname $0)

fromfile=$1  # wslpath '${file}'
if [ "$(basename ${fromfile})" = 'SaveandRun.sh' ];then
  exit 0
fi

### option
if [ ! "$(echo ${fromfile} | grep .py$)" = '' ]; then
  # Required: pip install pyformat, isort
  pyformat -i ${fromfile}
  isort ${fromfile}
  cmd='python3'
elif  [ ! "$(echo ${fromfile} | grep .sh$)" = '' ]; then
  cmd='bash'
fi

### convert from -> to
path_convert="$(sh path_convert.sh ${fromfile})"
tofile=$(echo ${path_convert} | cut -f1 -d' ')
local=$(echo ${path_convert} | cut -f2 -d' ')
host=$(echo ${path_convert} | cut -f3 -d' ')
pass=$(echo ${path_convert} | cut -f4 -d' ')

### for run to local
if [ "$(hostname)" = "${local}" ]; then
  ${cmd} ${fromfile}
  exit 0
fi

### [TODO] #4 ../../utils/snippet/shell/easy_ssh.sh
# send(Required .ssh/config)
sshpass=''
if [ ! "${pass}" = '' ]; then
  sshpass="sshpass -p ${pass}"
fi

${sshpass} ssh ${host} "mkdir -p $(dirname ${tofile})"
${sshpass} scp ${fromfile} ${host}:${tofile}
${sshpass} ssh ${host} "${cmd} ${tofile}"
