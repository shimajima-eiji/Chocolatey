#!/bin/bash
<<README
# 使い方
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- （ここにオプション）

e.g.:
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s -- -s Chocolatey

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

github_changes_fullpath=/usr/local/bin/github-changes # うまく行かない場合は、$(which github-changes)を参照する

help() {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h, --help          Display help
  -o, --owner         (required) owner of the Github repository
  -r, --repository    (required) name of the Github repository
EOM
}

while getopts ":f:o:r:s:h" optKey; do
  case "$optKey" in
  o)
    owner="${OPTARG}"
    ;;
  r)
    repository="${OPTARG}"
    ;;
  f | '--free')
    p=$(ps --pid $$ -o command | tail -1)
    if echo "$p" | grep '^bash '; then
      github-changes ${@:2}
    else
      echo 'This option is required Bash'
    fi
    exit 1
    ;;
  s | '--simple')
    repository=$2
    branch=${3:-master}
    filepath=${4:-false}
    owner=${5:-shimajima-eiji}

    if [ "${filepath}" ]; then
      target="CHANGELOG"
      mkdir ${target}
      filepath="${target}/${branch}.md"
    else
      filepath="CHANGELOG.md"
    fi
    ;;

  h | '--help')
    help
    exit 1
    ;;
  esac
done

if [ ! "$owner" -o ! "$repository" ]; then
  ${github_changes_fullpath} -h
  exit 1
fi

${github_changes_fullpath} -o ${owner} -r ${repository} -b ${branch} --use-commit-body -t "更新履歴" -z Asia/Tokyo -m "YYYY年M月D日" -n "最終更新" -a -f ${filepath}
echo "script completed!"
