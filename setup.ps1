### README.mdのソースを書き起こしたけど、これで実施できるとは思えない。
### 素直に手打ちするべし。

Get-ExecutionPolicy
# 初期だとRestrictedとなっているはず
Set-ExecutionPolicy AllSigned

# 何か言われたらうざったいのでA
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# お好みでどうぞ
cinst (package-name or config-file) #(upgrade) で更新できる。chocolateyguiはこのコマンドでないとupgradeできない

## 途中、【Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint):】と聞かれる事があるのでAとしておこう。

# やらなくても直ちに影響はないが、忘れずに戻しておこう
Set-ExecutionPolicy Restricted
