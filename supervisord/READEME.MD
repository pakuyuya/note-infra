## Supervisorとは

設定ファイルだけで簡単にプロセスをデーモン化するツールです。

pythonで実装されています。


## チュートリアル

### 1. supervisorのインストール

supervisorは、各ディストリビューションの公式リポジトリに組み込まれています。
`yum`や`apt-get`で入手しましょう。

```
yum install supervisor
```

```
apt-get update
apt-get install supervisor
```

### 2. 設定ファイルの確認

`/etc/supervisor`に設定ディレクトリが作成されます。

バージョンによりますが、以下のようになるでしょう。

```
root@b2cf09867735:/# ls -l /etc/supervisor/
total 8
drwxr-xr-x 2 root root 4096 Oct 29 11:15 conf.d
-rw-r--r-- 1 root root 1178 Jan  8  2016 supervisord.conf
```

### 3. 起動設定ファイルの追加

`/etc/supervisor/conf.d`に設定ファイルを追加しましょう。名前は任意で構いません。

以下、サンプルです。（nginxを予めインストールしてくださいね）

```
[program:nginx]
command=/usr/sbin/nginx -g "daemon off;"
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/nginx/stdout.log
stderr_logfile=/var/log/nginx/stderr.log
```

* `[program:～]`と記述されている箇所以降が、起動したいデーモンごとのセクションになります。
* １つの設定ファイルに複数のエントリを追加することが可能です。
* `command`に起動したいコマンドを設定します。このコマンドは、必ずデーモン化をoffにしてください。
 （nginxのようないくつかのアプリケーションは自らデーモン化する機能があります。）
 
 

### 4. supervisor サービスを起動

```
systemctl start supervisor
```

```
service supervisor start
```

