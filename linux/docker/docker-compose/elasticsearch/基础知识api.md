# https://www.elastic.co/guide/cn/elasticsearch/guide/current/empty-search.html

# 中文文档
- https://www.elastic.co/guide/cn/elasticsearch/guide/current/mapping-intro.html
## 映射
索引中每个文档都有类型 。每种类型都有映射（模式定义）。映射中定义了类型中每个域的数据类型，以及与类型有关的元数据。
字符串类型的域，type，index，anylazed ，可以设置index：指定分析器全文检索的方式，关键字，no不进行搜索；

## 复杂核心域类型
- [],null,[null]是空的，它们将不会被索引
### 内部对象以及内部对象数组是如何索引的
- 把内部对象转化成一组键值对列表组成的列表，可以有效地索引内部类；
### 嵌套对象
- type: nested
- 嵌套对象映射
- 嵌套对象查询
- 嵌套字段排序
# 在elasticsearch的plugins中添加ik分词器
- ik_max_word 细粒度的拆分
- ik_smart 最粗力度的拆分
```json
GET /_analyze
{
  "analyzer": "ik_smart",
  "text": "中华人民共和国国歌"
}

GET /_analyze
{
  "analyzer":"ik_max_word",
  "text": "中华人民共和国国歌"
}

GET /_analyze
{
  "analyzer":"ik_max_word",
  "text": "赵晋英最爱中国了！"
}

GET gb/_analyze
{
  "fields": "title",
  "text": "赵晋英最爱中国了！"
}


PUT /zhao
{
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "ik_max_word"
      }
    }
  }
}

PUT /zhao/_doc/1
{
  "name": "赵晋英最爱中国了！"
}

GET /zhao/_search
{
  "query": {
    "term": {
      "name": {
        "value": "赵"
      }
    }
  }
}


```
```json
GET _search
{
  "query": {
    "match_all": {}
  }
}

POST /products/_doc/1
{
  "title":"小日本柜子",
  "price":23.2,
  "createed_at":"2022-09-07",
  "description":"日币嗯多多岛"
}
POST /products/_doc
{
  "title":"小日本柜子",
  "price":23.2,
  "createed_at":"2022-09-07",
  "description":"日币嗯多多岛"
}

GET /products/_search

DELETE /products/_doc/k1UbGoMB3JDKXHu2aMZf

# 修改： 先删除后增加
PUT /products/_doc/2
{
  "title":"英国佬9",
  "price":123.223,
  "createed_at":"2022-09-09"
}
# 原有的文档基础上修改
POST /products/_doc/2/_update
{
  "doc":{
    "description":"基础文档修改"
  }
}
# id相同也是修改
POST /products/_doc/2
{
  "price":11.2,
  "createed_at":"2022-09-10"
}

GET /products/_search

# 批量操作；index新增；update：修改；delete：删除 非原子操作 
POST /products/_doc/_bulk
{"index":{"_id":"4"}}
  {"title":"红烧排骨鱼翅","price":44.44,"createed_at":"2022-08-07","description":"sisisi四四"}
{"update":{"_id":"3"}}
  {"doc":{"title":"444-333title"}}
{"delete":{"_id":"2"}}

GET /products/_doc/_search
{
  "query":{
    "match_all":{}
  }
}

GET /products/_search
{
  "query": {
    "match_all": {}
  }
}

# 默认的分词器
# 中文单个汉子 英文单个单词
# keyword double interge date 不分词
GET /products/_search
{
  "query": {
    "term": {
      "price": {
        "value": 23.2
      }
    }
  }
}

# range范围查询
GET /products/_search
{
  "query": {
    "range": {
      "price": {
        "gte": 10,
        "lte": 34
      }
    }
  }
}

# prefix前缀查询
GET /products/_search
{
  "query": {
    "prefix": {
      "title": {
        "value": "4"
      }
    }
  }
}

# wildcard通配符查询
GET /products/_search
{
  "query": {
    "wildcard": {
      "description": {
        "value": "si*"
      }
    }
  }
}

# ids查询符合条件的一组id
GET /products/_search
{
  "query": {
    "ids": {
      "values": [3,4]
    }
  }
}

# fuzzy
GET /products/_search
{
  "query": {
    "fuzzy": {
      "title": "红烧排骨鱼翅"
    }
  }
}

# bool查询，must must_not should
GET /products/_search
{
  "query": {
    "bool": {
      "must_not": [
        {"ids": {
          "values": [3]
        }},
        {"wildcard": {
            "description": {
              "value": "si*"
            }
          }
        }
      ]
    }
  }
}

# query_string 高亮查询
GET /products/_search
{
  "query": {
    "query_string": {
      "default_field": "description",
      "query": "日本人"
    }
  },
  "highlight": {
    "pre_tags": ["<span style='color:red;'>"], 
    "post_tags": ["</span>"], 
    "require_field_match": "false", 
    "fields": {
      "*":{}
    }
  },
  "sort": [
    {
      "_id": {
        "order": "desc"
      }
    }
  ], 
  "from": 0, 
  "size": 20,
  "_source": ["_id","title"]
}

# 分词器
POST /_analyze
{
  "analyzer": "standard",
  "text": "this is a , good Man 中华人名共和国"
}

DELETE /test

PUT /test
{
  "mappings":{
    "properties": {
      "title":{
        "type": "text",
        "analyzer": "keyword"
      }
    }
  }
}

PUT /test/_doc/1
{
  "title":"我是小黑，this is a good MAN"
}

GET /test/_search
{
  "query": {
    "term": {
      "title": {
        "value": "我是小黑，this is a good MAN"
      }
    }
  }
}



```