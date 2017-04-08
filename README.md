# nginx-conf

## 目录结构

```
# 根目录
/home/local/nginx-conf/

# 可执行文件
./bin/

# nginx配置
./conf/

# ssl证书 - 忽略提交
./ssl/

# 验证文件 - 忽略提交
./acme-challenge/
```

## 端口

端口 | 服务
--- | ---
8360 | 博客node
8888 | demo-node

## 命令

```
# 获取证书, 更新后把证书ln到./ssl中
./bin/certbot-auto certonly --webroot -w /home/local/nginx-conf/acme-challenge -d xuexb.com -d www.xuexb.com -d github.xuexb.com -d ci.xuexb.com -d static.xuexb.com -d proxy.xuexb.com -d api.xuexb.com -d echo.xuexb.com -d reload.cdn.xuexb.com -d source.xuexb.com

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
```
