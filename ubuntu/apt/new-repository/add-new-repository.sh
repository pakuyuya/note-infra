# リポジトリの形式を"<アーカイブ種別> <URL> <セクション>で記述
# 
# ■アーカイブ種別 = ソースの種別。
# deb  バイナリパッケージ。通常はこれ
# deb-src  差分ソースパッケージ。別のディストリビューションのものをDebian化するパッチが主だとか？
#
# ■セクション = バージョンみたいなもの。安定板。compornentとも。これはリポジトリごとに設定が依存する。
#   以下、Debianの公式リポジトリ http://ftp.jp.debian.org/debian/ の例。
# main           mainセクションのもののみ。
# stable main    mainセクションのもののみ。安定版のみを取得。
# main contrib   mainセクションのもののみ。フリーでない依存パッケージを持つフリーパッケージも対象
# main contrib non-free   mainセクションのもののみ。フリーでないパッケージも対象
# lenny-backports main    mainセクションのもののみ。不安定版も対象。

sudo echo "deb http://url/to/repository/ main" > /etc/apt/sources.list.d/myrepos.list

#設定を反映するには、一度 update する
sudo apt-get update
