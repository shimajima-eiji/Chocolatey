# !/bin/bash

repository=${1:-Chocolatey}
account=${2:-shimajima-eiji}
work_directory=${3:-~/cron}

commit_message="[$(date '+%Y/%m/%d')][CHANGELOG] 最新化"
github_changes_path="/usr/local/bin/github-changes"

if [ ! "${work_directory}" -o ! "${account}" -o ! "${repository}" ]; then
  echo "[ERROR] required construction."
  exit 1
fi

cd ${work_directory}
if [ ! "${work_directory}" = $(pwd) ]; then
  echo "[ERROR] failed change directory: ${repository_path}"
  echo "HINT: path is directory? or already exist?"
  exit 1
fi

# clone temp dir
if [ ! "${repository}" = $(basename $(pwd)) ]; then
  echo "create directory for temporary of clone"
  clone_flg=true
  git clone git@github.com:${account}/${repository}.git
  #git clone https://github.com/${account}/${repository}.git
  cd ${repository}

  if [ ! "${repository}" = $(basename $(pwd)) ]; then
    echo "[ERROR] can't complete: git clone git@github.com:${account}/${repository}.git / CURRENT: $(pwd)"
    exit 1
  fi
else
  git pull
fi

curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- -s ${repository}
git commit -a -m "${commit_message}"
git push

# remove temp dir
if [ "${clone_flg}" = true ]; then
  if [ "${repository}" = $(basename $(pwd)) ]; then
    echo "clean directory for temporary of clone"
    cd ../
    rm -rf "${repository}"
  fi
fi
