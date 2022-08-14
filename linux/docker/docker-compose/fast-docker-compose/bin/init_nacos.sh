#!/usr/bin/env bash
echo '=====开始运行nacos====='
docker-compose -f ../yaml/nacos.yml up -d
# echo '=====mysql正在进行初始化====='
# ./wait-for-it.sh localhost:3306 --timeout=60  -- echo "=====mysql已经准备就绪====="

