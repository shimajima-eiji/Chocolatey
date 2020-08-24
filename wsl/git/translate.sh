#!/bin/bash
: <<README
# 使い方
## 本スクリプト
gitリポジトリをcloneしたディレクトリ以下で実施する
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/translate.sh 2>/dev/null | bash

## 翻訳API
curl -L "https://script.google.com/macros/s/AKfycbzA5CyJFa8MQubeEL266bcfOqPcQpqBaH0Ta34nBBREH2IV5ss/exec?text=##%20Change%20Log&source=ja&target=en"

# 注意
curlでpythonファイルをダウンロードして流し込んで実行しているので<()構文が必要だが、この機能はshでは使えない。
bashとzshでは動く

# 仕様
git diff --name-only で変更があったものだけを対象としているため、変更がなかった＝remote originに存在しないファイルは変更なしという扱いにされている。
これはgit diffの仕様であり、回避法として対象ディレクトリのリポジトリを別の場所にcloneしてパスで比較する方法がある。
あるいは、diffを取らず全て変更してしまう方法も一手だが不要な処理を挟むため非推奨。

README

git branch >/dev/null 2>&1
if [ ! $? = 0 ]; then
  echo "gitリポジトリ以下のディレクトリではないので処理を中止"
  exit 1
fi

encode() {
  # 調べたいものは echo "(何か)" | nkf -WwMQ | tr = % で
  text=$(echo "${1}" | sed "s| |%20|g")
  echo "${text}"
}

script=$(curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/translate.py 2>/dev/null)

cd $(git rev-parse --show-toplevel)
echo "作業ディレクトリ: $(pwd -P)"
for path in $(find -name "*.md" -not -name "*_en.md" -size +1c); do
  git diff --name-only | grep $(echo ${path} | cut -c 3-) >/dev/null
  if [ $? = 1 ]; then # 変更がないものは翻訳しない
    continue
  fi

  echo "[START]: ${path}"
  output="$(dirname ${path})/$(basename ${path%.*}_en.md)"
  echo "## [日本語]($(echo ${path} | cut -c 2-))" >${output}
  echo "" >>${output}

  while read line; do
    text=$(encode "${line}" | tr -d "\r" | tr -d "\n")
    result=$(python <(echo "${script}") "${text}" "ja" "en")
    if [ "$(echo ${result} | jq -r .code)" = 200 ]; then
      result=$(echo ${result} | jq -r .text)
    else
      result=${line}
    fi
    echo ${result} | tee -a ${output}
  done <${path}

  echo "[COMPLETE]: ${path} to ${output}"
done
