<<__COMMENT
# Configs
windows: %HomePath%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_*************\LocalState\rootfs
VSCode: Remote WSL

##npm
- [github-changes](https://github.com/lalitkapoor/github-changes)
  - [view](https://github.com/shimajima-eiji/Chocolatey/blob/master/CHANGELOG.md)
__COMMENT

apt update
apt upgrade -y

# for Japanese
apt install -y language-pack-ja manpages-ja
update-locale LANG=ja_JP.UTF8
dpkg-reconfigure tzdata

# for github-changes
apt install -y npm
npm install -g github-changes

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

# for github-changes
npm install -g github-changes
