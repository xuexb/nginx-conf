#!/bin/sh
#
# 执行日志切割脚本

PATH=/sbin:/bin:/usr/sbin:/usr/bin

logrotate -f /home/local/nginx-conf/logrotate/nginx.conf
