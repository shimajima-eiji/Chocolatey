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

# ~/.ssh/config
SSHでgitをするなら必要

```
Host github github.com
  HostName github.com
  IdentityFile (秘密鍵)
  User git
```
