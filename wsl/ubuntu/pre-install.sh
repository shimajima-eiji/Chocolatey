# !/bin/sh 
:<<README
https://github.com/shimajima-eiji/Chocolatey/tree/master/wsl/ubuntu
README

complete() {
  echo
  echo "[SUCCESS] ${1}"
  echo $2
}

echo "curl成功"
read -p "このスクリプトは「crontab」と「ba(z)sh_profile」と「~/tmp」を上書きするが問題ない事を確認済みである (y/N): " yn
case "$yn" in
  [yY]*) echo "コマンドの実行を開始";;
  *) echo "コマンドを中止"; exit 0;;
esac

# sudoに失敗したら処理を中断させる
echo "ここで処理が止まるので、sudoパスワードを入力する。失敗したら処理を中止する"
sudo echo "[MESSAGE] sudoパスワードの入力を確認"
if [ ! $? = 0 ];then
  echo "[ERROR] sudoのパスワードが不正のため処理を終了"
  exit 1
fi

# 念のため、カレントディレクトリに移動する
cd ~/

# 最新化
sudo apt update
sudo apt upgrade -y
complete "最新化を完了"

# .bash_profileの登録先
profile_path="~/.bash_profile"
if [ "$(echo $SHELL)" = "/usr/bin/zsh" ]; then
  profile_path="~/.zsh_profile"
fi
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/.bash_profile >${profile_path}
complete "${profile_pash}を書き換え完了"

# 日本語設定を適用する
sudo apt install -y language-pack-ja manpages-ja
sudo update-locale LANG=ja_JP.UTF8
sudo dpkg-reconfigure tzdata  # select your timezone
complete "$日本語の対応完了"

# cronを設定する
sudo service cron start
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/cron >tmp
sudo mv tmp /var/spool/cron/crontabs/$USER
crontab -l
complete "cronの設定を反映完了"

# GithubをSSHで使う
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.gitconfig >>~/.gitconfig
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.ssh-config >>~/.ssh/config
complete "gitのssh利用の設定を反映完了" "[TODO] ssh-keygen -t rssで生成後、公開鍵をhttps://github.com/settings/keysに登録する"

# github-changesを導入
sudo apt install -y npm
sudo npm install -g github-changes
complete "github-changesを導入完了"

# anyenvを導入。.bash_profileはcurlで取得しているため省略
git clone https://github.com/riywo/anyenv ~/.anyenv
# echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ${profile_path}
source ${profile_path}
anyenv --init
#echo '
#export PATH="$HOME/.anyenv/bin:$PATH"
#export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
#export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
#' >> ${profile_path}
complete "anyenvを導入完了"

# for pyenv
## for python3.7
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
anyenv install pyenv
# pyenv install ()  # (pyenv install --list)
complete "pyenvを導入完了" "[TODO] pyenvを使って任意のpythonのインストール"

echo '次のコマンド: `exec $SHELL -l`を実行 or `chsh -s $(which zsh)`でzshに切り替える'
echo '終了後、必要に応じて[TODO]を実施する'
