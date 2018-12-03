#!/usr/bin/env sh
### TODO use wssh.py for .py
fromfile=$1

### option
if [ ! "$(echo ${fromfile} | grep .py$)" = '' ]; then
    pyformat -i ${fromfile}
    isort ${fromfile}
    cmd='python3'
elif  [ ! "$(echo ${fromfile} | grep .sh$)" = '' ]; then
    cmd='bash'
fi

### convert from -> to
from='/mnt/d/environment/Storage/OneDrive/WSL'
to='/opt/src'
tofile=$(echo ${fromfile} | sed "s#${from}#${to}#g")

### send(Required .ssh/config)
server='server'
pass='password'
sshpass -p "${pass}" scp ${server} ${fromfile} ${tofile}
sshpass -p "${pass}" ssh ${cmd} "${tofile}"
