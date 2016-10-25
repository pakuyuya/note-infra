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
