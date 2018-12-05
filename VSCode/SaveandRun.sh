#!/usr/bin/env sh
### TODO #3 use wssh.py for .py
fromfile=$1
if [ "$(basename ${fromfile})" = 'SaveandRun.sh' ];then
  exit 0
fi

server='okamoto1'
pass=''

### option
if [ ! "$(echo ${fromfile} | grep .py$)" = '' ]; then
  pyformat -i ${fromfile}
  isort ${fromfile}
  cmd='python3'
elif  [ ! "$(echo ${fromfile} | grep .sh$)" = '' ]; then
  cmd='bash'
fi

if [ "$(hostname)" = 'DESKTOP-CO9ORBL' ]; then
  ${cmd} ${fromfile}
  exit 0
fi

to='~'  #to='/opt/src'
tofile=$(echo ${fromfile} | sed "s#${from}#${to}#g")

### send(Required .ssh/config)
sshpass=''
if [ ! "${pass}" = '' ]; then
  sshpass="sshpass -p ${pass}"
fi
echo "[ ${tofile} ]"
${sshpass} ssh ${server} "mkdir -p $(dirname ${tofile})"
${sshpass} scp ${fromfile} ${server}:${tofile}
${sshpass} ssh ${server} "${cmd} ${tofile}"
