#!/usr/bin/env bash

echo '=====开始安装环境====='

echo '=====开始运行mysql====='
docker-compose -f ../yaml/mysql.yml up -d
# echo '=====mysql正在进行初始化====='
# ./wait-for-it.sh localhost:3306 --timeout=60  -- echo "=====mysql已经准备就绪====="

