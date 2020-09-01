#!/bin/sh
pull()
{
  before=$1
  path=$2

  cd "${path}"
  if [ "$(git rev-parse --show-toplevel)" = "${before}" ];then
    echo "${before}"
    exit 1
  fi

  curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/update_clones.sh 2>/dev/null | sh -s -- "${path}"
  git rev-parse --show-toplevel
}

path="(your path)"
# 単一実行の場合
before=$(pull "" "${path}")

# 複数実行の場合
for path in $(find "${path}" -type d -not -path '*/node_modules/*' -not -path '*/.*/*'); do
  after=$(pull "${before}" "${path}") 2>/dev/null
  if [ $? = 0 ];then
    echo "[complete] ${after}"
    before=${after}
  fi
done
