# !/bin/sh
: <<README
https://github.com/shimajima-eiji/Chocolatey/tree/master/wsl/ubuntu/README.md

# 運用ルール
taskにメッセージを入れて、処理の最初と最後にstart/successを挟む
README

output() {
  echo
  echo "[$1] $2"
  echo $3
}

start() {
  output "開始" $1
}

success() {
  output "完了" $1 $2
}

cat <<ATTENTION
curl成功
このスクリプトは「crontab」と「ba(z)sh_profile」と「\${HOME}/tmp」を上書きする
ここで処理が止まるので、処理を実行したい場合はsudoパスワードを入力する（何度か入力を確認されることがある）
処理を中断したい場合は、適当に入力するか「Ctrl+C」などで処理を終了させること

ATTENTION

sudo -k
sudo echo "[MESSAGE] sudoパスワードの入力を確認"
if [ ! $? = 0 ]; then
  echo "[ERROR] sudoのパスワードが不正のため処理を終了"
  exit 1
fi

todo=""
url="https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl"

# 念のため、カレントディレクトリに移動する
cd ${HOME}

task="最新化"
start ${task}
sudo apt update
sudo apt upgrade -y
success ${task}

task=".パス情報などを格納するprofileファイル名を設定"
profile_path="${HOME}/.profile"
echo "# $(date '+[%Y/%m/%d]')" >>${profile_path}
success "${task}: ${profile_path}"

task="日本語設定"
start ${task}
sudo apt install -y language-pack-ja manpages-ja
sudo update-locale LANG=ja_JP.UTF8
sudo dpkg-reconfigure tzdata # select your timezone
success ${task}

task="cronを設定する"
start ${task}
sudo service cron start
curl ${url}/cron/cron >tmp
sudo mv tmp /var/spool/cron/crontabs/${USER}
crontab -l
success ${task}

task="linux-brewによるパッケージ管理"
start ${task}
echo "" | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
sudo apt install -y build-essential
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"

echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>${profile_path}
echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>${profile_path}
echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>${profile_path}
echo 'export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"' >>${profile_path}
echo 'export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"' >>${profile_path}

echo "" | brew
brew install gcc
success ${task}

task="yarn"
start ${task}
brew reinstall yarn
success "${task}: npm install は yarn add になる点に注意"

task="translate-shell"
start ${task}
sudo wget git.io/trans -O /usr/local/bin/trans
sudo chmod +x /usr/local/bin/trans
success "${task}: transコマンドで翻訳できる。API制限に注意"

task="github-changes"
start ${task}
yarn global add github-changes
success ${task}

task="github-changelog-generator"
start ${task}
sudo gem install github_changelog_generator
success ${task}

task="anyenv"
start ${task}
brew reinstall anyenv
echo y | anyenv install --init # 「warning: templates not found」で怒られる場合、%USER%/.gitconfigにinitを指定している可能性がある
anyenv update
success ${task}

task="pyenv"
start ${task}
## for python3.7
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
anyenv install pyenv
todo="${todo}\n[TODO] pyenvを使って任意のバージョンのpythonのインストール: $(pyenv install --list)"
success "pyenvを導入完了"

task="gitのssh利用の設定"
start ${task}
curl ${url}/.gitconfig >${HOME}/.gitconfig
mkdir -p ${HOME}/.ssh
curl ${url}/.ssh/config >${HOME}/.ssh/config
todo="${todo}\n[TODO] \$(ssh-keygen -t rss)で生成後、公開鍵をgithubなど( https://github.com/settings/keys )に登録する"
success "${task}"

echo "${profile_path} の追記事項"
cat ${profile_path}

cat <<RECOMMEND

次に実施すべきコマンド:
\$(exec \$SHELL -l)
zshを使いたい場合は\$(chsh -s \$(which zsh))
を先に実行する。

終了後、必要に応じて[TODO]を実施する

RECOMMEND

echo "${todo}"
