#!/usr/bin/env sh
cd $(dirname $0)

fromfile=$1  # wslpath '${file}'
if [ "$(basename ${fromfile})" = 'SaveandRun.sh' -o ! "$(echo ${fromfile} | grep AppData/Roaming/Code/User/settings.json)" = '' ];then
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
elif  [ ! "$(echo ${fromfile} | grep .yaml$)" = '' ]; then
  cmd='ansible-playbook -i /etc/ansible/project/hosts'
else
  cmd=''
fi

### convert from -> to
path_config="$(sh path_config.sh ${fromfile})"
tofile=$(echo ${path_config} | cut -f1 -d' ')
local=$(echo ${path_config} | cut -f2 -d' ')
host=$(echo ${path_config} | cut -f3 -d' ')
pass=$(echo ${path_config} | cut -f4 -d' ')

### for run to local
if [ "$(hostname)" = "${local}a" ]; then
  if [ ! "${cmd}" = '' ]; then
    ${cmd} ${fromfile}
  fi
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
echo "${fromfile} ${tofile}"
echo "[complete] ${fromfile} -> ${host}:${tofile}"

if [ ! "${cmd}" = '' ]; then
  ${sshpass} ssh ${host} "${cmd} ${tofile}"
fi
