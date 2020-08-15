# !/bin/sh 
:<<README
https://github.com/shimajima-eiji/Chocolatey/tree/master/wsl/ubuntu
README

complete() {
  echo
  echo "[SUCCESS] ${1}"
  echo $2
}

cat <<ATTENTION
curl成功
このスクリプトは「crontab」と「ba(z)sh_profile」と「~/tmp」を上書きする
ここで処理が止まるので、処理を実行したい場合はsudoパスワードを入力する（何度か入力を確認されることがある）
処理を中断したい場合は、適当に入力するか「Ctrl+C」などで処理を終了させること
ATTENTION

sudo -k 
sudo echo "[MESSAGE] sudoパスワードの入力を確認"
if [ ! $? = 0 ];then
  echo "[ERROR] sudoのパスワードが不正のため処理を終了"
  exit 1
fi

message=""

# 念のため、カレントディレクトリに移動する
cd ~/

# 最新化
sudo apt update
sudo apt upgrade -y
complete "最新化を完了"

# .bash_profileの登録先
profile_path="~/.bash_profile"
if [ "$(echo $SHELL)" = "/usr/bin/zsh" ]; then
  profile_path="~/.zprofile"
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
mkdir -p ~/.ssh
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.ssh-config >>~/.ssh/config
complete "gitのssh利用の設定を反映完了"
message="${message}\n[TODO] `ssh-keygen -t rss`で生成後、公開鍵をgithubなど( https://github.com/settings/keys )に登録する"

# github-changesを導入
sudo apt install -y npm
sudo npm install -g github-changes
complete "github-changesを導入完了"

# anyenvを導入。.bash_profileはcurlで取得しているため省略
git clone https://github.com/riywo/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
anyenv --init

export PATH="$HOME/.anyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
complete "anyenvを導入完了"

# for pyenv
## for python3.7
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
anyenv install pyenv
complete "pyenvを導入完了"
message="${message}\n[TODO] pyenvを使って任意のバージョンのpythonのインストール: `pyenv install --list`"

cat <<RECOMMEND
次に実施すべきコマンド: 
`exec $SHELL -l`
zshを使いたい場合は`chsh -s $(which zsh)`
を先に実行する。

終了後、必要に応じて[TODO]を実施する
RECOMMEND
echo "${message}"
