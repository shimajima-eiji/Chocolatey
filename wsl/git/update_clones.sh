#!/bin/sh
<<README
CHANGELOG.mdを自動更新した時に、開発で使っている環境も更新してほしい時に自動化させる
誤作動防止のため、引数をフルパスで設定する必要がある。

# 使い方
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/update_clones.sh 2>/dev/null | sh -s -- ディレクトリ名1 ディレクトリ名2...

## 応用
git pullしたいパスの数だけ実施させることができるので、findコマンドで引数を与えてやるのが良い
sh -s -- ＄(find ＄(wslpath "your path") -type d -not -path "*/node_modules/*" -not -path "*/.*/*")
※不正実行防止のため、ドルマークは全角にしている。そのため、コピペ時はドルマークを半角にすること

README

debug=false
output() {
  if [ "$1" = "true" ]; then
    echo "$2"
  fi
}

pathes=$@

for path in ${pathes}; do
  if [ ! "$(echo ${path} | cut -c1)" = "/" ]; then
    output ${debug} "[SKIP] 誤作動を防止するため、入力はフルパスで設定すること: ${path}"
    continue
  elif [ ! -d "${path}" ]; then
    output ${debug} "[SKIP] 指定されたパスはディレクトリではない: ${path}"
    continue
  fi

  cd ${path}
  if [ ! -d "${path}/.git" ]; then
    output ${debug} "[SKIP] リポジトリのルートディレクトリではない： ${path}"
    continue
  fi

  git branch >/dev/null 2>&1
  if [ ! $? = 0 ]; then
    output ${debug} "[SKIP] 指定されたパスはcloneされたディレクトリではない: ${path}"
    continue
  fi

  cd $(git rev-parse --show-toplevel)
  git.exe pull --progress -v --no-rebase "origin" # gitだとダメらしく、TortoiseGitで上手く行ったのでexeを採用

done
