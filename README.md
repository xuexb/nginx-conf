# nginx-conf

> 注意, 本仓库只是我的 [前端小武博客](https://xuexb.com) 的站点配置, [github.com/xuexb/learn-nginx](https://github.com/xuexb/learn-nginx) 这里有更多配置说明~

- 使用 [certbot](https://github.com/certbot/certbot) 生成 [letsencrypt](https://letsencrypt.org/) SSL证书
- 使用 `crontab` + `bin/split-log` 定时切割nginx日志
- 统一管理`/favicon.ico`(优先使用站点目录内文件, 如果不存在则使用统一的)
- 统一管理`/robots.txt`(优先使用站点目录内文件, 如果不存在则使用统一的)

## 目录结构

```
# 根目录
/home/local/nginx-conf/

# 可执行文件
./bin/

# nginx配置
./conf/

# 扩展文件, 包括通用favicon.ico、通用robots.txt、ssl证书验证
./conf/inc/

# 站点配置
./conf/vhost/

# 公用静态文件
./html/

# ssl证书 - 忽略提交
./ssl/

# 验证文件 - 忽略提交
./acme-challenge/

# 日志源文件
/var/log/nginx/xuexb.com/last/{access,error}.{子域名}.log

# 日志切割文件文件
/var/log/nginx/xuexb.com/back/{Y-m-d}/{access,error}.{子域名}.log
```

## 端口

端口 | 服务
--- | ---
8360 | 博客node
8888 | demo-node

## 命令

```
# 获取证书, 更新后把证书ln到./ssl中
./bin/certbot-auto certonly --no-bootstrap  --webroot -w /home/local/nginx-conf/acme-challenge -d xuexb.com -d www.xuexb.com -d github.xuexb.com -d ci.xuexb.com -d static.xuexb.com -d proxy.xuexb.com -d api.xuexb.com -d echo.xuexb.com -d reload.cdn.xuexb.com -d mip.xuexb.com -d admin.xuexb.com -d cache.xuexb.com -d amp.xuexb.com -d log.xuexb.com -d status.xuexb.com

# 生成dhparam
openssl dhparam -out ./ssl/dhparam.pem 2048

# 生成root_ca_cert_plus_intermediates
wget https://letsencrypt.org/certs/isrgrootx1.pem
mv isrgrootx1.pem root.pem
cat root.pem chain.pem > root_ca_cert_plus_intermediates

# 自动更新
/home/local/nginx-conf/bin/certbot-auto renew && nginx -s reload

# pm2启动node服务
pm2 start conf/pm2.json

crontab -e
# 插入一条定时任务, 定时23:50开始分割, 后面是把错误和信息输出到指定文件, 方便调试
50 23 * * * sh /home/local/nginx-conf/bin/split-log >> /var/log/nginx/crontab.log 2>&1
```
