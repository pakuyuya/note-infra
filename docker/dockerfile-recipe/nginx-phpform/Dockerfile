FROM nginx:latest

RUN apt-get update
RUN apt-get install -y ssh
RUN apt-get install -y php5-fpm

# nginx.confを上書き
ADD conf/nginx.conf /etc/nginx/nginx.conf

#nginx用のvirtualhost設定追加
ADD conf/site-http.conf /etc/nginx/conf.d/default.conf
ADD conf/site-ssl.conf /etc/nginx/conf.d/default-ssl.conf

# 証明書ファイル追加
RUN mkdir -p /usr/local/nginx/conf/cert
ADD cert/cert.pem /usr/local/nginx/conf/cert.pem
ADD cert/cert.key /usr/local/nginx/conf/cert.key

# 設定ファイル書き換え
ENV php_conf /etc/php5/fpm/php.ini
ENV fpm_conf /etc/php5/fpm/php-fpm.conf
ENV www_conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i \
      -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" \
      -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" \
      -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" \
      -e "s/;date.timezone\s*=\s*/date.timezone = \"Asia\/Tokyo/g" \
      -e "s/;mbstring.language = Japanese/mbstring.language = Japanese/g" \
     ${php_conf} && \
    sed -i \
        -e "s/user = www-data/user = nginx/g" \
        -e "s/group = www-data/group = nginx/g" \
        -e "s/listen.owner = www-data/listen.owner = nginx/g" \
        -e "s/listen.group = www-data/listen.group = nginx/g" \
        -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
        -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
        -e "s/pm.max_children = 4/pm.start_servers = 4/g" \
        -e "s/pm.start_servers = 2/pm.start_servers = 2/g" \
        -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 1/g" \
        -e "s/pm.max_spare_servers = 3/pm.min_spare_servers = 3/g" \
        -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
        -e "s/^;clear_env = no$/clear_env = no/g" \
        ${www_conf}

RUN service ssh start
RUN service php5-fpm start

EXPOSE 22 80
