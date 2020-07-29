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

README

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

    # 三項演算子が使えない：https://qiita.com/kokorinosoba/items/2f95ffd897b8ba2fe0de
    if [ "$3" ]; then
      owner="$3"
    else
      owner="shimajima-eiji"
    fi
    ;;

  h | '--help')
    help
    exit 1
    ;;
  esac
done

if [ ! "$owner" -o ! "$repository" ]; then
  github-changes -h
  exit 1
fi

github-changes -o $owner -r $repository --use-commit-body -t "更新履歴" -z Asia/Tokyo -m "YYYY年M月D日" -n "最終更新"
echo "script completed!"
