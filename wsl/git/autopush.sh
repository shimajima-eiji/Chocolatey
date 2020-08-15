# !/bin/bash
<<README
すぐ使えるように引数に初期値を設定している。
自分で使う場合はforkしてこれとupdate_CHANGELOG.shの定数をを書き換えてください
README

### 引数処理
repository=${1:-Chocolatey}
if [ "${repository}" ]; then
  echo '[ERROR] $1:repositoryは必須'
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

mkdir -p CHANGELOG
for branch in ${@:3}; do
  git clone -b ${branch} git@github.com:${account}/${repository}.git
  cd ${repository}
  git add -A
  git commit -a -m "${message}"
  git tag -a v${today} -m "当日分の全コミット"
  git push origin v${today}
  cd -
  rm -rf ${repository}
  curl -sf ${sh_url} | sh -s -- ${repository} ${branch} true
done

git clone -b ${branch} git@github.com:${account}/${repository}.git
cd ${repository}
curl -sf ${sh_url} | sh -s -- ${repository} master false
rm -rf CHANGELOG
mv ../CHANGELOG CHANGELOG
git add -A
git commit -a -m "${message}"
git tag -a v${today} -m "当日分の全コミット"
git push origin v${today}
cd -
rm -rf ${repository}
