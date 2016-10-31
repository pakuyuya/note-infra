## pgpoolとは

* PostgreSQLの間に入って色々プロキシしてくれるツール
* キャッシュ、レプリケーション、ロードバランス様々

## インストール・起動

### インストールする

ubuntu

```sh
apt-get install pgpool2
```

### 設定する

* そのうち書く

### デーモン起動

```
service pgpool2 start
```

### 標準出力はきながらデーモン起動

```
pgpool -n -d > /var/log/pgpool/pgpool.log 2>&1 &
```