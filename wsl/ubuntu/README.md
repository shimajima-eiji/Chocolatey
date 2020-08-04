# 初期設定
## 各ディストリビューション
```
cd ~/
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.gitconfig >>~/.gitconfig
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.ssh-config >>~/.ssh/config
#sudo curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/cron.sh >>/var/spool/cron/crontabs/$USER

# ssh-keygen -t rsaで作成したファイルを https://github.com/settings/keys に登録しておく

sudo service cron start
```

crontabの設定は、`sudo (editor) /var/spool/cron/crontabs/$USER`で実施することを推奨。
<br>(crontab -eの隣にrキーがあり、誤って削除してしまう可能性が高いため)

# CHANGELOG.mdについて
[Github_scoutのwikiを参照](https://github.com/shimajima-eiji/Github_scout/wiki/【手引】更新履歴（CHANGELOG.md）)
