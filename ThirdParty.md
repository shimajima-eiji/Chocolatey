# ThirdParty
入れるものは任意だが、ここでは特筆すべき事項があるものについて触れる。

## 実行環境
- Windows10 Pro
- 調査時はcommit時に準拠するので、将来的にできない事も考えられる。

## MSストア
- [Windows Sub System](https://wsldownload.azureedge.net/Ubuntu_2004.2020.424.0_x64.appx)
  - おすすめはMSストアを使用することだが、MSストアを使わなくてもできるようだ（未検証）
- [iCloud Drive](https://support.apple.com/ja-jp/HT204283)
  - Chocolateyに存在するが、うまく動かない。(なお、[保存先を変えたい場合は設定が必要。](https://lovemac.jp/3696)
    ![image](https://user-images.githubusercontent.com/15845907/86483486-2069d080-bd8f-11ea-9c60-e202bbfb4e56.png)
  - 同様に、icloudフォトも、`mklink /J "C:Users\username\Pictures\iCloud Photos" "D:\iCloud Photos"`とする必要がある。こちらは半角スペースが必要。
    - Googleフォトと違い、ICloudフォトもPCローカルにダウンロードはできるが削除などはWebから行うため、撮影したものをすぐに使わないなら必要性を感じない。

## サードパーティー
- [Google Drive](https://www.google.com/intl/ja_ALL/drive/download/)
  - いつのまにかGoogleフォトが使えなくなっているが今も現役。Chocolateyに存在するが、うまく動かない。
- [tortoisegit](https://tortoisegit.org/)
  - GitをExplorerで使いたいなら必須。言語パックが別途必要なことも。
- [heicファイルをjpgファイルに変換](https://imagemagick.org/)
  - 詳細は[heic2jpg](https://github.com/shimajima-eiji/Chocolatey/blob/master/tool/heic2jpg.bsh)を参照。
- [RPGツクールRTP](https://tkool.jp/products/rtp.html)
  - MV以前のものは全て必要。dllファイルも含まれる。
