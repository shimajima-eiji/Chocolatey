#!/bin/bash
<<README
# 使い方
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | bash -s -- （ここにオプション）

e.g.:
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | bash -s -- -s Chocolatey

引数ごとに異なる振る舞いをします。
特にsオプションとfオプションです。

## --simple
私のためだけに作ったような機能です。
リポジトリを入れるだけで所定のフォーマットで出力します

## --free (not recommend)
従来のgithub-changes （オプション）を使いたい場合を想定していますが、これを経由するぐらいなら素直に自分でgithub-changesを呼び出したほうが良いです。
これがなくなればbashである必要がなくなりますので、廃止しようかと思っています。

# 参照
https://github.com/shimajima-eiji/Github_scout/wiki/【手引】更新履歴（CHANGELOG.md）

# 謝辞
本来であれば$3をowner、$4をbranchとするのが筋ですが、自分で使う事を想定しているので、$3をbranchとしています。
ぶっちゃけ横着です、気に入らない場合はforkして書き換えてください

README

help() {
  cat <<help
Usage: $(basename "$0") [OPTION]...
  1:-token        your's token (require:repo)
  2:(required)    name of the Github repository
  3:-master       branch
  4:-CHANGELOG.md filepath
help
}

if [ ! $(which github-changes) ]; then
  help
  exit 1
fi
if [ ! $(which github-changes) ]; then
  help
  exit 1
fi

### 引数処理
token=${GITHUB_TOKEN}
git branch >/dev/null 2>&1
if [ $? = 0 ]; then
  repository=$(basename $(git rev-parse --show-toplevel))
else
  repository=$1
fi

if [ ! "${token}" -o ! "${repository}" ]; then
  help
  exit 1
fi
branch=${2:-$(git rev-parse --abbrev-ref @)}
filepath=${3:-CHANGELOG.md}

### 定数
owner=$(git config user.name)

### main
github-changes -o ${owner} -r ${repository} -b ${branch} --use-commit-body -t "更新履歴" -z Asia/Tokyo -m "YYYY年M月D日" -n "最終更新" -a -f tmp -k ${token}
github_changelog_generator -u ${owner} -p ${repository} -t ${token} -o ${filepath}
cat tmp >>${filepath}
echo "" >>${filepath}
rm tmp
echo "[update_CHANGELOG] script completed!"
