# ~/.gitconfigに設定を追加
```
[user]
  email = (your mail)
  name = (your name)

[url "github:"]
        InsteadOf = https://github.com/
        InsteadOf = git@github.com:

[init]
  templatedir = $(Chocolatey)/wsl/_git
```

- user: いつも聞かれるアレ
- url: SSHでpushするために必要
- init:
  - cloneしてきた時に参照するテンプレートディレクトリ。
  - この場合、masterへのpushを禁止するprepushが自動的に読み込まれる。

## 初期設定
一回だけやれば以降すべてに適用される。

```
chmod +x $(Chocolatey)/wsl/_git/hooks/prepush
```

既にclone済みの場合、手動で[.git/hooks/prepush](https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/_git/hooks/pre-push)を作成する

## masterにpushしたい
たとえばupdate_CHANGELOGを使用したい場合を想定
```
cd (cloneディレクトリ)
rm ./.git/hooks/prepush
```

# ~/.ssh/config
SSHでgitをするなら必要

```
Host github github.com
  HostName github.com
  IdentityFile (秘密鍵)
  User git
```
