# nginx-conf

> 注意，本仓库只是我的站点一些配置，[github.com/xuexb/learn-nginx](https://github.com/xuexb/learn-nginx) 这里有更多配置说明~

- 使用 [acme.sh](https://github.com/Neilpang/acme.sh) 生成 [letsencrypt](https://letsencrypt.org/) 泛域名证书
- 使用 `crontab` + `bin/split-log` 定时切割nginx日志
- 统一管理 `/favicon.ico` （优先使用站点目录内文件，如果不存在则使用统一的）
- 统一管理`/robots.txt`（优先使用站点目录内文件，如果不存在则使用统一的）

## 目录结构

```
# 配置文件根目录
/home/xiaowu/local/nginx-conf/

# 可执行文件
./bin/

# nginx配置
./conf/

# 扩展文件，包括通用 favicon.ico 、通用 robots.txt 、SSL 能用配置
./conf/inc/

# 站点配置
./conf/主域名/

# 公用静态文件
./html/

# SSL 证书，acme 生成后需要复制到该文件夹
./ssl/

# 日志源文件
/var/log/nginx/xuexb.com/last/{access，rror}.{子域名}.log

# 日志切割文件文件
/var/log/nginx/xuexb.com/back/{Y-m-d}/{access，rror}.{子域名}.log
```

## 命令

```bash
# 生成证书
# 博客相关
acme.sh --issue --dns dns_ali -d xuexb.com -d *.xuexb.com -d *.registry.xuexb.com -d *.cdn.xuexb.com -d *.api.xuexb.com -d *.static.xuexb.com -d xuexb.cn -d www.xuexb.cn -d *.mip.xuexb.com *.amp.xuexb.com --log

# apijs 相关
acme.sh --issue --dns dns_ali -d apijs.org -d *.apijs.org -d apijs.net -d *.apijs.net --log

# alafe 相关
acme.sh --issue --dns dns_ali -d alafe.org -d *.alafe.org --log

# jiandansousuo 相关
acme.sh --issue \
    --dns dns_ali \
    -d jiandansousuo.com \
    -d *.jiandansousuo.com \
    -d *.api.jiandansousuo.com \
    -d *.proxy.jiandansousuo.com \
    -d *.static.jiandansousuo.com \
    -d *.cdn.jiandansousuo.com \
    -d jiandansousuo.cn \
    -d *.jiandansousuo.cn \
    -d jiandansousuo.org \
    -d *.jiandansousuo.org \
    --log

# 安装博客证书到配置目录
acme.sh --install-cert -d xuexb.com \
    --key-file       /home/xiaowu/local/nginx-conf/ssl/xuexb.com.key  \
    --fullchain-file /home/xiaowu/local/nginx-conf/ssl/xuexb.com.fullchain.cer \
    --reloadcmd     "/home/xiaowu/local/nginx-1.11.2/sbin/nginx -s stop && /home/xiaowu/local/nginx-1.11.2/sbin/nginx"

# 安装 apijs 证书到配置目录
acme.sh --install-cert -d apijs.org \
    --key-file       /home/xiaowu/local/nginx-conf/ssl/apijs.org.key  \
    --fullchain-file /home/xiaowu/local/nginx-conf/ssl/apijs.org.fullchain.cer \
    --reloadcmd     "/home/xiaowu/local/nginx-1.11.2/sbin/nginx -s stop && /home/xiaowu/local/nginx-1.11.2/sbin/nginx"

# 安装 alafe 证书到配置目录
acme.sh --install-cert -d alafe.org \
    --key-file       /home/xiaowu/local/nginx-conf/ssl/alafe.org.key  \
    --fullchain-file /home/xiaowu/local/nginx-conf/ssl/alafe.org.fullchain.cer \
    --reloadcmd     "/home/xiaowu/local/nginx-1.11.2/sbin/nginx -s stop && /home/xiaowu/local/nginx-1.11.2/sbin/nginx"

# 安装 jiandansousuo 证书到配置目录
acme.sh --install-cert -d jiandansousuo.com \
    --key-file       /home/xiaowu/local/nginx-conf/ssl/jiandansousuo.com.key  \
    --fullchain-file /home/xiaowu/local/nginx-conf/ssl/jiandansousuo.com.fullchain.cer \
    --reloadcmd     "/home/xiaowu/local/nginx-1.11.2/sbin/nginx -s stop && /home/xiaowu/local/nginx-1.11.2/sbin/nginx"

# 添加定时任务
# 先卸载当前用户的
acme.sh --uninstall-cronjob
# su root ，切换到 root 下，因为刷新 Nginx 的命令需要 root
acme.sh --install-cronjob

# 切换到 root 用户下添加定时任务
crontab -e
# 插入一条定时任务，定时23:50开始分割，后面是把错误和信息输出到指定文件，方便调试
50 23 * * * sh /home/xiaowu/local/nginx-conf/bin/split-log >> /var/log/nginx/crontab.log 2>&1
```
