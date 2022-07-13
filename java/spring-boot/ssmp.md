# SSMP案例-增删改查练习

# 数据层
- 创建实体类（lombok）
- Dao开发（mybatisplus)，制作数据层测试类；
- Service开发（基于mybatisplus进行增量开发，制作业务层测试类）
- Controller开发（基于Result开发，使用PostMan测试接口）

# 业务层
- 业务层开发-快速开发
  使用mybatisplus提供的业务层通用接口（IService<T>）与业务层通用实现类（ServiceImpl<M,T>）
  在通用类型的基础上做功能重载或功能追加；
  重载时避免覆盖原始操作方法，避免原始提供的功能丢失；

# 表现层
- 基于Result进行表现层接口的开发；
- 用postman测试表现层接口功能；

- 数据层
- 业务层
- 表现层

- getMapping
- postMapping
- putMapping
- deleteMapping

- 表现层消息一致性处理
- spring mvc qingqu cans