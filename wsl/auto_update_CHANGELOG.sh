# !/bin/bash
<<README
すぐ使えるように引数に初期値を設定している。
### main以前までを編集して使うこと。
README

repository=${1:-Chocolatey}
branch=${2:-master}
cpmaster=${3:-true}
account=${4:-shimajima-eiji}
work_directory=${5:-~/cron} # ※cronでロギングしているので、変更時は呼び出し側も対応する

### main

commit_message="[$(date '+%Y/%m/%d')][CHANGELOG] 最新化"
commit_other="[$(date '+%Y/%m/%d')][CHANGELOG][${branch}] 最新化"
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
  git clone -b ${branch} git@github.com:${account}/${repository}.git
  cd ${repository}

  if [ ! "${repository}" = $(basename $(pwd)) ]; then
    echo "[ERROR] can't complete: git clone git@github.com:${account}/${repository}.git / CURRENT: $(pwd)"
    exit 1
  fi
else
  git pull
fi

curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- -s ${repository} ${branch} false ${account}
git add -A
git commit -a -m "${commit_message}"
git push

# remove temp dir
if [ "${clone_flg}" = true ]; then
  if [ "${repository}" = $(basename $(pwd)) ]; then
    echo "clean directory for temporary of clone"
    cd ../
    rm -rf "${repository}"
  fi

  # cpmaster
  if [ ! "$cpmaster" -o "${branch}" = "master" ]; then
    exit 0
  fi

  git clone -b master git@github.com:${account}/${repository}.git
  cd ${repository}

  if [ ! "${repository}" = $(basename $(pwd)) ]; then
    echo "[ERROR] can't complete: git clone git@github.com:${account}/${repository}.git / CURRENT: $(pwd)"
    exit 1
  fi

  curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- -s ${repository} ${branch} true ${account}
  curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- -s ${repository} master false ${account}
  git add -A
  git commit -a -m "${commit_other}"
  git push

  if [ "${repository}" = $(basename $(pwd)) ]; then
    echo "clean directory for temporary of clone"
    cd ../
    rm -rf "${repository}"
  fi

fi
