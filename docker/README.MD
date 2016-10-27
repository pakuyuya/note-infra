nginxのイメージを起動するチュートリアルです。

## dockerのインストール

公式を参考にしてインストールを行ってください

https://docs.docker.com/engine/installation/

例えば Ubuntuの場合、以下の手順になります。

### 1.前提パッケージをインストール

```bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
```

### 2.リポジトリにアクセスするためのGPGキーを取得

```bash
# recv-keysの後ろはその時最新のものを取得
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

### 3.それぞれのUbuntuバージョンに対応したリポジトリのURLを、source.listに追加

```bash
# Ubuntu 16.04[LTS]の場合
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/source.list.d/docker.list
```

### 4.パッケージ情報をアップデート

```bash
sudo apt-get update
```

### 5.Dockerをインストール

```bash
sudo apt-get install docker-engine
```

### 6.Dockerデーモンを実行

```bash
# デーモン実行
sudo service docker start

# 再起動時も自動実行on
sysv-rc-conf docker on
```

## Dockerの仕組み

```
ローカルになにもない状態
　｜
[docker pull] リポジトリからイメージ取得
　↓
image   コンテナのもと。OSを凍結して作る。ディスクイメージなのでメモリ中の値は保持なし
　｜
[docker run] imageからコンテナ実体化
　↓
container　コンテナの実体。imageの差分ファイルのみが存在する。
```

## チュートリアル

nginxのイメージをDockerHubからダウンロード、コンテナ起動、動作確認からそれぞれの削除までのコマンドを見ていきましょう！

### 1.docker pull

nginxのDockerイメージをdocker公式リポジトリからダウンロードします。

```
docker pull nginx:latest
```

### 2.docker images

Docker imageの一覧が見れます。

```
docker images
```

### 3.docker run

ImageからDockerコンテナを作成し、同時に起動します。

```
docker run -d -p 80:80 --name hello
```

| 記述内容 | 解説 |
|----------|------|
| -d       | コンテナ起動時、ほとんどの場合最後にコマンドを１つ実行し、以降標準出力として吐き続ける`-d`オプションは、その標準出力を監視せず即元のTYに戻るオプション|
| -p       | ポートフォワーディング。ホストポート:コンテナのポートの対応を作る。 |
| --name   | コンテナにエイリアスをつける。この場合は「hello」が設定。指定しないと、ランダムな名前が設定される。 |

上記を叩くと、/bin/bashが実行されて起動したコンテナに自動的にTTYでログインする。

その後、Ctrlを押しなら P、Qと続けて叩いて実行をキャンセル。
このまま `exit`すると、コンテナが終了してしまう。

また、この状態であれば 80ポートにアクセスすると、NginxのWelcomページが見れる。

### 4.docker logs

Dockerコンテナの標準出力ログを表示します。例えばnginxのログの出力先をstdoutにすると、以下のコマンドでそのコンテナのログが見れます！

```
docker logs hello
```

### 5.docker exec

任意のコマンドを実行します。ターミナルで入る場合はコマンドを`bash`とするのが常套手段です。

```bash
docker exec -it hello bash
```

| 記述内容 | 解説 |
|----------|------|
| -i       | 標準出力を受け付ける |
| -t       | TTYを起動する。（CUIインタフェースを提供） |
| コンテナ名 | コマンドを実行する |
| 実行コマンド | 実行するコマンド |

### 6.docker ps

現在起動中のDockerコンテナの一覧を表示します。

```bash
docker ps
```

ちなみに、停止中のコンテナも表示するには`-a`オプションを付与してください。

```bash
docker ps -a
```

### 7.docker stop

コンテナを停止するコマンドです。

```bash
docker stop hello
```

停止したコンテナは以下コマンドで確認できます。

```
docker ps -a
```

### 8.docker rm

コンテナを削除するコマンドです。コマンドの最後に、コンテナのidかnameを指定してください。

```
docker rm -v hello
```

`-v` オプションをつけるとvolumeも一緒に削除します。
もしvolumeを割り当てして`-v`をつけないでいると、ホストにどんどんディレクトリが溜まっていきます。

### 9.docker rmi

イメージを削除するコマンドです。コマンドの最後に、イメージのidかnameを指定してください。

```
docker rmi nginx
```

## by the next ?

もう、このチュートリアルだけで標準的な構成はできるのではないでしょうか？
（Dockerのインタフェースは、素晴らしくシンプルですね！）

しかし、いちいち環境を作るのに対話的にコマンドを打つのは、イメージを山ほど作る中で非常に辛いものがあります・・・。
インストール職人になる前に、再現性Dockerの肝であり問題点、Dockerfileからの`build`を是非経験してください！
