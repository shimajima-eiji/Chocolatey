## [日本語](/wsl/git/README.md)

# Add settings to ~/.gitconfig
windowsの場合、`%USERPROFILE%¥.gitconfig`
<br>Called when using CMD, PowerShell, tortoiceGit, etc.

## .gitconfig
```
[user]
email = (your email)
name = (your name)

[url "github:"]
InsteadOf = https://github.com/
InsteadOf = git@github.com:

[init]
templatedir = (Chocolatey/wsl/git/template path)
```

`curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/.gitconfig >~/.gitconfig`

## Comment
-user: I'm always asked
-url: Required to push with SSH
-init:
-Template directory to refer to when cloning.
-In this case, prepush which prohibits push to master is automatically loaded.

# Initial setting
You only have to do it once and it applies to everything thereafter.

```
chmod +x (Chocolatey/wsl/git/template path) /wsl/git/template/hooks/pre-push
```

If already cloned, manually create [.git/hooks/prepush](https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/template/hooks/pre-push)

```
cd (clone directory)
curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/git/template/hooks/pre-push >.git/hooks/pre-push
```

## I want to push to master
For example, if you want to use update_CHANGELOG
```
cd (clone directory)
rm ./.git/hooks/pre-push
```

# I want to use git with SSH
in ~/.ssh/config

```
Host github github.com
HostName github.com
IdentityFile (private key)
User git
```

`curl https://github.com/shimajima-eiji/Chocolatey/blob/master/wsl/.ssh/config` >>~/.ssh/config

Operation of #CHANGELOG.md
[Refer to Github_scout wiki](https://github.com/shimajima-eiji/Github_scout/wiki/[Guide] Update history (CHANGELOG.md))
