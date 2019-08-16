# 1. Agenda

<!-- TOC -->

* [1. Agenda](#1-agenda)
* [2. installerディレクトリとは？](#2-installerディレクトリとは)
    - [2.1. 提案](#21-提案)
* [settings.json](#settingsjson)
* [settings.json](#settingsjson)
* [3. chocolateyとは？](#3-chocolateyとは)

<!-- /TOC -->

# 2. installerディレクトリとは？
他の端末と同期したい場合、インストーラー等は別途まとめておくと良い。
あるいは、chocoleteyで入らなかったものを格納すると手間が減るので、それらを管理するディレクトリ。

``` 
cd $(dirname $0)  # この場合、README.md
find . -mindepth 1 | cut -f2 -d '/' >files.txt
```

で、生成したものがfiles.txt。
インストーラーである必要はない

## 2.1. 提案

.mdを更新する時に、対象ファイルのディレクトリ以下のファイルを一覧できるようにしておく。
これはREADME.mdにファイルごとの使い方を書く場合に便利。
GitHub Pagesを作る場合、README.mdとindex.mdの両方が必要になるため、ピンポイントに指定しても良いかもしれない。

``` 
# settings.json
"saveAndRun": {
    "commands": [
        {
            "match": "\\.md$",
            "isShellCommand": true,
            "cmd": "cd $(dirname ${file}) && find . -mindepth 1 | cut -f2 -d '/'",
            "wsl": true
        }
    ]
}
```

なお、WSLでの使用を想定しているが、Unix/Linuxならwslをfalseにする。

# 3. chocolateyとは？
[ディレクトリ](../chocoletey)
コマンド一発で色々入れられるWindows版パッケージ管理ツール。

