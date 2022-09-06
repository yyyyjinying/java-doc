# docker pull elasticsearch:7.14.0
- docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.14.0
- mkdir -p /root/sorf/elasticsearch
- cd /root/sorf/elasticsearch
- 分别在创建映射文件config|data|logs|plugins
- docker cp -a elasticsearch:/usr/share/elasticsearch/config ./
- docker cp -a elasticsearch:/usr/share/elasticsearch/data ./
- docker cp -a elasticsearch:/usr/share/elasticsearch/logs ./
- docker cp -a elasticsearch:/usr/share/elasticsearch/plugins ./

- http://172.16.147.192:9200/ 测试是否成功
- 
# docker pull kibana:7.14.0
- docker run -d --name kibana -p 5601:5601 kibana:7.14.0
- mkdir -p /root/sorf/elasticsearch/kibana
- cd /root/sorf/elasticsearch/kibana
- docker cp kibana:/usr/share/kibana/config ./
