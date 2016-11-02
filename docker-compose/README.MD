## Docker Composeとは？

仮想コンテナエンジン「Docker」の管理ツールです。

Dockerでコンテナ起動する際、様々なオプションをコマンドラインで指定して起動するのですが、
そのオプションや複数起動の設定をすべて設定ファイルに記述し、簡単なコマンドで起動することができるようになります！

## インストール

Docker公式を参照。

https://docs.docker.com/compose/install/


## チュートリアル

nginxコンテナを起動するチュートリアルです。

### 1. 設定ファイル保存用ディレクトリを作成

好きな場所に、docker-compoesの設定ファイル用のディレクトリを作成してください。

### 2. docker-compose.ymlを作成

以下内容で`docker-compose.yml`を作成してください。

```yml
mynginx:
  image: nginx
  ports:
    - "80:80"
```

### 3. コンテナ起動まで

`docker-compose.yml`のあるディレクトリまで移動し、続いて以下コマンドを実行してください。


イメージを取得

```
docker-compose pull
```

コンテナ起動

```
docker-compose up -d
```

以上で、コンテナが起動します。当サーバーの80番ポートにアクセスすると、nginxのWellcomページが表示します。


起動したコンテナの標準出力は、以下コマンドで知ることができます。

```
docker-compose logs
```

### 4. コンテナの終了

コンテナの停止

```
docker-compose stop
```

コンテナの削除

```
docker-compose rm -f
```

