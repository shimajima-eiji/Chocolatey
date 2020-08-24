# !/bin/bash -l
<<README
すぐ使えるように引数に初期値を設定している。
自分で使う場合はforkしてこれとupdate_CHANGELOG.shの定数を書き換える

# 使い方
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/autopush.sh 2>/dev/null | bash

GITHUB_TOKENを環境変数として登録しておく必要があるためbashを強制する

README

### 引数処理
repository=${1}
echo "[INFO] ${repository} のautopushを実行..."
if [ ! "${repository}" -o ! "${GITHUB_TOKEN}" ]; then
  echo '[ERROR] $1:repository と 環境変数：$GITHUB_TOKEN は必須'
  exit 1
fi

### 定数
account=$(git config user.name)
today=$(date '+%Y/%m/%d')
sh_url=https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/update_CHANGELOG.sh
current=~/cron
mkdir -p ${current}

### main
cd ${current}
message="[${today}][CHANGELOG][jp2en] 最新化"
branch_update_flag="false"

script=$(curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/translate.sh 2>/dev/null)
mkdir -p CHANGELOG
for branch in ${@:2}; do
  echo "[INFO] ${branch} のautopushを実行"
  branch_update_flag="true"
  git clone -b ${branch} git@github.com:${account}/${repository}.git
  cd ${repository}
  curl -sf ${sh_url} | sh -s -- ${GITHUB_TOKEN} ${repository} ${branch}
  cp CHANGELOG.md ../CHANGELOG/${branch}.md
  if [ $? = 1 ]; then
    echo "[ERROR] curl result. ${repository};${branch}"
    cd -
    rm -rf ${repository}
    continue
  fi
  bash <(echo ${script}) # [TODO] ここで異常な動作を起こすかも知れない
  git add -A
  git commit -a -m "${message}"
  git tag -a v${today} -m "当日分の全コミット"
  rm .git/hooks/pre-push
  git push origin --tags
  git push
  cd -
  rm -rf ${repository}

  echo "[COMPLETE] ${branch} のautopushが完了"
done

git clone git@github.com:${account}/${repository}.git
cd ${repository}
if [ ${branch_update_flag} = "true" ]; then
  mv -f ../CHANGELOG/* CHANGELOG
  rm -rf ../CHANGELOG
fi
curl -sf ${sh_url} | sh -s -- ${GITHUB_TOKEN} ${repository} master
if [ $? = 1 ]; then
  echo "[ERROR] curl result. ${repository}:master"
  cd -
  rm -rf ${repository}
  exit 1
fi
git add -A
git commit -a -m "${message}"
git tag -a v${today} -m "当日分の全コミット"
rm .git/hooks/pre-push
git push origin --tags
git push
cd -
rm -rf ${repository}
echo "[COMPLETE] ${repository}:master のautopushが完了"
