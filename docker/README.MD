nginxのイメージを起動するチュートリアル。

## dockerのインストール

公式を参考にしてインストール

https://docs.docker.com/engine/installation/

例えば Ubuntuの場合

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

## docker pull

nginxのDockerイメージをdocker公式リポジトリからダウンロードする。

```
docker pull nginx:latest
```

## docker images

Docker imageの一覧が見れる。

```
docker images
```

## docker run

ImageからDockerコンテナを作成し、同時に起動する。

```
docker run -d -p 80:80 --name hello
```

| 記述内容 | 解説 |
|----------|------|
| -d       | Dockerをターミナルで監視しない。 |
| -p       | ポートフォワーディング。ホストポート:コンテナのポートの対応を作る。 |
| --name   | コンテナにエイリアスをつける。この場合は「hello」が設定 |

上記を叩くと、/bin/bashが実行されて起動したコンテナに自動的にTTYでログインする。

その後、Ctrlを押しなら P、Qと続けて叩いて実行をキャンセル。
このまま `exit`すると、コンテナが終了してしまう。

また、この状態であれば 80ポートにアクセスすると、NginxのWelcomページが見れる。

## docker logs

Dockerの標準出力ログを表示。

```
docker logs hello
```

## docker exec

任意のコマンドを実行する。ターミナルで入る場合は`bash`を起動する。

```bash
docker exec -it hello bash
```

| 記述内容 | 解説 |
|----------|------|
| -i       | 標準出力を受け付ける |
| -t       | TTYを起動する。（CUIインタフェースを提供） |
| コンテナ名 | コマンドを実行する |
| 実行コマンド | 実行するコマンド |

## docker ps

現在起動中のdockerが見れるコマンド。

```bash
docker ps
```

ちなみに、停止中のコンテナも表示するには`-a`オプションを付与する。

```bash
docker ps -a
```

## docker stop

コンテナを停止するコマンド。

```bash
docker stop hello
```

停止したコンテナは以下コマンドで確認できる。

```
docker ps -a
```

## docker rm

コンテナを削除するコマンド。

```
docker rm -v hello
```

`-v` オプションをつけるとvolumeも一緒に削除する。

## docker rmi

イメージを削除するコマンド。

```
docker rmi nginx
```
