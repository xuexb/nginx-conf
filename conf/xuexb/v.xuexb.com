server {
    server_name v.xuexb.com;

    root /home/xiaowu/wwwroot/v.xuexb.com;

    expires -1;

    # 加载ssl证书
    include inc/ssl.conf;

    # 加载公用robots.txt
    include inc/robots.conf;

    # 加载公用favicon
    include inc/favicon.conf;

    error_log   /var/log/nginx/xuexb.com/last/error.v.log   warn;
    access_log  /var/log/nginx/xuexb.com/last/access.v.log  nginx_cache_json;
}
