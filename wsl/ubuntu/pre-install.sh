# !/bin/sh 
:<<README
環境変数は.~/.bash_profileに書くようにしているが、zshを使う場合はリネームすること
README

sudo apt update
sudo apt upgrade -y

# 日本語設定を適用する
sudo apt install -y language-pack-ja manpages-ja
sudo update-locale LANG=ja_JP.UTF8
sudo dpkg-reconfigure tzdata  # select your timezone

# GithubをSSHで使う
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.gitconfig >>~/.gitconfig
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/home-.ssh-config >>~/.ssh/config
sudo curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/cron.sh >/var/spool/cron/crontabs/$USER

# for github-changes
sudo apt install -y npm
sudo npm install -g github-changes

# for anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
# echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
source ~/.bashrc
anyenv --init

## Case: missing path
echo '
export PATH="$HOME/.anyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
' >> ~/.$(basename $SHELL)_profile  # 現在ログイン中のshellに書く。bashだと$SHELLは/bin/bash

exec $SHELL -l

# for pyenv

# for python3.7
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
anyenv install pyenv
pyenv install ()  # (pyenv install --list)
