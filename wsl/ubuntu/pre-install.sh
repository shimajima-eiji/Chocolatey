# !/bin/sh 

sudo apt update
sudo apt upgrade -y

# for Japanese
sudo apt install -y language-pack-ja manpages-ja
sudo update-locale LANG=ja_JP.UTF8
sudo dpkg-reconfigure tzdata  # select your timezone

# for github-changes
sudo apt install -y npm
sudo npm install -g github-changes

# for anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc
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
