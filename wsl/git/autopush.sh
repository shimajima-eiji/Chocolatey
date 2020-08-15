# !/bin/bash
<<README
すぐ使えるように引数に初期値を設定している。
自分で使う場合はforkしてこれとupdate_CHANGELOG.shの定数をを書き換えてください
README

### 引数処理
token=${1}
repository=${2}
if [ ! "${repository}" -o ! "${token}" ]; then
  echo '[ERROR] $1:repository と $2:token(repo) は必須'
  exit 1
fi

### 定数
account=shimajima-eiji
today=$(date '+%Y/%m/%d')
sh_url=https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/update_CHANGELOG.sh
current=~/cron
mkdir -p ${current}

### main
cd ${current}
message="[${today}][CHANGELOG] 最新化"
branch_update_flag="false"

mkdir -p CHANGELOG
for branch in ${@:3}; do
  branch_update_flag="true"
  git clone -b ${branch} git@github.com:${account}/${repository}.git
  cd ${repository}
  curl -sf ${sh_url} | sh -s -- ${token} ${repository} ${branch}
  if [ $? = 1 ]; then
    echo "[ERROR] curl result. ${repository};${branch}"
    cd -
    rm -rf ${repository}
    continue
  fi
  git add -A
  git commit -a -m "${message}"
  git tag -a v${today} -m "当日分の全コミット"
  rm .git/hooks/pre-push
  git push origin --tags
  git push
  cd -
  rm -rf ${repository}

  curl -sf ${sh_url} | sh -s -- ${token} ${repository} ${branch} ../CHANGELOG/${branch}.md
  echo "[COMPLETE] ${repository}:${branch}"
done

git clone git@github.com:${account}/${repository}.git
cd ${repository}
if [ ${branch_update_flag} = "true" ]; then
  mv -f ../CHANGELOG CHANGELOG
fi
curl -sf ${sh_url} | sh -s -- ${token} ${repository} master
if [ $? = 1 ]; then
  echo "[ERROR] curl result. ${repository}:master"
  cd -
  rm -rf ${repository}
  continue
fi
git add -A
git commit -a -m "${message}"
git tag -a v${today} -m "当日分の全コミット"
rm .git/hooks/pre-push
git push origin --tags
git push
cd -
rm -rf ${repository}
