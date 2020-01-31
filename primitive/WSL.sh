# windows: %HomePath%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_*************\LocalState\rootfs

sudo apt update
sudo apt upgrade -y

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
'>>(shell)_profile

exec $SHELL -l

# for pyenv


# for python3.7
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
anyenv install pyenv
pyenv install ()  # (pyenv install --list)


