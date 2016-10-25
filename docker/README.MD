nginxのイメージを起動するチュートリアル。

# 仕組み

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
docker run -it -p 80:80 --name hello /bin/bash
```

| 記述内容 | 解説 |
|----------|------|
| -p       | ポートフォワーディング。ホストポート:コンテナのポートの対応を作る。 |
| --name   | コンテナにエイリアスをつける。この場合は「hello」が設定 |
| コマンド | コンテナ起動と同時に実行するコマンド。 |

上記を叩くと、/bin/bashが実行されて起動したコンテナに自動的にTTYでログインする。

その後、Ctrlを押しなら P、Qと続けて叩いて実行をキャンセル。
このまま `exit`すると、コンテナが終了してしまう。

また、この状態であれば 80ポートにアクセスすると、NginxのWelcomページが見れる。

## docker ps

現在起動中のdockerが見れるコマンド。

```
docker ps
```

ちなみに、停止中のコンテナも表示するには`-a`オプションを付与する。

```
docker ps -a
```

## docker stop

コンテナを停止するコマンド。

```
docker stop hello
```

停止したコンテナは以下コマンドで確認できる。

```
docker -ps -a
```

## docker rm

コンテナを削除するコマンド。

```
docker rm hello
```

## docker rmi

イメージを削除するコマンド。

```
docker rmi nginx
```
