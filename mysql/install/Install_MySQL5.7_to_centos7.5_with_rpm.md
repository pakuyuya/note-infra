下記の記事を参考にさせていただきました。

* https://enomotodev.hatenablog.com/entry/2016/09/01/225200
* https://weblabo.oscasierra.net/installing-mysql57-centos7-yum/
* https://www.dbonline.jp/mysql/user/index2.html
* https://qiita.com/keisukeYamagishi/items/d897e5c52fe9fd8d9273


## OS/enviornment

```bash
docker run --rm -d --name centos75 --privileged centos:centos7.5.1804 /sbin/init
docker exec -ti centos75 bash
```

## instalation

```
# wgetコマンドがない場合のみ
yum install -y wget

# rpmパッケージの入手と展開
mkdir /usr/local/src/MySQL5.7
cd /usr/local/src/MySQL5.7
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar
tar xvf mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar

# yum localinstallを用いたパッケージインストール
yum localinstall -y mysql-community-common-5.7.26-1.el7.x86_64.rpm \
                    mysql-community-libs-5.7.26-1.el7.x86_64.rpm \
                    mysql-community-client-5.7.26-1.el7.x86_64.rpm \
                    mysql-community-server-5.7.26-1.el7.x86_64.rpm

# バージョン確認
mysqld --version

# サービス自動起動設定とサービス起動
symstemctl enable mysqld.service
symstemctl start mysqld.service

# 初回起動後のログから、初期設定されたパスワードを確認
cat /var/log/mysqld.log | grep password

# 確認したパスワードをつかってMySQLに対話接続
mysql -u root -p
```

```sql
-- パスワードポリシー：パスワード長を6文字以上に
set global validate_password_length=6;
-- パスワードポリシー：パスワードポリシーをLOWに
set global validate_password_policy=LOW;
-- 対話コンソールを終了する
\q
```

```bash
# セキュリティ設定ツールを起動
mysql_secure_installation

Securing the MySQL server deployment.

Enter password for user root:
The 'validate_password' plugin is installed on the server.
The subsequent steps will run with the existing configuration
of the plugin.
Using existing password for root.

Estimated strength of the password: 100
Change the password for root ? ((Press y|Y for Yes, any other key for No) : y # rootユーザのパスワード変更

New password:

Re-enter new password:

Estimated strength of the password: 50
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y # 弱いパスワードだけど大丈夫ですか警告
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y # 匿名ユーザー削除
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : n # localhost以外からのroot接続禁止。今回は許容

 ... skipping.
By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y # test スキーマの削除
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y # 権限テーブルのリロード
Success.

All done!
```