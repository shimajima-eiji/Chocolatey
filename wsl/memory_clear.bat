@echo off
@rem WSLはWindowsのメモリを圧迫する（バグがある）ので、気付いた時に再起動する必要がある。
@rem WSL_Distributionにはwsl -lで参照した使用中のディストリビューションを入れておく
wsl -t %WSL_Distribution%
