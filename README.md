# nginx-conf

## 目录结构

```
# 根目录
/home/local/nginx-conf/

# 可执行文件
./bin/

# nginx配置
./conf/

# getssl脚本配置
./getssl/

# ssl证书
./ssl/

# 验证文件
./acme-challenge/
```

## 端口

端口 | 服务
--- | ---
8360 | 博客node
8888 | demo-node

## 命令

```
# 获取证书
getssl xuexb.com

# pm2启动node服务
pm2 start conf/pm2.json
```