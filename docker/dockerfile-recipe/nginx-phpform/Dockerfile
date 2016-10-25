FROM nginx:latest

RUN apt-get update
RUN apt-get install -y ssh
RUN apt-get install -y php-frm

# nginx.confを上書き
ADD conf/nginx.conf /etc/nginx/nginx.conf

# SSL用のvirtualhost設定追加
ADD conf/site-ssl.conf /etc/nginx/conf.d/site-ssl.conf

# TODO: pemファイル追加

# TODO: keyファイル追加

ENV php_conf /etc/php5/fpm/php.ini
ENV fpm_conf /etc/php5/fpm/php-fpm.conf
RUN sed -i \
      -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" \
      -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" \
      -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" \
      -e "s/;date.timezone\s*=\s*/date.timezone = \"Asia\/Tokyo/g"
      -e "s/;mbstring.language = Japanese/mbstring.language = Japanese/g"
     /etc/php5/fpm/php.ini && \
    sed -i \
        -e "s/;daemonize\s*=\s*yes/daemonize = no/g"\
        -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
        -e "s/pm.max_children = 4/pm.start_servers = 4/g" \
        -e "s/pm.start_servers = 2/pm.start_servers = 2/g" \
        -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 1/g" \
        -e "s/pm.max_spare_servers = 3/pm.min_spare_servers = 3/g" \
        -e "s/pm.max_requests = 500/pm.max_requests = 200/g" \
        -e "s/user = nobody/user = nginx/g" \
        -e "s/group = nobody/group = nginx/g" \
        -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
        -e "s/;listen.owner = nobody/listen.owner = nginx/g" \
        -e "s/;listen.group = nobody/listen.group = nginx/g" \
        -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
        -e "s/^;clear_env = no$/clear_env = no/g" \
        /etc/php5/fpm/php-fpm.conf && \
    ln -s /etc/php5/php.ini /etc/php5/conf.d/php.ini && \
    find /etc/php5/conf.d/ -name 