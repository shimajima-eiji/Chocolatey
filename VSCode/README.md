VS Code know-how

# 1. purpose

* As part of knowledge management, in order to create a similar environment, a small start environment will be constructed as follows.
* Try to operate on the assumption that sharing (constructing a Web application) after the requirements and operations are fixed.
* In consideration of versatility such as standardization and system migration, and availability of search, management by Excel will be stopped and a text base compatible with Markdown and rich text will be used.
* Corresponds to i18n (localization).
  + Currently provisional, English → Japanese hierarchy.

## 1.1. For Japanese

* ナレッジ管理の一環として、同様の環境を整えるためにまずはスモールスタートの環境を以下の通り構築する。
* あらかた要件や運用が固まってからシェアド化（Webアプリケーションを構築）する想定での運用を試みる。
* 共通化・システム移行など汎用性、検索の可用性を考慮し、エクセルでの管理はやめてMarkdownやリッチテキスト互換のテキストベースを活用する。
* i18n（ローカライズ）に対応する。
  + 現在は暫定で、英語→日本語の階層で作る。将来的には廃止

# 2. Topics
<!-- TOC -->

* [1. purpose](#1-purpose)
    - [1.1. For Japanese](#11-for-japanese)
* [2. Topics](#2-topics)
* [3. Attention](#3-attention)
    - [3.1. For Japanese](#31-for-japanese)
* [4. Origin of settings.json](#4-origin-of-settingsjson)
    - [4.1. Remove white space at end of line](#41-remove-white-space-at-end-of-line)
        - [4.1.1. 行末の空白を削除する【For Japanese】](#411-行末の空白を削除するfor-japanese)
* [5. Extensions](#5-extensions)
    - [5.1. Markdown](#51-markdown)
        - [5.1.1. Auto Markdown TOC](#511-auto-markdown-toc)
            - [5.1.1.1. For Japanese](#5111-for-japanese)
        - [5.1.2. markdown-index](#512-markdown-index)
            - [5.1.2.1. For Japanese](#5121-for-japanese)
        - [5.1.3. Markdown-formatter](#513-markdown-formatter)
            - [5.1.3.1. For Japanese](#5131-for-japanese)
        - [5.1.4. Markdown Table Format](#514-markdown-table-format)
            - [5.1.4.1. For Japanese](#5141-for-japanese)
        - [5.1.5. Auto-Open Markdown Preview](#515-auto-open-markdown-preview)
            - [5.1.5.1. For Japanese](#5151-for-japanese)
    - [5.2. For all Development](#52-for-all-development)
        - [5.2.1. Save And Run (with WSL)](#521-save-and-run-with-wsl)
            - [5.2.1.1. For Japanese](#5211-for-japanese)
    - [5.3. Misc](#53-misc)
        - [5.3.1. Japanese Language Pack for Visual Studio Code](#531-japanese-language-pack-for-visual-studio-code)
            - [5.3.1.1. For Japanese](#5311-for-japanese)

    

<!-- /TOC -->

# 3. Attention
Be careful not to put too much.
It may become very heavy and unusable for use.

## 3.1. For Japanese

入れ過ぎ注意。
非常に重くなり使用に耐えなくなる可能性がある。

# 4. Origin of settings.json

## 4.1. Remove white space at end of line

To delete the blank at the end of the line, add the above sentence.

``` 
{
    "files.trimTrailingWhitespace": true
}
```

### 4.1.1. 行末の空白を削除する【For Japanese】

行末の空白を削除するには、上記一文を追加する。

# 5. Extensions

## 5.1. Markdown

### 5.1.1. Auto Markdown TOC

#### 5.1.1.1. For Japanese

名前: Auto Markdown TOC
ID: huntertran.auto-markdown-toc
説明: Markdown TOC (Table Of Contents) Plugin for Visual Studio Code.
バージョン: 2.1.1
パブリッシャー: Hunter Tran
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=huntertran.auto-markdown-toc

Markdownの目次を右クリックで手軽に作成・更新できる。
一度置いたらファイルを保存するたびに最新の状態に適用してくれる。
が、**見出しに番号を付与したい場合、バグがあるので後述のmarkdown-indexと併用する必要がある。**

### 5.1.2. markdown-index

#### 5.1.2.1. For Japanese

名前: markdown-index
ID: legendmohe.markdown-index
説明: add index automatically to your titie
バージョン: 0.0.8
パブリッシャー: legendmohe
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=legendmohe.markdown-index

Auto Markdown TOCの作者が「Markdown TOC」という、見出しに番号をつけてもバグらないものを用意しているが、こちらは更新するたびにautoauto... というバグが出てくる。
これを回避するために別作者による、まったく同じ機能をもつ拡張機能を使う必要がある。
こちらは、項目を追加するたびに手動で採番をしなおす必要がある。
もうAuto Markdown TOCいらなくね？と思わないでもない。

### 5.1.3. Markdown-formatter

#### 5.1.3.1. For Japanese

名前: markdown-formatter
ID: mervin.markdown-formatter
説明:  A Markdown Plugin for code artist
バージョン: 0.6.4
パブリッシャー: mervin
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=mervin.markdown-formatter

Markdownのフォーマッタは数多くあるが、入れた瞬間に使えるのはこれだけ（執筆時点）
推奨に「markdownlint」が出てくるが、あくまでlinterなのでいい感じにやってくれない。
このformatterで整形してもWarnを吐きまくるので、煩わしいかもしれない。

### 5.1.4. Markdown Table Format

#### 5.1.4.1. For Japanese

名前: MarkDown Table Format
ID: tomashubelbauer.vscode-markdown-table-format
説明: Formats MarkDown tables so that all columns have the same width
バージョン: 1.0.1
パブリッシャー: Tomas Hubelbauer
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=TomasHubelbauer.vscode-markdown-table-format

なんとなくテーブルを作って右クリック→ドキュメントのフォーマット→Markdown Table Formatとすると、テーブルフォーマットをいい感じに作ってくれる。

たとえば、

|a|b|
|1|2|3|

が

| a | b |   |
|---|---|---|
| 1 | 2 | 3 |

になる。

### 5.1.5. Auto-Open Markdown Preview

#### 5.1.5.1. For Japanese

名前: Auto-Open Markdown Preview
ID: hnw.vscode-auto-open-markdown-preview
説明: Open Markdown preview automatically when opening a Markdown file
バージョン: 0.0.4
パブリッシャー: hnw
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=hnw.vscode-auto-open-markdown-preview

ショートカットキーでMarkdownプレビュー(Ctrl + Shift + V)を出す必要がないので、より初心者向き。
中身はVS Code標準のMarkdownプレビューと思われる。

## 5.2. For all Development

### 5.2.1. Save And Run (with WSL)

#### 5.2.1.1. For Japanese

名前: Save and Run with wsl
ID: raiscui.save-and-run-wsl
説明: Run commands when a file is saved in Terminal (add wsl path)
バージョン: 0.0.182
パブリッシャー: raiscui
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=raiscui.save-and-run-wsl

WSLで使わない場合は無印（withではない）を入れよう。
settings.jsonにsaveAndRunを入れてmatchするルールを書けば、保存するたびに指定したcmdに従い実行してくれるもの。&&でつなげば複数可能。
それが手間であればSaveandRun.shみたいなのを作って配布すれば環境を統一させることもできるが、VS Codeを入れれば誰にでも活用できるわけではないので、userSettings.jsonにわざわざ書く手間を考えるとどっこいどっこい（個人の主観による）
VS Codeの環境自体を配布するなら、syncSettingsと併用すると楽になる。

たとえばWSLでpythonファイルを実行させる場合、Windows用pythonとWSL用Pythonの2つを入れるより、WSLにpyformatやisortを入れて実行させた方が良いこともある。

## 5.3. Misc

### 5.3.1. Japanese Language Pack for Visual Studio Code

#### 5.3.1.1. For Japanese

名前: Japanese Language Pack for Visual Studio Code
ID: ms-ceintl.vscode-language-pack-ja
説明: Language pack extension for Japanese
バージョン: 1.37.5
パブリッシャー: Microsoft
VS Marketplace リンク: https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja

とりあえず画面の表示を日本語にしたいならすぐに入れておくもの。
これがないとVS Codeに慣れるまでは大変。

