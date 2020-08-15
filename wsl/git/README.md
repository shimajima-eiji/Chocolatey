# ~/.gitconfigに設定を追加
windowsの場合、`%USERPROFILE%¥.gitconfig`
<br>CMDやPowerShell、ほかtortoiceGitなどを使う場合に呼び出される

## .gitconfig
```
[user]
  email = (your email)
  name = (your name)

[url "github:"]
  InsteadOf = https://github.com/
  InsteadOf = git@github.com:

[init]
  templatedir = (Chocolatey/wsl/git/templateのパス）
```

`curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/.gitconfig >~/.gitconfig`

## 解説
- user: いつも聞かれるアレ
- url: SSHでpushするために必要
- init:
  - cloneしてきた時に参照するテンプレートディレクトリ。
  - この場合、masterへのpushを禁止するprepushが自動的に読み込まれる。

# 初期設定
一回だけやれば以降すべてに適用される。

```
chmod +x (Chocolatey/wsl/git/templateのパス）/wsl/git/template/hooks/pre-push
```

既にclone済みの場合、手動で[.git/hooks/prepush](https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/template/hooks/pre-push)を作成する

```
cd (cloneディレクトリ)
curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/template/hooks/pre-push >.git/hooks/pre-push
```

## masterにpushしたい
たとえばupdate_CHANGELOGを使用したい場合を想定
```
cd (cloneディレクトリ)
rm ./.git/hooks/pre-push
```

# gitをSSHで使いたい
~/.ssh/configに

```
Host github github.com
  HostName github.com
  IdentityFile (秘密鍵)
  User git
```

`curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/.ssh/config` >>~/.ssh/config
